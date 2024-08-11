?;2024. 7.25 MZ-80A��SA-1510�Ή� (SA-1510����ROM�p�b�`�̃A�h���X���Ⴄ����)


			ORG	0F000H

			DB	0FFH             ;ROM�Ȃ����ʃR�[�h
			JP		START
;******************** MONITOR CMT���[�`���փ��^�[�� *************************************
			JP		MSHED			; $F004
			JP		MSDAT			; $F007
			JP		MLHED			; $F00A
			JP		MLDAT			; $F00D
			JP		MVRFY			; $F010
START:
			LD	HL,DATA			;DATA����LENGTH�o�C�g��TRNS�ɃR�s�[����DSTRT������s
			LD	DE,(TRNS)
			LD	BC,(LENGTH)
			LDIR
			LD	HL,(DSTRT)
			JP	(HL)
LENGTH:
			DW 03C0H
TRNS:
			DW 5A40H
DSTRT:
			DW 5B00H

IS_SA1510:
			LD		A,(010DH)		;010DH��'A'�Ȃ�MZ-80A ("SA-1510"��"A")
			CP		'A'
			RET

MSHED:							;JUMP���Ă�����Ƀ��^�[��
			PUSH	DE			;PUSH���߂��Ԃ���JUMP���Ă��Ă���̂ő����PUSH�͂��Ă���
			PUSH	BC
			PUSH	HL
;;			CALL	IS_SA1510
;;			JP	Z,043AH
			JP	043AH
MSDAT:
			PUSH	DE
			PUSH	BC
			PUSH	HL
			CALL	IS_SA1510
			JP	Z,0474H
			JP	0479H
MLHED:
			PUSH	DE
			PUSH	BC
			PUSH	HL
			CALL	IS_SA1510
			JP	Z,04D3H
			JP	04DCH
MLDAT:
			PUSH	DE
			PUSH	BC
			PUSH	HL
			CALL	IS_SA1510
			JP	Z,04F3H
			JP	04FCH
MVRFY:
			PUSH	DE
			PUSH	BC
			PUSH	HL
			CALL	IS_SA1510
			JP	Z,0579H
			JP	058CH

DATA:							;��������N���������v���O������W�J(4023Byte���p�\)
			END
