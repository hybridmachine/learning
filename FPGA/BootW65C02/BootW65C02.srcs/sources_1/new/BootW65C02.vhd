----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2023 03:14:55 PM
-- Design Name: 
-- Module Name: BootW65C02 - Behavioral
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

entity BootW65C02 is
    Port ( RESET : in STD_LOGIC;
           --single_step_mode : in STD_LOGIC;
           --step : in STD_LOGIC;
           RESET_STATUS : out STD_LOGIC;
           FPGA_CLOCK : in STD_LOGIC;
           RDY : inout STD_LOGIC;
           ADDRESS_BUS : inout STD_LOGIC_VECTOR (15 downto 0);
           PHI2 : out STD_LOGIC           
           );
end BootW65C02;

architecture Behavioral of BootW65C02 is
    component cpu_clock
    port
     (-- Clock in ports
      -- Clock out ports
      clk_out1          : out    std_logic;
      clk_in1           : in     std_logic
     );
    end component;
    
    component W65C02_Interface is
    Port ( --VPB : in STD_LOGIC; -- Vector Pull
           RDY : inout STD_LOGIC; -- Ready
           --PHI1O : in STD_LOGIC; -- Inverse of PHI2 clock in
           --IRQB : out STD_LOGIC; -- Interrupt request
           --MLB : in STD_LOGIC; -- Memory lock, used in multi processor systems
           --NMIB : out STD_LOGIC; -- Non maskable interrupt
           --SYNC : in STD_LOGIC;
           AddressBus : inout STD_LOGIC_VECTOR (15 downto 0);
           --DataBus : inout STD_LOGIC_VECTOR (7 downto 0);
           --RWB : in STD_LOGIC;
           --BE : out STD_LOGIC;
           PHI2 : out STD_LOGIC;
           --SOB : out STD_LOGIC;
           --PHI2O : in STD_LOGIC;
           RESB_SIGNAL : in STD_LOGIC;
           RESB : OUT STD_LOGIC;
           CPU_CLOCK : in STD_LOGIC);
    end component;

    signal VPB : STD_LOGIC; -- Vector Pull
    signal PHI1O : STD_LOGIC; -- Inverse of PHI2 clock in
    signal IRQB : STD_LOGIC; -- Interrupt request
    signal MLB : STD_LOGIC; -- Memory lock, used in multi processor systems
    signal NMIB : STD_LOGIC; -- Non maskable interrupt
    signal SYNC : STD_LOGIC;
    signal DataBus : STD_LOGIC_VECTOR (7 downto 0);
    signal RWB : STD_LOGIC;
    signal BE : STD_LOGIC;
    
    signal base_clock_signal : STD_LOGIC; -- 10mhz, if FPGA clock is not 12mhz, update settings in cpu_clock IP
    signal clock_divider : STD_LOGIC_VECTOR(4 downto 0) := "00000";
    signal SOB : STD_LOGIC;
    signal PHI2O : STD_LOGIC;
    signal CPU_CLOCK_IFC : STD_LOGIC := '0';
begin


w65c02_clock : cpu_clock
   port map ( 
  -- Clock out ports  
   clk_out1 => base_clock_signal,
   -- Clock in ports
   clk_in1 => FPGA_CLOCK
 );

w65c02_iface : W65C02_Interface
    port map (
        --VPB  =>  VPB  ,
        RDY  =>  RDY  ,
        --PHI1O  =>  PHI1O  ,
        --IRQB  =>  IRQB  ,
        --MLB  =>  MLB  ,
        --NMIB  =>  NMIB  ,
        --SYNC  =>  SYNC  ,
        AddressBus  =>  ADDRESS_BUS  ,
        --DataBus  =>  DataBus  ,
        --RWB  =>  RWB  ,
        --BE  =>  BE  ,
        PHI2  =>  PHI2  ,
        --SOB  =>  SOB  ,
        --PHI2O  =>  PHI2O  ,
        RESB_SIGNAL  =>  RESET, -- Control signal going into processor
        RESB => RESET_STATUS, -- As reported by the processor interface, which controls the delay
        CPU_CLOCK => CPU_CLOCK_IFC  
    );

process (base_clock_signal, RESET)
begin
    if(rising_edge(base_clock_signal)) then
        clock_divider <= clock_divider + 1;
        if (unsigned(clock_divider) >= 5) then
            clock_divider <= "00000";
            CPU_CLOCK_IFC <= not(CPU_CLOCK_IFC); -- Toggle clock signal every 5 clocks of the base clock  
        end if;
    end if;
end process;

end Behavioral;
