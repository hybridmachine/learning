----------------------------------------------------------------------------------
-- Engineer: Brian Tabone
-- 
-- Create Date: 08/08/2023 04:00:45 PM
-- Design Name: 
-- Module Name: RAM - inferred_ram
-- Project Name: WD6502 Computer
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    GENERIC(
    ADDRESS_WIDTH: natural := 16;
    DATA_WIDTH: natural := 8;
    RAM_DEPTH: natural := 2**16 -- By default 65kb ram can be adjusted to leave address space for I/O
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
end RAM;

-- Adapted from example on Page 516 of "Effective Coding with VHDL"
architecture inferred_ram_arch of RAM is
    type ram_contents_type is array (natural range<>) of std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal ram_contents: ram_contents_type (0 to RAM_DEPTH - 1);
begin

    -- Since port A and B read and write to the same signal (memory) they
    -- must live inside the same process
    process(clka,clkb)
    variable write_address : natural := 0;
    variable read_address : natural := 0;
    begin
        -- Note no protection, if caller writes via A and B , no 
        -- locking of address occurs, synchronizing ports is the caller's
        -- responsibility
        if (clka'event and clka = '1') then
            if (wea = '1') then
                write_address := to_integer(unsigned(addra));
                ram_contents(write_address) <= dina;
            else
                read_address := to_integer(unsigned(addra));
                douta <= ram_contents(read_address);
            end if;
        end if;
        
        if (clkb'event and clkb = '1') then
            if (web = '1') then
                write_address := to_integer(unsigned(addrb));
                ram_contents(write_address) <= dinb;
            else
                read_address := to_integer(unsigned(addrb));
                doutb <= ram_contents(read_address);
            end if;
        end if;
    end process;
end inferred_ram_arch;
