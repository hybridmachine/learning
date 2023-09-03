----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/26/2023 11:43:29 AM
-- Design Name: 
-- Module Name: T_SIMULATE_6502 - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- In this test we connected the WD6502 interface to a simulation 65C02 and test various
-- CPU state transitions and reads/writes
entity T_SIMULATE_6502 is
--  Port ( );
end T_SIMULATE_6502;

architecture Behavioral of T_SIMULATE_6502 is

COMPONENT WD6502_Interface is
    Port ( CLOCK : in STD_LOGIC; -- Assume 100mhz clock
           RESET : in STD_LOGIC;
           -- CPU_STATUS : out STD_LOGIC_VECTOR (7 downto 0);
           BUS_DATA : inout STD_LOGIC_VECTOR (7 downto 0);
           BUS_ADDRESS : in STD_LOGIC_VECTOR (15 downto 0);
           CPU_CONTROL : inout STD_LOGIC_VECTOR (10 downto 0);
           CPU_CLOCK : out STD_LOGIC);
end COMPONENT;

constant T_CLOCK_PERIOD : time := 10ns; -- 100MHZ
signal T_CLOCK : STD_LOGIC;
signal T_RESET : STD_LOGIC;
signal T_BUS_DATA : STD_LOGIC_VECTOR (7 downto 0);
signal T_BUS_ADDRESS : STD_LOGIC_VECTOR (15 downto 0);
signal T_CPU_CONTROL : STD_LOGIC_VECTOR(10 downto 0);
signal T_CPU_CLOCK : STD_LOGIC;

-- PIN indexes for CPU_CONTROL vector
constant CPU_BE :integer := 0;      -- Bus Enable
constant CPU_IRQB :integer := 1;    -- Interrupt Request
constant CPU_MLB :integer := 2;     -- Memory Lock
constant CPU_NMIB :integer := 3;    -- Non-Maskable Interrupt
constant CPU_RDY :integer := 4;     -- Ready
constant CPU_RESB :integer := 5;    -- Reset
constant CPU_RWB :integer := 6;     -- Read/Write
constant CPU_SOB :integer := 7;     -- Set Overflow
constant CPU_SYNC :integer := 8;    -- Synchronize
constant CPU_VPB :integer := 9;     -- Vector Pull

begin

DUT : WD6502_Interface PORT MAP (
    CLOCK => T_CLOCK,
    RESET => T_RESET,
    BUS_DATA => T_BUS_DATA,
    BUS_ADDRESS => T_BUS_ADDRESS,
    CPU_CONTROL => T_CPU_CONTROL,
    CPU_CLOCK => T_CPU_CLOCK     
);

-- T_CLOCK process
process
begin
    T_CLOCK <= '0';
    wait for T_CLOCK_PERIOD / 2;
    T_CLOCK <= '1';
    wait for T_CLOCK_PERIOD / 2;
end process;

-- Check that the CPU clock is 1/100 the FPGA clock, we want 1mhz for the CPU clock
process(T_CLOCK,T_CPU_CLOCK)
variable T_CLOCK_TICKS : natural := 0;
variable RESET_VALUE : std_logic := '1';
variable CHECK_CPU_CLOCK_LATCH : std_logic := '0';

begin
    T_RESET <= RESET_VALUE;
    
    if (T_CLOCK_TICKS > 200) then
        RESET_VALUE := '0';
        -- From now on T_CPU_CLOCK should tick so this should only fire once
    end if;
    
    if (T_CLOCK'event and T_CLOCK = '1') then
        T_CLOCK_TICKS := T_CLOCK_TICKS + 1;
    end if;
    if (T_CPU_CLOCK'event and T_CPU_CLOCK = '1') then
        if (CHECK_CPU_CLOCK_LATCH = '0') then
            CHECK_CPU_CLOCK_LATCH := '1';
        else
            assert (T_CLOCK_TICKS < 101) report "CPU Clock is too fast: " & integer'image(T_CLOCK_TICKS) severity failure;
        end if;
        T_CLOCK_TICKS := 0;
    end if;
end process;
end Behavioral;

