// Simple Memory Module in Verilog
module simple_memory #(parameter ADDR_WIDTH = 12, DATA_WIDTH = 16) (
    input clk, // Clock
    input we,  // Write Enable
    input [ADDR_WIDTH-1:0] addr,
    input [DATA_WIDTH-1:0] din,
    output reg [DATA_WIDTH-1:0] dout
);
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];
    
    always @(posedge clk) begin
        if (we)
            mem[addr] <= din; // Write operation
        else
            dout <= mem[addr]; // Read operation
    end
endmodule

module composite_memory (
    input clk,  // Clock
    input we,   // Write Enable
    input [15:0] addr,  // 16-bit address
    input [7:0] din,    // 8-bit input data
    output reg [7:0] dout  // 8-bit output data
);
    // Memory bank selection (4 memory modules)
    wire [1:0] bank_sel = addr[15:14]; // Upper 2 bits decide the bank
    wire [13:0] local_addr = addr[13:0]; // Lower 14 bits for memory access

    // Output data from each memory bank
    wire [7:0] dout0, dout1, dout2, dout3;

    // Memory Modules (16K x 8-bit each)
    simple_memory #(14, 8) mem0 (.clk(clk), .we(we & (bank_sel == 2'b00)), .addr(local_addr), .din(din), .dout(dout0));
    simple_memory #(14, 8) mem1 (.clk(clk), .we(we & (bank_sel == 2'b01)), .addr(local_addr), .din(din), .dout(dout1));
    simple_memory #(14, 8) mem2 (.clk(clk), .we(we & (bank_sel == 2'b10)), .addr(local_addr), .din(din), .dout(dout2));
    simple_memory #(14, 8) mem3 (.clk(clk), .we(we & (bank_sel == 2'b11)), .addr(local_addr), .din(din), .dout(dout3));

    // Read MUX: Select the correct memory module's output
    always @(*) begin
        case (bank_sel)
            2'b00: dout = dout0;
            2'b01: dout = dout1;
            2'b10: dout = dout2;
            2'b11: dout = dout3;
            default: dout = 8'b0;
        endcase
    end
endmodule

