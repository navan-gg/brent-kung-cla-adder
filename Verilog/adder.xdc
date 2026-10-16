set_property PACKAGE_PIN N15 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0 5} [get_ports clk]

set_property PACKAGE_PIN J2 [get_ports rst_n]
set_property IOSTANDARD LVCMOS25 [get_ports rst_n]

set_property PACKAGE_PIN G1 [get_ports {A[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {A[0]}]

set_property PACKAGE_PIN F2 [get_ports {A[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {A[1]}]

set_property PACKAGE_PIN F1 [get_ports {A[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {A[2]}]

set_property PACKAGE_PIN E2 [get_ports {A[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {A[3]}]

set_property PACKAGE_PIN E1 [get_ports {A[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {A[4]}]

set_property PACKAGE_PIN D2 [get_ports {B[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {B[0]}]

set_property PACKAGE_PIN D1 [get_ports {B[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {B[1]}]

set_property PACKAGE_PIN C2 [get_ports {B[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {B[2]}]

set_property PACKAGE_PIN B2 [get_ports {B[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {B[3]}]

set_property PACKAGE_PIN A4 [get_ports {B[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {B[4]}]

set_property PACKAGE_PIN C13 [get_ports {Sum_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Sum_out[0]}]
set_property SLEW SLOW [get_ports {Sum_out[0]}]

set_property PACKAGE_PIN C14 [get_ports {Sum_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Sum_out[1]}]
set_property SLEW SLOW [get_ports {Sum_out[1]}]

set_property PACKAGE_PIN D14 [get_ports {Sum_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Sum_out[2]}]
set_property SLEW SLOW [get_ports {Sum_out[2]}]

set_property PACKAGE_PIN D15 [get_ports {Sum_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Sum_out[3]}]
set_property SLEW SLOW [get_ports {Sum_out[3]}]

set_property PACKAGE_PIN D16 [get_ports {Sum_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Sum_out[4]}]
set_property SLEW SLOW [get_ports {Sum_out[4]}]

set_property PACKAGE_PIN F18 [get_ports Cout_out]
set_property IOSTANDARD LVCMOS33 [get_ports Cout_out]
set_property SLEW SLOW [get_ports Cout_out]