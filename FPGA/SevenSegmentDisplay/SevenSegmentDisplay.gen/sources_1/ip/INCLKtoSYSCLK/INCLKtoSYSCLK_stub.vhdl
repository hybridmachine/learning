-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
-- Date        : Sat Apr 29 11:29:26 2023
-- Host        : BTABONE-MATH1 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/brian/source/repos/hybridmachine/learning/FPGA/SevenSegmentDisplay/SevenSegmentDisplay.gen/sources_1/ip/INCLKtoSYSCLK/INCLKtoSYSCLK_stub.vhdl
-- Design      : INCLKtoSYSCLK
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity INCLKtoSYSCLK is
  Port ( 
    clk_out1 : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end INCLKtoSYSCLK;

architecture stub of INCLKtoSYSCLK is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,clk_in1";
begin
end;
