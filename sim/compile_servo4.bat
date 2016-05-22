#!/bin/bash

set FLAG=-v --syn-binding --workdir=work  --work=work --ieee=synopsys --std=93c -fexplicit
#
ghdl -a $FLAG  ../vhdl/servoclock.vhd
ghdl -a $FLAG  ../vhdl/servotiming.vhd
ghdl -a $FLAG  ../vhdl/servounit.vhd
ghdl -a $FLAG  ../vhdl/servo4.vhd
#ghdl -a $FLAG ../test/tb_servo.vhd
#ghdl -e $FLAG tb_servo
#ghdl -r $FLAG tb_servo --vcd=core.vcd
