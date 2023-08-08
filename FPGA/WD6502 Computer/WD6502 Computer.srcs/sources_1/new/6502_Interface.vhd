----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/08/2023 04:00:45 PM
-- Design Name: 
-- Module Name: 6502_Interface - Behavioral
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

entity WD6502_Interface is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CPU_STATUS : out STD_LOGIC_VECTOR (7 downto 0);
           BUS_DATA : inout STD_LOGIC_VECTOR (7 downto 0);
           BUS_ADDRESS : in STD_LOGIC_VECTOR (15 downto 0);
           CPU_CONTROL : inout STD_LOGIC_VECTOR (8 downto 0));
end WD6502_Interface;

architecture Behavioral of WD6502_Interface is
-- PIN indexes for CPU_CONTROL vector
constant CPU_PHI2 : integer := 0;   -- CPU CLOCK
constant CPU_RESB : integer := 1;   -- CPU RESET
constant CPU_RDY : integer := 2;    -- CPU READY
constant CPU_IRQB : integer := 3;   -- Maskable Interrupt
constant CPU_NMIB : integer := 4;   -- Non Maskable Interrupt (Hardware)
constant CPU_SYNC : integer := 5;   -- CPU Is requesting op code on this cycle
constant CPU_VPB : integer := 6;    -- Interrupt vector being processed
constant CPU_RWB : integer := 7;    -- Read/Write flag
constant CPU_BE : integer := 8;     -- Bus Enable

begin


end Behavioral;
