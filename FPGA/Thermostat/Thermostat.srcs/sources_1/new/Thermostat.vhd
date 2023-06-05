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
        acPowerControl : out STD_LOGIC;
        heatPowerControl : out STD_LOGIC;
        clk : in STD_LOGIC;
        reset : in STD_LOGIC );
end Thermostat;

architecture Behavioral of Thermostat is

    --Inbound signals
    signal desiredTemp_reg : STD_LOGIC_VECTOR(6 downto 0);
    signal currentTemp_reg : STD_LOGIC_VECTOR(6 downto 0); 
    signal displaySel_reg : STD_LOGIC;
    signal acControlSwitch_reg : STD_LOGIC; 
    signal heatControlSwitch_reg : STD_LOGIC;
    
    --Outbound signals
    signal acPowerControl_reg : STD_LOGIC;
    signal heatPowerControl_reg : STD_LOGIC;
    signal displayedTemp_reg : STD_LOGIC_VECTOR(6 downto 0);
    
    
begin

    -- Input flipflops
    process(clk, reset, desiredTemp_reg, currentTemp_reg, displaySel_reg, acControlSwitch_reg, heatControlSwitch_reg)
    begin
        if reset = '0' then
            desiredTemp_reg <= (others => '0');
            currentTemp_reg <= (others => '0');
            displaySel_reg <= '0';
            acControlSwitch_reg <= '0';
            heatControlSwitch_reg <= '0';
        elsif clk'event and clk = '1' then
            desiredTemp_reg <= desiredTemp;
            currentTemp_reg <= currentTemp;
            displaySel_reg <= displaySel;
            acControlSwitch_reg <= acControlSwitch;
            heatControlSwitch_reg <= heatControlSwitch;
        else
            desiredTemp_reg <= desiredTemp_reg;
            currentTemp_reg <= currentTemp_reg;
            displaySel_reg <= displaySel_reg;
            acControlSwitch_reg <= acControlSwitch_reg;
            heatControlSwitch_reg <= heatControlSwitch_reg;
        end if;
    end process;

    -- Output flipflops
    process(clk, reset, displayedTemp_reg, acPowerControl_reg, heatPowerControl_reg)
    begin
        if reset = '0' then
            displayedTemp <= (others => '0');
            acPowerControl <= '0';
            heatPowerControl <= '0';
        elsif clk'event and clk = '1' then
            displayedTemp <= displayedTemp_reg;
            acPowerControl <= acPowerControl_reg;
            heatPowerControl <= heatPowerControl_reg;
        end if;
    end process;
    
    process(displaySel_reg, desiredTemp_reg, currentTemp_reg)
    begin 
        if displaySel_reg = '0' then
            displayedTemp_reg <= desiredTemp_reg;
        else
            displayedTemp_reg <= currentTemp_reg;
        end if;
    end process;
    
    process(reset, currentTemp_reg, desiredTemp_reg, acControlSwitch_reg, heatControlSwitch_reg)
    begin   
    
        if reset = '0' then    
            -- Default to off 
            acPowerControl_reg <= '0';
            heatPowerControl_reg <= '0';
   
        else 
            if acControlSwitch_reg = '1' then
                if unsigned(currentTemp_reg) > unsigned(desiredTemp_reg) then
                    acPowerControl_reg <= '1';
                else
                    acPowerControl_reg <= '0';
                end if;
            elsif heatControlSwitch_reg = '1' then
                if unsigned(currentTemp_reg) < unsigned(desiredTemp_reg) then
                    heatPowerControl_reg <= '1';
                else
                    heatPowerControl_reg <= '0';
                end if;
            end if; 
        end if;
    end process;
end Behavioral;
