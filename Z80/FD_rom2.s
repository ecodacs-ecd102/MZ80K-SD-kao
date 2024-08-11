?;2024. 7.25 MZ-80AのSA-1510対応 (SA-1510だけROMパッチのアドレスが違うため)


			ORG	0F000H

			DB	0FFH             ;ROMなし識別コード
			JP		START
;******************** MONITOR CMTルーチンへリターン *************************************
			JP		MSHED			; $F004
			JP		MSDAT			; $F007
			JP		MLHED			; $F00A
			JP		MLDAT			; $F00D
			JP		MVRFY			; $F010
START:
			LD	HL,DATA			;DATAからLENGTHバイトをTRNSにコピーしてDSTRTから実行
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
			LD		A,(010DH)		;010DHが'A'ならMZ-80A ("SA-1510"の"A")
			CP		'A'
			RET

MSHED:							;JUMPしてきた先にリターン
			PUSH	DE			;PUSH命令をつぶしてJUMPしてきているので代わりにPUSHはしておく
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

DATA:							;ここから起動したいプログラムを展開(4023Byte利用可能)
			END
