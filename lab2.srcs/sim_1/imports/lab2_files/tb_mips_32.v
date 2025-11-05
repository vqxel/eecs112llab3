`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2021 10:40:29 AM
// Design Name: 
// Module Name: tb_mips_32
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


module tb_mips_32;
  reg clk;
  reg reset;
  // Outputs  
  wire [31:0] result;

  // Instantiate the Unit Under Test (UUT)  
  mips_32 uut (
      .clk(clk),
      .reset(reset),
      .result(result)
  );

  real points = 0;

  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end

  initial begin
    // Initialize Inputs  

    reset = 1;
    // Wait 100 ns for global reset to finish  
    #100;
    reset = 0;
  end
endmodule
