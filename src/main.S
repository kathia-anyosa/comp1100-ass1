.syntax unified
.global main

.type main, %function

@COMP2300 Assignment 1 Part 1 - Produce a triangle wave with frequency 440Hz

main:
  bl init @branch to init in order to turn on headphone jack

begin_max:
  mov r4, 0x7fff @set initial maximum value of 0x7ffff in r4
  mov r0, r4 @move that value to r0
  bl BSP_AUDIO_OUT_Play_Sample @branch to BSP_AUDIO_OUT_Play_Sample to produce sound
  mov r5, #54 @set counter to 54 in r5
  b loop_down @branch to loop_down to continiously decrease the value at r4

begin_min:
  movs r4, 0x8000 @set initial minimum value of 0x8000 in r4
  mov r0, r4 @move that value to r0
  bl BSP_AUDIO_OUT_Play_Sample @branch to BSP_AUDIO_OUT_Play_Sample to produce sound
  mov r5, #54 @set counter to 54 in r5
  b loop_up @branch to loop_up to to continiously increase the value at r4

loop_down:
  sub r4, 1213 @substract 1213 from the value stored at r4
  mov r0, r4 @move new value to r0
  bl BSP_AUDIO_OUT_Play_Sample @branch to BSP_AUDIO_OUT_Play_Sample to produce sound
  b counter_down @branch to counter_down to decrease count by one

loop_up:
  add r4, 1213 @add 1213 to the value stored at r4
  mov r0, r4 @move new value to r0
  bl BSP_AUDIO_OUT_Play_Sample @branch to BSP_AUDIO_OUT_Play_Sample to produce sound
  b counter_up @branch to counter_up to decrease count by one

counter_down:
  subs r5, #1 @substract 1 from the current count
  bne loop_down @check that count is not zero
  beq begin_min @if count is equal to zero, branch to begin_min so as to produce other half of wave

counter_up:
  subs r5, #1 @substract 1 from the current count
  bne loop_up @check that count is not zero
  beq begin_max @if count is equal to zero, branch to begin_max so as to produce other half of wave

nop
b main
.size main, .-main