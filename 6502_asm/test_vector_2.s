VIDEO_PORT=$6003
VIDEO_X=$6005
VIDEO_Y=$6006
VIDEO_MODE=$6004

PORT_A=$6000
PORT_B=$6001
PORT_C=$6002
PORT_I=$6008

VIDEO_VAR_X=$00
VIDEO_VAR_Y=$01
VIDEO_PIXEL=$02
INDEX_VAR=$03


END_OF_LINE="0"

VIDEO_ENABLE=$00
WRITE=$02

	.org $0000
	.word $0000
	.org $8000


init:
	;flag reset 

	cli			;reset interrupt
	clv			;reset overflow
	clc			;reset carry
	cld			;reset decimal
	

	;video reset 
	
	lda #VIDEO_ENABLE	;load $00 in A
	sta VIDEO_PORT		;store it in VIDEO_PORT
	sta VIDEO_PIXEL		;store it in VIDEO_PIXEL
	sta VIDEO_MODE		;store it in VIDEO_MODE

	;restore register

	lda #$00
	ldx #$00
	ldy #$00
	txs	
	

main:	
	jmp print_1

	

print_1:
	lda word,x
	cmp #END_OF_LINE
	beq stop
	sta PORT_I
	inx
	jmp print_1

stop:
	nop
	jmp stop


video_update_pixel:
	pha			;push a into the stack
	lda VIDEO_VAR_X		;load x value
	sta VIDEO_X		;store it in x video position
	lda VIDEO_VAR_Y		;load y value
	sta VIDEO_Y		;store it in y video position
	lda VIDEO_PIXEL		;load pixel value
	sta VIDEO_PORT		;store it in video port
	lda #WRITE		;load write command
	sta VIDEO_MODE		;activate it
	lda #VIDEO_ENABLE	;load hidle command
	sta VIDEO_MODE		;activate it
	pla			;pull A from stack
	rts			;return

word:
	.byte "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporit. 0"

nmi_sequence:
	nop
	rti

interrupt_sequence:
	nop
	rti

	.org $fffa		;nmi vector
	.word nmi_sequence			
	.org $fffc		;reset / startup vector
	.word init
	.org $fffe		;interrupt vector
	.word interrupt_sequence
