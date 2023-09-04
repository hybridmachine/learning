----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/04/2023 12:40:41 PM
-- Design Name: 
-- Module Name: T_dp_mem_bfm - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity T_dp_mem_bfm is
--  Port ( );
end T_dp_mem_bfm;

architecture Behavioral of T_dp_mem_bfm is
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
for DUT:dp_mem use entity WORK.dp_mem(dp_mem_inferred_a);

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

process
file psuedocode_file: text;
    variable L_IN:          line;
    variable INSTRUCTION:   string (1 to 4);
    variable DUMMY:         character; -- Space between instructions, not used other than to perform the read
    variable ADDRESS:       std_logic_vector (3 DOWNTO 0);
    variable DATA:          std_logic_vector (15 DOWNTO 0);
begin

    T_ADDR_A <= x"0";
    T_ADDR_B <= x"0";

    T_DATA_IN_A <= x"0000";
    
    T_WRE_A <= '0';
    T_WRE_B <= '0';
    
    file_open(psuedocode_file, "C:\memtest.txt", READ_MODE);
    
    -- Let a few clock cycles (we'll use the slower clock) pass before we start issuing commands
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '1';
    wait until T_CLKB'event and T_CLKB = '1';
    
    while (INSTRUCTION /= "END ") loop
        readline(psuedocode_file, L_IN);
        read(L_IN, INSTRUCTION);
        read(L_IN, DUMMY);
        hread(L_IN, ADDRESS);
        read(L_IN, DUMMY);
        hread(L_IN, DATA); -- When in read mode, this is the expected value
                
        case (INSTRUCTION) is
            when "READ" =>
                T_WRE_B <= '0';
                T_ADDR_B <= ADDRESS;
                wait until T_CLKB'event and T_CLKB = '1';
                wait until T_CLKB'event and T_CLKB = '1';
                assert (T_DATA_OUT_B = DATA) report "Address " & std_logic_vector'image(ADDRESS) & " does not contain " & std_logic_vector'image(DATA) severity failure;
            when "WRITE" =>
                T_WRE_A <= '1';
                T_ADDR_A <= ADDRESS;
                T_DATA_IN_A <= DATA;
                wait until T_CLKA'event and T_CLKB = '1';
                wait until T_CLKA'event and T_CLKB = '1';
            when others =>
                assert FALSE report "Instruction non recognized" severity failure;
        end case;
    end loop;
end process;


end Behavioral;
