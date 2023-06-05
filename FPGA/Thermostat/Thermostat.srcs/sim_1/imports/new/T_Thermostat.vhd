----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Btabone
-- 
-- Create Date: 05/18/2023 10:08:32 AM
-- Design Name: 
-- Module Name: T_Thermostat - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Test bench for Thermostat
-- 
-- Dependencies: Thermostat.vhd
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity T_Thermostat is
end T_Thermostat;

architecture Behavioral of T_Thermostat is
    component Thermostat is
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
        end component;
        
        signal T_CURRENT_TEMP, T_DESIRED_TEMP : STD_LOGIC_VECTOR(6 downto 0);
        signal T_DISPLAY_SELECT : STD_LOGIC;
        signal T_DISPLAY_TEMP : STD_LOGIC_VECTOR(6 downto 0);
        signal T_AC_CTRL_SWITCH : STD_LOGIC;
        signal T_HEAT_CTRL_SWITCH : STD_LOGIC;
        signal T_AC_PWR_CTRL : STD_LOGIC;
        signal T_HEAT_PWR_CTRL : STD_LOGIC;
        signal T_CLK : STD_LOGIC;
        signal T_RESET : STD_LOGIC;
begin

    UUT: Thermostat port map (currentTemp => T_CURRENT_TEMP,
                              desiredTemp => T_DESIRED_TEMP,
                              displayedTemp => T_DISPLAY_TEMP,
                              displaySel => T_DISPLAY_SELECT,
                              acControlSwitch => T_AC_CTRL_SWITCH,
                              heatControlSwitch => T_HEAT_CTRL_SWITCH,
                              acPowerControl => T_AC_PWR_CTRL,
                              heatPowerControl => T_HEAT_PWR_CTRL,
                              clk => T_CLK,
                              reset => T_RESET);

    process 
    begin
        T_CLK <= '0';
        wait for 5ns;
        T_CLK <= '1';
        wait for 5ns;
    end process;
    
    process
    begin
        T_RESET <= '0'; -- Send reset
        wait for 50ns;
        T_RESET <= '1'; -- Begin normal operation
        wait for 50ns;
        
        -- Test display select function
        T_AC_CTRL_SWITCH <= '0'; -- AC off
        T_HEAT_CTRL_SWITCH <= '0'; -- HEAT off

        T_CURRENT_TEMP <= "0000000";
        T_DESIRED_TEMP <= "1111111";

        T_DISPLAY_SELECT <= '0';
        wait for 30ns;
        assert T_DISPLAY_TEMP = "1111111";

        T_DISPLAY_SELECT <= '1';
        wait for 30ns;
        assert T_DISPLAY_TEMP = "0000000";

        -- Test HVAC function
        
        T_AC_CTRL_SWITCH <= '1'; -- AC on
        T_HEAT_CTRL_SWITCH <= '0'; -- HEAT off
        T_CURRENT_TEMP <= "0011001"; -- 25C
        T_DESIRED_TEMP <= "0010110"; -- 22C
        wait for 50ns; 
        assert T_AC_PWR_CTRL = '1' report "AC Power was expected on" severity failure;
        assert T_HEAT_PWR_CTRL = '0' report "Heat Power was expected off" severity failure;
        T_CURRENT_TEMP <= "0011000"; -- 24C
        wait for 30ns;
        assert T_AC_PWR_CTRL = '1' report "AC Power was expected on" severity failure;
        assert T_HEAT_PWR_CTRL = '0' report "Heat Power was expected off" severity failure;
        T_CURRENT_TEMP <= "0010111"; -- 23C
        wait for 30ns;
        assert T_AC_PWR_CTRL = '1' report "AC Power was expected on" severity failure;
        assert T_HEAT_PWR_CTRL = '0' report "Heat Power was expected off" severity failure;
        T_CURRENT_TEMP <= "0010101"; -- 21C
        wait for 30ns;
        assert T_AC_PWR_CTRL = '0' report "AC Power was expected off" severity failure;
        assert T_HEAT_PWR_CTRL = '0' report "Heat Power was expected off" severity failure;
        
        T_AC_CTRL_SWITCH <= '0'; -- AC off
        T_HEAT_CTRL_SWITCH <= '1'; -- HEAT on
        wait for 30ns;
        
        assert T_AC_PWR_CTRL = '0' report "AC Power was expected off" severity failure;
        assert T_HEAT_PWR_CTRL = '1' report "Heat Power was expected on" severity failure; -- Heat should be on
        
        T_CURRENT_TEMP <= "0010111"; -- 23C
        wait for 30ns;
        assert T_AC_PWR_CTRL = '0' report "AC Power was expected off"  severity failure;
        assert T_HEAT_PWR_CTRL = '0' report "Heat Power was expected off" severity failure; -- Heat should be off
        
        wait;
    end process;
end Behavioral;
