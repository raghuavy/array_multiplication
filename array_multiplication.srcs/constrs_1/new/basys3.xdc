## Clock - 100MHz on W5
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Reset - SW15 (slide up = run, slide down = reset)
set_property PACKAGE_PIN R2 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]

## Input A - SW7..SW0
set_property PACKAGE_PIN V17 [get_ports {a[0]}]
set_property PACKAGE_PIN V16 [get_ports {a[1]}]
set_property PACKAGE_PIN W16 [get_ports {a[2]}]
set_property PACKAGE_PIN W17 [get_ports {a[3]}]
set_property PACKAGE_PIN W15 [get_ports {a[4]}]
set_property PACKAGE_PIN V15 [get_ports {a[5]}]
set_property PACKAGE_PIN W14 [get_ports {a[6]}]
set_property PACKAGE_PIN W13 [get_ports {a[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a[*]}]

## Input B - SW8..SW14 (SW15 reserved for rst_n)
set_property PACKAGE_PIN V2  [get_ports {b[0]}]
set_property PACKAGE_PIN T3  [get_ports {b[1]}]
set_property PACKAGE_PIN T2  [get_ports {b[2]}]
set_property PACKAGE_PIN R3  [get_ports {b[3]}]
set_property PACKAGE_PIN W2  [get_ports {b[4]}]
set_property PACKAGE_PIN U1  [get_ports {b[5]}]
set_property PACKAGE_PIN T1  [get_ports {b[6]}]
set_property PACKAGE_PIN P2  [get_ports {b[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[*]}]

## Output - LEDs LD15..LD0
set_property PACKAGE_PIN U16 [get_ports {output_array[0]}]
set_property PACKAGE_PIN E19 [get_ports {output_array[1]}]
set_property PACKAGE_PIN U19 [get_ports {output_array[2]}]
set_property PACKAGE_PIN V19 [get_ports {output_array[3]}]
set_property PACKAGE_PIN W18 [get_ports {output_array[4]}]
set_property PACKAGE_PIN U15 [get_ports {output_array[5]}]
set_property PACKAGE_PIN U14 [get_ports {output_array[6]}]
set_property PACKAGE_PIN V14 [get_ports {output_array[7]}]
set_property PACKAGE_PIN V13 [get_ports {output_array[8]}]
set_property PACKAGE_PIN V3  [get_ports {output_array[9]}]
set_property PACKAGE_PIN W3  [get_ports {output_array[10]}]
set_property PACKAGE_PIN U3  [get_ports {output_array[11]}]
set_property PACKAGE_PIN P3  [get_ports {output_array[12]}]
set_property PACKAGE_PIN N3  [get_ports {output_array[13]}]
set_property PACKAGE_PIN P1  [get_ports {output_array[14]}]
set_property PACKAGE_PIN L1  [get_ports {output_array[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {output_array[*]}]