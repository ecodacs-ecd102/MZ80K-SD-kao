;2021.12.12 MZ-700��FDP�AFDM�������������錻�ۂɑΏ�
;2022. 1.23 04D8H MONITOR ���[�h �C���t�H���[�V������֏����̃o�O���C��
;2022. 1.24 �t�@�C���l�[���̌���20h�l�߂�0dh�ɏC�����邽�߂̏�����Arduino������MZ-80K���ɏC��
;2022. 1.25 0475H MONITOR ���C�g �f�[�^��֏����A04F8H MONITOR ���[�h �f�[�^��֏����ł�8255��������p�~
;2022. 1.26 FD�R�}���h�Ń��[�h�\�ȃt�@�C����ރR�[�h��0x01�݂̂Ƃ��Ă���������P�p
;2022. 1.29 CMT��֏���RETURN���̊����݋���(EI)���폜
;2022. 1.31 FD�R�}���h���s��A�v�����삪�ł܂��Ă��܂��@�B�A�A�v���ւ̑Ώ�
;2022. 1.31 FDL�R�}���h�d�l�ύX FDL x�̏ꍇ�A�t�@�C�����擪�ꕶ�����r���Ĉ�v�������̂������o��
;           B�L�[�őO��20����\��
;2022. 2. 8 FDL�R�}���h�d�l�ύX FDL x�̏ꍇ�A�t�@�C�����擪1����?32�����܂łɊg��
;2022. 2.10 04D8H MONITOR ���[�h �C���t�H���[�V������֏����̒�����FDL�R�}���h���g����悤�ɏC��
;           FDL�R�}���h�������T�u���[�`����
;2022. 2.11 04D8H MONITOR ���[�h �C���t�H���[�V������֏����̒�����Ă�FDL�R�}���h��MZ-700 MONITOR 1Z-009A�A1Z-009B�����ł͎g���Ȃ��o�O���C�����܂����B
;
;[kaokun]
;2023.12.22 �ȉ��̉���
;	    8-TAB�ɐ��`
;           MZ-New Monitor�ɑΉ��B
;
;           �t�@�C���̃��[�h���ȂǂɃt�@�C���̃^�C�v�A�A�h���X����\������悤�ɂ����B
;
;           �e�[�v�֌W�R�}���h�̎���
;            *FDTB: �e�[�v��SD�A���o�b�N�A�b�v
;               *FDTB xx        xx�̓t�@�C�����擪��xx�����l(16�i2��)�B�ȗ�����01
;               DOS�t�@�C�����̐������[����
;               xxttDOS FILENAME
;                 xx:�t�@�C���ԍ�(�����l�́��Ŏw�肵����)
;                 tt:�t�@�C���^�C�v
;                 DOS FILENAME��PNAME����K���ɕϊ������B28�����ȏ�̕����͓�4���ƍ��킹��32�����𒴂���̂ŃJ�b�g�����
;                 $D000-����ۑ�����Ă���t�@�C��(�X�N���[���f��)�̃t�@�C���̖����� -DM �ƂȂ�B
;                 �t�@�C���������̏ꍇ  NO NAME �ƂȂ�
;               ����:
;               �E�X�N���[���f���̃o�b�N�A�b�v����邽�߁A�����ł͕K��$1200���烍�[�h�����B
;               �E�������[�v����̂ŏI��肽���ꍇ��SHIFT+BREAK���Ŏ~�߂�K�v������
;
;            *FDTL: �e�[�v���烍�[�h�B���[�h�I����SD�֕ۑ�����R�}���h��\��
;               *FDTL           �ŏ��Ɍ��������t�@�C���̃��[�h�Ǝ��s
;               *FDTL FILENAME  �w��t�@�C���̃��[�h�Ǝ��s
;               *FDTL/          �ŏ��Ɍ��������t�@�C�������[�h���Ď��s���Ȃ�
;               *FDTL/ FILENAME �w��t�@�C�������[�h���Ď��s���Ȃ�
;
;            *FDTS: �e�[�v�ɃZ�[�u
;               *FDTS ssss eeee xxxx FILENAME           type=01 �Œ�
;               *FDTS#tt ssss eeee xxxx FILENAME        type��16�i2���Ŏw��\
;
;            *FDTV:
;               *FDTV           �ŏ��Ɍ��������t�@�C���̃x���t�@�C
;               *FDTV FILENAME  �w��t�@�C���̃x���t�@�C
;
;           SD���[�h�A�Z�[�u���Ƀt�@�C���^�C�v�𔽉f����悤�ɂ����B(Arduino������p�R�}���h�őΉ����Ă���̂őΉ��v)
;           *FDS: SD�ɃZ�[�u
;               *FDTS ssss eeee xxxx DOS FILENAME       type=01 �Œ�, �t�@�C������DOS�t�@�C����
;               *FDTS#tt ssss eeee xxxx PROGRAM NAME    type��16�i2���Ŏw��B�t�@�C������MZ�t�@�C�����BDOS�t�@�C�����͓K���ɐ��������
;
;           *FD/: ���[�h�I����e�[�v�֕ۑ�����R�}���h��\������悤�ɂ����B
;
;           *FD>: ���[�h�I����e�[�v�֕ۑ�����B
;               �X�N���[���f���̃o�b�N�A�b�v����邽�߁A�����ł͕K��$1200���烍�[�h�����B�]���đ����̏ꍇ���[�h��̒��ڎ��s�s�B
;
;           ROM���󂯂邽�߈ȉ��̃R�}���h���폜(MZ700��MZ-New Monitor���g���O��B�R�}���h���_�u�邽��) �s�� ";@" �R�����g
;             *FDM:MEMORY DUMP
;             *FDW:MEMORY WRITE
;           ���̑��A�o�C�g���ߖ�̂��߃��b�Z�[�W�ށA���ʏ����ADEC B�ł̃��[�v��DJNZ���Ȃǌ�����
;
;           FDCD:CHDIR �R�}���h����
;             *FDCD[CR]                                 ���������J�����g�f�B���N�g����\��
;             *FDCD �f�B���N�g��[CR]                    �w�肵���f�B���N�g����CHDIR���J�����g�f�B���N�g����\��
;
;           FDMD:MKDIR �R�}���h����
;             *FDMD �f�B���N�g��[CR]                    �w��f�B���N�g�������
;
;           �A�v�����R�}���h�� *FDCD, *FDMD ��ǉ��B
;
;          FDL �R�}���h�̏o�͂��A�f�B�����N�g��("*FDCD ")�ƒʏ�t�@�C��(*FD  /DOS FILE:*FDCD )�ŕ������B
;
;2024. 3.13 DOS�t�@�C�����쐬���A�t�@�C�����̑O��ɃX�y�[�X������ꍇ�ɁADOS FILENAME�̑O�ォ��X�y�[�X���폜����
;           DOS�t�@�C�����쐬���A�����R�[�h05H��啶��/�������̃g�O���Ƃ��邽�ߑf�ʂ�����B
;           (�\���̓s���Ŏ��ۂ̏���������Arduino���ł��)
;	    ?�s�N���A�܂��̌�����
;
;2024. 6.23 1�{�̃e�[�v�ɕ����t�@�C�����ۑ����Ă����ă`�F�[�����[�h���Ă���^�C�v�̃Q�[���Ȃǂ�SD��1�̃f�B���N�g���ɓ��ꂽ���ɑΉ�
;           "*FD:": �J�����g�f�B���N�g���̃t�@�C����擪���珇�Ƀ��[�h����B
;                 (�f�B���N�g�����畨���I�ɓǂ񂾏��Ƀ��[�h����)
;                 �ȉ�Z=Z80, A=Arduino������
;		  �EZ:�ŏ���(CONTF)��':'�ɃZ�b�g : CONTF��$1200��1�o�C�g�O���g��
;                 �EZ:Arduino����':'�Ƃ����t�@�C���������[�h����悤�w���B":"��FAT�̃t�@�C�����Ƃ��Ă͎g���Ȃ��̂ŘA�����[�h���Ƌ�ʂł���B
;                   A:":"�Ƃ����t�@�C����������A�J�����g�f�B���N�g���̍ŏ��̃t�@�C�������[�h�Bskip=1�Ƃ���B
;                 �EZ:���̃R�}���h�ȍ~��Read INF�̓v�����v�g���o�����A��t�@�C���������[�h����悤Arduino���Ɏw��
;                 �EA:Arduino���́A��t�@�C���A���Askip!=0��������A�J�����g�f�B���N�g���̍ŏ�����(skip++)�X�L�b�v�����t�@�C����READ INF�ŕԂ�
;                 �EA:��t�@�C���łȂ��A�܂���LOAD�R�}���h��������skip=0�ɖ߂�
;           �g���q��*.mzt�̂Ƃ��͕\�����Ȃ��悤�ɂ����B(�����t�@�C�����̎��ɑ��肫��Ȃ�����)
;2024. 7.22 *FDL: �R�}���h�̃t���O�������������ɂ���
;2024. 7.25 MZ-80A��SA-1510�Ή� (SA-1510����ROM�p�b�`�̃A�h���X���Ⴄ����)
;2024. 7.29 �I���W�i����README�ɂ���ȉ��̃G���g���̓����ۏ�
;           0F082H: 8255 �C�j�V�����C�Y
;           0F85BH: MONITOR ���[�h �C���t�H���[�V������֏�������Arduino��HEADER LOAD�R�}���h93H�𑗐M���镔��(MLH_CONT)
;2024. 8.07 ���[�h�����v���O�������s���̓���ύX
;           - $1200�����̃A�h���X�ɂ̓W�����v���Ȃ�
;           - Music�̃e���|=4�ݒ�
;           - EI�Ŕ�э���
;2024. 8.11 github�փA�b�v���[�h


GETL		EQU		0003H
LETLN		EQU		0006H
NEWLIN		EQU		0009H
PRNTS		EQU		000CH
PRNT		EQU		0012H
MSGPR		EQU		0015H
PLIST		EQU		0018H
GETKEY		EQU		001BH
TIMST		EQU		0033H
XTEMP		EQU		0041H
MSTP		EQU		0047H
PRTWRD		EQU		03BAH
PRTBYT		EQU		03C3H
HLHEX		EQU		0410H
TWOHEX		EQU		041FH
ADCN		EQU		0BB9H
DISPCH		EQU		0DB5H
DPCT		EQU		0DDCH
IBUFE		EQU		10F0H
FNAME		EQU		10F1H
EADRS		EQU		1102H
FSIZE		EQU		1102H
SADRS		EQU		1104H
EXEAD		EQU		1106H
DSPX		EQU		1171H
DSPY		EQU		1172H
LBUF		EQU		11A3H
MBUF		EQU		11AEH
MANG		EQU		1173H
;
CONTF		EQU		11FFH		; for FD: command
CONTF_ON	EQU		':'		; ':' �Ȃ�A�����[�h��������
;
MONITOR_80K	EQU		0082H
MONITOR_700	EQU		00ADH
; kaokun [ ------------------------------------------------------
; MZ-NEW MONITOR / EU
MONITOR_NEWMON	EQU		0082H
MONITOR_NEWMON7	EQU		0082H
MONITOR_80A	EQU		0095H

; Tape
;WRINF		EQU		0021H
;WRDAT		EQU		0024H
;RDINF		EQU		0027H
;RDDAT		EQU		002AH
;VERFY		EQU		002DH

; kaokun ] ------------------------------------------------------

; 0D8H PORTA ���M�f�[�^(����4�r�b�g)
; 0D9H PORTB ��M�f�[�^(8�r�b�g)
;
; 0DAH PORTC Bit
; 7 IN  CHK
; 6 IN
; 5 IN
; 4 IN 
; 3 OUT
; 2 OUT FLG
; 1 OUT
; 0 OUT
;
; 0DBH �R���g���[�����W�X�^


		ORG		0F000H

		NOP					;ROM���ʃR�[�h
		JP		START
;******************** MONITOR CMT���[�`����� *************************************
ENT1:
		JP		MSHED
ENT2:
		JP		MSDAT
ENT3:
		JP		MLHED
ENT4:
		JP		MLDAT
ENT5:
		JP		MVRFY

; SA-1510�p
		JP		MSHED		; $F013
		JP		MSDAT		; $F016
		JP		MLHED		; $F019
		JP		MLDAT		; $F01C
		JP		MVRFY		; $F01F

START:
		CALL		INIT
		LD		(CONTF),A		;A=0�ŋA���Ă���̂ł��ł�FD:�R�}���h�p�̃t���O���N���A
		LD		DE,LBUF			;MZ-80K�AMZ-700�Ƃ��N���R�}���h��'*FD'�ɓ���
		LD		A,(DE)
		CP		'*'
		JP		NZ,MON
		INC 		DE
		LD		A,(DE)
		CP		'F'
		JP		NZ,MON
		INC		DE
		LD		A,(DE)
		CP		'D'
		JP		NZ,MON

		INC		DE			;FD�̎��̕����ֈړ�
STT2:
		LD		A,(DE)
		CP		20H			;FD�̌��1�����󔒂�����Έȍ~���t�@�C���l�[���Ƃ��ă��[�h(�t�@�C���l�[����32�����܂�)
		JP		Z,SDLOAD
		CP		'/'			;FD�̌オ'/'�Ȃ�ȍ~���t�@�C���l�[���Ƃ��ă��[�h�A���s�͂��Ȃ�(�t�@�C���l�[����32�����܂�)
		JP		Z,SDLOAD
;[kaokun]
		CP		'>'			;FD�̌オ'>'�Ȃ�ȍ~���t�@�C���l�[���Ƃ��ă��[�h�A�e�[�v�֕ۑ�
		JP		Z,SDLOAD
		CP		':'			;"FD:"
		JR		Z,SDLOAD_SEQ
;--
		CP		0DH			;FD�����ŉ��s�̏ꍇ�ɂ�DEFNAME�̕�������t�@�C���l�[���Ƃ��ă��[�h
		JR		NZ,STETC		;�Y���Ȃ��Ȃ瑼�R�}���h���`�F�b�N
;
STT3:
		PUSH		DE			;�ݒ�t�@�C����(0000.mzt)��]��
		LD		HL,DEFNAME
		INC		DE
		LD		BC,NEND-DEFNAME
		LDIR
		POP		DE
		JP		SDLOAD			;LOAD������
; "FD:"
SDLOAD_SEQ:
	; (DE) == ':' �ƂȂ��Ă���B
		LD		(CONTF),A		;�t���O�Z�b�g(A=':'�Ȃ̂�NZ)
		PUSH		DE
		POP		HL
		INC		HL			;':'�̎���CR���Z�b�g
		LD		(HL),0DH
		DEC		DE			;(DE+1)?:�t�@�C����=':',0DH �ƂȂ�悤�ɂ���B
		JP		SDLOAD			;LOAD������

STETC:
		CP		'S'			;FDS:SAVE������
		JP		Z,STSV
		CP		'A'			;FDA:�����N���t�@�C���ݒ菈����
		JP		Z,STAS
		CP		'L'			;FDL:�t�@�C���ꗗ�\��
;=====================================================================================
		JR		SKIP_001
;	�݊����m�ۂ̂��߂̃G���g��
L_PRE_F082:	DS		0F082H - L_PRE_F082
;		ORG		0F082H
		JP		INIT			; 8255�C�j�V�����C�Y
SKIP_001:
;=====================================================================================
		JP		Z,STLT
		CP		'D'			;FDD:DELETE / RMDIR
		JP		Z,STDE
		CP		'R'			;FDR:RENAME / RENDIR
		JP		Z,STRN
		CP		'P'			;FDP:DUMP
		JP		Z,STPR
		CP		'C'			;FDC:COPY / FDCD:CD
		JR		NZ,STETC2
		INC		DE
		LD		A,(DE)			;FDC�̎��̕���
		DEC		DE
		CP		'D'
		JP		NZ,STCP			;FDC:COPY
		INC		DE
		JP		STCHDIR			;FDCD:CHDIR
STETC2:
		CP		'M'			;(FDM:MEMORY DUMP) / FDMD:MKDIR
;@		JP		Z,STMD
		JR		NZ,STETC3
		INC		DE
		LD		A,(DE)
		CP		'D'
		JP		Z,STMKDIR
		DEC		DE
;@		JP		STMD
STETC3:
;@		CP		'W'			;FDW:MEMORY WRITE
;@		JP		Z,STMW
		CP		'Z'			;FDZ:MZ-700 PATCH START
		JP		Z,STMZ
		CP		'U'			;FDU:MZ-700 ��RAM START
		JP		Z,STURA
; kaokun [ -----------------------------------------------------------------------------
		CP		'T'			;FDTL/FDTS/FDTV/FDTB: Tape Load/Save/Verify/Backup Tape to SD
		JP		NZ,STTP99
; FDTx command
		INC		DE			;FDT�̎��̕����ֈړ�
		LD		A,(DE)
		CP		'L'			;FDTL:Tape LOAD
		JP		NZ,STTP2
		INC		DE
		LD		A,(DE)			;���̕���
		INC		DE			;DE=�t�@�C�����擪�A�h���X
		CP		20H			;FDTL�̌��1�����󔒂�����Έȍ~���t�@�C���l�[���Ƃ��ă��[�h(�t�@�C���l�[����16�����܂�)
		JR		Z,TPLOAD
		CP		'/'			;FDTL�̌オ'/'�Ȃ�ȍ~���t�@�C���l�[���Ƃ��ă��[�h�A���s�͂��Ȃ�(�t�@�C���l�[����16�����܂�)
		JR		Z,TPLOAD
		CP		0DH			;FDTL�����ŉ��s�̏ꍇ�ɂ͍ŏ��̃t�@�C�������[�h
		JP		NZ,CMDERR		;�Y���Ȃ�=�R�}���h�G���[
		LD		(DE),A			;�t�@�C������0D�łԂ�
;**** �e�[�v���[�h ****
TPLOAD:
		CALL		TPRDINF			;�w�b�_�����[�h���ĕ\��
		JP		C,MON			;�u���[�N/�G���[�Ȃ炻�̂܂܃R�}���h�҂���

		LD		DE,LBUF+6		;"*FDTL/"��6������΂����ʒu���t�@�C����
		LD		B,16
		CALL		TPSKIPSPC		;SKIP SPACES
		LD		HL,FNAME
		LD		B,16			;�ő�16����
;		LD		A,(DE)			;�ȗ���
		CP		0DH
		JR		Z,TPLOAD2		;�t�@�C��������
		CALL		CMPSTR			;��r
		JR		NZ,TPLOAD		;�t�@�C�����s��v
;���[�h���t�@�C�����\��
TPLOAD2:
				;LOADING �t�@�C����
		LD		DE,TMSG_LOADING
		CALL		TPDISP_FN
		CALL		TPMLDAT			;�{�̂̃��[�h
		JR		NC,TPLOAD3
		CP		02H			;01=Check SUM Error, 02=BREAK
		JP		Z,MON			;�u���[�N
		LD		DE,TMSG_CSUM		;"CHECKSUM ERR"
		CALL		MSGPR
		JP		MON
TPLOAD3:
		CALL		LETLN
		LD		DE,TMSG_OK		;"OK"
		CALL		MSGPR

; SD�Z�[�u�p�̃R�}���h�������\��
; *FDS#tt ssss eeee xxxx FILENAME
		CALL		TPDISPFDSCMD

		LD		A,(LBUF+5)		;"*FDTL/"��"/"
		CP		"/"
		JP		Z,MON
		LD		HL,(EXEAD)
		LD		A,H
		CP		012H
		JP		C,MON
		JP		(HL)

STTP2:
		CP		'V'			;FDTV:Tape VERIFY
		JR		NZ,STTP3
;**** �e�[�v�x���t�@�C ****
TPVERFY:
		CALL		TPRDINF			;�w�b�_�����[�h���ĕ\��
		JP		C,MON			;�u���[�N/�G���[�Ȃ炻�̂܂܃R�}���h�҂���

		LD		DE,LBUF+6		;"*FDTV/"��6������΂����ʒu���t�@�C����
		LD		B,16
		CALL		TPSKIPSPC		;SKIP SPACES
		LD		HL,FNAME
		LD		B,16			;�ő�16����
;		LD		A,(DE)			;�ȗ���
		CP		0DH
		JR		Z,TPVERFY2		;�t�@�C��������
		CALL		CMPSTR			;��r
		JR		NZ,TPVERFY		;�t�@�C�����s��v
;�x���t�@�C���t�@�C�����\��
TPVERFY2:
		LD		DE,TMSG_VERFYING	;VERIFYING �t�@�C����
		CALL		TPDISP_FN
		CALL		TPMVRFY
		JR		NC,TPVERFY3
		CP		02H			;01=Check SUM Error, 02=BREAK
		JP		Z,MON			;�u���[�N
		LD		DE,TMSG_DATAERROR	;"DATA ERR"
		CALL		MSGPR
		JP		MON
TPVERFY3:
		CALL		LETLN
		LD		DE,TMSG_OK		;"OK"
		CALL		MSGPR
		JP		MON

STTP3:
		CP		'S'			;FDTS:Tape SAVE
		JP		NZ,STTP4
;**** �e�[�v�Z�[�u ****
; *FDTS ssss eeee xxxx		; type=01 �Œ�
; *FDTS#tt ssss eeee xxxx	; type�w��\
				; #tt �̃`�F�b�N
TPSAVE:
		INC		DE
		LD		A,(DE)
		CP		'#'
		LD		A,01H			;�f�t�H���g�^�C�v
		JR		NZ,TSAVE_NOTYPE
		INC		DE
		PUSH		DE
		CALL		TWOHEX			;#tt �Ńt�@�C���^�C�v�w��
		JR		C,TPSAVE1
		POP		DE
		INC		DE			;tt�̂Ԃ�X�L�b�v
		INC		DE
TSAVE_NOTYPE:
		LD		(IBUFE),A		;�t�@�C���^�C�v�ۑ�

		INC 		DE
		PUSH		DE
		CALL		HLHEX			;1�����󂯂�4����16�i���ł����SADRS�ɃZ�b�g���đ��s
		JR		C,TPSAVE1
		LD		(SADRS),HL		;SARDS�ۑ�
		POP		DE

		INC		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE
		PUSH		DE			;5�����i�߂�4����16�i���ł����FSIZE�ɃZ�b�g���đ��s
		CALL		HLHEX
		JR		C,TPSAVE1
		LD		BC,(SADRS)
		SBC		HL,BC			;EADRS��SADRS���傫���Ȃ��ꍇ�̓G���[
		JR		Z,TPSAVE1
		JR		C,TPSAVE1
		INC		HL			;HL=EADRS-START+1 = FSIZE
		LD		(FSIZE),HL		;FSIZE�Z�b�g

		POP		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE			;5�����i�߂�4����16�i���ł����EXEAD�ɃZ�b�g���đ��s
		PUSH		DE
		CALL		HLHEX
		JR		C,TPSAVE1
		LD		(EXEAD),HL		;EXEAD�ۑ�
		POP		DE

		INC		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE			;5�����i�߂ăt�@�C���l�[��������Α��s
		CALL		TPSKIPSPC		;SKIP SPACES
;		LD		A,(DE)			;�ȗ���
		CP		21H
		JR		C,TPSAVE2
		EX		DE,HL			;HL=�t�@�C�����擪�A�h���X
		JR		TPSAVE3			;SAVE������

TPSAVE1:
							;16�i��4���̎擾�Ɏ��s����EADRS��SARDS���傫���Ȃ�
		LD		DE,MSG_AD
		JP		ERRMSG
TPSAVE2:
							;�t�@�C���l�[���̎擾�Ɏ��s
		LD		DE,MSG_FNAME
		JP		ERRMSG
;�t�@�C�����̃Z�b�g
TPSAVE3:
		LD		DE,FNAME
		LD		BC,16
		LDIR
		LD		A,0DH
		LD		(DE),A

;�w�b�_�̃��C�g(WRITING �\�������̒��ōs���Ă����)
		CALL		TPMSHED
		JP		C,MON			;�u���[�N/�G���[�Ȃ炻�̂܂܃R�}���h�҂���
;�{�̂̃��C�g
TPSAVE3_2:
		CALL		TPMSDAT
		JR		C,TPSAVE4
		CALL		LETLN
		LD		DE,TMSG_OK		;"OK"
		CALL		MSGPR
TPSAVE4:
		JP		MON

STTP4:
		CP		'B'			;FDTB:Backup Tape to SD copy
		JP		NZ,STTP99
;**** �e�[�v����SD��BREAK���������(�܂��͂��܂��^�C�~���O�Ńe�[�v���~�܂�)�܂ŘA���o�b�N�A�b�v ****
;**** �`�F�b�N�T���G���[�͖����B�t�@�C�����͓K���ɕϊ����� ****
				;FDTB xx	xx��;�t�@�C���������̎��̃t�@�C�����ǋL�ԍ������l(16�i2��)
		INC		DE
		LD		A,1
		LD		(LBUF),A		;�t�@�C���������̎��̃t�@�C�����ǋL�ԍ������l
		LD		A,(DE)
		CP		0DH
		JR		Z,TPBACKUP10		;xx�Ȃ�
		LD		B,16
		CALL		TPSKIPSPC		;SKIP SPACES
		CALL		TWOHEX
		JP		C,MON
		LD		(LBUF),A		;2����16�i��������Ώ����l�ɏ�������
		JR		TPBACKUP10
TPBACKUP:
		LD		HL,LBUF			;�t�@�C���ԍ�++
		INC		(HL)
TPBACKUP10:
		CALL		TPRDINF			;�w�b�_�����[�h���ĕ\��
		JP		NC,TPBACKUP20
		CP		02H			;01=Check SUM Error, 02=BREAK
		JP		Z,MON			;�u���[�N
		JR		TPBACKUP		;���̃t�@�C����
TPBACKUP20:
	;LOADING �t�@�C����
		LD		DE,TMSG_LOADING
		CALL		TPDISP_FN

	;�X�N���[���f���΍�:�K��$1200?�փ��[�h
		LD		HL,(SADRS)		;SADRS�̑Ҕ�
		PUSH		HL
		LD		HL,1200H		;1200H�ɃZ�b�g
		LD		(SADRS),HL
		CALL		TPMLDAT			;�{�̂̃��[�h
		POP		HL
		LD		(SADRS),HL		;SADRS�̕��A
		JR		NC,TPBACKUP30
		CP		02H			;01=Check SUM Error, 02=BREAK
		JP		Z,MON			;�u���[�N
		LD		DE,TMSG_CSUM		;"CHECKSUM ERR"
		CALL		MSGPR
		JR		TPBACKUP		;���̃t�@�C����
TPBACKUP30:
		CALL		LETLN
		LD		DE,TMSG_OK		;"OK"
		CALL		MSGPR

; SD�Z�[�u�p��DOS�t�@�C�����ւ̕ϊ� FNAME -> LBUF+6 +2 +2
		LD		DE,LBUF+10
		CALL		TPMKDOSFNAME
;  -> DOS FILENAME.MZT

; �Z�[�u�t�@�C�����̍�荞��
		LD		DE,LBUF+6
		PUSH		DE
; �t�@�C���ԍ�
		LD		A,(LBUF)
		CALL		TPSTOREHEX
; �t�@�C���^�C�v
		LD		A,(IBUFE)
		CALL		TPSTOREHEX
		POP		DE

	;�X�N���[���f���΍�:���[�h�A�h���X��Dxxx��������DOS�t�@�C����������"-DM"�ɂ���
		LD		A,(SADRS+1)
		AND		0F0H
		CP		0D0H
		JR		NZ,TPBACKUP70
;;		LD		DE,LBUF+6
		LD		B,32-3			;"-DM"�̕�������������
TPBACKUP50:
		LD		A,(DE)
		CP		0DH
		JR		Z,TPBACKUP60
		INC		DE
		DJNZ		TPBACKUP50
TPBACKUP60:
		LD		HL,TPSDEMO		;"-DM",0DH
		LD		BC,TPSDEMO1-TPSDEMO
		LDIR
TPBACKUP70:
; SD�Z�[�u�p�̃R�}���h�������\��
; *FDS#tt ssss eeee xxxx FILENAME
		CALL		TPDISPFDSCMD
;  -> DOS FILENAME.MZT
		CALL		TPDISPDOSFN

;SD��FSIZE�ł͂Ȃ���EADRS�Ȃ̂Ōv�Z����B
		LD		HL,(SADRS)
		EX		DE,HL
		LD		HL,(FSIZE)
		LD		(LBUF+1),HL		;FSIZE�Ҕ�
		ADD		HL,DE			;EADRS=SADRS+FSIZE-1
		DEC		HL
		LD		(EADRS),HL		;EADRS�ۑ�
	;���M�w�b�_�����Z�b�g���ASD�J�[�h��SAVE���s
		LD		HL,LBUF+6		;������ɍ�荞�񂾕����g�p
		LD		A,0A0H			;TYPE�t��SAVE�R�}���hA0H
		CALL		STCD			;00�ȊO(ZF�������Ă��Ȃ�)�Ȃ�ERROR
		JP		NZ,SVERR
				;type�𑗂�
		LD		A,(IBUFE)
		CALL		SNDBYTE
	;----
		CALL		HDSEND			;�w�b�_��񑗐M
		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,SVERR
;; $1200?�̃f�[�^�ɂȂ�悤���[�N������
		LD		HL,1200H
		LD		(SADRS),HL
		LD		DE,(LBUF+1)		;�o�C�g��
		ADC		HL,DE
		DEC		HL
		LD		(EADRS),HL
		CALL		DBSEND			;�f�[�^���M

		LD		DE,MSG_SV
		CALL		PLIST
		CALL		LETLN

		JP		TPBACKUP		;���̃t�@�C����
STTP99:
; kaokun ] -----------------------------------------------------------------------------
		JP		CMDERR

;**** 8255������ ****
;PORTC����BIT��OUTPUT�A���BIT��INPUT�APORTB��INPUT�APORTA��OUTPUT
INIT:
		LD		A,8AH
		OUT		(0DBH),A
;�o��BIT�����Z�b�g
INIT2:
;;		LD		A,00H			;PORTA <- 0
		XOR		A			;�o�C�g���ߖ�
		OUT		(0D8H),A
		OUT		(0DAH),A		;PORTC <- 0
		RET

;**** LOAD ****
;��M�w�b�_�����Z�b�g���ASD�J�[�h����LOAD���s
;DE+1?:�t�@�C����
SDLOAD:
		LD		A,0A1H			;�^�C�v�t��LOAD�R�}���hA1H
		CALL		STCMD
		CALL		HDRCV			;�w�b�_����M
;[kaokun]
		LD		HL,(SADRS)		;SADRS�Ҕ�
		PUSH		HL
		LD		A,(LBUF+3)
		CP		'>'			;'*FD>'�ł����$1200���烍�[�h
		JR		NZ,SDLOAD1
		LD		HL,1200H
		LD		(SADRS),HL
SDLOAD1:
		PUSH		AF
		CALL		DBRCV			;�f�[�^��M
		POP		AF
		POP		HL
		LD		(SADRS),HL		;SADRS���A
		CP		'>'			;'*FD>'�ł����$1200������e�[�v�ɕۑ���MONITOR�R�}���h�҂��ɖ߂�
		JR		Z,SDLOAD2
		CP		'/'			;'*FD/'�ł���Ύ��s�A�h���X�ɔ�΂���MONITOR�R�}���h�҂��ɖ߂�
		JR		Z,SDLOAD2

; FD�R�}���h���s��A�v�����삪�ł܂��Ă��܂��@�B�A�A�v���ւ̑Ώ�
		EI					;�J�Z�b�g���[�h��EI�ɂȂ��Ă���悤�Ȃ̂œ��P
		LD		A,00H
		LD		DE,0000H
		CALL		TIMST
		LD		A,4			;Init Music
		CALL		XTEMP
		CALL		MSTP
		LD		HL,(EXEAD)
		LD		A,H			;[kaokun]:$1200���O�̒l�̓I�[�g�X�^�[�g����
		CP		012H
		JP		C,MON
		JP		(HL)
;kaokun
SDLOAD2:
		CALL		LETLN
		LD		DE,TMSG_OK		;"OK"
		CALL		MSGPR
; �J�Z�b�g�Z�[�u�p�̃R�}���h�������\��
; *FDTS#tt ssss eeee xxxx FILENAME
		CALL		LETLN
		LD		DE,TMSG_FDTS		;*FDTS#
		CALL		TPDISPFDTSCMD

		LD		A,(LBUF+3)
		CP		'>'			;'*FD>'�ł����$1200������e�[�v�ɕۑ�
		JP		NZ,MON

;�w�b�_�̃��C�g(WRITING �\�������̒��ōs���Ă����)
		CALL		TPMSHED
		JP		C,MON			;�u���[�N/�G���[�Ȃ炻�̂܂܃R�}���h�҂���
;�{�̂̃��C�g
		LD		HL,1200H		;�ۑ����͏��$1200����
		LD		(SADRS),HL
		JP		TPSAVE3_2

;�w�b�_��M
;[kaokun] �^�C�v����M����
HDRCV:
				;type+�t�@�C��������M=======
		LD		HL,IBUFE
		LD		B,1+17
HDRC1:
		CALL		RCVBYTE			;�t�@�C���l�[����M
		LD		(HL),A
		INC		HL
		DJNZ		HDRC1
		LD		DE,MSG_LD		;�t�@�C���l�[��LOADING�\��
		CALL		MSGPR
		CALL		TPDISP_FNONLY		;FILENAME[CR]

		LD		HL,SADRS		;SADRS�擾
		CALL		RCVBYTE
		LD		(HL),A
		INC		HL
		CALL		RCVBYTE
		LD		(HL),A

		LD		HL,FSIZE		;FSIZE�擾
		CALL		RCVBYTE
		LD		(HL),A
		INC		HL
		CALL		RCVBYTE
		LD		(HL),A

		LD		HL,EXEAD		;EXEAD�擾
		CALL		RCVBYTE
		LD		(HL),A
		INC		HL
		CALL		RCVBYTE
		LD		(HL),A

	; -> tt ssss eeee xxxx
		CALL		TPDISPHEAD2
		CALL		LETLN
		RET

;�f�[�^��M
DBRCV:
		LD		DE,(FSIZE)
		LD		HL,(SADRS)
DBRLOP:
		CALL		RCVBYTE
		LD		(HL),A
		DEC		DE
		LD		A,D
		OR		E
		INC		HL
		JR		NZ,DBRLOP		;DE=0�܂�LOOP
		RET

;**** SAVE ****
STSV:
		INC		DE
; [kaokun] : �t�@�C���^�C�v��ۑ��ł���悤��
;	     *FDS ssss eeee xxxx DOS filename		type 01=OBJ
;	     *FDS#02 ssss eeee xxxx Program name	type �w��+PNAME
		LD		A,(DE)
		CP		'#'
		LD		A,01H			;�f�t�H���g�^�C�v
		JR		NZ,STSV_NOTYPE
		INC		DE
		PUSH		DE
		CALL		TWOHEX			;#xx �Ńt�@�C���^�C�v�w��
		JR		C,STSV1
		POP		DE
		INC		DE
		INC		DE
STSV_NOTYPE:
		LD		(IBUFE),A		;�t�@�C���^�C�v�ۑ�
		INC		DE
		PUSH		DE
		CALL		HLHEX			;1�����󂯂�4����16�i���ł����SADRS�ɃZ�b�g���đ��s
		JR		C,STSV1

		LD		(SADRS),HL		;SARDS�ۑ�
		POP		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE
		PUSH		DE			;5�����i�߂�4����16�i���ł����EADRS�ɃZ�b�g���đ��s
		CALL		HLHEX
		JR		C,STSV1
		PUSH		HL
		LD		BC,(SADRS)
		SBC		HL,BC			;EADRS��SADRS���傫���Ȃ��ꍇ�̓G���[
		POP		HL
;;		JR		Z,STSV1			;�[��(==SADRS==EADRS, 1�o�C�g)�͋����ėǂ���
		JR		C,STSV1

		LD		(EADRS),HL		;EADRS�ۑ�
		POP		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE			;5�����i�߂�4����16�i���ł����EXEAD�ɃZ�b�g���đ��s
		PUSH		DE
		CALL		HLHEX
		JR		C,STSV1

		LD		(EXEAD),HL		;EXEAD�ۑ�
		POP		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE			;5�����i�߂ăt�@�C���l�[��������Α��s
		LD		A,(DE)
		CP		21H
		JR		C,STSV2

	;�t�@�C������FNAME�֐ςݍ���
		PUSH		DE
		LD		B,16
		LD		HL,FNAME
STSV0:
		LD		A,(DE)
		LD		(HL),A
		INC		HL
		INC		DE
		DJNZ		STSV0
		LD		(HL),0DH
		POP		HL			;PROG NAME or DOS Filename

		LD		A,(LBUF+4)		;*FDS#��#
		CP		'#'
		JR		NZ,SDSAVE		;DOS Filename �Ƃ��� SAVE������

; PNAME --> SD�Z�[�u�p��DOS�t�@�C�����ւ̕ϊ� FNAME -> LBUF+6
		LD		DE,LBUF+6
		PUSH		DE
		CALL		TPMKDOSFNAME
;  -> DOS FILENAME.MZT
		CALL		TPDISPDOSFN
		POP		HL
		JR		SDSAVE			;SAVE������

STSV1:
				;16�i��4���̎擾�Ɏ��s����EADRS��SARDS���傫���Ȃ�
		LD		DE,MSG_AD
		JR		ERRMSG
STSV2:
				;�t�@�C���l�[���̎擾�Ɏ��s
		LD		DE,MSG_FNAME
		JR		ERRMSG
CMDERR:
				;�R�}���h�ُ�
		LD		DE,MSG_CMD
		JR		ERRMSG

;���M�w�b�_�����Z�b�g���ASD�J�[�h��SAVE���s
;[kaokun]
;DOS FNAME=(HL)
;MZT PNAME=(FNAME)
;�ƕ�����
;�R�}���hA0(�^�C�v�t��)���g���B
SDSAVE:
		LD		A,0A0H			;TYPE�t��SAVE�R�}���hA0H
		CALL		STCD			;00�ȊO(ZF�������Ă��Ȃ�)�Ȃ�ERROR
		JP		NZ,SVERR
				;type�𑗂�
		LD		A,(IBUFE)
		CALL		SNDBYTE
	;----
		CALL		HDSEND			;�w�b�_��񑗐M
		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		AND		A			;00�ȊO�Ȃ�ERROR
		JR		NZ,SVERR
		CALL		DBSEND			;�f�[�^���M
		LD		DE,MSG_SV
		JR		ERRMSG

SVER0:
		POP		DE			;CALL��STACK��j������
SVERR:
		CP		0F0H
		JR		NZ,ERR3
		LD		DE,MSG_F0		;SD-CARD INITIALIZE ERROR
		JR		ERRMSG
;FD�R�}���h�Ń��[�h�\�ȃt�@�C����ރR�[�h��0x01�݂̂Ƃ��Ă���������P�p
;ERR2:
;		CP		0F2H
;		JR		NZ,ERR3
;		LD		DE,MSG_F2		;NOT OBJECT FILE
;		JR		ERRMSG
ERR3:
		CP		0F1H
		JR		NZ,ERR4
		LD		DE,MSG_F1		;NOT FIND FILE
		JR		ERRMSG
ERR4:
		CP		0F3H
		JR		NZ,ERR5
		LD		DE,MSG_F3		;FILE EXIST
		JR		ERRMSG
ERR5:
		CP		0F4H
		JR		NZ,ERR99
		LD		DE,MSG_CMD
		JR		ERRMSG
ERR99:
		CALL		PRTBYT
		LD		DE,MSG99		;���̑�ERROR
ERRMSG:
		CALL		MSGPR
		CALL		LETLN
MON:
		LD		A,(014EH)
		CP		'P'			;014EH��'P'�Ȃ�MZ-80K
		JP		Z,MONITOR_80K
		CP		'N'			;014EH��'N'�Ȃ�FN-700
		JP		Z,MONITOR_80K
; [kaokun] MZ-NewMon ------------------------------------------------
		CP		20H			;014EH��' '�Ȃ�MZ-NEW MONITOR MZ-80K ("MONITOR VER"�̃X�y�[�X)
		JP		Z,MONITOR_NEWMON
		LD		A,(0145H)
		CP		'7'			;0145H��'7'�Ȃ�MZ-NEW MONITOR MZ-700 ("MZ700"��"7")
		JP		Z,MONITOR_NEWMON7
		LD		A,(010DH)		;010DH��'A'�Ȃ�MZ-80A ("SA-1510"��"A")
		CP		'A'
		JP		Z,MONITOR_80A
; -------------------------------------------------------------------
		LD		A,(06EBH)
		CP		'M'			;06EBH��'M'�Ȃ�MZ-700 (JP/EU ����)
		JP		Z,MONITOR_700
		JP		0000H			;���ʂł��Ȃ�������0000H�փW�����v

;�w�b�_���M
;[kaokun]
;DOS FNAME=(HL)
;MZT PNAME=(FNAME)
;�ƕ�����
HDSEND:
		LD		B,32
SS1:
		LD		A,(HL)			;FNAME���M
		CALL		SNDBYTE
		INC		HL
		DJNZ		SS1
		LD		A,0DH
		CALL		SNDBYTE

		LD		HL,FNAME		; ��������g��
		LD		B,16
SS2:
		LD		A,(HL)			;PNAME���M
		CALL		SNDBYTE
		INC		HL
		DJNZ		SS2
		LD		A,0DH
		CALL		SNDBYTE

		LD		HL,SADRS		;SADRS���M
		LD		A,(HL)
		CALL		SNDBYTE
		INC		HL
		LD		A,(HL)
		CALL		SNDBYTE

		LD		HL,EADRS		;EADRS���M
		LD		A,(HL)
		CALL		SNDBYTE
		INC		HL
		LD		A,(HL)
		CALL		SNDBYTE

		LD		HL,EXEAD		;EXEAD���M
		LD		A,(HL)
		CALL		SNDBYTE
		INC		HL
		LD		A,(HL)
		CALL		SNDBYTE
		RET

;�f�[�^���M
;SADRS����EADRS�܂ł𑗐M
DBSEND:
		LD		HL,(EADRS)
		EX		DE,HL
		LD		HL,(SADRS)
DBSLOP:
		LD		A,(HL)
		CALL		SNDBYTE
		LD		A,H
		CP		D
		JR		NZ,DBSLP1
		LD		A,L
		CP		E
		RET		Z			;HL == DE �Ȃ�I���
DBSLP1:
		INC		HL
		JR		DBSLOP

;**** AUTO START SET ****
STAS:
		LD		A,82H			;AUTO START SET�R�}���h82H
		CALL		STCMD
		LD		DE,MSG_AS
		JP		ERRMSG


;**** DIRLIST ****
STLT:
		INC		DE			;FDL�̎��̕�����
		LD		HL,DEFDIR		;�s����'*FD '��t���邱�ƂŃJ�[�\�����ړ��������^�[���Ŏ��s�ł���悤��
		LD		BC,DEND-DEFDIR
		CALL		DIRLIST
		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,SVERR
		JP		MON


;**** DIRLIST�{�� (HL=�s���ɕt�����镶����̐擪�A�h���X BC=�s���ɕt�����镶����̒���, DE=DOS�t�@�C����) ****
;****              �߂�l A=�G���[�R�[�h ****
DIRLIST:
		PUSH		BC			;�t�@�C�����O�̃X�y�[�X���X�L�b�v
		LD		B,32
		CALL		TPSKIPSPC		;SKIP SPACES
		POP		BC

		LD		A,0A3H			;�f�B���g�������t��DIRLIST�R�}���h0A3H�𑗐M
		CALL		STCD			;00�ȊO(ZF�������Ă��Ȃ�)�Ȃ�ERROR
		JP		NZ,DLRET
		PUSH		BC
		LD		B,32+1			;��r�t�@�C�����𑗐M
STLT1:							;0DH�̏�����Arduino���ł��悤�ɂ���
		LD		A,(DE)
		CALL		SNDBYTE
		INC		DE
		DJNZ		STLT1
		POP		BC
DL1:
		PUSH		HL			;HL=�s���ɕt�����镶����
		PUSH		BC			;������
DL1_1:
		CALL		RCVBYTE			;������M 'F' or 'D' �܂��͎w��(0FFH,0FEH)�̎�M
		CP		0FFH			;'0FFH'����M������I��
		JR		Z,DL4
		CP		0FEH			;'0FEH'����M������ꎞ��~���Ĉꕶ�����͑҂�
		JR		Z,DL5
	;�t�@�C�����̎�M�ƕ\���������荞��
		LD		DE,LBUF
		LDIR
		CP		'D'
		JR		NZ,DL1_99		;�ʏ�t�@�C���̂Ƃ�
	;�ȉ��f�B���N�g���̂Ƃ�
		LD		A,(LBUF)		;�s����"*FD   " �Ȃ� ����������"CD"
		CP		'*'			;����ȊO�Ȃ�*FDCD��ςݍ���
		JR		Z,DL1_2
		LD		HL,STR_FDCD		;"*FDCD "
		LD		C,STR_FDCD_END-STR_FDCD	;"*FDCD "��6�o�C�g
		JR		DL1_3
DL1_2:
		DEC		DE
		DEC		DE
		DEC		DE
		LD		HL,STR_FDCD+3		;"*FDCD "�̓�3������΂��Č���"CD "�𗘗p
		LD		C,STR_FDCD_END-STR_FDCD-3
DL1_3:
		LDIR
DL1_99:
	;�ȏ�f�B���N�g���̂Ƃ�
		EX		DE,HL
		LD		B,0
DL2:
		CALL		RCVBYTE			;'00H'����M����܂ł���s�Ƃ���
		OR		A
		JR		Z,DL3
		CP		0DH			;0DH�͖���
		JR		Z,DL2
		LD		(HL),A
		INC		B			;������++
		INC		HL
		JR		DL2
	;1�s�G���h
DL3:
		LD		(HL),0DH		;�G���h�}�[�N��������
; .MZT �͏���
		LD		A,B
		CP		4			;'.MZT'��4�����ȏ�K�v
		JR		C,DL3z
		DEC		HL
		LD		A,(HL)
		CP		'T'
		JR		NZ,DL3z
		DEC		HL
		LD		A,(HL)
		CP		'Z'
		JR		NZ,DL3z
		DEC		HL
		LD		A,(HL)
		CP		'M'
		JR		NZ,DL3z
		DEC		HL
		LD		A,(HL)
		CP		'.'
		JR		NZ,DL3z
		LD		(HL),0DH
DL3z:
		CALL		CLRLINE
		LD		DE,LBUF			;'00H'����M�������s����\�����ĉ��s
		CALL		MSGPR
; �s���܂ŃN���A����
		CALL		CLRLBUF
		CALL		LETLN
		POP		BC
		POP		HL
		JR		DL1
DL4:
		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		POP		BC
		POP		HL
DLRET:
		RET

DL5:
		LD		DE,MSG_KEY1		;HIT ANT KEY�\��
		CALL		MSGPR
		LD		A,0C2H
		CALL		DISPCH
		LD		DE,MSG_KEY2		;HIT ANT KEY�\��
		CALL		MSGPR
		CALL		LETLN
DL6:
		CALL		GETKEY			;1�������͑҂�
		OR		A
		JR		Z,DL6
		CP		64H			;SHIFT+BREAK�őł��؂�
		JR		Z,DL7
		CP		12H			;�J�[�\�����őł��؂�
		JR		Z,DL9
		CP		42H			;�uB�v�őO�y�[�W
		JR		Z,DL8
		LD		A,00H			;����ȊO�Ōp��
		JR		DL8
DL9:
		LD		A,0C2H			;�J�[�\�����őł��؂����Ƃ��ɃJ�[�\��2�s���
		CALL		DPCT
		LD		A,0C2H
		CALL		DPCT
DL7:
		LD		A,0FFH			;0FFH���f�R�[�h�𑗐M
DL8:
		CALL		SNDBYTE
		CALL		LETLN
		JP		DL1_1			;FF 00 �̎�M



;**** FILE DELETE ****
STDE:
		LD		A,84H			;FILE DELETE�R�}���h84H
		CALL		STCMD

		LD		DE,MSG_DELQ		;'DELETE?'�\��
		CALL		MSGPR
		CALL		LETLN
STDE3:
		CALL		GETKEY
		OR		A
		JR		Z,STDE3
		CP		59H			;'Y'�Ȃ�OK�Ƃ���00H�𑗐M
		JR		NZ,STDE4
		LD		A,00H
		JR		STDE5
STDE4:
		LD		A,0FFH			;'Y'�ȊO�Ȃ�CANSEL�Ƃ���0FFH�𑗐M
STDE5:
		CALL		SNDBYTE
		CALL		RCVBYTE
		OR		A			;00H����M�����DELETE����
		JR		NZ,STDE6
		LD		DE,MSG_DELY		;'DELETE OK'�\��
		JR		STDE8
STDE6:
		CP		01H			;01H����M�����CANSEL����
		JR		NZ,STDE7
		LD		DE,MSG_DELN		;'DELETE CANSEL'�\��
		JR		STDE8
STDE7:
		JP		SVERR
STDE8:
		JP		ERRMSG

;**** FILE RENAME ****
STRN:
		LD		A,85H			;FILE RENAME�R�}���h85H
		CALL		STCMD

		LD		DE,MSG_REN		;'NEW NAME:'�\��
		CALL		MSGPR

		LD		A,09H
		LD		(DSPX),A		;�J�[�\���ʒu��'NEW NAME:'�̎���
		LD		DE,LBUF			;NEW FILE NAME���擾
		CALL		GETL
		CALL		TRIM_LBUF
		LD		DE,LBUF+8		;NEW FILE NAME�𑗐M
		CALL		STFN
		CALL		STFS

		CALL		RCVBYTE
		OR		A			;00H����M�����RENAME����
		JP		NZ,SVERR
		LD		DE,MSG_RENY
		JP		ERRMSG

;**** FDCD: CHDIR �R�}���h ****
STCHDIR:
		LD		A,0A6H			;CHDIR�R�}���hA6H
		JR		STCHMKDIR
;*** FDMD: MKDIR  �R�}���h ****
STMKDIR:
		LD		A,0A7H			;MKDIR�R�}���hA7H
STCHMKDIR:
		CALL		CHMKDIR			;00H����M�����CD/MD����
		JP		NZ,SVERR
		JP		MON

;**** CHDIR/MKDIR �{�� ****
; (DE+1)?�t�@�C�����̃|�C���^
; A: 0A6H = CHDIR�R�}���h, 0A7H = MKDIR�R�}���h
; ZF��OK
CHMKDIR:
		PUSH		AF
		LD		B,32
		INC		DE
		CALL		TPSKIPSPC
		EX		DE,HL
		POP		AF
		CALL		STCMD2
		CALL		LETLN
	;�J�����g�f�B���N�g�����܂ޕ������M
STCHD_10:
		CALL		RCVBYTE			;'00H'����M����܂ŕ\��
		OR		A
		JR		Z,STCHD_20
		CALL		PRNT
		JR		STCHD_10
STCHD_20:
		CALL		RCVBYTE			;A�ɃG���[�R�[�h�����ă��^�[��
		OR		A
		RET


;**** FILE DUMP ****
STPR:
		LD		A,86H			;FILE DUMP�R�}���h86H
		CALL		STCMD

;		LD		A,0C6H			;��ʃN���A
;		CALL		DPCT
STPR6:
		LD		HL,SADRS		;SADRS�擾
		CALL		RCVBYTE
		LD		(HL),A
		INC		HL
		CALL		RCVBYTE
		LD		(HL),A
		LD		HL,(SADRS)
		LD		A,H
		CP		0FFH			;ADRS��0FFFFH�����M����Ă�����DUMP�����I��
		JR		NZ,STPR7
		LD		A,L
		CP		0FFH
		JR		NZ,STPR7
		JP		STPR8
STPR7:
		LD		DE,MSG_AD1		;DUMP TITLE�\��
		CALL		MSGPR
		CALL		LETLN
		LD		C,16			;16�s(128Byte)��\��
STPR0:
		PUSH		BC
		LD		B,8			;��s(8Byte)����M
		LD		HL,LBUF
STPR1:
		CALL		RCVBYTE
		LD		(HL),A
		INC		HL
		DJNZ		STPR1

		LD		HL,(SADRS)		;�A�h���X�\��
		CALL		PRTWRD
		LD		DE,0008H		;����(128Byte)���̓A�h���X���󂯎��Ȃ��̂Ŏ��O�ŃC���N�������g
		ADD		HL,DE
		LD		(SADRS),HL

		LD		B,8			;��s(8Byte)�̃f�[�^��16�i���\��
		LD		DE,LBUF
STPR2:
		CALL		PRNTS
		LD		A,(DE)
		CALL		PRTBYT
		INC		DE
		DJNZ		STPR2

		CALL		PRNTS
		LD		DE,LBUF			;��s(8Byte)�̃f�[�^���L�����N�^�\��
		LD		B,8
STPR9:
		LD		A,(DE)
		CP		10H			;MZ-700�ł̕��������ɑΏ�
		JR		NC,STPRA
		LD		A,20H
STPRA:
		CALL		ADCN
		CALL		DISPCH
		INC		DE
		DJNZ		STPR9

		CALL		LETLN
		POP		BC
		DEC		C
		JR		NZ,STPR0

		LD		DE,MSG_AD2		;���͑҂����b�Z�[�W�\��
		CALL		MSGPR
		CALL		LETLN
		CALL		LETLN
STPR3:
		CALL		GETKEY			;1�������͑҂�
		OR		A
		JR		Z,STPR3
		CP		64H			;SHIFT+BREAK�őł��؂�
		JR		Z,STPR4
		CALL		SNDBYTE			;SHIFT+BREAK�ȊO��ASCII�R�[�h�̂܂ܑ��M�AARDUINO����'B'������
		JP		STPR6
STPR4:
		LD		A,0FFH			;0FFH���f�R�[�h�𑗐M
STPR5:
		CALL		SNDBYTE
		CALL		RCVBYTE			;SHIFT+BREAK�ł̒��f����ADRS'0FFFFH'�̎�M�y�я�ԃR�[�h�̎�M��j��
		CALL		RCVBYTE
STPR8:
		CALL		RCVBYTE
		JP		MON

;**** FILE COPY ****
STCP:
		LD		A,87H			;FILE COPY�R�}���h87H
		CALL		STCMD
		LD		DE,MSG_REN		;'NEW NAME:'�\��
		CALL		MSGPR

		LD		A,09H
		LD		(DSPX),A		;�J�[�\���ʒu��'NEW NAME:'�̎���
		LD		DE,LBUF			;NEW FILE NAME���擾
		CALL		GETL
		CALL		TRIM_LBUF
		LD		DE,LBUF+8		;NEW FILE NAME�𑗐M
		CALL		STFN
		CALL		STFS

		CALL		RCVBYTE
		OR		A			;00H����M�����COPY����
		JP		NZ,SVERR
		LD		DE,MSG_CPY
		JP		ERRMSG

;@;**** MEMORY DUMP ****
;@STMD:
;@		INC		DE
;@		INC		DE
;@		CALL		HLHEX			;1�����󂯂�4����16�i���ł����SADRS�ɃZ�b�g���đ��s
;@		JP		C,STSV1
;@		LD		(SADRS),HL		;SARDS�ۑ�
;@
;@STMD6:
;@		LD		DE,MSG_AD1		;DUMP TITLE�\��
;@		CALL		MSGPR
;@		CALL		LETLN
;@		LD		C,10H			;16�s(128Byte)��\��
;@STMD7:
;@		LD		HL,(SADRS)		;�A�h���X�\��
;@		CALL		PRTWRD
;@		CALL		PRNTS
;@
;@		
;@		LD		B,08H			;��s(8Byte)�̃f�[�^��16�i���\��
;@STMD0:
;@		LD		A,(HL)
;@		CALL		PRTBYT
;@		CALL		PRNTS
;@		CALL		GETKEY
;@		CP		64H
;@		JR		Z,STMD4
;@		INC		HL
;@		DJNZ		STMD0
;@
;@		LD		HL,(SADRS)
;@		LD		B,08H			;��s(8Byte)�̃f�[�^���L�����N�^�\��
;@STMD2:
;@		LD		A,(HL)
;@		CP		10H			;MZ-700�ł̕��������ɑΏ�
;@		JR		NC,STMD8
;@		LD		A,20H
;@STMD8:
;@		CALL		ADCN
;@		CALL		DISPCH
;@		CALL		GETKEY
;@		CP		64H			;�\���r���ł�SHIFT+BREAK�őł��؂�
;@		JR		Z,STMD4
;@		INC		HL
;@		DJNZ		STMD2
;@
;@		LD		(SADRS),HL
;@		CALL	LETLN
;@
;@		DEC		C
;@		JR		NZ,STMD7
;@		
;@		LD		DE,MSG_AD2		;���͑҂����b�Z�[�W�\��
;@		CALL		MSGPR
;@		CALL		LETLN
;@		CALL		LETLN
;@STMD3:
;@		CALL		GETKEY			;1�������͑҂�
;@		OR		A
;@		JR		Z,STMD3
;@		CP		64H			;SHIFT+BREAK�őł��؂�
;@		JR		Z,STMD4
;@		CP		42H
;@		JR		NZ,STMD5
;@		LD		HL,(SADRS)
;@		LD		DE,0100H
;@		SBC		HL,DE
;@		LD		(SADRS),HL
;@STMD5:;
;@		JP		STMD6
;@STMD4:
;@		JP		MON
;@
;@;**** MEMORY WRITE ****
;@STMW:
;@		INC		DE
;@		INC		DE
;@		CALL		HLHEX			;1�����󂯂�4����16�i���ł����HL�ɃZ�b�g���đ��s
;@		JP		C,STSV1
;@
;@		INC		DE
;@		INC		DE
;@		INC		DE
;@		INC		DE
;@STSP1:
;@		LD		A,(DE)
;@		CP		0DH
;@		JR		Z,STMW9			;�A�h���X�݂̂Ȃ�I��
;@		CP		20H
;@		JR		NZ,STMW1
;@		INC		DE          		;�󔒂͔�΂�
;@		JR		STSP1
;@
;@STMW1:
;@		CALL		TWOHEX
;@		JR		C,STMW8
;@		LD		(HL),A			;2����16�i���������(HL)�ɏ�������
;@		INC		HL
;@
;@STSP2:
;@		LD		A,(DE)
;@		CP		0DH			;��s�I��
;@		JR		Z,STMW8
;@		CP		20H
;@		JR		NZ,STMW1
;@		INC		DE			;�󔒂͔�΂�
;@		JR		STSP2
;@
;@STMW8:
;@		LD		DE,MSG_FDW		;�s����'*FDW '
;@		CALL		MSGPR
;@		CALL		PRTWRD			;�A�h���X�\��
;@		CALL		PRNTS
;@		LD		DE,LBUF			;��s����
;@		CALL		GETL
;@		LD		DE,LBUF
;@		LD		A,(DE)
;@		CP		1BH
;@		JR		Z,STMW9			;SHIFT+BREAK�Ŕj���A�I��
;@		LD		DE,LBUF+3
;@		JR		STMW
;@STMW9:
;@		JP		MON

;**** MZ-700 PATCH START ****
STMZ:
		DI
		LD		HL,0000H		;ROM��2000H�ɃR�s�[
		LD		DE,2000H
		LD		BC,1000H
		LDIR
		OUT		(0E0H),A		;��RAM ON
		LD		HL,2000H		;��RAM��ROM�̓��e���R�s�[
		LD		DE,0000H
		LD		BC,1000H
		LDIR
		LD		HL,STMZ2		;���������A�h���X
		LD		DE,STMZ3		;���������f�[�^
		LD		B,0FH
STMZ1:
		PUSH		BC
		LD		C,(HL)
		INC		HL
		LD		B,(HL)
		LD		A,(DE)
		LD		(BC),A
		POP		BC
		INC		DE
		INC		HL
		DJNZ		STMZ1
		LD		HL,00ADH
		LD		A,(HL)
		CP		0CDH
		JP		NZ,0000H		;MZ-700�Ɣ��f�ł��Ȃ����0000H����X�^�[�g
		LD		DE,MSG_ST
		CALL		MSGPR
		CALL		LETLN
		JP		MONITOR_700		;MZ-700�Ɣ��f�ł����00ADH����X�^�[�g

STMZ2:
		DW		0437H,0438H,0439H
		DW		0476H,0477H,0478H
		DW		04D9H,04DAH,04DBH
		DW		04F9H,04FAH,04FBH
		DW		0589H,058AH,058BH

STMZ3:
		DB		0C3H
		DW		ENT1
		DB		0C3H
		DW		ENT2
		DB		0C3H
		DW		ENT3
		DB		0C3H
		DW		ENT4
		DB		0C3H
		DW		ENT5

;**** MZ-700 ��RAM START ****
STURA:
		OUT		(0E0H),A		;��RAM ON
		LD		HL,00ADH
		LD		A,(HL)
		CP		0CDH
		JP		NZ,0000H		;0CDH�łȂ����NZ-700�ȂǂƔ��f����0000H����X�^�[�g
		LD		DE,MSG_ST
		CALL		MSGPR
		CALL		LETLN
		JP		MONITOR_700		;(00ADH)��0CDH�Ȃ�1Z-009A����1Z-009B�̃p�b�`�ς�MONITOR�Ɣ��f����00ADH����X�^�[�g

;**** [kaokun] �e�[�v Load/Save/Verify ****
IS_SA1510:
		LD		A,(010DH)		;010DH��'A'�Ȃ�MZ-80A ("SA-1510"��"A")
		CP		'A'
		RET
TPMSHED:
	;JUMP���Ă�����Ƀ��^�[��
		PUSH		DE			;PUSH���߂��Ԃ���JUMP���Ă��Ă���̂ő����PUSH�͂��Ă���
		PUSH		BC
		PUSH		HL
;;		CALL		IS_SA1510
;;		JP		Z,043AH
		JP		043AH
TPMSDAT:
		PUSH		DE
		PUSH		BC
		PUSH		HL
		CALL		IS_SA1510
		JP		Z,0474H
		JP		0479H
TPMLHED:
		PUSH		DE
		PUSH		BC
		PUSH		HL
		CALL		IS_SA1510
		JP		Z,04D3H
		JP		04DCH
TPMLDAT:
		PUSH		DE
		PUSH		BC
		PUSH		HL
		CALL		IS_SA1510
		JP		Z,04F3H
		JP 		04FCH
TPMVRFY:
		PUSH		DE
		PUSH		BC
		PUSH		HL
		CALL		IS_SA1510
		JP		Z,0579H
		JP		058CH

; �t�@�C�����\������
; FOUND FILENAME �̂悤�ȑO�̃��b�Z�[�W��DE�Ŏw��
TPDISP_FN:
		CALL		LETLN
		CALL		MSGPR
; �t�@�C�����\���̂�
TPDISP_FNONLY:
		LD		A,0DH			;�O�̂���
		LD		(FNAME+16),A
		LD		DE,FNAME
		CALL		PLIST
		CALL		LETLN
		RET


;**** �e�[�v�w�b�_�����[�h���ĕ\�� ****
TPRDINF:
		CALL		TPMLHED
		JR		NC,TPRDINF2
		CP		02H			;01=Check SUM Error, 02=BREAK
		JR		Z,TPRDINF1		;�u���[�N
		CALL		LETLN
		LD		DE,TMSG_CSUM		;"CHECKSUM ERR"
		CALL		MSGPR
		LD		A,01H			;01=Check SUM Error, 02=BREAK
TPRDINF1:
		SCF
		RET
TPRDINF2:
		LD		DE,TMSG_FOUND		;FOUND �t�@�C����
		CALL		TPDISP_FN
	; -> tt ssss eeee xxxx
		CALL		TPDISPHEAD2
		XOR		A
		RET

;**** �e�[�v�̃w�b�_���\�� ****
; ffff tttt xxxx
TPDISPHEAD:
		LD		HL,(SADRS)
		PUSH		HL
;=====================================================================================
		JR		SKIP_002
;	�݊����m�ۂ̂��߂̃G���g��
;	MONITOR ���[�h �C���t�H���[�V������֏�������Arduino��HEADER LOAD�R�}���h93H�𑗐M���镔��(MLH_CONT)
L_PRE_F85B:	DS		0F85BH - L_PRE_F85B
;		ORG		0F85BH
		JP		MLH_CONT		; 
SKIP_002:
;=====================================================================================
		CALL		PRTWRD
		CALL		PRNTS
		LD		HL,(FSIZE)
		POP		DE
		ADD		HL,DE			; EADRS=SADRS+FSIZE-1
		DEC		HL
		CALL		PRTWRD
		CALL		PRNTS
		LD		(HL),0
		LD		HL,(EXEAD)
		CALL		PRTWRD
		RET

; **** �^�C�v�A�A�h���X���܂ߕ\��  ****
; -> tt ssss eeee xxxx
TPDISPHEAD2:
		LD		DE,TMSG_ARROW		; -> 
		CALL		MSGPR
		LD		A,(IBUFE)
		CALL		PRTBYT			;tt
		CALL		PRNTS			;' '
		CALL		TPDISPHEAD		;ssss eeee xxxx
		RET

; **** DOS�t�@�C�����̕\��  ****
TPDISPDOSFN:
		LD		DE,TMSG_ARROW
		CALL		MSGPR
		LD		DE,LBUF+6
		CALL		PLIST
		LD		DE,TMSG_MZT
		CALL		MSGPR
		CALL		LETLN
		RET


; SD�Z�[�u�p�̃R�}���h�������\��
; *FDS#tt ssss eeee xxxx FILENAME
TPDISPFDSCMD:
		CALL		LETLN
		LD		DE,TMSG_FDS		;*FDS#
TPDISPFDTSCMD:
		CALL		MSGPR
		LD		A,(IBUFE)
		CALL		PRTBYT			;tt
		CALL		PRNTS
		CALL		TPDISPHEAD
		CALL		PRNTS
		JP		TPDISP_FNONLY		;�o�C�g���ߖ�B�t�@�C�����\�����ʂ�

;**** (DE)�Ŏ������t�@�C�����擪�Ȃǂ̃X�y�[�X���X�L�b�v����܂�DE���W�X�^��i�߂� ****
TPSKIPSPC:						;SKIP SPACES
		LD		A,(DE)
		CP		20H
		RET		NZ
		INC		DE
		DJNZ		TPSKIPSPC
		RET

;**** (HL)�Ŏ������Ƃ��납��X�y�[�X���X�L�b�v����܂�HL���W�X�^��i�߂� ****
TPSKIPSPC2:
		LD		A,(HL)
		CP		20H
		RET		NZ
		INC		HL
		JR		TPSKIPSPC2


;**** FNAME��MZ�t�@�C������DOS�t�@�C�����ɕϊ�����LBUF+6?�֊i�[ ****
; ?����������ő�2�o�C�g�ɕϊ�
; ���W�X�^�ۑ����Ȃ�
; IN:
;	FNAME:	�v���O������ (�ő�16����+CR)
; OUT:
;       (DE-1): 00H�ƂȂ�
;	(DE)?: DOS�t�@�C���� (�ő�32����+CR)
; WORK:
;	LBUF+0:	NONAME�̎��̃t�@�C���ԍ�
;	LBUF+1:	���[�h�A�h���X�Ҕ�
;	LBUF+2:	���[�h�A�h���X�Ҕ�
;	LBUF+3:	�q�����A�Ńt���O	= (IX)
;	LBUF+4:	�c�蕶����		= (IX+1)
;	LBUF+5:	00
;	DE?�ϊ���t�@�C����
TPMKDOSFNAME:
		PUSH		DE
		POP		HL
;�o�͐�33�o�C�g��0DH�Ŗ��߂�B
		LD		B,32+1
TPMKDOSFN_INIT:
		LD		(HL),0DH
		INC		HL
		DJNZ		TPMKDOSFN_INIT
;		CALL		TRIM_AFTER_FNAME	;�ϊ������Trim
;�ϊ����C��
		PUSH		DE
		LD		HL,FNAME		;HL=�ϊ����|�C���^
		CALL		TPSKIPSPC2		;�OTrim2024. 3.24
		LD		IX,LBUF+3		;(IX):�q�����A�Ńt���O,(IX+1):�c�蕶����
		XOR		A
		LD		(IX),A			;�q�����A�Ńt���O�N���A
		LD		(IX+1),16		;�ő�16���� (�ϊ����32�����Ȃ̂�1����������2�o�C�g�ɕϊ����Ă�OK)
		DEC		DE
		LD		(DE),A			;�ϊ����1�o�C�g�O����̒l��NON-ASCII�ŕۏ؂���
		INC		DE			;DE=�ϊ���|�C���^
TPMKDOSFNLOOP:
		LD		A,(HL)
		INC		HL			;HL=���̕���
TPMKDOSFN01:
		CP		0DH
		JP		Z,TPMKDOSFNEND

TPMKDOSFN02:
; A���t�@�C�����ɋ�����邩�`�F�b�N
; 20H?5DH, ������ *?<>:\/ ������
; 05H������
		CP		'*'
TPMKDOSFN03:
		JP		Z,TPMKDOSFNCTRL
		CP		'?'
		JR		Z,TPMKDOSFN03		;�o�C�g���ߖ�
		CP		'<'
		JR		NZ,TPMKDOSFN10
		LD		A,'['
TPMKDOSFN05:
		JP		TPMKDOSFNNEXT
TPMKDOSFN10:
		CP		'>'
		JR		NZ,TPMKDOSFN20
		LD		A,']'
		JR		TPMKDOSFN05		;�o�C�g���ߖ�
TPMKDOSFN20:
		CP		':'
TPMKDOSFN22	JP		Z,TPMKDOSFNCTRL
		CP		5CH			;\
		JR		Z,TPMKDOSFN22		;�o�C�g���ߖ�
		CP		'/'
		JR		Z,TPMKDOSFN22		;�o�C�g���ߖ�
		CP		05H			;�啶��/�������ؑւ͑f�ʂ� 2024. 3.13
		JR		Z,TPMKDOSFN05		;�o�C�g���ߖ�
;20-5D?
		CP		20H
		JP		C,TPMKDOSFNCTRL
		CP		5EH
		JR		C,TPMKDOSFN05		;�o�C�g���ߖ�

;==== [ A,(HL)�̃t�@�C���������̃}�b�v ====
TPMKDOSFNMAP:
		PUSH		DE
		POP		IY			;�ϊ���̑O���������
		CP		81H
		JP		C,TPMKDOSFNEMOJI	;?$80:�}�b�v�ΏۊO
;81-BF = �J�i===
TPMKDOSFNMAPKANA:
				;81-85H: �B�u�v�A�E
		CP		86H
		JR		NC,TPMKDOSFN30
		SUB		81H
		PUSH		HL
		LD		HL,TPNMAP8185
		JP		TPMKDOSFNNEXT_1_1	;HL��1�o�C�g�e�[�u��������1�o�C�g�X�g�A+POP HL

TPMKDOSFN30:
		JR		NZ,TPMKDOSFN40
				;86H:"��"
		PUSH		HL
		LD		HL,"WO"
		JP		TPMKDOSFNNEXT_HL_2	;HL��2�o�C�g���X�g�A

; (IY-1)(IY-2)��DE�ɓ��������`�F�b�N
TPMKDOSFN_CHK_B2:
		LD		B,A
		LD		A,(IY-2)
		CP		D
		JR		NZ,TPMKDOSFN_CHK_B2_E
		LD		A,(IY-1)
		CP		E
TPMKDOSFN_CHK_B2_E:
		LD		A,B
		RET

TPMKDOSFN40:
				;87-8BH: �@�B�D�F�H
		CP		8CH
		JR		NC,TPMKDOSFN50
		SUB		87H
		LD		C,A			;C:=0:�@, 1:�B, 2:�D, 3:�F, 4:�H
; ->�O��TI���F�Ȃ�CHE
		CP		3
		JR		NZ,TPMKDOSFN42
		PUSH		DE
		LD		DE,"TI"
		CALL		TPMKDOSFN_CHK_B2
		POP		DE
		JR		NZ,TPMKDOSFN42
		LD		(IY-2),"C"
		LD		(IY-1),"H"
		JR		TPMKDOSFN46

; ->�O��HU�������Ȃ�HU�������FA/FI/FU/FU/FE/FO : �t�@?�t�H
TPMKDOSFN42:
		PUSH		DE
		LD		DE,"HU"
		CALL		TPMKDOSFN_CHK_B2
		POP		DE
		JR		Z,TPMKDOSFN44
				;LA-LO
		LD		A,"L"
		LD		(DE),A
		INC		DE
		JR		TPMKDOSFN46
TPMKDOSFN44:
;�t�@?�t�H
		LD		A,"F"
		LD		(IY-2),A
		DEC		DE
TPMKDOSFN46:
		LD		A,C
		JP		TPMKDOSFNNEXT_AIUEO	;A�ɏ]����AIUEO�̃X�g�A

TPMKDOSFN50:
;8C-8E: ������
		CP		8FH
		JR		NC,TPMKDOSFN60
		SUB		8CH			;��x2���邱�Ƃ�AIUEO�̃e�[�u�����p�ł���
		ADD		A,A			;0:��, 2:��, 4:�� => 0:A, 2:U, 4:O
		LD		C,A
	; �O��TI�Ȃ�TI�������CHA/CHU/CHO�Ƃ���
	; �O��I�Ȃ�I�������YA/YU/YO�Ƃ���
	; �����łȂ��Ƃ��A'LYA'��3�o�C�g�ɂȂ�̂ł��Ȃ��B�����'YA'�ɂ���̂őO�����Ȃ�����
		LD		A,(IY-1)
		CP		'I'
		JR		NZ,TPMKDOSFN55
		DEC		DE			;�O�����
		LD		A,(IY-2)
		CP		'T'
		JR		NZ,TPMKDOSFN55
		LD		A,'C'
		LD		(IY-2),A
		LD		A,'H'
		JR		TPMKDOSFN57
TPMKDOSFN55:
		LD		A,'Y'
TPMKDOSFN57:
		LD		(DE),A
		INC		DE
		LD		A,C
		JP		TPMKDOSFNNEXT_AIUEO	;A�ɏ]����AIUEO�̃X�g�A

TPMKDOSFN60:
				;8FH: �b
		JR		NZ,TPMKDOSFN70
	;�ϊ��̎����A�C�E�G�I(91H-95H)�ȊO�̃J�i�Ȃ炻�̕����𔽕� = �q���A�Ńt���O���Ă邾��
	;->86-8F,96-BD�͈̔͂Ȃ�q���A�Ńt���O���Ă�
		LD		A,(IX+1)		;�c�蕶����
		CP		2
		JR		C,TPMKDOSFN63		;�����Ȃ�(�������܂ߎc��2��������)
		LD		A,(HL)
		CP		86H
		JR		C,TPMKDOSFN63		;���͎q���łȂ�
		CP		90H
		JR		C,TPMKDOSFN66		;���͎q���Ȃ̂Ńt���O�Z�b�g�̂�
		CP		96H
		JR		C,TPMKDOSFN63		;���͎q���łȂ�
		CP		0BEH
		JR		C,TPMKDOSFN66		;���͎q���Ȃ̂Ńt���O�Z�b�g�̂�
TPMKDOSFN63:
	;�����łȂ����"TU"�Ƃ���B
		PUSH		HL
		LD		HL,"TU"
		JP		TPMKDOSFNNEXT_HL_2	;HL��2�o�C�g���X�g�A
TPMKDOSFN66:
		LD		(IX),1			;�q���A�Ńt���O�Z�b�g
		JP		TPMKDOSFNNEXT_NOP	;�����������̕�����

TPMKDOSFN70:
;90H:����
		CP		90H
		JR		NZ,TPMKDOSFN80
		LD		A,'-'
		JP		TPMKDOSFNNEXT		;A���X�g�A���Ď���

TPMKDOSFN80:
;91-95: �A�C�E�G�I
		CP		96H
		JR		NC,TPMKDOSFN90
		SUB		91H
		LD		C,A
		CP		2			;���̑Ή�
		JR		NZ,TPMKDOSFN83
		CALL		TP_IS_DAKUTEN
		JR		NZ,TPMKDOSFN83
		LD		A,'V'
		CALL		TPMKDOSFN_SCONS		;�q���A�Ńt���O�����Ȃ���q���̃X�g�A(Store Consonant)+INC DE
		INC		HL			;1��������
		DEC		(IX+1)
TPMKDOSFN83:
		LD		A,C
		JP		TPMKDOSFNNEXT_AIUEO	;A�ɏ]����AIUEO�̃X�g�A

TPMKDOSFN90:
				;96-FF
				;�����_���͐�ɕ���
		CP		0BDH
		JR		Z,TPMKDOSFN_NN		;��
		CP		0BEH
		JR		Z,TPMKDOSFN_DAKU	;�J�P��
		CP		0BFH
		JR		Z,TPMKDOSFN_HDAKU	;�K�P��
		CP		0FFH
		JR		Z,TPMKDOSFN_PI		;��

				;96-B3: �J�s?�}�s
				;B7-BC: ���s�A��
				;���ʏ���
		CP		0BDH
		JR		NC,TPMKDOSFNEMOJI	;BD-FF�}�b�v�ΏۊO

		CP		0B4H			;96-B3
		JR		C,TPMKDOSFN100
		CP		0B7H			;B4-B6
		JR		C,TPMKDOSFN_YAYUYO	;������
		SUB		3			;�������������̓������̂Ԃ�l�߂�
TPMKDOSFN100:
;5�Ŋ����Ďq���ƕꉹ�̌����A���_�A�����_����
		SUB		96H
;==== (DE++) = TPMAPTBL_K2R[A/5]; A = TPMAPTBL_AIUEO[A%5]
TPNMAP2:
	; A/5 : �x���Ă��ǂ��̂�5������������
		LD		C,0FFH			; -1
		LD		B,5
TNMAP2_10:
		INC		C			; ����+1
		SUB		B
		JR		NC,TNMAP2_10		; ������΂���1��
		ADD		A,B			; �]���߂�
	; ������ A:�]��, C:��
		LD		B,0
		PUSH		DE
		PUSH		HL
		LD		HL,TPMAPTBL_K2R
		ADD		HL,BC
		LD		D,(HL)			;D=(HL + A/5)�@�q��
		LD		E,A			;E=�]��
		POP		HL
		LD		A,D			;A=�q����
		CALL		TP_IS_DAKUTEN		;���͑��_?
		JR		C,TNMAP2_20
		JR		Z,TNMAP2_30:
		JR		TNMAP2_50
TNMAP2_20:
				;�����_
		CP		'H'			;�����_��H�̎��̂�
		JR		NZ,TNMAP2_60		;�����_�s��
		LD		A,'P'
		JR		TNMAP2_40
TNMAP2_30:
	;���_
	;����0-2,4�̎��̂�
		LD		A,C
		CP		3
		JR		Z,TNMAP2_50		;���_�s��
		CP		5
		JR		NC,TNMAP2_50		;���_�s��
		PUSH		HL
		LD		HL,TPMAPTBL_GZDB	; �K�U�_�o�s
		CALL		TPNMAP1
		POP		HL
TNMAP2_40:
		INC		HL			;(��)���_�X�L�b�v
		DEC		(IX+1)			;�c�蕶��������
		JR		TNMAP2_60
TNMAP2_50:
		LD		A,D			;A=�q����

TNMAP2_60:
	;�q���A�Ńt���O�����Ȃ���q���̃X�g�A
		LD		C,E			;C=�]��
		POP		DE
		CALL		TPMKDOSFN_SCONS
		LD		A,C			;�]��
		JR		TPMKDOSFNNEXT_AIUEO	;A�ɏ]����AIUEO�̃X�g�A

TPMKDOSFN_YAYUYO:
;B4-B6: ������
		SUB		0B4H
		ADD		A,A
		LD		B,A			;�ꉹ�̕ۑ�
		LD		A,"Y"
		CALL		TPMKDOSFN_SCONS		;�q��
		LD		A,B
		JR		TPMKDOSFNNEXT_AIUEO	;A�ɏ]����AIUEO�̃X�g�A

TPMKDOSFN_NN:
;��=NN
		LD		A,'N'
		CALL		TPMKDOSFN_SCONS		;�q��
		JR		TPMKDOSFNNEXT

TPMKDOSFN_DAKU:
;�J�P��
		LD		A,'"'
		JR		TPMKDOSFNNEXT
TPMKDOSFN_HDAKU:
;�K�P��
		LD		A,'.'
		JR		TPMKDOSFNNEXT
TPMKDOSFN_PI:
; ��
		PUSH		HL
		LD		HL,"PI"
		JR		TPMKDOSFNNEXT_HL_2	;HL��2�o�C�g���X�g�A

TPMKDOSFNEMOJI:
		LD		A,'@'
		JR		TPMKDOSFNNEXT
TPMKDOSFNCTRL:
		LD		A,'='
		JR		TPMKDOSFNNEXT
;==== ] A,(HL)�̃t�@�C���������̃}�b�v�����܂� ====

;���ʕ�
;HL��1�o�C�g�e�[�u��������1�o�C�g�X�g�A+POP HL
TPMKDOSFNNEXT_1_1:
	;1�o�C�g�e�[�u��������1�o�C�g�X�g�A
		CALL		TPNMAP1			; �e�[�u���ŕϊ�

TPMKDOSFNNEXT_HL_2_0:
		POP		HL
		JR		TPMKDOSFNNEXT

TPMKDOSFNNEXT_HL_2:
	;HL��2�o�C�g���X�g�A
		LD		A,H
		CALL		TPMKDOSFN_SCONS		;�q��
		LD		A,L
		JR		TPMKDOSFNNEXT_HL_2_0

TPMKDOSFNNEXT_AIUEO:
	;A�ɏ]����AIUEO�̃X�g�A
		PUSH		HL
		LD		HL,TPMAPTBL_AIUEO
		CALL		TPNMAP1
		JR		TPMKDOSFNNEXT_HL_2_0

;A�̓��e��DOS FILENAME�ɃX�g�A���Ď���
TPMKDOSFNNEXT:
		LD		C,A
		LD		A,(IX+1)		; �c��
		OR		A
		LD		A,C
		JR		Z,TPMKDOSFNEND		; ���Ɏc��0�̏ꍇ�ȉ��͂��Ȃ�
		LD		(DE),A
		INC		DE
TPMKDOSFNNEXT_NOP:
		DEC		(IX+1)
		JP		NZ,TPMKDOSFNLOOP

TPMKDOSFNEND:
		LD		A,0DH
		LD		(DE),A
; ���O��������
		POP		DE
		LD		A,(DE)
		CP		0DH
		RET		NZ
; "NO NAME"
		LD		HL,TPNONAME
		LD		DE,LBUF+6
		LD		BC,TPNONAME1-TPNONAME
		LDIR
		LD		A,0DH
		LD		(DE),A
		RET


;=== (DE)?��A��16�i2���ŃX�g�A, DE�͎��� ===
TPSTOREHEX:
		PUSH		AF
		SRL		A
		SRL		A
		SRL		A
		SRL		A
		ADD		A,30H
		CP		3AH
		JR		C,TPSTOREHEX10
		ADD		A,7
TPSTOREHEX10:
		LD		(DE),A
		INC		DE
		POP		AF
		AND		0FH
		ADD		A,30H
		CP		3AH
		JR		C,TPSTOREHEX20
		ADD		A,7
TPSTOREHEX20:
		LD		(DE),A
		INC		DE
		RET
;
;==== A = (HL + A)
TPNMAP1:
		ADD		A,L
		LD		L,A
		LD		A,H
		ADC		A,0
		LD		H,A
		LD		A,(HL)
		RET

;==== �q���A�Ńt���O�����Ȃ���q���̃X�g�A(Store Consonant)+INC DE
TPMKDOSFN_SCONS:
		PUSH		BC
		LD		B,A
		LD		A,(IX)
		OR		A			;ZF=�q���A�Ńt���O
		LD		A,B
		LD		(DE),A			;�q���X�g�A
		LD		(IX),0			;�A�Ńt���O�N���A
		JR		Z,TPMKDOSFN_SCONS10
		INC		DE			;�A��
		LD		(DE),A
TPMKDOSFN_SCONS10:
		INC		DE
		POP		BC
		RET

;==== (HL)�̎w�����������_�������_�����ׂ�
;Z=0,C=0:�ǂ���ł��Ȃ�
;Z=1,C=0:���_
;Z=0,C=1:�����_
TP_IS_DAKUTEN:
		PUSH		BC
		LD		C,A
		LD		A,(HL)
		CP		0BEH
		JR		Z,TP_IS_DAKUTEN20	; Z=1,C=0
		CP		0BFH
		LD		A,1
		JR		Z,TP_IS_DAKUTEN10
		OR		A			; Z=0,C=0
		JR		TP_IS_DAKUTEN20
TP_IS_DAKUTEN10:
		OR		A
		SCF			; Z=0,C=1
TP_IS_DAKUTEN20:
		LD		A,C
		POP		BC
		RET

;�J�i�����ϊ��˃t�@�C�����������e�[�u��
TPMAPTBL_AIUEO:
		DB		"AIUEO"			;�A�C�E�G�I
TPMAPTBL_K2R:
		DB		"KSTNHMRW"		;�J�T�^�i�n�}�����s
TPMAPTBL_GZDB:
		DB		"GZDNB"			; �K�U�_�o�s
TPNMAP8185:
		DB		".[],-"			;�B�u�v�A�E

;**** [kaokun] �e�[�v�p MESSAGE DATA ********************
TMSG_FOUND:
		DB		'FOUND '
		DB		0DH
;TMSG_LOADING:						;SD�p���p
;		DB		'LOADING '
;		DB		0DH
TMSG_VERFYING:
		DB		'VERIFYING '
		DB		0DH
TMSG_CSUM:
		DB		'CHECKSUM ERROR'
		DB		0DH
TMSG_DATAERROR:
		DB		"DATA ERROR"
		DB		0DH
TMSG_OK:
		DB		'OK'
		DB		0DH
TMSG_FDS:
		DB		'*FDS#'
		DB		0DH
TMSG_FDTS:
		DB		'*FDTS#'
		DB		0DH
TMSG_ARROW:
		DB		' -> '
		DB		0DH

TMSG_MZT:
		DB		'.MZT'
		DB		0DH

TPNONAME	DB		'NO NAME'
TPNONAME1:

TPSDEMO:
		DB		'-DM',0DH
TPSDEMO1:

;**** 1BYTE��M ****
;��MDATA��A���W�X�^�ɃZ�b�g���ă��^�[��
RCVBYTE:
		CALL		F1CHK			;PORTC BIT7��1�ɂȂ�܂�LOOP
		IN		A,(0D9H)		;PORTB -> A
		PUSH 		AF
		LD		A,05H
		OUT		(0DBH),A		;PORTC BIT2 <- 1
		CALL		F2CHK			;PORTC BIT7��0�ɂȂ�܂�LOOP
		LD		A,04H
		OUT		(0DBH),A		;PORTC BIT2 <- 0
		POP 		AF
		RET

;**** 1BYTE���M ****
;A���W�X�^�̓��e��PORTA����4BIT��4BIT�����M
SNDBYTE:
		PUSH		AF
		RRA
		RRA
		RRA
		RRA
		AND		0FH
		CALL		SND4BIT
		POP		AF
		AND		0FH
		CALL		SND4BIT
		RET

;**** 4BIT���M ****
;A���W�X�^����4�r�b�g�𑗐M����
SND4BIT:
		OUT		(0D8H),A
		LD		A,05H
		OUT		(0DBH),A		;PORTC BIT2 <- 1
		CALL		F1CHK			;PORTC BIT7��1�ɂȂ�܂�LOOP
		LD		A,04H
		OUT		(0DBH),A		;PORTC BIT2 <- 0
		CALL		F2CHK
		RET

;**** BUSY��CHECK(1) ****
; 82H BIT7��1�ɂȂ�܂�LOP
F1CHK:
		IN		A,(0DAH)
		AND		80H			;PORTC BIT7 = 1?
		JR		Z,F1CHK
		RET

;**** BUSY��CHECK(0) ****
; 82H BIT7��0�ɂȂ�܂�LOOP
F2CHK:
		IN		A,(0DAH)
		AND		80H			;PORTC BIT7 = 0?
		JR		NZ,F2CHK
		RET

;****** FILE NAME �擾 (IN:DE �R�}���h�����̎��̕��� OUT:HL �t�@�C���l�[���̐擪)*********
STFN:
		PUSH	AF
STFN1:
		INC		DE			;�t�@�C���l�[���܂ŃX�y�[�X�ǂݔ�΂�
		LD		A,(DE)
		CP		20H
		JR		Z,STFN1
		CP		05H			; 05H�͋���
		JR		Z,STFN2
;		CP		30H			;�u0�v�ȏ�̕����łȂ���΃G���[�Ƃ���
		CP		21H			;[kaokun] ! �ȍ~��
		JP		C,STSV2
STFN2:
		EX		DE,HL
		POP		AF
		RET

;**** �R�}���h���M (IN:A �R�}���h�R�[�h)****
STCD:
		CALL		SNDBYTE			;A���W�X�^�̃R�}���h�R�[�h�𑗐M
		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		OR		A			;NO ERROR�Ȃ�ZF
		RET

;**** �t�@�C���l�[�����M(IN:HL �t�@�C���l�[���̐擪) ******
STFS:
		LD		B,32
STFS1:
		LD		A,(HL)			;FNAME���M
		CALL		SNDBYTE
		INC		HL
		DJNZ		STFS1
		LD		A,0DH
		CALL		SNDBYTE
		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		RET

;**** �R�}���h�A�t�@�C�������M (IN:A �R�}���h�R�[�h DE+1:�t�@�C���l�[���̐擪)****
STCMD:
		CALL		STFN			;�t�@�C���l�[���擾
STCMD2:
		PUSH		HL
		CALL		STCD			;00�ȊO(ZF�������Ă��Ȃ�)�Ȃ�ERROR
		POP		HL
		JP		NZ,SVER0
		CALL		STFS			;�t�@�C���l�[�����M
		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,SVER0
		RET

;******** MESSAGE DATA ********************
MSG_LD:
		DB		16H
TMSG_LOADING:
		DB		'LOADING '
		DB		0DH

WRMSG:
		DB		'WRITING '
		DB		0DH

MSG_SV:
		DB		'SAVE OK!'
		DB		0DH

MSG_AS:
		DB		'ASTART OK!'
		DB		0DH

MSG_ST:
		DB		'PATCHED MON START!'
		DB		0DH

MSG_AD:
		DB		'ADDRESS ERROR!'
		DB		0DH

MSG_FNAME:
		DB		'FILE NAME ERROR!'
		DB		0DH

MSG_CMD:
		DB		'COMMAND ERROR!'
		DB		0DH

MSG_F0:
		DB		'SD-CARD INITIALIZE ERROR'
		DB		0DH

MSG_F1:
		DB		'FILE NOT FOUND'
		DB		0DH

;MSG_F2:
;		DB		'NOT OBJECT FILE'
;		DB		0DH

MSG_F3:
		DB		'FILE EXISTS'
		DB		0DH

MSG_KEY1:
		DB		'NEXT:ANY BACK:B BREAK:'
		DB		0DH
MSG_KEY2:
		DB		' OR SHIFT+BREAK'
		DB		0DH

MSG_DELQ:
		DB		'DELETE? (Y:OK ELSE:CANCEL)'
		DB		0DH

MSG_DELY:
		DB		'DELETE OK'
		DB		0DH

MSG_DELN:
		DB		'DELETE CANCELED'
		DB		0DH

MSG_REN:
		DB		'NEW NAME:                            '
		DB		0DH

MSG_DNAME:;			 123456789
		DB		'DOS FILE:'				; 9����
MSG_DNAMEEND:;			 1234567890123456789012345678		; +28����=37�����o��
;;		DB		'                            '
		DB		0DH

MSG_RENY:
		DB		'RENAME OK'
		DB		0DH

MSG_AD1:
		DB		'ADRS +0 +1 +2 +3 +4 +5 +6 +7 01234567'
		DB		0DH

MSG_AD2:
		DB		'NEXT:ANY BACK:B BREAK:SHIFT+BREAK'
		DB		0DH

MSG_CPY:
		DB		'COPY OK'
		DB		0DH

MSG_FDW:
		DB		'*FDW '
		DB		0DH

MSG99:
		DB		' ERROR'
		DB		0DH

DEFNAME:
		DB		'0000'
		DB		0DH
NEND:

DEFDIR:
		DB		'*FD   '		;*FDCD���ƍ��킹�邽�ߋ󔒂�1�ǉ�
DEND:

STR_FDCD:	DB		'*FDCD '
STR_FDCD_END:

;
;�t�@�C�����̌��Trim
;S-OS SWORD�A8080�p�e�L�X�g�E�G�f�B�^?�A�Z���u���̓t�@�C���l�[���̌�낪20h�l�߂ƂȂ邽��0dh�ɏC��
;
TRIM_LBUF:
		PUSH		BC
		PUSH		HL
		LD		HL,LBUF+40
		LD		B,41
		JR		TRIM_AFTER_FNAME2

TRIM_AFTER_FNAME:
		PUSH		BC
		PUSH		HL
		LD		B,17
		LD		HL,FNAME+10H		;�t�@�C���l�[��
TRIM_AFTER_FNAME2:
		LD		C,0DH
		LD		(HL),C			;�X�g�b�p
TAF0:
		LD		A,(HL)
		CP		C			;0DH�ł���΂ЂƂO�̕����̌����Ɉڂ�
		JR		Z,TAF2
		CP		05H			;20H,05H,0DH�̃p�^�[���͖���
		JR		Z,TAF1
		CP		05H			;20H,05H,0DH�̃p�^�[���͖���
		JR		Z,TAF1
		CP		20H			;20H�ł����0DH���Z�b�g���ĂЂƂO�̕����̌����Ɉڂ�
		JR		NZ,TAF3			;05H, 0DH�A20H�ȊO�̕����ł���ΏI��
TAF1:
		LD		(HL),C
TAF2:
		DEC		HL
		DJNZ		TAF0
TAF3:
		POP		HL
		POP		BC
		RET

;*********************** 0436H MONITOR ���C�g �C���t�H���[�V������֏��� ************
MSHED:
		DI
		PUSH		DE
		PUSH		BC
		PUSH		HL
		CALL		INIT
		LD		A,91H			;HEADER SAVE�R�}���h91H
		CALL		MCMD			;�R�}���h�R�[�h���M
;;		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,MERR

		CALL		TRIM_AFTER_FNAME	;���Trim

	; WRITING �t�@�C����
		LD		DE,WRMSG		;'WRITING '
		CALL		TPDISP_FN

		LD		HL,IBUFE
		LD		B,128
MSH3:
		LD		A,(HL)			;�C���t�H���[�V���� �u���b�N���M
		CALL		SNDBYTE
		INC		HL
		DJNZ		MSH3

		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,MERR

		JP		MRET			;����RETURN

;******************** 0475H MONITOR ���C�g �f�[�^��֏��� **********************
MSDAT:
		DI
		PUSH		DE
		PUSH		BC
		PUSH		HL
		LD		A,92H			;DATA SAVE�R�}���h92H
		CALL		MCMD			;�R�}���h�R�[�h���M
;;		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,MERR

		LD		HL,FSIZE		;FSIZE���M
		LD		A,(HL)
		CALL		SNDBYTE
		INC		HL
		LD		A,(HL)
		CALL		SNDBYTE

		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,MERR

		LD		DE,(FSIZE)
		LD		HL,(SADRS)
MSD1:
		LD		A,(HL)
		CALL		SNDBYTE			;SADRS����FSIZE Byte�𑗐M�B�����Z�[�u�̏ꍇ�A���O��0436H��OPEN���ꂽ�t�@�C����ΏۂƂ���256�o�C�g����0475H��CALL�����B
		DEC		DE
		LD		A,D
		OR		E
		INC		HL
		JR		NZ,MSD1

		JP		MRET			;����RETURN


;**** �s�����ꂢ�ɂ��� ****
CLRLINE:
		PUSH		BC
		PUSH		DE
		LD		A,2			;2���ڂ�DELx2
		LD		(DSPX),A
		LD		B,A
CL10:
		LD		A,0C7H			;[DEL]
		CALL		DPCT
		DJNZ		CL10
;		XOR		A
;		LD		(DSPX),A
		LD		DE,MSG_38SPC		;37�X�y�[�X�o��
		CALL		MSGPR
		XOR		A
		LD		(DSPX),A
		POP		DE
		POP		BC
		RET
;				 00000000011111111112222222222333333333
;				 12345678901234567890123456789012345678
MSG_38SPC:	DB		'                                      ',0DH

;**** LBUF�����ꂢ�ɂ��� ****
;LBUF��0DH�Ŗ��߃t�@�C���l�[�����w�肳��Ȃ��������Ƃɂ���
CLRLBUF:
		PUSH		BC
		PUSH		HL

		LD		B,40
		LD		HL,LBUF
CLB10:
		LD		(HL),0DH
		INC		HL
		DJNZ		CLB10

		POP		HL
		POP		BC
		RET

;************************** 04D8H MONITOR ���[�h �C���t�H���[�V������֏��� *****************
MLHED:
		DI
		PUSH		DE
		PUSH		BC
		PUSH		HL
		CALL		INIT

;;		LD		A,00H
;;		LD		DE,0000H
;;		CALL		TIMST

; �A�����[�h���[�h�̎���UI���X�L�b�v
		LD		A,(CONTF)		;(CONTF)��
		CP		CONTF_ON		;':'�ł�
		JR		NZ,MLH0			;�Ȃ��Ȃ�UI����
		LD		A,0DH
		LD		DE,LBUF
		LD		(DE),A			;�t�@�C���������A�Ƃ���
		JR		MLH_CONT		;Arduino���烍�[�h
MLH0:
;;		CALL		CLRLINE			;�s�N���A�����̂�ROPOKO�ŃN���A�ł��Ȃ��̂ł�����������N���A
		PUSH		BC
		LD		A,39			;39���ڂ�DELx39
		LD		(DSPX),A
		LD		B,A
MLHCL:
		LD		A,0C7H			;[DEL]
		CALL		DPCT
		DJNZ		MLHCL
		POP		BC
		CALL		CLRLBUF
		LD		DE,MSG_DNAME		;'DOS FILE:'
		CALL		MSGPR
;;		LD		A,09H			;�J�[�\����9�����ڂɖ߂�
;;		LD		(DSPX),A

;;;;		LD		DE,MBUF			;�t�@�C���l�[�����w�����邽�߂̋���̍�BLOAD�R�}���h�Ƃ��Ă̓t�@�C���l�[���Ȃ��Ƃ��ĉ��s�����̂��ɍs�o�b�t�@�̈ʒu�����炵��DOS�t�@�C���l�[������͂���B
		LD		DE,LBUF
		CALL		GETL
		CALL		TRIM_LBUF
;;		LD		DE,MBUF+9
		LD		DE,LBUF+9

		LD		A,(DE)
;**** �t�@�C���l�[���̐擪��'*'�Ȃ�g���R�}���h�����ֈڍs ****
		CP		'*'
		JR		Z,MLHCMD
MLH_CONT:
		LD		A,93H			;HEADER LOAD�R�}���h93H
		CALL		MCMD			;�R�}���h�R�[�h���M
;;		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,MERR

MLH1:
		LD		A,(DE)
		CP		20H			;�s���̃X�y�[�X���t�@�C���l�[���܂œǂݔ�΂�
		JR		NZ,MLH2
		INC		DE
		JR		MLH1

MLH2:
		LD		B,20H
MLH4:
		LD		A,(DE)			;FNAME���M
		CALL		SNDBYTE
		INC		DE
		DJNZ		MLH4
		LD		A,0DH
		CALL		SNDBYTE
		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,MERR

		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,MERR

		LD		HL,IBUFE
		LD		B,80H
MLH5:
		CALL		RCVBYTE			;�ǂ݂����ꂽ�C���t�H���[�V�����u���b�N����M
		LD		(HL),A
		INC		HL
		DJNZ		MLH5

		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,MERR

		JP		MRET			;����RETURN

;**************************** �A�v���P�[�V������SD-CARD���쏈�� **********************
MLHCMD:
;**** HL�ADE�ABC���W�X�^��ۑ� ****
		PUSH		HL
		PUSH		DE
		PUSH		BC
		INC		DE			;'*'�̎�
;**** FDL�R�}���h ****
		LD		HL,CMD_FDL
		LD		B,3			;FDL��3����
		CALL		CMPSTR
		JR		Z,MLHFDLCMD
;**** FDCD�R�}���h ****
		LD		HL,CMD_FDCD
		LD		B,4			;FD[CM]D��4����
		CALL		CMPSTR
		LD		A,0A6H			;CHDIR�R�}���hA6H
		JR		Z,MLHFDCDMD
;**** FDMD�R�}���h ****
		LD		HL,CMD_FDMD
		CALL		CMPSTR
		LD		A,0A7H			;MKDIR�R�}���hA7H
		JR		Z,MLHFDCDMD
MLHCMD_R:
		POP		BC
		POP		DE
		POP		HL
;**** �t�@�C���l�[�����͂֕��A ****
		JP		MLH0

MLHFDLCMD:
				; �A�v���� FDL ����
		INC		DE			;'F'�̎�
		INC		DE			;'D'�̎�
		INC		DE			;'L'�̎�
		LD		HL,MSG_DNAME		;�s����'DOS FILE:'��t���邱�ƂŃJ�[�\�����ړ��������^�[���Ŏ��s�ł���悤��
		LD		BC,MSG_DNAMEEND-MSG_DNAME	;"DOS FILE:" �̕�����=9
;**** FDL�R�}���h�Ăяo�� ****
		CALL		DIRLIST
		AND		A			;00�ȊO�Ȃ�ERROR
		JR		NZ,SERR
		JR		MLHCMD_R

MLHFDCDMD:
				; �A�v���� FDCD/FDMD ����
		INC		DE			;'F'�̎�
		INC		DE			;'D'�̎�
		INC		DE			;'C'/'M'�̎�
		INC		DE			;'D'�̎�
		CALL		CHMKDIR			;00H����M�����CD/MD����
		JR		Z,MLHCMD_R		; �G���[�łȂ���΃A�v���������𑱂���
;;		JR		SERR

;******* �A�v���P�[�V������SD-CARD���쏈���pERROR���� **************
SERR:
		CP		0F0H
		JR		NZ,SERR3
		LD		DE,MSG_F0
		JR		SERRMSG

SERR3:
		CP		0F1H
		JR		NZ,SERR99
		LD		DE,MSG_F1
		JR		SERRMSG

SERR99:
		CALL		PRTBYT
		LD		DE,MSG99

SERRMSG:
		CALL		MSGPR
		CALL		LETLN
		POP		BC
		POP		DE
		POP		HL
;**** �t�@�C���l�[�����͂֕��A ****
		JP		MLH0

;**** �R�}���h�������r ****
CMPSTR:
		PUSH		BC
		PUSH		DE
CMP1:
		LD		A,(DE)
		CP		(HL)
		JR		NZ,CMP2
		DEC		B
		JR		Z,CMP2
		CP		0DH
		JR		Z,CMP2
		INC		DE
		INC		HL
		JR		CMP1
CMP2:
		POP		DE
		POP		BC
		RET

;**** �R�}���h���X�g ****
; �����g���p
CMD_FDL:
		DB		'FDL',0DH
CMD_FDCD:
		DB		'FDCD',0DH
CMD_FDMD:
		DB		'FDMD',0DH


;**************************** 04F8H MONITOR ���[�h �f�[�^��֏��� ********************
MLDAT:
		DI
		PUSH		DE
		PUSH		BC
		PUSH		HL
		LD		A,94H			;DATA LOAD�R�}���h94H
		CALL		MCMD			;�R�}���h�R�[�h���M
;;		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,MERR

		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,MERR

		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,MERR

		LD		DE,FSIZE		;FSIZE���M
		LD		A,(DE)
		CALL		SNDBYTE
		INC		DE
		LD		A,(DE)
		CALL		SNDBYTE
		CALL		DBRCV			;FSIZE���̃f�[�^����M���ASADRS����i�[�B�������[�h�̏ꍇ�A���O��0436H��OPEN���ꂽ�t�@�C����ΏۂƂ���256�o�C�g����SADRS�����Z�����04F8H��CALL�����B

		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		AND		A			;00�ȊO�Ȃ�ERROR
		JP		NZ,MERR

		JR		MRET			;����RETURN

;************************** 0588H VRFY CMT �x���t�@�C��֏��� *******************
MVRFY:
		DI
		XOR		A			;����I���t���O
;		EI

		RET

;******* ��֏����p�R�}���h�R�[�h���M (IN:A �R�}���h�R�[�h) **********
MCMD:
;		PUSH		AF
;		CALL		INIT
;		POP		AF
		CALL		SNDBYTE			;�R�}���h�R�[�h���M
		CALL		RCVBYTE			;��Ԏ擾(00H=OK)
		AND		A			;�o�C�g���ߖ�̂��߂����Ń[�����肵�Ă���
		RET

;****** ��֏����p����RETURN���� **********
MRET:
		POP		HL
		POP		BC
		POP		DE
		XOR		A			;����I���t���O
;		EI

		RET

;******* ��֏����pERROR���� **************
MERR:
		CP		0F0H
		JR		NZ,MERR3
		LD		DE,MSG_F0
		JR		MERRMSG
;��֏����ł̓t�@�C����ރR�[�h�̔��ʂȂ�
;MERR2:
;		CP		0F2H
;		JR		NZ,MERR3
;		LD		DE,MSG_F2
;		JR		MERRMSG

MERR3:
		CP		0F1H
		JR		NZ,MERR99
		LD		DE,MSG_F1
		JR		MERRMSG

MERR99:
		CALL		PRTBYT
		LD		DE,MSG99

MERRMSG:
		CALL		MSGPR
		CALL		LETLN
		XOR		A
		LD		(CONTF),A	; �A�����[�h���[�h�N���A
		POP		HL
		POP		BC
		POP		DE
		LD		A,02H
		SCF
;		EI

		RET

		END
