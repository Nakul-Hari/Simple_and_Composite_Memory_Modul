# Simple and Composite Memory Module - Verilog Implementation

This repository contains Verilog implementations of a simple memory module and a composite memory module, along with a testbench to verify their functionality. The modules are designed to be configurable and scalable, making them suitable for various applications requiring temporary data storage.

## Overview

### Simple Memory Module
The `simple_memory` module is a synchronous memory unit with configurable address and data widths. It supports both read and write operations, synchronized to the rising edge of a clock signal.

#### Key Features:
- **Parameterized Address and Data Width**: Customize the memory size and data width using parameters.
- **Synchronous Operations**: Read and write operations are synchronized to the clock.
- **Write Enable Control**: A write enable signal (`we`) controls whether a write operation is performed.

### Composite Memory Module
The `composite_memory` module extends the functionality of the simple memory module by dividing the memory into multiple banks. Each bank is an instance of the `simple_memory` module, and the selection of the bank is determined by the upper bits of the address.

#### Key Features:
- **Memory Bank Selection**: The memory is divided into 4 banks, selected using the upper 2 bits of the address.
- **Independent Write Control**: Each memory bank has independent write control, preventing conflicts.
- **Read Multiplexing**: A multiplexer selects the correct memory bank's output based on the address.

### Testbench
The `composite_memory_tb` testbench verifies the functionality of the composite memory module. It includes tasks for writing and reading data, and it checks the correctness of the memory operations.

#### Test Procedure:
1. **Write Operations**: Data is written to different memory banks.
2. **Read Operations**: Data is read back from the same addresses to verify correctness.
3. **Waveform Dumping**: The simulation waveform is dumped for visualization.

## Repository Structure
- **`simple_memory.v`**: Verilog code for the simple memory module.
- **`composite_memory.v`**: Verilog code for the composite memory module.
- **`composite_memory_tb.v`**: Verilog testbench for the composite memory module.
- **`waveform.vcd`**: Simulation waveform file (generated during simulation).

## Usage
1. **Simulation**: Use a Verilog simulator (e.g., Icarus Verilog, ModelSim) to run the testbench.
2. **Waveform Visualization**: Open the generated `waveform.vcd` file using a waveform viewer (e.g., GTKWave) to analyze the simulation results.

## Expected Output
The testbench will display the results of the read operations, showing the data read from each memory bank. The expected output is:
- Read from `0x0000`: `A5`
- Read from `0x4001`: `5A`
- Read from `0x8002`: `3C`
- Read from `0xC003`: `7E`

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## Acknowledgments
- This project was developed as part of a digital design course.
- Special thanks to the open-source Verilog community for providing valuable resources and tools.

---

For more details, refer to the source code and the accompanying documentation. If you have any questions or suggestions, feel free to reach out!
