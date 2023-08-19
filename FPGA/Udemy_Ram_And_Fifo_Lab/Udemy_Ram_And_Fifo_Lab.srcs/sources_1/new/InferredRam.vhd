----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/12/2023 05:46:19 PM
-- Design Name: 
-- Module Name: InferredRam - Behavioral
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
use work.all;
ENTITY inferred_ram IS
  GENERIC(
    ADDRESS_WIDTH: natural := 16;
    DATA_WIDTH: natural := 8
  );
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END inferred_ram;

-- Adapted from example on Page 516 of "Effective Coding with VHDL"
architecture inferred_ram_arch of inferred_ram is
    constant RAM_DEPTH: natural := 2**ADDRESS_WIDTH;
    type ram_contents_type is array (natural range<>) of std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal ram_contents: ram_contents_type (0 to RAM_DEPTH - 1);
begin

    process(clka)  
    variable write_address : natural := 0;
    begin
        if (wea = "1") then
            write_address := to_integer(unsigned(addra));
            ram_contents(write_address) <= dina;
        end if;
    end process;

    -- Note currently there is no synchronization between writes and reads
    -- Users must validate that writes to the same address are not in process during reads
    process(clkb)
    variable read_address : natural := 0;
    begin
        read_address := to_integer(unsigned(addrb));
        doutb <= ram_contents(read_address);
    end process;
end inferred_ram_arch;
