
Servo motor driver (vhdl)
=========================

precision: 256 steps

Contains three modules:

servoclock: clock generation module (need one for all units)

servotiming: global timing (need one for all units)

servounit: decrementer ( one per unit)

******************************************************************************

Demo: four servo motor drivers with i2c interface : i2cservo4
==============================================================

~230 LE (Altera)

Use a 74HCT04 (hex inverterS) to convert 3v cpld output to 5v to command servo motors.

![mock up](https://github.com/tirfil/vhdServo/images/SERVO.JPG)
