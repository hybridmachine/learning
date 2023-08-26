----------------------------------------------------------------------------------
-- Engineer: Brian Tabone
-- 
-- Create Date: 08/08/2023 04:00:45 PM
-- Design Name: 
-- Module Name: MemoryManager - Behavioral
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

entity MemoryManager is
    GENERIC(
        ADDRESS_WIDTH: natural := 16;
        DATA_WIDTH: natural := 8
    );
    Port ( BUS_DATA : inout STD_LOGIC_VECTOR ((DATA_WIDTH - 1) downto 0);
           BUS_ADDRESS : in STD_LOGIC_VECTOR ((ADDRESS_WIDTH - 1) downto 0);
           CPU_CLOCK : in STD_LOGIC;
           WRITE_FLAG : in STD_LOGIC -- When 1, data to address, read otherwise
           );
end MemoryManager;

architecture Behavioral of MemoryManager is

-- RAM signals
signal addra: std_logic_VECTOR((ADDRESS_WIDTH - 1) downto 0);
signal addrb: std_logic_VECTOR((ADDRESS_WIDTH - 1) downto 0);
signal clka: std_logic;
signal	clkb: std_logic;
signal	dina: std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
signal	dinb: std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
signal	douta: std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
signal	doutb: std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
signal	wea: std_logic;
signal	web: std_logic;
	
COMPONENT RAM is
    GENERIC(
    ADDRESS_WIDTH: natural := 16;
    DATA_WIDTH: natural := 8;
    RAM_DEPTH: natural := 2**16
  );
    PORT (
	addra: IN std_logic_VECTOR((ADDRESS_WIDTH - 1) downto 0);
	addrb: IN std_logic_VECTOR((ADDRESS_WIDTH - 1) downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
	dinb: IN std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
	douta: OUT std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
	doutb: OUT std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
	wea: IN std_logic;
	web: IN std_logic
  );
end COMPONENT;
begin

MAIN_RAM: RAM port map (
    addra => addra,
    addrb => addrb,
    dina => dina,
    dinb => dinb,
    douta => douta,
    doutb => doutb,
    wea => wea,
    web => web,
    clka => clka,
    clkb => clkb
); 


end Behavioral;
