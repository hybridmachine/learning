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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Thermostat is
 Port ( signal vectorIn : in STD_LOGIC_VECTOR(6 downto 0); 
        signal vectorOut : out STD_LOGIC_VECTOR(6 downto 0);
         displaySel : in STD_LOGIC );
end Thermostat;

architecture Behavioral of Thermostat is
    -- Dummy test values to test the display selection
    signal vector2 : STD_LOGIC_VECTOR(6 downto 0) := "0010100"; -- Dummy 20 C value
begin

    process(displaySel, vectorIn)
    begin
        if displaySel = '0' then
            vectorOut <= vectorIn;
        else
            vectorOut <= vector2;
        end if;
    end process;
end Behavioral;
