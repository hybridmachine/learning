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
        heatPowerControl : out STD_LOGIC );
end Thermostat;

architecture Behavioral of Thermostat is
begin

    process(displaySel, desiredTemp, currentTemp)
    begin
        if displaySel = '0' then
            displayedTemp <= desiredTemp;
        else
            displayedTemp <= currentTemp;
        end if;
    end process;
    
    process(acControlSwitch, heatControlSwitch, currentTemp, desiredTemp)
    begin
        -- Default to off , set power state based on switch and temp state
        -- This way if user switches from cool to heat or vice versa, we'll turn off the opposite
        -- mode by default
        acPowerControl <= '0';
        heatPowerControl <= '0';
        
        if acControlSwitch = '1' then
            if unsigned(currentTemp) > unsigned(desiredTemp) then
                acPowerControl <= '1';
            else
                acPowerControl <= '0';
            end if;
        elsif heatControlSwitch = '1' then
            if unsigned(currentTemp) < unsigned(desiredTemp) then
                heatPowerControl <= '1';
            else
                heatPowerControl <= '0';
            end if;
        end if; 
    end process;
end Behavioral;
