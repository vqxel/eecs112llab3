`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
// 
// Create Date: 01/25/2021 10:34:43 AM
// Design Name: 
// Module Name: instruction_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//
// Dependencies: 
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:.
//////////////////////////////////////////////////////////////////////////////////

module reza_instruction_mem (
    input  [ 9:0] read_addr,
    output [31:0] data
);

  reg     [31:0] rom                                                              [255:0];


  reg     [31:0] NOP_delay;  // Standard NOP (sll $0, $0, 0)
  reg     [31:0] NOP_target;  // Distinct NOP for jump validation (addi $0, $0, 0)

  integer i;  // Loop variable

  initial begin

    NOP_delay = 32'h00000000;  // NOP instruction (sll $0, $0, 0)
    NOP_target = 32'h20000000;  // Distinct NOP for jump target (addi $0, $0, 0)

    // instruction     alu result in hex     register content     mem content
    rom[0] = 32'b10001100000000010000000000000000; // r1  = mem[0]        4 (add 0)         r1 = 00000005          -
    rom[1] = 32'b10001100000000100000000000000100; // r2  = mem[1]        8 (add 1)         r2 = 0fdf6e91          -
    rom[2] = 32'b10001100000000110000000000001000; // r3  = mem[2]        c (add 2)         r3 = 6a31439b          -
    rom[3] = 32'b10001100000001000000000000001100; // r4  = mem[3]        10(add 3)         r4 = 56343ffd          -
    rom[4] = 32'b10001100000001010000000000010000; // r5  = mem[4]        14(add 4)         r5 = 429eeddb          -
    rom[5] = 32'b10001100000001100000000000010100; // r6  = mem[5]        18(add 5)         r6 = 90000000          -
    rom[6] = 32'b10001100000001110000000000011000; // r7  = mem[6]        1c(add 6)         r7 = 9134fd75          -
    rom[7] = 32'b10001100000010000000000000011100; // r8  = mem[7]        20(add 7)         r8 = bcd11247          -
    rom[8] = 32'b10001100000010010000000000100000; // r9  = mem[8]        24(add 8)         r9 = b55bd831          -
    rom[9] = 32'b10001100000010100000000000100100; // r10 = mem[9]        28(add 9)         r10= d18fa600         -

    // BRANCH TEST SETUP (from original rom[100]-rom[102])
    rom[10] = 32'b00100000001011011111111111111101; // addi r13,r1,#fffd ($13 = $1 + (-3) = 5 - 3 = 2)
    rom[11] = 32'b10001100000011100000000000000000;  // r14 = mem[0] ($14 = 5)
    rom[12] = 32'b00100000001011111111111111111110; // addi r15,r1,#fffe ($15 = $1 + (-2) = 5 - 2 = 3)

    // --- DELAY ---
    rom[13] = NOP_delay;
    rom[14] = NOP_delay;
    rom[15] = NOP_delay;
    rom[16] = NOP_delay;
    rom[17] = NOP_delay;

    // --- GROUP 1: NOR ---
    rom[18] = 32'b00000000001000100110000000100111;  // nor  r12,r1,r2
    rom[19] = 32'b00000000010001110110000000100111;  // nor  r12,r2,r7
    rom[20] = 32'b00000000011010000110000000100111;  // nor  r12,r3,r8
    rom[21] = 32'b00000000111010000110000000100111;  // nor  r12,r7,r8
    rom[22] = 32'b00000000110010100110000000100111;  // nor  r12,r6,r10

    // --- DELAY ---
    rom[23] = NOP_delay;
    rom[24] = NOP_delay;
    rom[25] = NOP_delay;
    rom[26] = NOP_delay;
    rom[27] = NOP_delay;

    // --- GROUP 2: SLT ---
    rom[28] = 32'b00000000001000100110100000101010;  // slt  r13,r1,r2
    rom[29] = 32'b00000000010001110110100000101010;  // slt  r13,r2,r7
    rom[30] = 32'b00000001000000110110100000101010;  // slt  r13,r8,r3
    rom[31] = 32'b00000001000001110110100000101010;  // slt  r13,r8,r7
    rom[32] = 32'b00000000110010100110100000101010;  // slt  r13,r6,r10

    // --- DELAY ---
    rom[33] = NOP_delay;
    rom[34] = NOP_delay;
    rom[35] = NOP_delay;
    rom[36] = NOP_delay;
    rom[37] = NOP_delay;

    // --- GROUP 3: XOR ---
    rom[38] = 32'b00000000010000111000100000100110;  // xor  r17,r2,r3
    rom[39] = 32'b00000000010001111000100000100110;  // xor  r17,r2,r7
    rom[40] = 32'b00000000011010001000100000100110;  // xor  r17,r3,r8
    rom[41] = 32'b00000000111010001000100000100110;  // xor  r17,r7,r8
    rom[42] = 32'b00000001001010101000100000100110;  // xor  r17,r9,r10

    // --- DELAY ---
    rom[43] = NOP_delay;
    rom[44] = NOP_delay;
    rom[45] = NOP_delay;
    rom[46] = NOP_delay;
    rom[47] = NOP_delay;

    // --- GROUP 4: MULT --- 
    rom[48] = 32'b00000000001000101001000000011000;  // mult r18,r1,r2
    rom[49] = 32'b00000000010001111001000000011000;  // mult r18,r2,r7
    rom[50] = 32'b00000000011010001001000000011000;  // mult r18,r3,r8
    rom[51] = 32'b00000000111010001001000000011000;  // mult r18,r7,r8
    rom[52] = 32'b00000001001010101001000000011000;  // mult r18,r9,r10

    // --- DELAY ---
    rom[53] = NOP_delay;
    rom[54] = NOP_delay;
    rom[55] = NOP_delay;
    rom[56] = NOP_delay;
    rom[57] = NOP_delay;

    // --- GROUP 5: DIV --- 
    rom[58] = 32'b00000000010000011001100000011010;  // div  r19,r2,r1
    rom[59] = 32'b00000000111000101001100000011010;  // div  r19,r7,r2
    rom[60] = 32'b00000001000000111001100000011010;  // div  r19,r8,r3
    rom[61] = 32'b00000001000001111001100000011010;  // div  r19,r8,r7
    rom[62] = 32'b00000001001010101001100000011010;  // div  r19,r9,r10

    // --- DELAY ---
    rom[63] = NOP_delay;
    rom[64] = NOP_delay;
    rom[65] = NOP_delay;
    rom[66] = NOP_delay;
    rom[67] = NOP_delay;

    // --- GROUP 6: SLL --- 
    rom[68] = 32'b11000000010000000111000011000000;  // sll  r14,r2,#3
    rom[69] = 32'b11000000111000000111001101000000;  // sll  r14,r2,#13
    rom[70] = 32'b11000000011000000111010001000000;  // sll  r14,r3,#17
    rom[71] = 32'b11000000111000000111000111000000;  // sll  r14,r7,#7
    rom[72] = 32'b11000000111000000111011111000000;  // sll  r14,r7,#31

    // --- DELAY ---
    rom[73] = NOP_delay;
    rom[74] = NOP_delay;
    rom[75] = NOP_delay;
    rom[76] = NOP_delay;
    rom[77] = NOP_delay;

    // --- GROUP 7: SRL --- 
    rom[78] = 32'b11000000001000000111100101000010;  // srl  r15,r1,#5
    rom[79] = 32'b11000001000000000111100111000010;  // srl  r15,r8,#7
    rom[80] = 32'b11000001000000000111110100000010;  // srl  r15,r8,#20
    rom[81] = 32'b11000001001000000111100011000010;  // srl  r15,r9,#3
    rom[82] = 32'b11000001001000000111111111000010;  // srl  r15,r9,#31

    // --- DELAY ---
    rom[83] = NOP_delay;
    rom[84] = NOP_delay;
    rom[85] = NOP_delay;
    rom[86] = NOP_delay;
    rom[87] = NOP_delay;

    // --- GROUP 8: SRA --- 
    rom[88] = 32'b11000000110000001000000110000011;  // sra  r16,r6,#6
    rom[89] = 32'b11000001001000001000000010000011;  // sra  r16,r9,#2
    rom[90] = 32'b11000001000000001000000001000011;  // sra  r16,r8,#1
    rom[91] = 32'b11000001001000001000000101000011;  // sra  r16,r9,#5
    rom[92] = 32'b11000001001000001000011111000011;  // sra  r16,r9,#31

    // --- DELAY ---
    rom[93] = NOP_delay;
    rom[94] = NOP_delay;
    rom[95] = NOP_delay;
    rom[96] = NOP_delay;
    rom[97] = NOP_delay;

    // --- GROUP 9: ANDI ---
    rom[98] = 32'b00110000011010111111111101100011;  // andi r11,r3,#ff63
    rom[99] = 32'b00110000111010110000111101100011;  // andi r11,r7,#f63
    rom[100] = 32'b00110001010010111110000100100111;  // andi r11,r10,#e127
    rom[101] = 32'b00110001000010111101000000000010;  // andi r11,r8,#d002
    rom[102] = 32'b00110001000010110000000000000000;  // andi r11,r8,#0

    // --- DELAY ---
    rom[103] = NOP_delay;
    rom[104] = NOP_delay;
    rom[105] = NOP_delay;
    rom[106] = NOP_delay;
    rom[107] = NOP_delay;

    // --- GROUP 10: BEQ --- 
    // Test 1: branch forward taken (r1 == r14, both are 5)
    rom[108] = 32'b00010011110111110000000000000001; // beq r30,r31,#1 (Test 1: branch forward taken, r30==r31, both likely 0)
    rom[109] = NOP_delay;  // (SKIPPED) was: add r10,r1,r2
    rom[110] = NOP_target;  // (TARGET, runs) was: add r19,r1,r3

    // Test 2: branch forward not taken (r6 != r10)
    rom[111] = 32'b00010000110010100000000000000001;  // beq r6,r10,#1 (NOT TAKEN)
    rom[112] = NOP_delay;  // (Fall-through, runs) was: add r12,r1,r4
    rom[113] = NOP_target;  // (Fall-through, runs) was: add r19,r1,r3

    // Test 3: branch backward taken (loop)
    // $r13=2, $r15=3 from setup
    rom[114] = NOP_delay;  // addi r13,r13,#1 (r13 becomes 3)
    rom[115] = NOP_delay;  // beq r13,r15,#-2 (r13==r15, TAKEN, jumps to 114)
    // --- loop ---
    // rom[114] runs again: addi r13,r13,#1 (r13 becomes 4)
    // rom[115] runs again: beq r13,r15,#-2 (r13!=r15, NOT TAKEN)
    // --- fall through ---
    rom[116] = NOP_delay;  // (runs after loop)


    // --- DELAY ---
    rom[117] = NOP_delay;
    rom[118] = NOP_delay;
    rom[119] = NOP_delay;
    rom[120] = NOP_delay;
    rom[121] = NOP_delay;

    // --- GROUP 11: JUMP ---
    // Test 1: Jump forward over 1 instruction
    // j 124 (0x7C)
    rom[122] = 32'b00001000000000000000000001111100;  // j #7c (jumps to rom[124])
    rom[123] = NOP_delay;  // (SKIPPED - delay slot)
    rom[124] = NOP_target;  // (TARGET - addi $0, $0, 0)

    // Test 2: Jump forward over 2 instructions
    // j 128 (0x80)
    rom[125] = 32'b00001000000000000000000010000000;  // j #80 (jumps to rom[128])
    rom[126] = NOP_delay;  // (SKIPPED - delay slot)
    rom[127] = NOP_delay;  // (SKIPPED - because of jump)
    rom[128] = NOP_target;  // (TARGET - addi $0, $0, 0)

    // --- DELAY ---
    rom[129] = NOP_delay;
    rom[130] = NOP_delay;
    rom[131] = NOP_delay;
    rom[132] = NOP_delay;
    rom[133] = NOP_delay;

    // Fill remaining rom with NOPs just in case
    for (i = 134; i < 256; i = i + 1) begin
      rom[i] = NOP_delay;
    end

  end

  assign data = rom[read_addr[9:2]];

endmodule

