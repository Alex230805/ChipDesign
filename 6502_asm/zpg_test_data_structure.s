VIDEO_PORT=$6003
VIDEO_X=$6005
VIDEO_Y=$6006
VIDEO_MODE=$6004

PORT_A=$6000
PORT_B=$6001
PORT_C=$6002
PORT_I=$6008


POINTER=$00

WORD_POINTER=$50

 .org $0000
 .word $0000
 .org $8000

init:
    clc
    cld
    clv
    cli
    ldx #$00
    ldy #$0B
    lda #$00

copy:
    lda WORD_VECTOR,X
    sta WORD_POINTER,X
    inx
    dey
    cpy #$00
    bne copy
linking:
    lda #WORD_POINTER
    sta POINTER
    ldx #$0B
    ldy #$00

INDIRECT_READING:
    lda (POINTER),Y
    sta PORT_I
    iny
    dex
    cpx #$00
    bne INDIRECT_READING

linking_2:
    lda WORD_VECTOR_2,X
    sta WORD_POINTER,X
    inx
    dey
    cpy #$00
    bne linking_2
    lda #WORD_POINTER
    sta POINTER
    ldx #$0B
    ldy #$00

INDIRECT_READING_2:
    lda (POINTER),Y
    sta PORT_I
    iny
    dex
    cpx #$00
    bne INDIRECT_READING_2

DO_NOTHING:
    nop
    jmp DO_NOTHING


 include "./word.s"

    .org $FFFC
    .word $8000