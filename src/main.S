.syntax unified
.global main

.type main, %function

@COMP2300 Assignment 1 Part 1 - Produce a triangle wave with frequency 440Hz

main:
  bl init @branch to init in order to turn on headphone jack

begin_max:
  mov r4, 0x7fff @set initial maximum value of 0x7ffff in r4
  mov r0, r4 
  bl BSP_AUDIO_OUT_Play_Sample @branch to BSP_AUDIO_OUT_Play_Sample to produce sound
  mov r5, #54 @set counter to 54 in r5
  b loop_down

begin_min:
  movs r4, 0x8000 @set initial minimum value of 0x8000 in r4
  mov r0, r4 
  bl BSP_AUDIO_OUT_Play_Sample 
  mov r5, #54 @set counter to 54 in r5
  b loop_up

loop_down: @continiously decrease the value at r4 by 1213
  sub r4, 1213
  mov r0, r4 
  bl BSP_AUDIO_OUT_Play_Sample 
  b counter_down

loop_up: @continiously increase the value at r4 by 1213
  add r4, 1213
  mov r0, r4 
  bl BSP_AUDIO_OUT_Play_Sample 
  b counter_up

counter_down: @decrease count by one and branch to begin_min once count is zero
  subs r5, #1 
  bne loop_down @check that count is not zero
  beq begin_min

counter_up: @decrease count by one and branch to begin_min once count is zero
  subs r5, #1 
  bne loop_up @check that count is not zero
  beq begin_max

nop
b main
.size main, .-main