----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/20/2023 11:41:06 AM
-- Design Name: 
-- Module Name: dp_mem_inferred - Behavioral
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

architecture dp_mem_inferred of dp_mem is
    -- Assumption is A and B ports have same address and data width
    constant ADDRESS_WIDTH: natural := addra'length;
    constant DATA_WIDTH: natural := dina'length;

    constant RAM_DEPTH: natural := 2**ADDRESS_WIDTH;
    type ram_contents_type is array (natural range<>) of std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal ram_contents: ram_contents_type (0 to RAM_DEPTH - 1);
begin
    process(clka,clkb)
    variable write_address : natural := 0;
    variable read_address : natural := 0;
    begin
        -- Note no protection, if caller writes via A and B , no 
        -- locking of address occurs, synchronizing ports is the caller's
        -- responsibility
        if (wea = '1') then
            write_address := to_integer(unsigned(addra));
            ram_contents(write_address) <= dina;
        else
            read_address := to_integer(unsigned(addra));
            douta <= ram_contents(read_address);
        end if;
        
        if (web = '1') then
            write_address := to_integer(unsigned(addrb));
            ram_contents(write_address) <= dinb;
        else
            read_address := to_integer(unsigned(addrb));
            doutb <= ram_contents(read_address);
        end if;
    end process;
end dp_mem_inferred;
