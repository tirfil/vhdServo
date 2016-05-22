#!/bin/bash

set FLAG=-v --syn-binding --workdir=work  --work=work --ieee=synopsys --std=93c -fexplicit
#
ghdl -a $FLAG  ../vhdl/servoclock.vhd
ghdl -a $FLAG  ../vhdl/servotiming.vhd
ghdl -a $FLAG ../test/tb_servotiming.vhd
ghdl -e $FLAG tb_servotiming
ghdl -r $FLAG tb_servotiming --vcd=core.vcd
