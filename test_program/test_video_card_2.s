VIDEO_PORT=$6003
VIDEO_X=$6005
VIDEO_Y=$6006
VIDEO_MODE=$6004



PORT_A=$6000
PORT_B=$6001
PORT_C=$6002


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
	ldx #$00
	ldy #$00

main:
	lda PIXEL_VAR
	stx VIDEO_X
	sty VIDEO_Y
	stx PORT_A
	sty PORT_B
	sta VIDEO_PORT
	sta PORT_C

	pha
	lda #WRITE
	sta VIDEO_MODE
	lda #VIDEO_ENABLE
	sta VIDEO_MODE
	pla

	inx
	
	adc #$02
	sta PIXEL_VAR
	cpx #$20
	beq reset_x
	jmp main


reset_x:
	ldx #$00
	iny
	cpy #$20
	beq reset_y
	jmp main


reset_y:
	ldy #$00
	jmp main
	.org $fffc
	.word $8000

