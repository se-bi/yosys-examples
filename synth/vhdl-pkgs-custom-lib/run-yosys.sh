ghdl analyze --work=custom_lib  data_types.vhd
ghdl analyze reg.vhd
yosys -m ghdl -p 'ghdl reg'
