----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/25/2023 10:54:25 AM
-- Design Name: 
-- Module Name: T_BootW65C02 - Behavioral
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

entity T_BootW65C02 is
--  Port ( );
end T_BootW65C02;

architecture Behavioral of T_BootW65C02 is
    component BootW65C02 is
    Port ( RESET : in STD_LOGIC;
           --single_step_mode : in STD_LOGIC;
           --step : in STD_LOGIC;
           RESET_STATUS : out STD_LOGIC;
           FPGA_CLOCK : in STD_LOGIC;
           RDY : inout STD_LOGIC;
           ADDRESS_BUS : inout STD_LOGIC_VECTOR (15 downto 0);
           PHI2 : out STD_LOGIC           
           );
    end component;
    
    signal T_RESET, T_CLOCK, T_RDY, T_PHI2, T_RESET_STATUS : STD_LOGIC;
    signal T_ADDRESS_BUS : STD_LOGIC_VECTOR (15 downto 0);
    
begin
    DUT: BootW65C02 port map (
        RESET => T_RESET,
        RESET_STATUS => T_RESET_STATUS,
        FPGA_CLOCK => T_CLOCK,
        RDY => T_RDY,
        ADDRESS_BUS => T_ADDRESS_BUS,
        PHI2 => T_PHI2
    );

process
    constant loopN : integer := 14;
begin
    T_RESET <= '0'; -- Low for reset
    wait for 42ns;
    T_RESET <= '1';
    
    for i in 0 to loopN - 1 loop
        T_CLOCK <= '1';
        wait for 42ns;
        T_CLOCK <= '0';
        wait for 42ns;
    end loop;
    assert (T_RESET_STATUS = '1') report "Reset is active too early!";
    
    T_CLOCK <= '1';
    wait for 42ns;
    T_CLOCK <= '0';
    wait for 42ns;
    assert (T_RESET_STATUS = '0') report "Reset is still in low state!";
    
end process;
end Behavioral;
