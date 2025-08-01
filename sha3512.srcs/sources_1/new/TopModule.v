`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2024 14:36:22
// Design Name: 
// Module Name: mainMod
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


module mainMod(
   input clk ,
   input rst ,
   input [63:0]in ,
   output reg done,
   output reg[511:0]out
    );
     
    reg [1599:0]mainIN;
    wire [1599:0]outputT;
    wire [1599:0]outputTr;
    wire [1599:0]outputR;
    wire [1599:0]outputC;
    wire [1599:0]outa;
    reg  rounds;
    reg [5:0] rc;
    wire [63:0]iota;
    wire [1599:0]outputP;
   
    
   reg[3:0] counter;
   always@(posedge clk or posedge rst) begin
     if(rst) begin 
     rounds<=0;// this is the part that keeps check of each of the rounds if round is over switch to 1 happens
     counter<=1; // this verifies each step in the round and keeps a count of it
    end else begin
       if(counter<2 )
       begin 
         counter<=counter+1;
         rounds<=0;
       end else begin
         counter<=0;
         rounds<=1;
       end
     end  
   end
  wire [64:0]padded_message;
 // little endian to big endian convertion 
 assign padded_message = {in[7:0],   in[15:8],  in[23:16], in[31:24],
                             in[39:32], in[47:40], in[55:48], in[63:56]};
  
  //this always block is based on the rounds switching to loead new data every round
  always@(posedge rounds or posedge rst)begin
       if(rst)begin
        rc<=0;
        mainIN<=0;
       end else begin
       if(rc==0)begin
          mainIN<={padded_message,316'b0,4'b0110,640'b0,4'b1000,572'b0};
          
       end else begin
          mainIN<=outa;   // this part is responsible for replace the old round output     
       end
       rc<=rc+1;//keeping the round count in check
       end
  end
  
  
  wire [511:0] slice = outa[1599:1088];//these are used to conver each 64 bits into little endian
  //to big endian format since its standard output format
  
    always@(posedge done) begin
    if(done)begin
        out <= {
    {slice[455:448], slice[463:456], slice[471:464], slice[479:472],
     slice[487:480], slice[495:488], slice[503:496], slice[511:504]},  // Chunk 8
    {slice[391:384], slice[399:392], slice[407:400], slice[415:408],
     slice[423:416], slice[431:424], slice[439:432], slice[447:440]}, // Chunk 7
    {slice[327:320], slice[335:328], slice[343:336], slice[351:344],
     slice[359:352], slice[367:360], slice[375:368], slice[383:376]}, // Chunk 6
    {slice[263:256], slice[271:264], slice[279:272], slice[287:280],
     slice[295:288], slice[303:296], slice[311:304], slice[319:312]}, // Chunk 5
    {slice[199:192], slice[207:200], slice[215:208], slice[223:216],
     slice[231:224], slice[239:232], slice[247:240], slice[255:248]}, // Chunk 4
    {slice[135:128], slice[143:136], slice[151:144], slice[159:152],
     slice[167:160], slice[175:168], slice[183:176], slice[191:184]}, // Chunk 3
    {slice[71:64], slice[79:72], slice[87:80], slice[95:88],
     slice[103:96], slice[111:104], slice[119:112], slice[127:120]}, // Chunk 2
    {slice[7:0],   slice[15:8],  slice[23:16], slice[31:24],
     slice[39:32], slice[47:40], slice[55:48], slice[63:56]}   // Chunk 1
};
    end else begin     
            out<=0;
    end
  
  end
  
  always@(*)begin
   if(rc==25) begin    
    done=1;
   end else begin
    done=0;
        end
  
  end
   
    theta u1 (
        .clk(clk),
        .rst(rst),
        .in(mainIN),
        .out(outputT)  
    );
    
    rho u2 (
    .clk(clk),
    .rst(rst),
     .in(outputT),
        .out(outputR)
    );

    chi u4 (
    .clk(clk),
    .rst(rst),
    .in(outputR),
    .addr(rc+6'b111111),
        .out(outa)
    );

endmodule
