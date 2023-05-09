`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brian Tabone 
// 
// Create Date: 04/22/2023 06:01:20 PM
// Design Name: 
// Module Name: BlinkLEDs
// Project Name: 
// Target Devices: Artix 7 on Basys 3
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BlinkLEDs(
    input CLOCK_IN,
    input RESET,
    output OUT_HIGH,
    output OUT_LOW,
    output NOT_LOW
    );
    
//--------Internal Variables-----
reg[31:0]blinkcount;


//---internal signals-----
wire clk_in;
wire reset_in;

assign clk_in = CLOCK_IN;
assign reset_in = RESET;
assign OUT_HIGH = blinkcount[25];
assign OUT_LOW = blinkcount[24];

not(NOT_LOW, OUT_LOW);

always @(posedge clk_in)

if (reset_in) begin
    blinkcount <= 32'b0;
end

else

begin
    blinkcount <= blinkcount + 1;
end


endmodule
