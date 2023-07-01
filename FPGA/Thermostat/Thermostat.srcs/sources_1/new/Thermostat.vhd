----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Brian Tabone 
-- 
-- Create Date: 04/25/2023 05:12:50 PM
-- Design Name: 
-- Module Name: Thermostat - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Thermostat is
 Port ( desiredTemp : in STD_LOGIC_VECTOR(6 downto 0);
        currentTemp : in STD_LOGIC_VECTOR(6 downto 0); 
        displayedTemp : out STD_LOGIC_VECTOR(6 downto 0);
        displaySel : in STD_LOGIC;
        acControlSwitch : in STD_LOGIC;
        heatControlSwitch : in STD_LOGIC;
        furnaceHotStatus : in STD_LOGIC; --0 for warming up 1 for ready, fan can come on
        acColdStatus : in STD_LOGIC; --0 for cooling down and 1 for read, fan can come on
        acPowerControl : out STD_LOGIC;
        heatPowerControl : out STD_LOGIC;
        fanPowerControl : out STD_LOGIC;
        clk : in STD_LOGIC;
        reset : in STD_LOGIC );
end Thermostat;

architecture Behavioral of Thermostat is

    type HVAC_MODE is ( IDLE,           -- No cooling or heating needed, standing by. 
                        COOL_ON,        -- Cool mode turned on and temp above set point
                        COOL_RDY,       -- Cool mode on, temp above set point and system cool enough to start fan
                        COOL_COMPLETE,  -- Cooling is complete, will turn off fan and go to idle when AC cool enough signal goes low
                        HEAT_ON,        -- Heat mode on, temp below set point
                        HEAT_RDY,       -- Heat mode on, hot enought to start fan
                        HEAT_COMPLETE   -- Heating is complete, will turn off fan and go to idle when heater warm enough goes low
                        ); 
    
    
    signal HVAC_CURRENT_STATE : HVAC_MODE;
    signal HVAC_NEXT_STATE : HVAC_MODE;
    
    --Inbound signals
    signal desiredTemp_reg : STD_LOGIC_VECTOR(6 downto 0);
    signal currentTemp_reg : STD_LOGIC_VECTOR(6 downto 0); 
    signal displaySel_reg : STD_LOGIC;
    signal acControlSwitch_reg : STD_LOGIC; 
    signal heatControlSwitch_reg : STD_LOGIC;
    signal acColdStatus_reg : STD_LOGIC;
    signal furnaceHotStatus_reg : STD_LOGIC;
    
    --Outbound signals
    signal acPowerControl_reg : STD_LOGIC;
    signal heatPowerControl_reg : STD_LOGIC;
    signal displayedTemp_reg : STD_LOGIC_VECTOR(6 downto 0);
    signal fanPowerControl_reg : STD_LOGIC;
    
