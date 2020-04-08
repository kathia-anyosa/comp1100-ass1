.syntax unified
.global main

.type main, %function


main:
  bl init

begin_max:
  mov r4, 0x7fff
  mov r0, r4
  bl BSP_AUDIO_OUT_Play_Sample
  mov r5, #54
  b loop_down

begin_min:
  movs r4, 0x8000
  mov r0, r4
  bl BSP_AUDIO_OUT_Play_Sample
  mov r5, #54
  b loop_up

loop_down:
  sub r4, #1213
  mov r0, r4
  bl BSP_AUDIO_OUT_Play_Sample
  b counter_down

loop_up:
  add r4, #1213
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