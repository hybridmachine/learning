----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2023 03:48:01 PM
-- Design Name: 
-- Module Name: W65C02_Interface - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Interface to the W65C02, out on the interface is in on the chip and vice versa
-- See https://www.westerndesigncenter.com/wdc/documentation/w65c02s.pdf for full details
entity W65C02_Interface is
    Port ( VPB : in STD_LOGIC; -- Vector Pull
           RDY : inout STD_LOGIC; -- Ready
           PHI1O : in STD_LOGIC; -- Inverse of PHI2 clock in
           IRQB : out STD_LOGIC; -- Interrupt request
           MLB : in STD_LOGIC; -- Memory lock, used in multi processor systems
           NMIB : out STD_LOGIC; -- Non maskable interrupt
           SYNC : in STD_LOGIC;
           AddressBus : inout STD_LOGIC_VECTOR (15 to 0);
           DataBus : inout STD_LOGIC_VECTOR (7 to 0);
           RWB : in STD_LOGIC;
           BE : out STD_LOGIC;
           PHI2 : out STD_LOGIC;
           SOB : out STD_LOGIC;
           PHI2O : in STD_LOGIC;
           RESB : inout STD_LOGIC;
           CPU_CLOCK : in STD_LOGIC);
end W65C02_Interface;

architecture Behavioral of W65C02_Interface is

signal ready : std_logic_vector (3 to 0);
begin

    process(CPU_CLOCK)
    begin
        if(rising_edge(CPU_CLOCK)) then
            PHI2 <= '1';
            if (unsigned(ready) < 15) then
                RDY <= '0';
                ready <= ready + 1;
            else
                RDY <= '1';
            end if; 
        end if;
        
        if(falling_edge(CPU_CLOCK)) then
           PHI2 <= '0';
        end if;
    end process;
    
end Behavioral;
