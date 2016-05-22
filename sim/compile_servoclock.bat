#!/bin/bash

set FLAG=-v --syn-binding --workdir=work  --work=work --ieee=synopsys --std=93c -fexplicit
#

ghdl -a $FLAG  ../vhdl/servoclock.vhd
ghdl -a $FLAG ../test/tb_servoclock.vhd
ghdl -e $FLAG tb_servoclock
ghdl -r $FLAG tb_servoclock --vcd=core.vcd
