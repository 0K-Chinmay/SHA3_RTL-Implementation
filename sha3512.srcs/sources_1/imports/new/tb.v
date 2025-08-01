`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2024 11:54:59
// Design Name: 
// Module Name: showOut
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

module tb;
localparam R=1600;
    reg clk;
    reg rst;
    reg [63:0] state_in1;
    wire [511:0] state_out1;
    wire done;
    // Instantiate the Keccak round FSM
    mainMod uut (
        .clk(clk),
        .rst(rst),
        .done(done),
        .in(state_in1),
        .out(state_out1)   
    );
    // Clock generation
    //assign state_out1=0;
    always #1 clk = ~clk; // 10 time units period
    initial begin
        clk = 0;
        rst = 1;
        state_in1=0;
        #10;
        rst = 0; 
        //state_out1=0;
        // Apply reset
        state_in1=64'h0;
        #2;
               
        //state_in1=64'h1f877c;      
        wait(done);
        #2;
       
        state_in1=0;
        #20;
        rst = 1; 
        state_in1= 
                  { $random, $random, $random, $random, $random, 
                   $random, $random, $random, $random, $random
                  };
                    
        #20;
          rst = 0;  
        #10;   
       
        wait(done);
       /* state_in1=0;
        #10;
        rst = 1;   
        #10;
          rst = 0;  
        #10;   
        state_in1={$random, $random, $random, $random, $random, 
                   $random, $random, $random, $random, $random, 
                   $random, $random, $random, $random, $random, 
                   $random, $random, $random, $random, $random
                  };
                  
        wait(done);
        state_in1=0;
        #10;
        rst = 1;   
        #10;*/
        #100;
        $finish;
      
      /*
      
      146 cycles 
      
      
      
      
      
      */
      
      
     endmodule
  