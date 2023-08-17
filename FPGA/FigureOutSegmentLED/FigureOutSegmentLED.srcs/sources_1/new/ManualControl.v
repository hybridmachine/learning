`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2023 12:30:39 PM
// Design Name: 
// Module Name: ManualControl
// Project Name: 
// Target Devices: 
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


module ManualControl(
    CAT, // Drive the Segment cathode
    ANO, // Drive the Segment anode
    SWINC, // Cathode Control SW0 through SW6
    SWINA // Anode Control S7 through S10
    );
    
    output[7:0]CAT;
    input [7:0]SWINC;
    output[3:0]ANO;
    input [3:0]SWINA;
    
    assign CAT = ~SWINC;
    assign ANO = ~SWINA;
endmodule
