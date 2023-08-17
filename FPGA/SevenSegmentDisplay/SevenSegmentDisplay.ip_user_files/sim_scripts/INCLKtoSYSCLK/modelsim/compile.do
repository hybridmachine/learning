vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../ipstatic" \
"../../../../SevenSegmentDisplay.gen/sources_1/ip/INCLKtoSYSCLK/INCLKtoSYSCLK_clk_wiz.v" \
"../../../../SevenSegmentDisplay.gen/sources_1/ip/INCLKtoSYSCLK/INCLKtoSYSCLK.v" \


vlog -work xil_defaultlib \
"glbl.v"

