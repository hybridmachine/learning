----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/12/2023 02:22:04 PM
-- Design Name: 
-- Module Name: T_BlockRam - Behavioral
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
use WORK.CHAR2STD.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity T_BlockRam is
--  Port ( );
end T_BlockRam;

architecture Behavioral of T_BlockRam is
COMPONENT blk_mem_gen_0 IS
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

COMPONENT inferred_ram IS
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

signal T_CLKA : std_logic;
signal T_WRE_A : STD_LOGIC_VECTOR(0 DOWNTO 0);
signal T_ADDR_A : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal T_DATA_A : STD_LOGIC_VECTOR(7 DOWNTO 0);

signal T_CLKB : std_logic;
signal T_ADDR_B : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal T_DATA_B : STD_LOGIC_VECTOR(7 DOWNTO 0);

constant CLKA_PERIOD : time := 1000 ns;
constant CLKB_PERIOD : time := 2000 ns;

begin

--DUT : blk_mem_gen_0 port map (
--    clka => T_CLKA,
--    wea => T_WRE_A,
--    addra => T_ADDR_A,
--    dina => T_DATA_A,
--    clkb => T_CLKB,
--    addrb => T_ADDR_B,
--    doutb => T_DATA_B);

DUT : inferred_ram port map (
    clka => T_CLKA,
    wea => T_WRE_A,
    addra => T_ADDR_A,
    dina => T_DATA_A,
    clkb => T_CLKB,
    addrb => T_ADDR_B,
    doutb => T_DATA_B);
    
--clka
process
begin
    T_CLKA <= '0';
    wait for CLKA_PERIOD / 2;
    T_CLKA <= '1';
    wait for CLKA_PERIOD / 2;
end process;

--clkb
process
begin
    T_CLKB <= '0';
    wait for CLKB_PERIOD / 2;
    T_CLKB <= '1';
    wait for CLKB_PERIOD / 2;
end process;

-- Simulation process
-- Write 'Hello' to the first five bytes of RAM, via portA. Read it back on port B
process
begin
    T_ADDR_A <= x"0000";
    T_ADDR_B <= x"0000";

    T_DATA_A <= x"00";
    T_WRE_A <= "1";
    
    wait until T_CLKA'event and T_CLKA = '0';
    T_DATA_A <= CHAR2STD('H');
    T_ADDR_A <= x"0000";
    wait until T_CLKA'event and T_CLKA = '1';
    wait until T_CLKA'event and T_CLKA = '0';
    T_DATA_A <= CHAR2STD('e');
    T_ADDR_A <= x"0001";
    wait until T_CLKA'event and T_CLKA = '1';
    wait until T_CLKA'event and T_CLKA = '0';
    T_DATA_A <= CHAR2STD('L');
    T_ADDR_A <= x"0002";
    wait until T_CLKA'event and T_CLKA = '1';
    wait until T_CLKA'event and T_CLKA = '0';
    T_DATA_A <= CHAR2STD('L');
    T_ADDR_A <= x"0003";
    wait until T_CLKA'event and T_CLKA = '1';
    wait until T_CLKA'event and T_CLKA = '0';
    T_DATA_A <= CHAR2STD('o');
    T_ADDR_A <= x"0004";
    wait until T_CLKA'event and T_CLKA = '1';
    wait until T_CLKA'event and T_CLKA = '0';
    
    wait until T_CLKB'event and T_CLKB = '0';
    T_ADDR_B <= x"0000";
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    assert (T_DATA_B = CHAR2STD('H')) report "Address 0 does not contain 'H'" severity failure;
    
    wait until T_CLKB'event and T_CLKB = '0';
    T_ADDR_B <= x"0001";
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    assert (T_DATA_B = CHAR2STD('e')) report "Address 1 does not contain 'e'" severity failure;
    
    wait until T_CLKB'event and T_CLKB = '0';
    T_ADDR_B <= x"0002";
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    assert (T_DATA_B = CHAR2STD('L')) report "Address 2 does not contain 'L'" severity failure;

    wait until T_CLKB'event and T_CLKB = '0';
    T_ADDR_B <= x"0003";
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    assert (T_DATA_B = CHAR2STD('L')) report "Address 3 does not contain 'L'" severity failure;

    wait until T_CLKB'event and T_CLKB = '0';
    T_ADDR_B <= x"0004";
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    assert (T_DATA_B = CHAR2STD('o')) report "Address 4 does not contain 'o'" severity failure;
    
    wait;
end process;

end Behavioral;
