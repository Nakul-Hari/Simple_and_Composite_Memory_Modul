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

