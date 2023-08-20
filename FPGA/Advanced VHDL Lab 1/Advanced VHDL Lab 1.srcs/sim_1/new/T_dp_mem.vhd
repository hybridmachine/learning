----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/20/2023 12:20:10 PM
-- Design Name: 
-- Module Name: T_dp_mem - Behavioral
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

entity T_dp_mem is
--  Port ( );
end T_dp_mem;

architecture Behavioral of T_dp_mem is
COMPONENT dp_mem IS
	port (
	addra: IN std_logic_VECTOR(3 downto 0);
	addrb: IN std_logic_VECTOR(3 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(15 downto 0);
	dinb: IN std_logic_VECTOR(15 downto 0);
	douta: OUT std_logic_VECTOR(15 downto 0);
	doutb: OUT std_logic_VECTOR(15 downto 0);
	wea: IN std_logic;
	web: IN std_logic);
END COMPONENT;

signal T_CLKA : STD_LOGIC;
signal T_WRE_A : STD_LOGIC;
signal T_ADDR_A : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal T_DATA_IN_A : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal T_DATA_OUT_A : STD_LOGIC_VECTOR(15 DOWNTO 0);

signal T_CLKB : STD_LOGIC;
signal T_WRE_B : STD_LOGIC;
signal T_ADDR_B : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal T_DATA_IN_B : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal T_DATA_OUT_B : STD_LOGIC_VECTOR(15 DOWNTO 0);

constant CLKA_PERIOD : time := 1000 ns;
constant CLKB_PERIOD : time := 2000 ns;

-- Uncomment to Test with IP block
--for DUT:dp_mem use entity WORK.dp_mem(dp_mem_a);

-- Uncomment to Test with Inferred Ram
for DUT:dp_mem use entity WORK.dp_mem(dp_mem_inferred);

begin

DUT :dp_mem port map (
    clka => T_CLKA,
    wea => T_WRE_A,
    addra => T_ADDR_A,
    dina => T_DATA_IN_A,
    douta => T_DATA_OUT_A,
    clkb => T_CLKB,
    web => T_WRE_B,
    addrb => T_ADDR_B,
    dinb => T_DATA_IN_B,
    doutb => T_DATA_OUT_B
);

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
    T_ADDR_A <= x"0";
    T_ADDR_B <= x"0";

    T_DATA_IN_A <= x"0000";
    -- Write to A , read from B
    T_WRE_A <= '1';
    T_WRE_B <= '0';
    
    wait until T_CLKA'event and T_CLKA = '0';
    T_DATA_IN_A <= x"00" & CHAR2STD('H');
    T_ADDR_A <= x"0";
    wait until T_CLKA'event and T_CLKA = '1';
    wait until T_CLKA'event and T_CLKA = '0';
    T_DATA_IN_A <= x"00" & CHAR2STD('e');
    T_ADDR_A <= x"1";
    wait until T_CLKA'event and T_CLKA = '1';
    wait until T_CLKA'event and T_CLKA = '0';
    T_DATA_IN_A <= x"00" & CHAR2STD('L');
    T_ADDR_A <= x"2";
    wait until T_CLKA'event and T_CLKA = '1';
    wait until T_CLKA'event and T_CLKA = '0';
    T_DATA_IN_A <= x"00" & CHAR2STD('L');
    T_ADDR_A <= x"3";
    wait until T_CLKA'event and T_CLKA = '1';
    wait until T_CLKA'event and T_CLKA = '0';
    T_DATA_IN_A <= x"00" & CHAR2STD('o');
    T_ADDR_A <= x"4";
    wait until T_CLKA'event and T_CLKA = '1';
    wait until T_CLKA'event and T_CLKA = '0';
    
    wait until T_CLKB'event and T_CLKB = '0';
    T_ADDR_B <= x"0";
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    assert (T_DATA_OUT_B = x"00" & CHAR2STD('H')) report "Address 0 does not contain 'H'" severity failure;
    
    wait until T_CLKB'event and T_CLKB = '0';
    T_ADDR_B <= x"1";
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    assert (T_DATA_OUT_B = x"00" & CHAR2STD('e')) report "Address 1 does not contain 'e'" severity failure;
    
    wait until T_CLKB'event and T_CLKB = '0';
    T_ADDR_B <= x"2";
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    assert (T_DATA_OUT_B = x"00" & CHAR2STD('L')) report "Address 2 does not contain 'L'" severity failure;

    wait until T_CLKB'event and T_CLKB = '0';
    T_ADDR_B <= x"3";
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    assert (T_DATA_OUT_B = x"00" & CHAR2STD('L')) report "Address 3 does not contain 'L'" severity failure;

    wait until T_CLKB'event and T_CLKB = '0';
    T_ADDR_B <= x"4";
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '0';
    assert (T_DATA_OUT_B = x"00" & CHAR2STD('o')) report "Address 4 does not contain 'o'" severity failure;
    
    wait;
end process;

end Behavioral;