begin

    -- Unclocked thermostat state machine
    process(reset, desiredTemp_reg,currentTemp_reg,acControlSwitch_reg,heatControlSwitch_reg,furnaceHotStatus_reg,acColdStatus_reg)
    begin
    if reset = '0' then    
            -- Default to off 
            acPowerControl_reg <= '0';
            heatPowerControl_reg <= '0';
            displayedTemp_reg <= "0000000";          
            HVAC_NEXT_STATE <= IDLE;
            acPowerControl_reg <= '0';
            heatPowerControl_reg <= '0';
            fanPowerControl_reg <= '0';
            
        else 
            case HVAC_CURRENT_STATE is
                when IDLE => 
                    acPowerControl_reg <= '0';
                    heatPowerControl_reg <= '0';
                    fanPowerControl_reg <= '0';
                    
                    if acControlSwitch_reg = '1' then
                        HVAC_NEXT_STATE <= COOL_ON;
                    elsif heatPowerControl_reg = '1' then
                        HVAC_NEXT_STATE <= HEAT_ON;
                    else
                        HVAC_NEXT_STATE <= IDLE;
                    end if;
                when COOL_ON =>
                    if acControlSwitch_reg = '1' then
                        if unsigned(currentTemp_reg) > unsigned(desiredTemp_reg) then
                            acPowerControl_reg <= '1';
                            HVAC_NEXT_STATE <= COOL_RDY;
                        else
                            HVAC_NEXT_STATE <= IDLE; -- Go back to idle, will transition back to cool_on and check temp again on next cycle
                        end if;                    
                    else
                        HVAC_NEXT_STATE <= IDLE;
                    end if;
                when COOL_RDY =>
                    HVAC_NEXT_STATE <= COOL_RDY;
                    
                    if acControlSwitch_reg = '1' and acColdStatus_reg = '0' then
                        fanPowerControl_reg <= '0';
                    elsif acControlSwitch_reg = '1' and acColdStatus_reg = '1' then
                        fanPowerControl_reg <= '1';
                        if unsigned(currentTemp_reg) <= unsigned(desiredTemp_reg) then
                            HVAC_NEXT_STATE <= COOL_COMPLETE;
                        end if;
                    else
                        -- User turned off the AC switch, transition to complete which will handle the final fan status
                        HVAC_NEXT_STATE <= COOL_COMPLETE; 
                    end if;         
                when COOL_COMPLETE =>
                    -- Don't transition to idle until the HVAC says the ac is no longer cool enough to run the fan. 
                    -- If the user switches to heat, there will be a delay in transition until the cold status flag goes low
                    if acColdStatus_reg = '0' then
                        fanPowerControl_reg <= '0';
                        HVAC_NEXT_STATE <= IDLE;
                    else
                        HVAC_NEXT_STATE <= COOL_COMPLETE;
                    end if;
                when HEAT_ON =>
                    if heatControlSwitch_reg = '1' then
                        if unsigned(currentTemp_reg) < unsigned(desiredTemp_reg) then
                            heatPowerControl_reg <= '1';
                            HVAC_NEXT_STATE <= HEAT_RDY;
                        else
                            HVAC_NEXT_STATE <= IDLE; 
                        end if;
                    else
                        -- Heat complete will handle fan status then transition to IDLE
                        HVAC_NEXT_STATE <= HEAT_COMPLETE;
                    end if;  
                 when HEAT_RDY =>
                    --TODO implement
                 when HEAT_COMPLETE =>
                    --TODO implement
                when others =>
                    HVAC_NEXT_STATE <= IDLE;
            end case;
                
                
            if displaySel_reg = '0' then
                displayedTemp_reg <= desiredTemp_reg;
            else
                displayedTemp_reg <= currentTemp_reg;
            end if;
            
            if acControlSwitch_reg = '1' then
                
            elsif heatControlSwitch_reg = '1' then
                if unsigned(currentTemp_reg) < unsigned(desiredTemp_reg) then
                    heatPowerControl_reg <= '1';
                else
                    heatPowerControl_reg <= '0';
                end if;
            end if;
        end if;
    end process;
    
    -- State machine current state update
    process(clk,reset)
    begin
        if reset = '0' then
            HVAC_CURRENT_STATE <= IDLE;
        elsif (clk'event and clk = '1') then
            HVAC_CURRENT_STATE <= HVAC_NEXT_STATE;
        else
            HVAC_CURRENT_STATE <= HVAC_CURRENT_STATE;
        end if;
    end process;
    
    -- Input flipflops
    process(clk, reset)
    begin
        if reset = '0' then
            desiredTemp_reg <= (others => '0');
            currentTemp_reg <= (others => '0');
            displaySel_reg <= '0';
            acControlSwitch_reg <= '0';
            heatControlSwitch_reg <= '0';
            acColdStatus_reg <= '0';
            furnaceHotStatus_reg <= '0';
        elsif clk'event and clk = '1' then
            desiredTemp_reg <= desiredTemp;
            currentTemp_reg <= currentTemp;
            displaySel_reg <= displaySel;
            acControlSwitch_reg <= acControlSwitch;
            heatControlSwitch_reg <= heatControlSwitch;
            acColdStatus_reg <= acColdStatus;
            furnaceHotStatus_reg <= furnaceHotStatus;
        else
            desiredTemp_reg <= desiredTemp_reg;
            currentTemp_reg <= currentTemp_reg;
            displaySel_reg <= displaySel_reg;
            acControlSwitch_reg <= acControlSwitch_reg;
            heatControlSwitch_reg <= heatControlSwitch_reg;
            acColdStatus_reg <= acColdStatus_reg;
            furnaceHotStatus_reg <= furnaceHotStatus_reg;
        end if;
    end process;

    -- Output flipflops
    process(clk, reset)
    begin
        if reset = '0' then
            displayedTemp <= (others => '0');
            acPowerControl <= '0';
            heatPowerControl <= '0';
            fanPowerControl <= '0';
        elsif clk'event and clk = '1' then
            displayedTemp <= displayedTemp_reg;
            acPowerControl <= acPowerControl_reg;
            heatPowerControl <= heatPowerControl_reg;
            fanPowerControl <= fanPowerControl_reg;
        end if;
    end process;
  
    
end Behavioral;
