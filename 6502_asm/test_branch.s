

	.org $0000
	.word $0000
	.org $8000


main:
	lda #$60
	cmp #$60
	beq do_nothing
	jmp main

do_nothing:
	nop
	jmp do_nothing


	.org $fffc
	.word main
