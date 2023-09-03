----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/02/2023 12:25:28 PM
-- Design Name: 
-- Module Name: WD65C02_SIMULATOR - Behavioral
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

-- Simple WD65C02 simulator, to test the WD65C02 interface and support FPGA based peripherial chips
entity WD65C02_SIMULATOR is
    Port ( PHI2 : in STD_LOGIC;
           PHI1O : out STD_LOGIC;
           PHI2O : out STD_LOGIC;
           RESB : in STD_LOGIC;
           RDY : in STD_LOGIC;
           IRQB : in STD_LOGIC;
           NMIB : in STD_LOGIC;
           SYNC : out STD_LOGIC;
           VPB : in STD_LOGIC;
           RWB : out STD_LOGIC;
           BE : in STD_LOGIC;
           ADDRESS : inout STD_LOGIC_VECTOR (15 downto 0);
           DATA : inout STD_LOGIC_VECTOR (7 downto 0));
end WD65C02_SIMULATOR;
                    
architecture Behavioral of WD65C02_SIMULATOR is

type CPU_STATE is ( RESET_START,
                    RESET_COMPLETE,
                    READ_BOOT_LOW,
                    READ_BOOT_HIGH,
                    EXECUTING,
                    READY,
                    OPCODE_FETCH,
                    READ_DATA,
                    WRITE_DATA,
                    STANDBY);

signal NEXT_CPU_STATE : CPU_STATE;
signal CURRENT_CPU_STATE : CPU_STATE;

signal REGISTER_A : std_logic_vector(7 downto 0);
signal REGISTER_X : std_logic_vector(7 downto 0);
signal REGISTER_Y : std_logic_vector(7 downto 0);
signal PROGRAM_COUNTER : std_logic_vector (15 downto 0);
signal REGISTER_STATUS : std_logic_vector (7 downto 0);
signal STACK_POINTER : std_logic_vector (8 downto 0); -- Bit 8 is always 1, on 65C02 stack is $100 to $1FF

signal CURRENT_INSTRUCTION : std_logic_vector(23 downto 0); -- ADH | ADL | OPCODE

-- The WD65C02 takes 7 clock ticks after reset goes back to high before 
constant RESET_CLOCK_TICKS : natural := 7;

begin

-- Not sure we'll ever use these but to be thorough, added here
PHI1O <= not PHI2;
PHI2O <= PHI2;

-- The processor state machine
process(PHI2)
variable RESET_CLOCK_TIMER : natural := 0; -- Count 7 cycles after a reset before processor is ready
variable JUMP_TO_BOOT_VECTOR : std_logic := '1';

begin
    NEXT_CPU_STATE <= CURRENT_CPU_STATE;
    if (RESB = '0') then
        NEXT_CPU_STATE <= RESET_START;
    elsif (PHI2'event and PHI2 = '1') then
        -- Signal default values when not otherwise set by state machine
        RWB <= '0';
        SYNC <= '0';

        case CURRENT_CPU_STATE is
            when RESET_COMPLETE =>
                CURRENT_INSTRUCTION <= x"0000";
                REGISTER_A <= x"00";
                REGISTER_X <= x"00";
                REGISTER_Y <= x"00";
                PROGRAM_COUNTER <= x"FFFC";
                NEXT_CPU_STATE <= READ_BOOT_LOW;
            when READ_BOOT_LOW =>
                RWB <= '1';
                SYNC <= '1';
                if (PROGRAM_COUNTER = x"FFFC")
                then
                    ADDRESS <= PROGRAM_COUNTER;
                    PROGRAM_COUNTER <= x"FFFD";
                else
                    NEXT_CPU_STATE <= READ_BOOT_HIGH;
                    CURRENT_INSTRUCTION(7 downto 0) <= DATA;            
                end if;
            when READ_BOOT_HIGH =>
                RWB <= '1';
                SYNC <= '1';

                if (PROGRAM_COUNTER = x"FFFD")
                then
                    ADDRESS <= PROGRAM_COUNTER;
                    PROGRAM_COUNTER <= x"FFFE"; -- Will get updated by instruction (typically a jump on boot)
                else
                    NEXT_CPU_STATE <= EXECUTING;
                    CURRENT_INSTRUCTION(15 downto 8) <= DATA;
                end if;
             when EXECUTING =>
                
            when others =>
                NEXT_CPU_STATE <= RESET_START;
        end case;
        if (RESET_CLOCK_TIMER > 0) then
            RESET_CLOCK_TIMER := RESET_CLOCK_TIMER - 1;
        else
            if (JUMP_TO_BOOT_VECTOR = '1') then
                RWB <= '1';
                ADDRESS <= x"FFFC";
            else
            end if;
            -- Normal Processing
        end if;
    end if;
end process;

process(NEXT_CPU_STATE)
variable RESET_CLOCK_TIMER : natural := 0; -- Count 7 cycles after a reset before processor is ready
variable JUMP_TO_BOOT_VECTOR : std_logic := '1';
begin
    case NEXT_CPU_STATE is
        when RESET_START =>
            if (RESET_CLOCK_TIMER > 0) then
                RESET_CLOCK_TIMER := RESET_CLOCK_TIMER - 1;
            else
                CURRENT_CPU_STATE <= RESET_COMPLETE;
            end if;
        when READ_BOOT_LOW =>
            CURRENT_CPU_STATE <= READ_BOOT_LOW; -- Passthrough, will read and store in instruction storage        
        when READ_BOOT_HIGH =>
            CURRENT_CPU_STATE <= READ_BOOT_HIGH; -- Passthrough
        when EXECUTING =>
            -- Decode the instruction in the current_instruction vector
        when others => 
            CURRENT_CPU_STATE <= RESET_START;
    end case;
end process;

end Behavioral;
