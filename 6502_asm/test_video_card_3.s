 
VIDEO_PORT=$6003
VIDEO_X=$6005
VIDEO_Y=$6006
VIDEO_MODE=$6004

PORT_H=$6007

DISPLAY_LIMIT=$20
DELTA_PIXEL=$06

VIDEO_ENABLE=$00
WRITE_ENABLE=$02

 .org $0000
 .word $0000
 .org $8000


init_system:
	clc
	clv
	cli
	cld
	lda $00
	ldx #$00
	ldy #$00


main:
	adc #DELTA_PIXEL
	sta VIDEO_PORT
	stx VIDEO_X
	sty VIDEO_Y
	pha 
	lda #WRITE_ENABLE
	sta VIDEO_MODE
	lda #VIDEO_ENABLE
	sta VIDEO_MODE
	pla
	inx
	cpx #DISPLAY_LIMIT
	beq reset_x
	jmp main

reset_x:
	ldx #$00
	iny
	cpy #DISPLAY_LIMIT
	beq init_stop
	jmp main

init_stop:
	lda #$01
	sta PORT_H
	jmp stop

stop:
	nop
	jmp stop

	.org $fffc
	.word $8000
