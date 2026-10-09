VIDEO_PORT=$6003
VIDEO_X=$6005
VIDEO_Y=$6006
VIDEO_MODE=$6004



PORT_A=$6000
PORT_B=$6001
PORT_C=$6002
PORT_H=$6007


DISPLAY_LIMIT=$20
DELTA_PIXEL=$01

PIXEL_VAR=$00
VIDEO_ENABLE=$00
WRITE=$02

	.org $0000
	.word $0000
	.org $8000

init:
	clc		
	clv		
	cld		
	cli
	lda #$00
	sta PIXEL_VAR
	sta PORT_H
	ldx #$00
	ldy #$00

main:
	lda PIXEL_VAR
	sta VIDEO_PORT
	pha
	lda #WRITE
	sta VIDEO_MODE
	lda #VIDEO_ENABLE
	sta VIDEO_MODE
	pla
	inx
	adc #DELTA_PIXEL
	sta PIXEL_VAR
	cpx #DISPLAY_LIMIT
	stx VIDEO_X
	beq reset_x
	jmp main


reset_x:
	ldx #$00
	iny
	cpy #$20
	beq reset_y
	sty VIDEO_Y
	jmp main


reset_y:
	ldy #$00
	lda #$ff
	sta PORT_H
	jmp stop



stop:
	nop
	jmp stop

	.org $fffc
	.word $8000

