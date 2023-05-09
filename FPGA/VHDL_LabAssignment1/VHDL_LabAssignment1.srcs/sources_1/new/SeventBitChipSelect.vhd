----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2023 04:20:31 PM
-- Design Name: 
-- Module Name: SeventBitChipSelect - Behavioral
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

entity SeventBitChipSelect is
  Port ( bit0 : out STD_LOGIC;
         bit1 : out STD_LOGIC;
         bit2 : out STD_LOGIC;
         bit3 : out STD_LOGIC;
         bit4 : out STD_LOGIC;
         bit5 : out STD_LOGIC;
         bit6 : out STD_LOGIC;
         chsl : in STD_LOGIC;
         CLK : in STD_LOGIC  );
end SeventBitChipSelect;

architecture Behavioral of SeventBitChipSelect is
    signal vector1 : STD_LOGIC_VECTOR(6 downto 0) := "0000101";
    signal vector2 : STD_LOGIC_VECTOR(6 downto 0) := "1011000";
begin

    process(chsl)
    begin
        if chsl = '0' then
            bit0 <= vector1(0);
            bit1 <= vector1(1);
            bit2 <= vector1(2);
            bit3 <= vector1(3);
            bit4 <= vector1(4);
            bit5 <= vector1(5);
            bit6 <= vector1(6);
        else
            bit0 <= vector2(0);
            bit1 <= vector2(1);
            bit2 <= vector2(2);
            bit3 <= vector2(3);
            bit4 <= vector2(4);
            bit5 <= vector2(5);
            bit6 <= vector2(6);
        end if;
end process;

end Behavioral;
