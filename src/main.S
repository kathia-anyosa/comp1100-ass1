.syntax unified
.global main

.type main, %function

@COMP2300 Assignment 1 Part 2 - Produce a square wave with frequency 440Hz

main:
  bl init @branch to init in order to turn on headphone jack

begin_max:
  mov r4, 0x7fff @set maximum value of 0x7ffff in r4
  mov r0, r4 
  bl BSP_AUDIO_OUT_Play_Sample @branch to BSP_AUDIO_OUT_Play_Sample to produce sound
  mov r5, #54 @set counter to 54 in r5
  b loop_max 
  
begin_min:
  movs r4, 0x8000 @set minimum value of 0x8000 in r4
  mov r0, r4 
  bl BSP_AUDIO_OUT_Play_Sample 
  mov r5, #54 @set counter to 54 in r5
  b loop_min

loop_max: @continiously move value at r4 to r0
  mov r0, r4 
  bl BSP_AUDIO_OUT_Play_Sample 
  b counter_down

loop_min: @continuously move value at r4 to r0
  mov r0, r4 
  bl BSP_AUDIO_OUT_Play_Sample 
  b counter_up

counter_down: @decrease count by one and branch to begin_min once count is zero
  subs r5, #1 
  bne loop_max @check that count is not zero
  beq begin_min

counter_up: @decrease count by one and branch to begin_max once count is zero
  subs r5, #1 
  bne loop_min @check that count is not zero
  beq begin_max

nop
b main
.size main, .-main