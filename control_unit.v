module control_unit (Jump,Branch, RegDst ,RegWrite,ALUSrc,ALUOp,MemRead,MemWrite,MemtoReg,opcode,funct);
output reg Jump,Branch,RegWrite,ALUSrc,MemRead,MemWrite;
output reg [1:0]MemtoReg,RegDst;
output reg [1:0]ALUOp;
input [5:0] opcode,funct ;

always @(opcode)
begin 
casez (opcode)6'h0: // R-formate 
begin 
if (funct==6'h8)
begin
RegWrite<=1'b0;
end
else
begin
RegWrite<=1'b1;
end
Jump <=1'b0;
Branch<=1'b0;
RegDst<=2'b01;
ALUSrc<=1'b0;
ALUOp<=2'b10;
MemRead<=1'b0;
MemWrite<=1'b0;
MemtoReg<=2'b00;
end
6'h23: //LW 
begin 
Jump <=1'b0;
Branch<=1'b0;
RegDst<=2'b00;
RegWrite<=1'b1;
ALUSrc<=1'b1;
ALUOp<=2'b00;
MemRead<=1'b1;
MemWrite<=1'b0;
MemtoReg<=2'b01;
end
6'h2B: //SW
begin 
Jump <=1'b0;
Branch<=1'b0;
RegDst<=2'bxx;
RegWrite<=1'b0;
ALUSrc<=1'b1;
ALUOp<=2'b00;
MemRead<=1'b0;
MemWrite<=1'b1;
MemtoReg<=2'bxx;
end
6'h2: // jumb  
begin 
Jump <=1'b1;
Branch<=1'b0;
RegDst<=2'bxx;
RegWrite<=1'b0;
ALUSrc<=1'b0;
ALUOp<=2'bxx;
MemRead<=1'b0;
MemWrite<=1'b0;
MemtoReg<=2'bxx;
end

6'h4: // beq
begin 
Jump <=1'b0;
Branch<=1'b1;
RegDst<=2'bxx;
RegWrite<=1'b0;
ALUSrc<=1'b0;
ALUOp<=2'b01;
MemRead<=1'b0;
MemWrite<=1'b0;
MemtoReg<=2'bxx;
end
6'h5: // bne
begin 
Jump <=1'b0;
Branch<=1'b1;
RegDst<=2'bxx;
RegWrite<=1'b0;
ALUSrc<=1'b0;
ALUOp<=2'b01;
MemRead<=1'b0;
MemWrite<=1'b0;
MemtoReg<=2'bxx;
end
 6'h8: //addi 
begin 
Jump <=1'b0;
Branch<=1'b0;
RegDst<=2'b00;
RegWrite<=1'b1;
ALUSrc<=1'b1;
ALUOp<=2'b00;
MemRead<=1'b0;
MemWrite<=1'b0;
MemtoReg<=2'b00;
end

6'hD:  //ori
begin 
Jump <=1'b0;
Branch<=1'b0;
RegDst<=2'b00;
RegWrite<=1'b1;
ALUSrc<=1'b1;
ALUOp<=2'b11; 
MemRead<=1'b0;
MemWrite<=1'b0;
MemtoReg<=2'b00;
end
6'h3: //jal 
begin 
Jump <=1'b1;
Branch<=1'b0;
RegDst<=2'b10;
RegWrite<=1'b1;
ALUSrc<=1'b0;
ALUOp<=2'b00;
MemRead<=1'b0;
MemWrite<=1'b0;
MemtoReg<=2'b10;
end
default :  
begin 
Jump <=1'bx;
Branch<=1'bx;
RegDst<=2'bxx;
RegWrite<=1'bx;
ALUSrc<=1'bx;
ALUOp<=2'bxx;
MemRead<=1'bx;
MemWrite<=1'bx;
MemtoReg<=2'bxx;
end
endcase 
end 
endmodule 

module controlTestBench() ; 

wire [1:0]MemtoReg,RegDst;
wire Jump,Branch ,RegWrite,ALUSrc,MemRead,MemWrite;
wire [1:0] ALUOp ;
reg [5:0]opcode;

control_unit test (Jump,Branch, RegDst ,RegWrite,ALUSrc, ALUOp ,MemRead,MemWrite,MemtoReg,opcode);

initial 
begin 
$monitor ("Jump=%b,Branch=%b, RegDst=%b ,RegWrite=%b,ALUSrc=%b ,MemRea%b,MemWrite=%b,MemtoReg=%b,opcode=%b, ALUOp=%b ",
Jump,Branch, RegDst ,RegWrite,ALUSrc,MemRead,MemWrite,MemtoReg,opcode,ALUOp); 
#10
opcode = 6'b101011;
#10
opcode=6'b100011;
#10
opcode=6'b000100;
end 

endmodule  