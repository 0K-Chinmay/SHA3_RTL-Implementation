

module rho(
input clk,
input rst,
input [1599:0] in,
output reg [1599:0] out
);
  reg [63:0] A[4:0][4:0];
  wire [5:0] rotCO[4:0][4:0];
   reg [63:0] Y[4:0][4:0];
  
assign rotCO[4][4] = 6'd0;   assign rotCO[4][3] = 6'd36;  assign rotCO[4][2] = 6'd3;
assign rotCO[4][1] = 6'd41;  assign rotCO[4][0] = 6'd18;  assign rotCO[3][4] = 6'd1;
assign rotCO[3][3] = 6'd44;  assign rotCO[3][2] = 6'd10;  assign rotCO[3][1] = 6'd45;
assign rotCO[3][0] = 6'd2;   assign rotCO[2][4] = 6'd62;  assign rotCO[2][3] = 6'd6;
assign rotCO[2][2] = 6'd43;  assign rotCO[2][1] = 6'd15;  assign rotCO[2][0] = 6'd61;
assign rotCO[1][4] = 6'd28;  assign rotCO[1][3] = 6'd55;  assign rotCO[1][2] = 6'd25;
assign rotCO[1][1] = 6'd21;  assign rotCO[1][0] = 6'd56;  assign rotCO[0][4] = 6'd27;
assign rotCO[0][3] = 6'd20;  assign rotCO[0][2] = 6'd39;  assign rotCO[0][1] = 6'd8;
assign rotCO[0][0] = 6'd14;



always@(posedge clk or posedge rst) begin
if(rst) begin out<=0; 
end else begin
  out<={ A[4][4], A[4][3], A[4][2], A[4][1], A[4][0],
  A[3][4], A[3][3], A[3][2], A[3][1], A[3][0],
  A[2][4], A[2][3], A[2][2], A[2][1], A[2][0],
  A[1][4], A[1][3], A[1][2], A[1][1], A[1][0],
  A[0][4], A[0][3], A[0][2], A[0][1], A[0][0] };
 end 
    
end

always@(*) begin
 //$display("%x+++",in);
 { Y[4][4], Y[4][3], Y[4][2], Y[4][1], Y[4][0],
  Y[3][4], Y[3][3], Y[3][2], Y[3][1], Y[3][0],
  Y[2][4], Y[2][3], Y[2][2], Y[2][1], Y[2][0],
  Y[1][4], Y[1][3], Y[1][2], Y[1][1], Y[1][0],
  Y[0][4], Y[0][3], Y[0][2], Y[0][1], Y[0][0] } = in;
 //pi A[x,y]=Temp((2*x+3*y)%5)][x]
 
A[0][4] = Y[0][0] << rotCO[0][0] | (Y[0][0] >> (64 - rotCO[0][0]));
A[0][3] = Y[2][0] << rotCO[2][0] | (Y[2][0] >> (64 - rotCO[2][0]));
A[0][1] = Y[1][0] << rotCO[1][0] | (Y[1][0] >> (64 - rotCO[1][0]));
A[0][2] = Y[4][0] << rotCO[4][0] | (Y[4][0] >> (64 - rotCO[4][0]));
A[0][0] = Y[3][0] << rotCO[3][0] | (Y[3][0] >> (64 - rotCO[3][0]));

A[1][4] = Y[1][1] << rotCO[1][1] | (Y[1][1] >> (64 - rotCO[1][1]));
A[1][3] = Y[3][1] << rotCO[3][1] | (Y[3][1] >> (64 - rotCO[3][1]));
A[1][2] = Y[0][1] << rotCO[0][1] | (Y[0][1] >> (64 - rotCO[0][1]));
A[1][1] = Y[2][1] << rotCO[2][1] | (Y[2][1] >> (64 - rotCO[2][1]));
A[1][0] = Y[4][1] << rotCO[4][1] | (Y[4][1] >> (64 - rotCO[4][1]));

A[2][4] = Y[2][2] << rotCO[2][2] | (Y[2][2] >> (64 - rotCO[2][2]));
A[2][3] = Y[4][2] << rotCO[4][2] | (Y[4][2] >> (64 - rotCO[4][2]));
A[2][2] = Y[1][2] << rotCO[1][2] | (Y[1][2] >> (64 - rotCO[1][2]));
A[2][1] = Y[3][2] << rotCO[3][2] | (Y[3][2] >> (64 - rotCO[3][2]));
A[2][0] = Y[0][2] << rotCO[0][2] | (Y[0][2] >> (64 - rotCO[0][2]));

A[3][4] = Y[3][3] << rotCO[3][3] | (Y[3][3] >> (64 - rotCO[3][3]));
A[3][3] = Y[0][3] << rotCO[0][3] | (Y[0][3] >> (64 - rotCO[0][3]));
A[3][2] = Y[2][3] << rotCO[2][3] | (Y[2][3] >> (64 - rotCO[2][3]));
A[3][1] = Y[4][3] << rotCO[4][3] | (Y[4][3] >> (64 - rotCO[4][3]));
A[3][0] = Y[1][3] << rotCO[1][3] | (Y[1][3] >> (64 - rotCO[1][3]));

A[4][4] = Y[4][4] << rotCO[4][4] | (Y[4][4] >> (64 - rotCO[4][4]));
A[4][3] = Y[1][4] << rotCO[1][4] | (Y[1][4] >> (64 - rotCO[1][4]));
A[4][2] = Y[3][4] << rotCO[3][4] | (Y[3][4] >> (64 - rotCO[3][4]));
A[4][1] = Y[0][4] << rotCO[0][4] | (Y[0][4] >> (64 - rotCO[0][4]));
A[4][0] = Y[2][4] << rotCO[2][4] | (Y[2][4] >> (64 - rotCO[2][4]));

end  
endmodule