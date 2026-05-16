# array_multiplication

A parameterized sequential array multiplier implemented in SystemVerilog, synthesized and deployed on the Basys 3 FPGA (Xilinx Artix-7 xc7a35tcpg236-1).

## how it works

Array multiplication is the hardware analog of long multiplication. For two N-bit operands A and B, the multiplier iterates over each bit of B and accumulates partial products:

```
output = Σ (A << i) * B[i]   for i = 0 to N-1
```

Each cycle, if `B[i] = 1`, a shifted copy of A is added to the running total. If `B[i] = 0`, nothing is added. After N cycles the accumulator holds the full 2N-bit product. This is the sequential (one partial product per cycle) version of the classic array multiplier — the combinational version computes all partial products in parallel but uses more area.

This is also the scalar degenerate case of matrix multiplication: in a full matrix multiply, each output element `C[i][j]` is the dot product of row i of A with column j of B. Here, each "element" is a single bit, AND is the multiply, and the shift-accumulate is the summation.

## architecture

```
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        n            <= '0;
        output_array <= '0;
    end else if (n < N) begin
        output_array <= output_array + (a << n) * b[n];
        n            <= n + 1'b1;
    end
end
```

- `n` is a `$clog2(N)`-bit counter tracking the current bit index
- `b[n]` gates the partial product — it's 0 or 1, so `* b[n]` either zeroes or passes through `(a << n)`
- accumulation stops at `n = N-1` and the result holds until reset

## files

| file | description |
|------|-------------|
| `array_multiplication.sv` | parameterized N-bit sequential multiplier |
| `tb_array_multiplication.sv` | testbench — applies inputs, waits N cycles, checks result |
| `basys3.xdc` | pin constraints for Basys 3 |

## parameters

| parameter | default | description |
|-----------|---------|-------------|
| `N` | 8 | bit width of operands. output is 2N bits wide |

## io

| port | direction | width | description |
|------|-----------|-------|-------------|
| `clk` | input | 1 | 100 MHz system clock |
| `rst_n` | input | 1 | active-low async reset |
| `a` | input | N | multiplicand |
| `b` | input | N | multiplier |
| `output_array` | output | 2N | product (valid after N clock cycles) |

## pin mapping (Basys 3)

| signal | switches | notes |
|--------|----------|-------|
| `a[7:0]` | SW7–SW0 | lower 8 switches |
| `b[7:0]` | SW14–SW8 | upper 7 switches + SW8 |
| `rst_n` | SW15 | slide up to run, slide down to reset |
| `output_array[15:0]` | LD15–LD0 | all 16 LEDs |
| `clk` | W5 | onboard 100 MHz oscillator |

## usage

1. Set SW7–SW0 to your desired value of A (binary)
2. Set SW14–SW8 to your desired value of B (binary)
3. Slide SW15 down to reset, then up to run
4. After ~80 ns (8 cycles at 100 MHz) the LEDs display the 16-bit product

## simulation results

Simulated with `a = 0xDD` (221) and `b = 0xAE` (174). The waveform shows `output_array` stepping through intermediate partial product accumulations each clock cycle, reaching the final value of `0x9636` (38454 = 221 × 174) after 8 cycles.

![waveform](https://github.com/user-attachments/assets/cb7859ad-d313-4b60-8636-e150705cf309)

The RTL schematic shows the synthesized datapath: shift register, multiplier, adder, and output register chain.

![schematic](https://github.com/user-attachments/assets/102fa399-4b05-4ea1-aa78-bb25b9e8b769)

![rtl](https://github.com/user-attachments/assets/31d94db7-b0cb-4262-a771-eb3883ddd56a)

## timing

| metric | value |
|--------|-------|
| clock period | 10 ns (100 MHz) |
| cycles to complete | N (8 for default) |
| latency | 80 ns |
| WNS (post-route) | 4.501 ns |

The design meets timing comfortably with 4.5 ns of slack — could clock significantly faster if needed.

## tools

- Vivado 2025.2
- Basys 3 (Xilinx Artix-7 xc7a35tcpg236-1)
