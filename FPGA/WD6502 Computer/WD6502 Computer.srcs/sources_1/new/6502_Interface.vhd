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
    Port ( CLOCK : in STD_LOGIC; -- Assume 100mhz clock
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

constant FPGA_CLOCK_MHZ : integer := 100;

-- Assuming a 100mhz FPGA clock, we'll divide our counter by this amount.
-- Remember that we want 50% duty cycle so if we want a 1mhz clock, we divide by 50mhz to get half of our duty cycle
constant CPU_CLOCK_DIVIDER : integer := 2;   

-- From the WD65C02 spec 
-- When a positive edge (on RESB) is detected, there will be a reset sequence lasting seven clock cycles.
constant CPU_RESET_HOLDOFF_CLOCKTICKS : integer := 7; 

type CPU_STATE is ( RESET_START,
                    RESET_COMPLETE,
                    READY,
                    OPCODE_FETCH,
                    READ_DATA,
                    WRITE_DATA,
                    STANDBY);

signal NEXT_CPU_STATE : CPU_STATE;
signal CURRENT_CPU_STATE : CPU_STATE;

signal WD6502_CLOCK : std_logic;
begin

wd6502_clockmachine : process (CLOCK, RESET)
variable FPGA_CLOCK_COUNTER_FOR_CPU : integer range 0 to FPGA_CLOCK_MHZ;
begin
    if (RESET = '1') then
        FPGA_CLOCK_COUNTER_FOR_CPU := 1;
        WD6502_CLOCK <= '0';
    elsif (CLOCK'event and CLOCK = '1') then
        if (FPGA_CLOCK_COUNTER_FOR_CPU = FPGA_CLOCK_MHZ / CPU_CLOCK_DIVIDER) then
            FPGA_CLOCK_COUNTER_FOR_CPU := 1;
            WD6502_CLOCK <= not WD6502_CLOCK;
        else
            FPGA_CLOCK_COUNTER_FOR_CPU := FPGA_CLOCK_COUNTER_FOR_CPU + 1;
            WD6502_CLOCK <= WD6502_CLOCK; -- Is this needed?
        end if;
    end if;
end process wd6502_clockmachine;

wd6502_statemachine : process (CLOCK, RESET)
begin
    if (RESET = '1') then
        NEXT_CPU_STATE <= RESET_START;
    else
        case CURRENT_CPU_STATE is
            when RESET_START =>
                -- We need to hold RESB low for at least 2 CPU clock cycles
                
                -- Next we need to set RESB high and then wait for 7 CPU clock cycles 
                -- before transitioning to RESET_COMPLETE
            when RESET_COMPLETE =>
                -- Transition to READY
            when READY =>
                -- When SYNC goes high, CPU is reading an opcode
            
            when READ_DATA =>
            when WRITE_DATA =>
            when OPCODE_FETCH =>
            
            when STANDBY =>
            when others =>
        end case;
    end if;
end process wd6502_statemachine;

wd6502_updatestate : process (CLOCK,RESET)
begin
    if (RESET = '1') then
        CURRENT_CPU_STATE <= RESET_START;
    elsif (CLOCK'event and CLOCK = '1') then
        CURRENT_CPU_STATE <= NEXT_CPU_STATE;
    else
        CURRENT_CPU_STATE <= CURRENT_CPU_STATE;
    end if;
end process wd6502_updatestate;

end Behavioral;
