module data_mem_midterm (
    input clk,
    input [31:0] access_addr,
    input [31:0] write_data,
    input wr_en,
    input rd_en,
    output [31:0] read_data
);

  reg [31:0] ram[255:0];  // The size of your data memory.

  integer i;

  initial begin
    for (i = 0; i < 256; i = i + 1) begin
      ram[i] <= 32'd0;
    end
  end

  always @(posedge clk) begin
    if (wr_en) begin
      ram[access_addr[9:2]] <= write_data;
    end
  end

  assign read_data = rd_en ? ram[access_addr[9:2]] : 32'b0;

endmodule

