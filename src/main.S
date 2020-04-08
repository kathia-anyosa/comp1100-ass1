.syntax unified
.global main

.type main, %function


main:
  bl init @initialize and turn on headphone jack

begin_max:
  mov r4, 0x7fff @set initial maximum value of 0x7ffff in r4
  mov r0, r4 @move that value to r0
  bl BSP_AUDIO_OUT_Play_Sample @produce sound
  mov r5, #54 @set counter to 54 in r5
  b loop_down @branch to loop_down

begin_min:
  movs r4, 0x8000 @set initial minimum value of 0x8000 in r4
  mov r0, r4 @move that value to r0
  bl BSP_AUDIO_OUT_Play_Sample @produce sound
  mov r5, #54 @set counter to 54 in r5
  b loop_up @branch to loop_down

loop_down:
  sub r4, 1213 @substract 1213 
  mov r0, r4
  bl BSP_AUDIO_OUT_Play_Sample
  b counter_down

loop_up:
  add r4, 1213
  mov r0, r4
  bl BSP_AUDIO_OUT_Play_Sample
  b counter_up

counter_down:
  subs r5, #1
  bne loop_down
  beq begin_min

counter_up:
  subs r5, #1
  bne loop_up
  beq begin_max

nop
b main
.size main, .-main