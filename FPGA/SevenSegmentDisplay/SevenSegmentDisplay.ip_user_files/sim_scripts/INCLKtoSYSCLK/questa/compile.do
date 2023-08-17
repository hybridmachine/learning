vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../ipstatic" \
"../../../../SevenSegmentDisplay.gen/sources_1/ip/INCLKtoSYSCLK/INCLKtoSYSCLK_clk_wiz.v" \
"../../../../SevenSegmentDisplay.gen/sources_1/ip/INCLKtoSYSCLK/INCLKtoSYSCLK.v" \


vlog -work xil_defaultlib \
"glbl.v"

