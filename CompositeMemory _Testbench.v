
module composite_memory_tb;
    reg clk;
    reg we;
    reg [15:0] addr;
    reg [7:0] din;
    wire [7:0] dout;
    reg [7:0] r_data;  // Declare r_data before use

    // Instantiate the composite_memory module
    composite_memory uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Task for writing data
    task write_mem;
        input [15:0] t_addr;
        input [7:0] t_din;
        begin
            @(posedge clk);
            we = 1;
            addr = t_addr;
            din = t_din;
            @(posedge clk);
            we = 0; // Disable write after one cycle
        end
    endtask

    // Task for reading data (fix: store output in `r_data`)
    task read_mem;
        input [15:0] t_addr;
        begin
            @(posedge clk);
            addr = t_addr;
            we = 0;  // Ensure write is disabled
            @(posedge clk);
            #1;  // Small delay to allow dout to stabilize
            r_data = dout;
        end
    endtask


    initial begin
      
        $dumpfile("waveform.vcd");
        $dumpvars(0, composite_memory_tb);
      
        // Initialize signals
        clk = 0;
        we = 0;
        addr = 0;
        din = 0;

        #10; // Wait for reset period

        // Write and Read test
        $display("Writing and Reading Test");
        write_mem(16'h0000, 8'hA5); // Write to bank 0
        write_mem(16'h4001, 8'h5A); // Write to bank 1
        write_mem(16'h8002, 8'h3C); // Write to bank 2
        write_mem(16'hC003, 8'h7E); // Write to bank 3

        #10; // Wait some time

        // Read back values
        read_mem(16'h0000);
        $display("Read from 0x0000: %h (Expected: A5)", r_data);
        read_mem(16'h4001);
        $display("Read from 0x4001: %h (Expected: 5A)", r_data);
        read_mem(16'h8002);
        $display("Read from 0x8002: %h (Expected: 3C)", r_data);
        read_mem(16'hC003);
        $display("Read from 0xC003: %h (Expected: 7E)", r_data);

        #10;
        $stop;
    end
endmodule

