# 5-bit Brent-Kung Carry Look-Ahead Adder

This project was made as a part of the course EC2.201 VLSI Design taken in Monsoon '25 in IIIT Hyderabad. The full report, with circuit diagrams, stick diagrams, layouts and waveforms, is in [VLSI_PROJ.pdf](VLSI_PROJ.pdf).

This is a complete, end-to-end implementation of a 5-bit carry look-ahead adder built on the Brent-Kung parallel prefix architecture, designed at transistor level in 180 nm CMOS, laid out in Magic, simulated before and after layout in ngspice, and implemented in Verilog on an FPGA. The inputs are registered by TSPC (true single-phase clock) flip-flops on one rising clock edge, and the 5-bit sum and carry out are available at the next rising edge. Each sum output drives an inverter load of Wp/Wn = 20λ/10λ (λ = 0.09 µm).

## Design

- **Prefix network:** the carries are computed with a Brent-Kung prefix tree of gray and black cells, built from the bitwise generate (g = a·b) and propagate (p = a ⊕ b) signals. Brent-Kung uses the fewest prefix cells of the common parallel prefix adders, which keeps the area and wiring small at the cost of some extra logic depth and lack of scalability.
- **Gates:** Only 3 basic gates are being used. The static CMOS inverter, NAND, and NOR gates are sized to match the logical effort of a reference inverter. XOR is built from four NAND gates.
- **Flip-flops:** positive edge-triggered TSPC D flip-flops, which need only a single clock phase. This was chosen due to its simplicity and effictiveness.

## Results

| | Pre-layout | Post-layout |
|---|---|---|
| Adder delay, worst case (t<sub>pd,max</sub>) | 0.845 ns | 0.525 ns |
| Adder delay, best case (t<sub>pd,min</sub>) | 0.086 ns | 0.150 ns |
| Flip-flop clock-to-Q (t<sub>pcq,max</sub> / t<sub>pcq,min</sub>) | 0.134 / 0.075 ns | 0.150 / 0.092 ns |
| Setup time | 0.172 ns | 0.230 ns |
| Hold time | 0.121 ns | 0.182 ns |
| Minimum clock period | 1.151 ns | 0.905 ns |
| Maximum clock frequency | 868.8 MHz | 1.1 GHz |

The minimum clock period is t<sub>pd,max</sub> + t<sub>pcq,max</sub> + t<sub>setup</sub>. The hold-time condition is met in both cases. The Verilog model passes an exhaustive test of all 1024 input combinations.

## Project structure

```
Verilog/
  cla_adder.v             Brent-Kung adder, D flip-flops and the top-level circuit
  tb_cla_adder.v          Testbench: checks all 32 x 32 input combinations
  adder.xdc               FPGA pin and clock constraints (Vivado)
ngspice/                  Pre-layout simulations
  adder_pre.cir           Adder block: functional check and delay measurement
  dff_pre.cir             TSPC flip-flop: clock-to-Q delay
  final_circuit_pre.cir   Full circuit with input and output flip-flops
  TSMC_180nm.txt          180 nm transistor models (BSIM3)
magic/                    Layouts (scmos technology)
  inverter.mag, and.mag, or.mag, dff.mag
  adderblock.mag          Adder block
  full_circuit.mag        Full circuit
  SCN6M_DEEP.09.tech27    Magic technology file
  Postlayout/             Netlists extracted from the layouts and their simulations
    test_adderblock.cir   Adder block (post-layout)
    test_final.cir        Full circuit (post-layout)
    dff_post.spice        Flip-flop (post-layout)
VLSI_PROJ.pdf             Project report
```

## Tools

- [ngspice](https://ngspice.sourceforge.io/) for the circuit simulations
- [Magic](http://opencircuitdesign.com/magic/) for the layouts and netlist extraction
- [Icarus Verilog](https://steveicarus.github.io/iverilog/) and GTKWave for the Verilog simulation
- Xilinx Vivado for the FPGA implementation

On Ubuntu/Debian:

```
sudo apt install ngspice magic iverilog gtkwave
```

## How to run

**Verilog simulation**

```
cd Verilog
iverilog -o tb_cla_adder tb_cla_adder.v
vvp tb_cla_adder
gtkwave bka.vcd
```

The testbench prints `SUCCESS: All 1024 tests passed.` if every sum is correct.

**Pre-layout simulations**

```
cd ngspice
ngspice adder_pre.cir
ngspice dff_pre.cir
ngspice final_circuit_pre.cir
```

**Post-layout simulations**

```
cd magic/Postlayout
ngspice test_adderblock.cir
ngspice test_final.cir
ngspice dff_post.spice
```

**Viewing the layouts**

```
cd magic
magic -T SCN6M_DEEP.09.tech27 full_circuit.mag
```

**FPGA**

Create a Vivado project with `Verilog/cla_adder.v` (top module `final_circuit`) and the constraints in `Verilog/adder.xdc`, then synthesize, implement and program the board.
