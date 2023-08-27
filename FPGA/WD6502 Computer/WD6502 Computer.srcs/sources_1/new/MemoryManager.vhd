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
use IEEE.NUMERIC_STD.ALL;

-- This modules manages the memory map of the computer. In this revision we have a very simple
-- map. 
--      $FFFF downto $EFFF is ROM, 1KB of ROM
--      $EFFE downto $0400 is RAM, 60KB of RAM (60,414)
--      $03FF downto $0200 is Memory mapped I/O, 511 bytes of I/O space
--      $01FF downto $0100 is processor reserved stack, 256 bytes of processor reserved stack space
--      $00FF downot $0001 is system reserved, unused for now.
--      $0000 is memory manager exception flags
--          $80 -> Write to illegal address exception. Attempt to write to ROM or status register or reserved memory area
--          $40 -> Read from illegal address exception (set only by the memmory mapped I/O subsystem)
-- This is a simple, nonconfigurable at runtime map. Longer term we'll probably want to mimic the Commodore 64 map with config bytes at $0000 and $0001
entity MemoryManager is
    Port ( BUS_DATA : inout STD_LOGIC_VECTOR (7 downto 0);
           BUS_ADDRESS : in STD_LOGIC_VECTOR (15 downto 0);
           CPU_CLOCK : in STD_LOGIC;
           WRITE_FLAG : in STD_LOGIC -- When 1, data to address, read address and store on data line otherwise
           );
end MemoryManager;

architecture Behavioral of MemoryManager is

constant DATA_WIDTH: natural := 8;
constant ADDRESS_WIDTH: natural := 16;

-- RAM signals
signal ram_addra: std_logic_VECTOR((ADDRESS_WIDTH - 1) downto 0);
signal ram_addrb: std_logic_VECTOR((ADDRESS_WIDTH - 1) downto 0);
signal ram_clka: std_logic;
signal ram_clkb: std_logic;
signal ram_dina: std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
signal ram_dinb: std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
signal ram_douta: std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
signal ram_doutb: std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
signal ram_wea: std_logic;
signal ram_web: std_logic;

signal rom_addra: std_logic_VECTOR((ADDRESS_WIDTH - 1) downto 0);
signal rom_douta: std_logic_VECTOR((DATA_WIDTH - 1) downto 0);
signal rom_clka: std_logic;
	
COMPONENT RAM is
    GENERIC(
    ADDRESS_WIDTH: natural := 16;
    DATA_WIDTH: natural := 8;
    RAM_DEPTH: natural := 2**15
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

COMPONENT ROM is
    PORT (
	addra: IN std_logic_VECTOR(15 downto 0);
	clka: IN std_logic;
	douta: OUT std_logic_VECTOR(7 downto 0)
  );
end COMPONENT;
begin

MAIN_RAM: RAM port map (
    addra => ram_addra,
    addrb => ram_addrb,
    dina => ram_dina,
    dinb => ram_dinb,
    douta => ram_douta,
    doutb => ram_doutb,
    wea => ram_wea,
    web => ram_web,
    clka => ram_clka,
    clkb => ram_clkb
); 

MAIN_ROM: ROM port map (
    addra => rom_addra,
    douta => rom_douta,
    clka => rom_clka
);

end Behavioral;
