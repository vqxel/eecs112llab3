`timescale 1ns / 1ps

module instruction_mem (
    input  [ 9:0] read_addr,
    output [31:0] data
);

  reg [31:0] rom[255:0];

  initial begin

    // -- Initialization --
    // $a0 = 200 (base address)
    // $a1 = 3   (index i)
    rom[0]  = 32'b00100000000001000000000011001000;  // addi $a0, $zero, 200
    rom[1]  = 32'b00100000000001010000000000000011;  // addi $a1, $zero, 3

    // Store initial values in memory
    // $t5 = 10
    // mem[200 + 12] = 10
    rom[2]  = 32'b00100000000011010000000000001010;  // addi $t5, $zero, 10
    rom[3]  = 32'b10101100100011010000000000001100;  // sw $t5, 12($a0)

    // $t6 = 99
    // mem[200 + 16] = 99
    rom[4]  = 32'b00100000000011100000000001100011;  // addi $t6, $zero, 99
    rom[5]  = 32'b10101100100011100000000000010000;  // sw $t6, 16($a0)

    // -- Main Program (Swap Logic) (at rom[6]) --
    rom[6]  = 32'b11000000101000000100000010000000;  // sll $t0, $a1, 2
    rom[7]  = 32'b00000000100010000100000000100000;  // add $t0, $a0, $t0
    rom[8]  = 32'b10001101000010010000000000000000;  // lw $t1, 0($t0)
    rom[9]  = 32'b10001101000010100000000000000100;  // lw $t2, 4($t0)
    rom[10] = 32'b10101101000010100000000000000000;  // sw $t2, 0($t0)
    rom[11] = 32'b10101101000010010000000000000100;  // sw $t1, 4($t0)

  end

  assign data = rom[read_addr[9:2]];

endmodule
