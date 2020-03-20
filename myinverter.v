module sign_extend (out,in);
input  [15:0] in ; 
output   [31:0] out ; 
 
assign out = { {16{in[15]}} , in } ;  
endmodule 


module sign () ; 

reg [15:0] in ;
wire [31:0] out ;

sign_extend test(out,in);

initial 
begin 
$monitor (" out=%b ", out); 
#10
in = 16'b0111010101010101 ;
#10
in=16'b1111111111111110;

end 

endmodule  

