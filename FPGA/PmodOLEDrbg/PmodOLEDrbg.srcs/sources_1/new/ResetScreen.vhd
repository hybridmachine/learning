----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Brian Tabone
-- 
-- Create Date: 05/13/2023 10:45:25 AM
-- Design Name: 
-- Module Name: ResetScreen - Behavioral
-- Project Name: PmodOLEDrgb
-- Target Devices: Basys3 / Artix 7
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: This module resets the screen per methods layed out in
-- https://digilent.com/reference/pmod/pmodoledrgb/reference-manual
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

entity ResetScreen is
  GENERIC(
    clk_freq        : INTEGER := 25); --system clock frequency in MHz
  Port (
    clock   : IN     STD_LOGIC;
    reset_n         : IN     STD_LOGIC;                     --active low reset
    miso            : IN     STD_LOGIC;                     --SPI master in, slave out
    mosi            : OUT    STD_LOGIC;                     --SPI master out, slave in
    sclk            : BUFFER STD_LOGIC;                     --SPI clock
    cs_n            : OUT    STD_LOGIC                     --pmod chip select  
    );
end ResetScreen;

architecture Behavioral of ResetScreen is

TYPE machine IS(start, initiate_transaction, byte_transact, byte_pause); --needed states
  SIGNAL state       : machine := start;               --state machine
  SIGNAL spi_ena     : STD_LOGIC;                      --enable for SPI bus
  SIGNAL spi_tx      : STD_LOGIC_VECTOR(7 DOWNTO 0);   --latest data byte received by SPI
  SIGNAL spi_busy    : STD_LOGIC;                      --busy signal from spi bus
  SIGNAL clk_out1    : std_logic;                      --Generated clock out (25mhz)
  
--declare SPI Master component
  COMPONENT spi_master IS
    GENERIC(
      slaves  : INTEGER := 1;   --number of spi slaves
      d_width : INTEGER := 8);  --data bus width
    PORT(
      clock   : IN     STD_LOGIC;                             --system clock, 100mhz
      reset_n : IN     STD_LOGIC;                             --asynchronous reset
      enable  : IN     STD_LOGIC;                             --initiate transaction
      cpol    : IN     STD_LOGIC;                             --spi clock polarity
      cpha    : IN     STD_LOGIC;                             --spi clock phase
      cont    : IN     STD_LOGIC;                             --continuous mode command
      clk_div : IN     INTEGER;                               --system clock cycles per 1/2 period of sclk
      addr    : IN     INTEGER;                               --address of slave
      tx_data : IN     STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  --data to transmit
      miso    : IN     STD_LOGIC;                             --master in, slave out
      sclk    : BUFFER STD_LOGIC;                             --spi clock
      ss_n    : BUFFER STD_LOGIC_VECTOR(slaves-1 DOWNTO 0);   --slave select
      mosi    : OUT    STD_LOGIC;                             --master out, slave in
      busy    : OUT    STD_LOGIC;                             --busy / data ready signal
      rx_data : OUT    STD_LOGIC_VECTOR(d_width-1 DOWNTO 0)); --data received
  END COMPONENT spi_master;
  
  component clk_wiz_0
    port
     (-- Clock in ports
      -- Clock out ports
      clk_out1          : out    std_logic;
      clk_in1           : in     std_logic
     );
    end component;
  
begin


sysClock : clk_wiz_0
   port map ( 
  -- Clock out ports  
   clk_out1 => clk_out1,
   -- Clock in ports
   clk_in1 => clock
 );
 
 --instantiate and configure the SPI Master component
  spi_master_0:  spi_master
    GENERIC MAP(slaves => 1, d_width => 8)
    PORT MAP(clock => clk_out1, reset_n => reset_n, enable => spi_ena, cpol => '0',
             cpha => '0', cont => '0', clk_div => clk_freq/2, addr => 0,
             tx_data => spi_tx, miso => miso, sclk => sclk, ss_n => open,
             mosi => mosi, busy => spi_busy);
             
end Behavioral;
