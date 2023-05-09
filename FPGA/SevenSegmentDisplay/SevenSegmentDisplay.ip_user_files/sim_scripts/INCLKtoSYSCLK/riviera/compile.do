vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" \
"../../../../SevenSegmentDisplay.gen/sources_1/ip/INCLKtoSYSCLK/INCLKtoSYSCLK_clk_wiz.v" \
"../../../../SevenSegmentDisplay.gen/sources_1/ip/INCLKtoSYSCLK/INCLKtoSYSCLK.v" \


vlog -work xil_defaultlib \
"glbl.v"

