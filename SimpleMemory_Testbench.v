// Testbench for Simple Memory Module
module tb_simple_memory;
    reg clk;
    reg we;
    reg [3:0] addr;
    reg [7:0] din;
    wire [7:0] dout;
    
    simple_memory uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );
    
    always #5 clk = ~clk; // Generate clock signal
  
  	initial begin
    	$dumpfile("waveform.vcd"); // Specifies the VCD file name
    	$dumpvars(0, tb_simple_memory); // Dumps all variables of testbench
	end

    
    initial begin
        clk = 0;
        we = 0;
        addr = 4'b0000;
        din = 8'b00000000;
        
        // Write to memory
        #10 we = 1; addr = 4'b0001; din = 8'hA5;
        #10 we = 1; addr = 4'b0010; din = 8'h5A;
        
        // Read from memory
        #10 we = 0; addr = 4'b0001;
        #10 we = 0; addr = 4'b0010;
        
        #20 $stop;
    end
endmodule

