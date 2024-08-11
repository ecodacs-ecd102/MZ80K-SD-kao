;2021.12.12 MZ-700でFDP、FDMが文字化けする現象に対処
;2022. 1.23 04D8H MONITOR リード インフォメーション代替処理のバグを修正
;2022. 1.24 ファイルネームの後ろの20h詰めを0dhに修正するための処理をArduino側からMZ-80K側に修正
;2022. 1.25 0475H MONITOR ライト データ代替処理、04F8H MONITOR リード データ代替処理での8255初期化を廃止
;2022. 1.26 FDコマンドでロード可能なファイル種類コードは0x01のみとしていた制限を撤廃
;2022. 1.29 CMT代替処理RETURN時の割込み許可(EI)を削除
;2022. 1.31 FDコマンド実行後アプリ動作が固まってしまう機械、アプリへの対処
;2022. 1.31 FDLコマンド仕様変更 FDL xの場合、ファイル名先頭一文字を比較して一致したものだけを出力
;           Bキーで前の20件を表示
;2022. 2. 8 FDLコマンド仕様変更 FDL xの場合、ファイル名先頭1文字?32文字までに拡張
;2022. 2.10 04D8H MONITOR リード インフォメーション代替処理の中からFDLコマンドを使えるように修正
;           FDLコマンド処理をサブルーチン化
;2022. 2.11 04D8H MONITOR リード インフォメーション代替処理の中から呼ぶFDLコマンドがMZ-700 MONITOR 1Z-009A、1Z-009B環境下では使えないバグを修正しました。
;
;[kaokun]
;2023.12.22 以下の改造
;	    8-TABに整形
;           MZ-New Monitorに対応。
;
;           ファイルのロード時などにファイルのタイプ、アドレス情報を表示するようにした。
;
;           テープ関係コマンドの実装
;            *FDTB: テープ⇒SD連続バックアップ
;               *FDTB xx        xxはファイル名先頭のxx初期値(16進2桁)。省略時は01
;               DOSファイル名の生成ルールは
;               xxttDOS FILENAME
;                 xx:ファイル番号(初期値は↑で指定した物)
;                 tt:ファイルタイプ
;                 DOS FILENAMEはPNAMEから適当に変換される。28文字以上の部分は頭4桁と合わせて32文字を超えるのでカットされる
;                 $D000-から保存されているファイル(スクリーンデモ)のファイルの末尾は -DM となる。
;                 ファイル名無しの場合  NO NAME となる
;               メモ:
;               ・スクリーンデモのバックアップを作るため、内部では必ず$1200からロードされる。
;               ・無限ループするので終わりたい場合はSHIFT+BREAK等で止める必要がある
;
;            *FDTL: テープからロード。ロード終了後SDへ保存するコマンドを表示
;               *FDTL           最初に見つかったファイルのロードと実行
;               *FDTL FILENAME  指定ファイルのロードと実行
;               *FDTL/          最初に見つかったファイルをロードして実行しない
;               *FDTL/ FILENAME 指定ファイルをロードして実行しない
;
;            *FDTS: テープにセーブ
;               *FDTS ssss eeee xxxx FILENAME           type=01 固定
;               *FDTS#tt ssss eeee xxxx FILENAME        typeを16進2桁で指定可能
;
;            *FDTV:
;               *FDTV           最初に見つかったファイルのベリファイ
;               *FDTV FILENAME  指定ファイルのベリファイ
;
;           SDロード、セーブ時にファイルタイプを反映するようにした。(Arduino側も専用コマンドで対応しているので対応要)
;           *FDS: SDにセーブ
;               *FDTS ssss eeee xxxx DOS FILENAME       type=01 固定, ファイル名はDOSファイル名
;               *FDTS#tt ssss eeee xxxx PROGRAM NAME    typeを16進2桁で指定。ファイル名はMZファイル名。DOSファイル名は適当に生成される
;
;           *FD/: ロード終了後テープへ保存するコマンドを表示するようにした。
;
;           *FD>: ロード終了後テープへ保存する。
;               スクリーンデモのバックアップを作るため、内部では必ず$1200からロードされる。従って多くの場合ロード後の直接実行不可。
;
;           ROMを空けるため以下のコマンドを削除(MZ700やMZ-New Monitorを使う前提。コマンドがダブるため) 行頭 ";@" コメント
;             *FDM:MEMORY DUMP
;             *FDW:MEMORY WRITE
;           その他、バイト数節約のためメッセージ類、共通処理、DEC BでのループをDJNZ化など見直し
;
;           FDCD:CHDIR コマンド実装
;             *FDCD[CR]                                 何もせずカレントディレクトリを表示
;             *FDCD ディレクトリ[CR]                    指定したディレクトリへCHDIRしカレントディレクトリを表示
;
;           FDMD:MKDIR コマンド実装
;             *FDMD ディレクトリ[CR]                    指定ディレクトリを作る
;
;           アプリ内コマンドに *FDCD, *FDMD を追加。
;
;          FDL コマンドの出力を、ディレレクトリ("*FDCD ")と通常ファイル(*FD  /DOS FILE:*FDCD )で分けた。
;
;2024. 3.13 DOSファイル名作成時、ファイル名の前後にスペースがある場合に、DOS FILENAMEの前後からスペースを削除する
;           DOSファイル名作成時、文字コード05Hを大文字/小文字のトグルとするため素通しする。
;           (表示の都合で実際の小文字化はArduino側でやる)
;	    ?行クリアまわりの見直し
;
;2024. 6.23 1本のテープに複数ファイルが保存してあってチェーンロードしているタイプのゲームなどをSDの1つのディレクトリに入れた物に対応
;           "*FD:": カレントディレクトリのファイルを先頭から順にロードする。
;                 (ディレクトリから物理的に読んだ順にロードする)
;                 以下Z=Z80, A=Arduino側処理
;		  ・Z:最初に(CONTF)を':'にセット : CONTFは$1200の1バイト前を使う
;                 ・Z:Arduino側に':'というファイル名をロードするよう指示。":"はFATのファイル名としては使えないので連続ロードだと区別できる。
;                   A:":"というファイルが来たら、カレントディレクトリの最初のファイルをロード。skip=1とする。
;                 ・Z:このコマンド以降のRead INFはプロンプトを出さず、空ファイル名をロードするようArduino側に指示
;                 ・A:Arduino側は、空ファイル、かつ、skip!=0だったら、カレントディレクトリの最初から(skip++)個スキップしたファイルをREAD INFで返す
;                 ・A:空ファイルでない、またはLOADコマンドだったらskip=0に戻す
;           拡張子が*.mztのときは表示しないようにした。(長いファイル名の時に送りきれないため)
;2024. 7.22 *FDL: コマンドのフラグ初期化を厳密にした
;2024. 7.25 MZ-80AのSA-1510対応 (SA-1510だけROMパッチのアドレスが違うため)
;2024. 7.29 オリジナルのREADMEにある以下のエントリの動作を保証
;           0F082H: 8255 イニシャライズ
;           0F85BH: MONITOR リード インフォメーション代替処理内でArduinoにHEADER LOADコマンド93Hを送信する部分(MLH_CONT)
;2024. 8.07 ロードしたプログラム実行時の動作変更
;           - $1200未満のアドレスにはジャンプしない
;           - Musicのテンポ=4設定
;           - EIで飛び込む
;2024. 8.11 githubへアップロード


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
CONTF_ON	EQU		':'		; ':' なら連続ロード中を示す
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

; 0D8H PORTA 送信データ(下位4ビット)
; 0D9H PORTB 受信データ(8ビット)
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
; 0DBH コントロールレジスタ


		ORG		0F000H

		NOP					;ROM識別コード
		JP		START
;******************** MONITOR CMTルーチン代替 *************************************
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

; SA-1510用
		JP		MSHED		; $F013
		JP		MSDAT		; $F016
		JP		MLHED		; $F019
		JP		MLDAT		; $F01C
		JP		MVRFY		; $F01F

START:
		CALL		INIT
		LD		(CONTF),A		;A=0で帰ってくるのでついでにFD:コマンド用のフラグもクリア
		LD		DE,LBUF			;MZ-80K、MZ-700とも起動コマンドは'*FD'に統一
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

		INC		DE			;FDの次の文字へ移動
STT2:
		LD		A,(DE)
		CP		20H			;FDの後に1文字空白があれば以降をファイルネームとしてロード(ファイルネームは32文字まで)
		JP		Z,SDLOAD
		CP		'/'			;FDの後が'/'なら以降をファイルネームとしてロード、実行はしない(ファイルネームは32文字まで)
		JP		Z,SDLOAD
;[kaokun]
		CP		'>'			;FDの後が'>'なら以降をファイルネームとしてロード、テープへ保存
		JP		Z,SDLOAD
		CP		':'			;"FD:"
		JR		Z,SDLOAD_SEQ
;--
		CP		0DH			;FDだけで改行の場合にはDEFNAMEの文字列をファイルネームとしてロード
		JR		NZ,STETC		;該当なしなら他コマンドをチェック
;
STT3:
		PUSH		DE			;設定ファイル名(0000.mzt)を転送
		LD		HL,DEFNAME
		INC		DE
		LD		BC,NEND-DEFNAME
		LDIR
		POP		DE
		JP		SDLOAD			;LOAD処理へ
; "FD:"
SDLOAD_SEQ:
	; (DE) == ':' となっている。
		LD		(CONTF),A		;フラグセット(A=':'なのでNZ)
		PUSH		DE
		POP		HL
		INC		HL			;':'の次にCRをセット
		LD		(HL),0DH
		DEC		DE			;(DE+1)?:ファイル名=':',0DH となるようにする。
		JP		SDLOAD			;LOAD処理へ

STETC:
		CP		'S'			;FDS:SAVE処理へ
		JP		Z,STSV
		CP		'A'			;FDA:自動起動ファイル設定処理へ
		JP		Z,STAS
		CP		'L'			;FDL:ファイル一覧表示
;=====================================================================================
		JR		SKIP_001
;	互換性確保のためのエントリ
L_PRE_F082:	DS		0F082H - L_PRE_F082
;		ORG		0F082H
		JP		INIT			; 8255イニシャライズ
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
		LD		A,(DE)			;FDCの次の文字
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
		CP		'U'			;FDU:MZ-700 裏RAM START
		JP		Z,STURA
; kaokun [ -----------------------------------------------------------------------------
		CP		'T'			;FDTL/FDTS/FDTV/FDTB: Tape Load/Save/Verify/Backup Tape to SD
		JP		NZ,STTP99
; FDTx command
		INC		DE			;FDTの次の文字へ移動
		LD		A,(DE)
		CP		'L'			;FDTL:Tape LOAD
		JP		NZ,STTP2
		INC		DE
		LD		A,(DE)			;次の文字
		INC		DE			;DE=ファイル名先頭アドレス
		CP		20H			;FDTLの後に1文字空白があれば以降をファイルネームとしてロード(ファイルネームは16文字まで)
		JR		Z,TPLOAD
		CP		'/'			;FDTLの後が'/'なら以降をファイルネームとしてロード、実行はしない(ファイルネームは16文字まで)
		JR		Z,TPLOAD
		CP		0DH			;FDTLだけで改行の場合には最初のファイルをロード
		JP		NZ,CMDERR		;該当なし=コマンドエラー
		LD		(DE),A			;ファイル名を0Dでつぶす
;**** テープロード ****
TPLOAD:
		CALL		TPRDINF			;ヘッダをリードして表示
		JP		C,MON			;ブレーク/エラーならそのままコマンド待ちへ

		LD		DE,LBUF+6		;"*FDTL/"で6文字飛ばした位置がファイル名
		LD		B,16
		CALL		TPSKIPSPC		;SKIP SPACES
		LD		HL,FNAME
		LD		B,16			;最大16文字
;		LD		A,(DE)			;省略可
		CP		0DH
		JR		Z,TPLOAD2		;ファイル名無し
		CALL		CMPSTR			;比較
		JR		NZ,TPLOAD		;ファイル名不一致
;ロード中ファイル名表示
TPLOAD2:
				;LOADING ファイル名
		LD		DE,TMSG_LOADING
		CALL		TPDISP_FN
		CALL		TPMLDAT			;本体のロード
		JR		NC,TPLOAD3
		CP		02H			;01=Check SUM Error, 02=BREAK
		JP		Z,MON			;ブレーク
		LD		DE,TMSG_CSUM		;"CHECKSUM ERR"
		CALL		MSGPR
		JP		MON
TPLOAD3:
		CALL		LETLN
		LD		DE,TMSG_OK		;"OK"
		CALL		MSGPR

; SDセーブ用のコマンド文字列を表示
; *FDS#tt ssss eeee xxxx FILENAME
		CALL		TPDISPFDSCMD

		LD		A,(LBUF+5)		;"*FDTL/"の"/"
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
;**** テープベリファイ ****
TPVERFY:
		CALL		TPRDINF			;ヘッダをリードして表示
		JP		C,MON			;ブレーク/エラーならそのままコマンド待ちへ

		LD		DE,LBUF+6		;"*FDTV/"で6文字飛ばした位置がファイル名
		LD		B,16
		CALL		TPSKIPSPC		;SKIP SPACES
		LD		HL,FNAME
		LD		B,16			;最大16文字
;		LD		A,(DE)			;省略可
		CP		0DH
		JR		Z,TPVERFY2		;ファイル名無し
		CALL		CMPSTR			;比較
		JR		NZ,TPVERFY		;ファイル名不一致
;ベリファイ中ファイル名表示
TPVERFY2:
		LD		DE,TMSG_VERFYING	;VERIFYING ファイル名
		CALL		TPDISP_FN
		CALL		TPMVRFY
		JR		NC,TPVERFY3
		CP		02H			;01=Check SUM Error, 02=BREAK
		JP		Z,MON			;ブレーク
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
;**** テープセーブ ****
; *FDTS ssss eeee xxxx		; type=01 固定
; *FDTS#tt ssss eeee xxxx	; type指定可能
				; #tt のチェック
TPSAVE:
		INC		DE
		LD		A,(DE)
		CP		'#'
		LD		A,01H			;デフォルトタイプ
		JR		NZ,TSAVE_NOTYPE
		INC		DE
		PUSH		DE
		CALL		TWOHEX			;#tt でファイルタイプ指定
		JR		C,TPSAVE1
		POP		DE
		INC		DE			;ttのぶんスキップ
		INC		DE
TSAVE_NOTYPE:
		LD		(IBUFE),A		;ファイルタイプ保存

		INC 		DE
		PUSH		DE
		CALL		HLHEX			;1文字空けて4桁の16進数であればSADRSにセットして続行
		JR		C,TPSAVE1
		LD		(SADRS),HL		;SARDS保存
		POP		DE

		INC		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE
		PUSH		DE			;5文字進めて4桁の16進数であればFSIZEにセットして続行
		CALL		HLHEX
		JR		C,TPSAVE1
		LD		BC,(SADRS)
		SBC		HL,BC			;EADRSがSADRSより大きくない場合はエラー
		JR		Z,TPSAVE1
		JR		C,TPSAVE1
		INC		HL			;HL=EADRS-START+1 = FSIZE
		LD		(FSIZE),HL		;FSIZEセット

		POP		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE			;5文字進めて4桁の16進数であればEXEADにセットして続行
		PUSH		DE
		CALL		HLHEX
		JR		C,TPSAVE1
		LD		(EXEAD),HL		;EXEAD保存
		POP		DE

		INC		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE			;5文字進めてファイルネームがあれば続行
		CALL		TPSKIPSPC		;SKIP SPACES
;		LD		A,(DE)			;省略可
		CP		21H
		JR		C,TPSAVE2
		EX		DE,HL			;HL=ファイル名先頭アドレス
		JR		TPSAVE3			;SAVE処理へ

TPSAVE1:
							;16進数4桁の取得に失敗又はEADRSがSARDSより大きくない
		LD		DE,MSG_AD
		JP		ERRMSG
TPSAVE2:
							;ファイルネームの取得に失敗
		LD		DE,MSG_FNAME
		JP		ERRMSG
;ファイル名のセット
TPSAVE3:
		LD		DE,FNAME
		LD		BC,16
		LDIR
		LD		A,0DH
		LD		(DE),A

;ヘッダのライト(WRITING 表示もこの中で行ってくれる)
		CALL		TPMSHED
		JP		C,MON			;ブレーク/エラーならそのままコマンド待ちへ
;本体のライト
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
;**** テープからSDへBREAKが押される(またはうまいタイミングでテープが止まる)まで連続バックアップ ****
;**** チェックサムエラーは無視。ファイル名は適当に変換する ****
				;FDTB xx	xxは;ファイル名無しの時のファイル名追記番号初期値(16進2桁)
		INC		DE
		LD		A,1
		LD		(LBUF),A		;ファイル名無しの時のファイル名追記番号初期値
		LD		A,(DE)
		CP		0DH
		JR		Z,TPBACKUP10		;xxなし
		LD		B,16
		CALL		TPSKIPSPC		;SKIP SPACES
		CALL		TWOHEX
		JP		C,MON
		LD		(LBUF),A		;2桁の16進数があれば初期値に書き込み
		JR		TPBACKUP10
TPBACKUP:
		LD		HL,LBUF			;ファイル番号++
		INC		(HL)
TPBACKUP10:
		CALL		TPRDINF			;ヘッダをリードして表示
		JP		NC,TPBACKUP20
		CP		02H			;01=Check SUM Error, 02=BREAK
		JP		Z,MON			;ブレーク
		JR		TPBACKUP		;次のファイルへ
TPBACKUP20:
	;LOADING ファイル名
		LD		DE,TMSG_LOADING
		CALL		TPDISP_FN

	;スクリーンデモ対策:必ず$1200?へロード
		LD		HL,(SADRS)		;SADRSの待避
		PUSH		HL
		LD		HL,1200H		;1200Hにセット
		LD		(SADRS),HL
		CALL		TPMLDAT			;本体のロード
		POP		HL
		LD		(SADRS),HL		;SADRSの復帰
		JR		NC,TPBACKUP30
		CP		02H			;01=Check SUM Error, 02=BREAK
		JP		Z,MON			;ブレーク
		LD		DE,TMSG_CSUM		;"CHECKSUM ERR"
		CALL		MSGPR
		JR		TPBACKUP		;次のファイルへ
TPBACKUP30:
		CALL		LETLN
		LD		DE,TMSG_OK		;"OK"
		CALL		MSGPR

; SDセーブ用のDOSファイル名への変換 FNAME -> LBUF+6 +2 +2
		LD		DE,LBUF+10
		CALL		TPMKDOSFNAME
;  -> DOS FILENAME.MZT

; セーブファイル名の作り込み
		LD		DE,LBUF+6
		PUSH		DE
; ファイル番号
		LD		A,(LBUF)
		CALL		TPSTOREHEX
; ファイルタイプ
		LD		A,(IBUFE)
		CALL		TPSTOREHEX
		POP		DE

	;スクリーンデモ対策:ロードアドレスがDxxxだったらDOSファイル名末尾を"-DM"にする
		LD		A,(SADRS+1)
		AND		0F0H
		CP		0D0H
		JR		NZ,TPBACKUP70
;;		LD		DE,LBUF+6
		LD		B,32-3			;"-DM"の文字数だけ引く
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
; SDセーブ用のコマンド文字列を表示
; *FDS#tt ssss eeee xxxx FILENAME
		CALL		TPDISPFDSCMD
;  -> DOS FILENAME.MZT
		CALL		TPDISPDOSFN

;SDはFSIZEではなくてEADRSなので計算する。
		LD		HL,(SADRS)
		EX		DE,HL
		LD		HL,(FSIZE)
		LD		(LBUF+1),HL		;FSIZE待避
		ADD		HL,DE			;EADRS=SADRS+FSIZE-1
		DEC		HL
		LD		(EADRS),HL		;EADRS保存
	;送信ヘッダ情報をセットし、SDカードへSAVE実行
		LD		HL,LBUF+6		;こちらに作り込んだ物を使用
		LD		A,0A0H			;TYPE付きSAVEコマンドA0H
		CALL		STCD			;00以外(ZFが立っていない)ならERROR
		JP		NZ,SVERR
				;typeを送る
		LD		A,(IBUFE)
		CALL		SNDBYTE
	;----
		CALL		HDSEND			;ヘッダ情報送信
		CALL		RCVBYTE			;状態取得(00H=OK)
		AND		A			;00以外ならERROR
		JP		NZ,SVERR
;; $1200?のデータになるようワークを改変
		LD		HL,1200H
		LD		(SADRS),HL
		LD		DE,(LBUF+1)		;バイト数
		ADC		HL,DE
		DEC		HL
		LD		(EADRS),HL
		CALL		DBSEND			;データ送信

		LD		DE,MSG_SV
		CALL		PLIST
		CALL		LETLN

		JP		TPBACKUP		;次のファイルへ
STTP99:
; kaokun ] -----------------------------------------------------------------------------
		JP		CMDERR

;**** 8255初期化 ****
;PORTC下位BITをOUTPUT、上位BITをINPUT、PORTBをINPUT、PORTAをOUTPUT
INIT:
		LD		A,8AH
		OUT		(0DBH),A
;出力BITをリセット
INIT2:
;;		LD		A,00H			;PORTA <- 0
		XOR		A			;バイト数節約
		OUT		(0D8H),A
		OUT		(0DAH),A		;PORTC <- 0
		RET

;**** LOAD ****
;受信ヘッダ情報をセットし、SDカードからLOAD実行
;DE+1?:ファイル名
SDLOAD:
		LD		A,0A1H			;タイプ付きLOADコマンドA1H
		CALL		STCMD
		CALL		HDRCV			;ヘッダ情報受信
;[kaokun]
		LD		HL,(SADRS)		;SADRS待避
		PUSH		HL
		LD		A,(LBUF+3)
		CP		'>'			;'*FD>'であれば$1200からロード
		JR		NZ,SDLOAD1
		LD		HL,1200H
		LD		(SADRS),HL
SDLOAD1:
		PUSH		AF
		CALL		DBRCV			;データ受信
		POP		AF
		POP		HL
		LD		(SADRS),HL		;SADRS復帰
		CP		'>'			;'*FD>'であれば$1200からをテープに保存しMONITORコマンド待ちに戻る
		JR		Z,SDLOAD2
		CP		'/'			;'*FD/'であれば実行アドレスに飛ばずにMONITORコマンド待ちに戻る
		JR		Z,SDLOAD2

; FDコマンド実行後アプリ動作が固まってしまう機械、アプリへの対処
		EI					;カセットリード後EIになっているようなので踏襲
		LD		A,00H
		LD		DE,0000H
		CALL		TIMST
		LD		A,4			;Init Music
		CALL		XTEMP
		CALL		MSTP
		LD		HL,(EXEAD)
		LD		A,H			;[kaokun]:$1200より前の値はオートスタート無し
		CP		012H
		JP		C,MON
		JP		(HL)
;kaokun
SDLOAD2:
		CALL		LETLN
		LD		DE,TMSG_OK		;"OK"
		CALL		MSGPR
; カセットセーブ用のコマンド文字列を表示
; *FDTS#tt ssss eeee xxxx FILENAME
		CALL		LETLN
		LD		DE,TMSG_FDTS		;*FDTS#
		CALL		TPDISPFDTSCMD

		LD		A,(LBUF+3)
		CP		'>'			;'*FD>'であれば$1200からをテープに保存
		JP		NZ,MON

;ヘッダのライト(WRITING 表示もこの中で行ってくれる)
		CALL		TPMSHED
		JP		C,MON			;ブレーク/エラーならそのままコマンド待ちへ
;本体のライト
		LD		HL,1200H		;保存時は常に$1200から
		LD		(SADRS),HL
		JP		TPSAVE3_2

;ヘッダ受信
;[kaokun] タイプも受信する
HDRCV:
				;type+ファイル名を受信=======
		LD		HL,IBUFE
		LD		B,1+17
HDRC1:
		CALL		RCVBYTE			;ファイルネーム受信
		LD		(HL),A
		INC		HL
		DJNZ		HDRC1
		LD		DE,MSG_LD		;ファイルネームLOADING表示
		CALL		MSGPR
		CALL		TPDISP_FNONLY		;FILENAME[CR]

		LD		HL,SADRS		;SADRS取得
		CALL		RCVBYTE
		LD		(HL),A
		INC		HL
		CALL		RCVBYTE
		LD		(HL),A

		LD		HL,FSIZE		;FSIZE取得
		CALL		RCVBYTE
		LD		(HL),A
		INC		HL
		CALL		RCVBYTE
		LD		(HL),A

		LD		HL,EXEAD		;EXEAD取得
		CALL		RCVBYTE
		LD		(HL),A
		INC		HL
		CALL		RCVBYTE
		LD		(HL),A

	; -> tt ssss eeee xxxx
		CALL		TPDISPHEAD2
		CALL		LETLN
		RET

;データ受信
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
		JR		NZ,DBRLOP		;DE=0までLOOP
		RET

;**** SAVE ****
STSV:
		INC		DE
; [kaokun] : ファイルタイプを保存できるように
;	     *FDS ssss eeee xxxx DOS filename		type 01=OBJ
;	     *FDS#02 ssss eeee xxxx Program name	type 指定+PNAME
		LD		A,(DE)
		CP		'#'
		LD		A,01H			;デフォルトタイプ
		JR		NZ,STSV_NOTYPE
		INC		DE
		PUSH		DE
		CALL		TWOHEX			;#xx でファイルタイプ指定
		JR		C,STSV1
		POP		DE
		INC		DE
		INC		DE
STSV_NOTYPE:
		LD		(IBUFE),A		;ファイルタイプ保存
		INC		DE
		PUSH		DE
		CALL		HLHEX			;1文字空けて4桁の16進数であればSADRSにセットして続行
		JR		C,STSV1

		LD		(SADRS),HL		;SARDS保存
		POP		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE
		PUSH		DE			;5文字進めて4桁の16進数であればEADRSにセットして続行
		CALL		HLHEX
		JR		C,STSV1
		PUSH		HL
		LD		BC,(SADRS)
		SBC		HL,BC			;EADRSがSADRSより大きくない場合はエラー
		POP		HL
;;		JR		Z,STSV1			;ゼロ(==SADRS==EADRS, 1バイト)は許して良い筈
		JR		C,STSV1

		LD		(EADRS),HL		;EADRS保存
		POP		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE			;5文字進めて4桁の16進数であればEXEADにセットして続行
		PUSH		DE
		CALL		HLHEX
		JR		C,STSV1

		LD		(EXEAD),HL		;EXEAD保存
		POP		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE
		INC		DE			;5文字進めてファイルネームがあれば続行
		LD		A,(DE)
		CP		21H
		JR		C,STSV2

	;ファイル名をFNAMEへ積み込み
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

		LD		A,(LBUF+4)		;*FDS#の#
		CP		'#'
		JR		NZ,SDSAVE		;DOS Filename として SAVE処理へ

; PNAME --> SDセーブ用のDOSファイル名への変換 FNAME -> LBUF+6
		LD		DE,LBUF+6
		PUSH		DE
		CALL		TPMKDOSFNAME
;  -> DOS FILENAME.MZT
		CALL		TPDISPDOSFN
		POP		HL
		JR		SDSAVE			;SAVE処理へ

STSV1:
				;16進数4桁の取得に失敗又はEADRSがSARDSより大きくない
		LD		DE,MSG_AD
		JR		ERRMSG
STSV2:
				;ファイルネームの取得に失敗
		LD		DE,MSG_FNAME
		JR		ERRMSG
CMDERR:
				;コマンド異常
		LD		DE,MSG_CMD
		JR		ERRMSG

;送信ヘッダ情報をセットし、SDカードへSAVE実行
;[kaokun]
;DOS FNAME=(HL)
;MZT PNAME=(FNAME)
;と分ける
;コマンドA0(タイプ付き)を使う。
SDSAVE:
		LD		A,0A0H			;TYPE付きSAVEコマンドA0H
		CALL		STCD			;00以外(ZFが立っていない)ならERROR
		JP		NZ,SVERR
				;typeを送る
		LD		A,(IBUFE)
		CALL		SNDBYTE
	;----
		CALL		HDSEND			;ヘッダ情報送信
		CALL		RCVBYTE			;状態取得(00H=OK)
		AND		A			;00以外ならERROR
		JR		NZ,SVERR
		CALL		DBSEND			;データ送信
		LD		DE,MSG_SV
		JR		ERRMSG

SVER0:
		POP		DE			;CALL元STACKを破棄する
SVERR:
		CP		0F0H
		JR		NZ,ERR3
		LD		DE,MSG_F0		;SD-CARD INITIALIZE ERROR
		JR		ERRMSG
;FDコマンドでロード可能なファイル種類コードは0x01のみとしていた制限を撤廃
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
		LD		DE,MSG99		;その他ERROR
ERRMSG:
		CALL		MSGPR
		CALL		LETLN
MON:
		LD		A,(014EH)
		CP		'P'			;014EHが'P'ならMZ-80K
		JP		Z,MONITOR_80K
		CP		'N'			;014EHが'N'ならFN-700
		JP		Z,MONITOR_80K
; [kaokun] MZ-NewMon ------------------------------------------------
		CP		20H			;014EHが' 'ならMZ-NEW MONITOR MZ-80K ("MONITOR VER"のスペース)
		JP		Z,MONITOR_NEWMON
		LD		A,(0145H)
		CP		'7'			;0145Hが'7'ならMZ-NEW MONITOR MZ-700 ("MZ700"の"7")
		JP		Z,MONITOR_NEWMON7
		LD		A,(010DH)		;010DHが'A'ならMZ-80A ("SA-1510"の"A")
		CP		'A'
		JP		Z,MONITOR_80A
; -------------------------------------------------------------------
		LD		A,(06EBH)
		CP		'M'			;06EBHが'M'ならMZ-700 (JP/EU 共通)
		JP		Z,MONITOR_700
		JP		0000H			;識別できなかったら0000Hへジャンプ

;ヘッダ送信
;[kaokun]
;DOS FNAME=(HL)
;MZT PNAME=(FNAME)
;と分ける
HDSEND:
		LD		B,32
SS1:
		LD		A,(HL)			;FNAME送信
		CALL		SNDBYTE
		INC		HL
		DJNZ		SS1
		LD		A,0DH
		CALL		SNDBYTE

		LD		HL,FNAME		; こちらを使う
		LD		B,16
SS2:
		LD		A,(HL)			;PNAME送信
		CALL		SNDBYTE
		INC		HL
		DJNZ		SS2
		LD		A,0DH
		CALL		SNDBYTE

		LD		HL,SADRS		;SADRS送信
		LD		A,(HL)
		CALL		SNDBYTE
		INC		HL
		LD		A,(HL)
		CALL		SNDBYTE

		LD		HL,EADRS		;EADRS送信
		LD		A,(HL)
		CALL		SNDBYTE
		INC		HL
		LD		A,(HL)
		CALL		SNDBYTE

		LD		HL,EXEAD		;EXEAD送信
		LD		A,(HL)
		CALL		SNDBYTE
		INC		HL
		LD		A,(HL)
		CALL		SNDBYTE
		RET

;データ送信
;SADRSからEADRSまでを送信
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
		RET		Z			;HL == DE なら終わり
DBSLP1:
		INC		HL
		JR		DBSLOP

;**** AUTO START SET ****
STAS:
		LD		A,82H			;AUTO START SETコマンド82H
		CALL		STCMD
		LD		DE,MSG_AS
		JP		ERRMSG


;**** DIRLIST ****
STLT:
		INC		DE			;FDLの次の文字へ
		LD		HL,DEFDIR		;行頭に'*FD 'を付けることでカーソルを移動させリターンで実行できるように
		LD		BC,DEND-DEFDIR
		CALL		DIRLIST
		AND		A			;00以外ならERROR
		JP		NZ,SVERR
		JP		MON


;**** DIRLIST本体 (HL=行頭に付加する文字列の先頭アドレス BC=行頭に付加する文字列の長さ, DE=DOSファイル名) ****
;****              戻り値 A=エラーコード ****
DIRLIST:
		PUSH		BC			;ファイル名前のスペースをスキップ
		LD		B,32
		CALL		TPSKIPSPC		;SKIP SPACES
		POP		BC

		LD		A,0A3H			;ディレトリ属性付きDIRLISTコマンド0A3Hを送信
		CALL		STCD			;00以外(ZFが立っていない)ならERROR
		JP		NZ,DLRET
		PUSH		BC
		LD		B,32+1			;比較ファイル名を送信
STLT1:							;0DHの除去はArduino側でやるようにした
		LD		A,(DE)
		CALL		SNDBYTE
		INC		DE
		DJNZ		STLT1
		POP		BC
DL1:
		PUSH		HL			;HL=行頭に付加する文字列
		PUSH		BC			;文字列長
DL1_1:
		CALL		RCVBYTE			;属性受信 'F' or 'D' または指示(0FFH,0FEH)の受信
		CP		0FFH			;'0FFH'を受信したら終了
		JR		Z,DL4
		CP		0FEH			;'0FEH'を受信したら一時停止して一文字入力待ち
		JR		Z,DL5
	;ファイル名の受信と表示文字列作り込み
		LD		DE,LBUF
		LDIR
		CP		'D'
		JR		NZ,DL1_99		;通常ファイルのとき
	;以下ディレクトリのとき
		LD		A,(LBUF)		;行頭が"*FD   " なら ←←←して"CD"
		CP		'*'			;それ以外なら*FDCDを積み込む
		JR		Z,DL1_2
		LD		HL,STR_FDCD		;"*FDCD "
		LD		C,STR_FDCD_END-STR_FDCD	;"*FDCD "で6バイト
		JR		DL1_3
DL1_2:
		DEC		DE
		DEC		DE
		DEC		DE
		LD		HL,STR_FDCD+3		;"*FDCD "の頭3文字飛ばして後ろの"CD "を利用
		LD		C,STR_FDCD_END-STR_FDCD-3
DL1_3:
		LDIR
DL1_99:
	;以上ディレクトリのとき
		EX		DE,HL
		LD		B,0
DL2:
		CALL		RCVBYTE			;'00H'を受信するまでを一行とする
		OR		A
		JR		Z,DL3
		CP		0DH			;0DHは無視
		JR		Z,DL2
		LD		(HL),A
		INC		B			;文字数++
		INC		HL
		JR		DL2
	;1行エンド
DL3:
		LD		(HL),0DH		;エンドマーク書き込み
; .MZT は消す
		LD		A,B
		CP		4			;'.MZT'で4文字以上必要
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
		LD		DE,LBUF			;'00H'を受信したら一行分を表示して改行
		CALL		MSGPR
; 行末までクリアする
		CALL		CLRLBUF
		CALL		LETLN
		POP		BC
		POP		HL
		JR		DL1
DL4:
		CALL		RCVBYTE			;状態取得(00H=OK)
		POP		BC
		POP		HL
DLRET:
		RET

DL5:
		LD		DE,MSG_KEY1		;HIT ANT KEY表示
		CALL		MSGPR
		LD		A,0C2H
		CALL		DISPCH
		LD		DE,MSG_KEY2		;HIT ANT KEY表示
		CALL		MSGPR
		CALL		LETLN
DL6:
		CALL		GETKEY			;1文字入力待ち
		OR		A
		JR		Z,DL6
		CP		64H			;SHIFT+BREAKで打ち切り
		JR		Z,DL7
		CP		12H			;カーソル↑で打ち切り
		JR		Z,DL9
		CP		42H			;「B」で前ページ
		JR		Z,DL8
		LD		A,00H			;それ以外で継続
		JR		DL8
DL9:
		LD		A,0C2H			;カーソル↑で打ち切ったときにカーソル2行上へ
		CALL		DPCT
		LD		A,0C2H
		CALL		DPCT
DL7:
		LD		A,0FFH			;0FFH中断コードを送信
DL8:
		CALL		SNDBYTE
		CALL		LETLN
		JP		DL1_1			;FF 00 の受信



;**** FILE DELETE ****
STDE:
		LD		A,84H			;FILE DELETEコマンド84H
		CALL		STCMD

		LD		DE,MSG_DELQ		;'DELETE?'表示
		CALL		MSGPR
		CALL		LETLN
STDE3:
		CALL		GETKEY
		OR		A
		JR		Z,STDE3
		CP		59H			;'Y'ならOKとして00Hを送信
		JR		NZ,STDE4
		LD		A,00H
		JR		STDE5
STDE4:
		LD		A,0FFH			;'Y'以外ならCANSELとして0FFHを送信
STDE5:
		CALL		SNDBYTE
		CALL		RCVBYTE
		OR		A			;00Hを受信すればDELETE完了
		JR		NZ,STDE6
		LD		DE,MSG_DELY		;'DELETE OK'表示
		JR		STDE8
STDE6:
		CP		01H			;01Hを受信すればCANSEL完了
		JR		NZ,STDE7
		LD		DE,MSG_DELN		;'DELETE CANSEL'表示
		JR		STDE8
STDE7:
		JP		SVERR
STDE8:
		JP		ERRMSG

;**** FILE RENAME ****
STRN:
		LD		A,85H			;FILE RENAMEコマンド85H
		CALL		STCMD

		LD		DE,MSG_REN		;'NEW NAME:'表示
		CALL		MSGPR

		LD		A,09H
		LD		(DSPX),A		;カーソル位置を'NEW NAME:'の次へ
		LD		DE,LBUF			;NEW FILE NAMEを取得
		CALL		GETL
		CALL		TRIM_LBUF
		LD		DE,LBUF+8		;NEW FILE NAMEを送信
		CALL		STFN
		CALL		STFS

		CALL		RCVBYTE
		OR		A			;00Hを受信すればRENAME完了
		JP		NZ,SVERR
		LD		DE,MSG_RENY
		JP		ERRMSG

;**** FDCD: CHDIR コマンド ****
STCHDIR:
		LD		A,0A6H			;CHDIRコマンドA6H
		JR		STCHMKDIR
;*** FDMD: MKDIR  コマンド ****
STMKDIR:
		LD		A,0A7H			;MKDIRコマンドA7H
STCHMKDIR:
		CALL		CHMKDIR			;00Hを受信すればCD/MD完了
		JP		NZ,SVERR
		JP		MON

;**** CHDIR/MKDIR 本体 ****
; (DE+1)?ファイル名のポインタ
; A: 0A6H = CHDIRコマンド, 0A7H = MKDIRコマンド
; ZFでOK
CHMKDIR:
		PUSH		AF
		LD		B,32
		INC		DE
		CALL		TPSKIPSPC
		EX		DE,HL
		POP		AF
		CALL		STCMD2
		CALL		LETLN
	;カレントディレクトリを含む文字列受信
STCHD_10:
		CALL		RCVBYTE			;'00H'を受信するまで表示
		OR		A
		JR		Z,STCHD_20
		CALL		PRNT
		JR		STCHD_10
STCHD_20:
		CALL		RCVBYTE			;Aにエラーコードを入れてリターン
		OR		A
		RET


;**** FILE DUMP ****
STPR:
		LD		A,86H			;FILE DUMPコマンド86H
		CALL		STCMD

;		LD		A,0C6H			;画面クリア
;		CALL		DPCT
STPR6:
		LD		HL,SADRS		;SADRS取得
		CALL		RCVBYTE
		LD		(HL),A
		INC		HL
		CALL		RCVBYTE
		LD		(HL),A
		LD		HL,(SADRS)
		LD		A,H
		CP		0FFH			;ADRSに0FFFFHが送信されてきたらDUMP処理終了
		JR		NZ,STPR7
		LD		A,L
		CP		0FFH
		JR		NZ,STPR7
		JP		STPR8
STPR7:
		LD		DE,MSG_AD1		;DUMP TITLE表示
		CALL		MSGPR
		CALL		LETLN
		LD		C,16			;16行(128Byte)を表示
STPR0:
		PUSH		BC
		LD		B,8			;一行(8Byte)を受信
		LD		HL,LBUF
STPR1:
		CALL		RCVBYTE
		LD		(HL),A
		INC		HL
		DJNZ		STPR1

		LD		HL,(SADRS)		;アドレス表示
		CALL		PRTWRD
		LD		DE,0008H		;一画面(128Byte)中はアドレスを受け取らないので自前でインクリメント
		ADD		HL,DE
		LD		(SADRS),HL

		LD		B,8			;一行(8Byte)のデータを16進数表示
		LD		DE,LBUF
STPR2:
		CALL		PRNTS
		LD		A,(DE)
		CALL		PRTBYT
		INC		DE
		DJNZ		STPR2

		CALL		PRNTS
		LD		DE,LBUF			;一行(8Byte)のデータをキャラクタ表示
		LD		B,8
STPR9:
		LD		A,(DE)
		CP		10H			;MZ-700での文字化けに対処
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

		LD		DE,MSG_AD2		;入力待ちメッセージ表示
		CALL		MSGPR
		CALL		LETLN
		CALL		LETLN
STPR3:
		CALL		GETKEY			;1文字入力待ち
		OR		A
		JR		Z,STPR3
		CP		64H			;SHIFT+BREAKで打ち切り
		JR		Z,STPR4
		CALL		SNDBYTE			;SHIFT+BREAK以外はASCIIコードのまま送信、ARDUINO側で'B'を処理
		JP		STPR6
STPR4:
		LD		A,0FFH			;0FFH中断コードを送信
STPR5:
		CALL		SNDBYTE
		CALL		RCVBYTE			;SHIFT+BREAKでの中断時はADRS'0FFFFH'の受信及び状態コードの受信を破棄
		CALL		RCVBYTE
STPR8:
		CALL		RCVBYTE
		JP		MON

;**** FILE COPY ****
STCP:
		LD		A,87H			;FILE COPYコマンド87H
		CALL		STCMD
		LD		DE,MSG_REN		;'NEW NAME:'表示
		CALL		MSGPR

		LD		A,09H
		LD		(DSPX),A		;カーソル位置を'NEW NAME:'の次へ
		LD		DE,LBUF			;NEW FILE NAMEを取得
		CALL		GETL
		CALL		TRIM_LBUF
		LD		DE,LBUF+8		;NEW FILE NAMEを送信
		CALL		STFN
		CALL		STFS

		CALL		RCVBYTE
		OR		A			;00Hを受信すればCOPY完了
		JP		NZ,SVERR
		LD		DE,MSG_CPY
		JP		ERRMSG

;@;**** MEMORY DUMP ****
;@STMD:
;@		INC		DE
;@		INC		DE
;@		CALL		HLHEX			;1文字空けて4桁の16進数であればSADRSにセットして続行
;@		JP		C,STSV1
;@		LD		(SADRS),HL		;SARDS保存
;@
;@STMD6:
;@		LD		DE,MSG_AD1		;DUMP TITLE表示
;@		CALL		MSGPR
;@		CALL		LETLN
;@		LD		C,10H			;16行(128Byte)を表示
;@STMD7:
;@		LD		HL,(SADRS)		;アドレス表示
;@		CALL		PRTWRD
;@		CALL		PRNTS
;@
;@		
;@		LD		B,08H			;一行(8Byte)のデータを16進数表示
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
;@		LD		B,08H			;一行(8Byte)のデータをキャラクタ表示
;@STMD2:
;@		LD		A,(HL)
;@		CP		10H			;MZ-700での文字化けに対処
;@		JR		NC,STMD8
;@		LD		A,20H
;@STMD8:
;@		CALL		ADCN
;@		CALL		DISPCH
;@		CALL		GETKEY
;@		CP		64H			;表示途中でもSHIFT+BREAKで打ち切り
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
;@		LD		DE,MSG_AD2		;入力待ちメッセージ表示
;@		CALL		MSGPR
;@		CALL		LETLN
;@		CALL		LETLN
;@STMD3:
;@		CALL		GETKEY			;1文字入力待ち
;@		OR		A
;@		JR		Z,STMD3
;@		CP		64H			;SHIFT+BREAKで打ち切り
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
;@		CALL		HLHEX			;1文字空けて4桁の16進数であればHLにセットして続行
;@		JP		C,STSV1
;@
;@		INC		DE
;@		INC		DE
;@		INC		DE
;@		INC		DE
;@STSP1:
;@		LD		A,(DE)
;@		CP		0DH
;@		JR		Z,STMW9			;アドレスのみなら終了
;@		CP		20H
;@		JR		NZ,STMW1
;@		INC		DE          		;空白は飛ばす
;@		JR		STSP1
;@
;@STMW1:
;@		CALL		TWOHEX
;@		JR		C,STMW8
;@		LD		(HL),A			;2桁の16進数があれば(HL)に書き込み
;@		INC		HL
;@
;@STSP2:
;@		LD		A,(DE)
;@		CP		0DH			;一行終了
;@		JR		Z,STMW8
;@		CP		20H
;@		JR		NZ,STMW1
;@		INC		DE			;空白は飛ばす
;@		JR		STSP2
;@
;@STMW8:
;@		LD		DE,MSG_FDW		;行頭に'*FDW '
;@		CALL		MSGPR
;@		CALL		PRTWRD			;アドレス表示
;@		CALL		PRNTS
;@		LD		DE,LBUF			;一行入力
;@		CALL		GETL
;@		LD		DE,LBUF
;@		LD		A,(DE)
;@		CP		1BH
;@		JR		Z,STMW9			;SHIFT+BREAKで破棄、終了
;@		LD		DE,LBUF+3
;@		JR		STMW
;@STMW9:
;@		JP		MON

;**** MZ-700 PATCH START ****
STMZ:
		DI
		LD		HL,0000H		;ROMを2000Hにコピー
		LD		DE,2000H
		LD		BC,1000H
		LDIR
		OUT		(0E0H),A		;裏RAM ON
		LD		HL,2000H		;裏RAMにROMの内容をコピー
		LD		DE,0000H
		LD		BC,1000H
		LDIR
		LD		HL,STMZ2		;書き換えアドレス
		LD		DE,STMZ3		;書き換えデータ
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
		JP		NZ,0000H		;MZ-700と判断できなければ0000Hからスタート
		LD		DE,MSG_ST
		CALL		MSGPR
		CALL		LETLN
		JP		MONITOR_700		;MZ-700と判断できれば00ADHからスタート

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

;**** MZ-700 裏RAM START ****
STURA:
		OUT		(0E0H),A		;裏RAM ON
		LD		HL,00ADH
		LD		A,(HL)
		CP		0CDH
		JP		NZ,0000H		;0CDHでなければNZ-700などと判断して0000Hからスタート
		LD		DE,MSG_ST
		CALL		MSGPR
		CALL		LETLN
		JP		MONITOR_700		;(00ADH)が0CDHなら1Z-009A又は1Z-009Bのパッチ済みMONITORと判断して00ADHからスタート

;**** [kaokun] テープ Load/Save/Verify ****
IS_SA1510:
		LD		A,(010DH)		;010DHが'A'ならMZ-80A ("SA-1510"の"A")
		CP		'A'
		RET
TPMSHED:
	;JUMPしてきた先にリターン
		PUSH		DE			;PUSH命令をつぶしてJUMPしてきているので代わりにPUSHはしておく
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

; ファイル名表示共通
; FOUND FILENAME のような前のメッセージをDEで指定
TPDISP_FN:
		CALL		LETLN
		CALL		MSGPR
; ファイル名表示のみ
TPDISP_FNONLY:
		LD		A,0DH			;念のため
		LD		(FNAME+16),A
		LD		DE,FNAME
		CALL		PLIST
		CALL		LETLN
		RET


;**** テープヘッダをリードして表示 ****
TPRDINF:
		CALL		TPMLHED
		JR		NC,TPRDINF2
		CP		02H			;01=Check SUM Error, 02=BREAK
		JR		Z,TPRDINF1		;ブレーク
		CALL		LETLN
		LD		DE,TMSG_CSUM		;"CHECKSUM ERR"
		CALL		MSGPR
		LD		A,01H			;01=Check SUM Error, 02=BREAK
TPRDINF1:
		SCF
		RET
TPRDINF2:
		LD		DE,TMSG_FOUND		;FOUND ファイル名
		CALL		TPDISP_FN
	; -> tt ssss eeee xxxx
		CALL		TPDISPHEAD2
		XOR		A
		RET

;**** テープのヘッダ情報表示 ****
; ffff tttt xxxx
TPDISPHEAD:
		LD		HL,(SADRS)
		PUSH		HL
;=====================================================================================
		JR		SKIP_002
;	互換性確保のためのエントリ
;	MONITOR リード インフォメーション代替処理内でArduinoにHEADER LOADコマンド93Hを送信する部分(MLH_CONT)
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

; **** タイプ、アドレスを含め表示  ****
; -> tt ssss eeee xxxx
TPDISPHEAD2:
		LD		DE,TMSG_ARROW		; -> 
		CALL		MSGPR
		LD		A,(IBUFE)
		CALL		PRTBYT			;tt
		CALL		PRNTS			;' '
		CALL		TPDISPHEAD		;ssss eeee xxxx
		RET

; **** DOSファイル名の表示  ****
TPDISPDOSFN:
		LD		DE,TMSG_ARROW
		CALL		MSGPR
		LD		DE,LBUF+6
		CALL		PLIST
		LD		DE,TMSG_MZT
		CALL		MSGPR
		CALL		LETLN
		RET


; SDセーブ用のコマンド文字列を表示
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
		JP		TPDISP_FNONLY		;バイト数節約。ファイル名表示共通へ

;**** (DE)で示されるファイル名先頭などのスペースをスキップするまでDEレジスタを進める ****
TPSKIPSPC:						;SKIP SPACES
		LD		A,(DE)
		CP		20H
		RET		NZ
		INC		DE
		DJNZ		TPSKIPSPC
		RET

;**** (HL)で示されるところからスペースをスキップするまでHLレジスタを進める ****
TPSKIPSPC2:
		LD		A,(HL)
		CP		20H
		RET		NZ
		INC		HL
		JR		TPSKIPSPC2


;**** FNAMEのMZファイル名をDOSファイル名に変換してLBUF+6?へ格納 ****
; ?文字当たり最大2バイトに変換
; レジスタ保存しない
; IN:
;	FNAME:	プログラム名 (最大16文字+CR)
; OUT:
;       (DE-1): 00Hとなる
;	(DE)?: DOSファイル名 (最大32文字+CR)
; WORK:
;	LBUF+0:	NONAMEの時のファイル番号
;	LBUF+1:	ロードアドレス待避
;	LBUF+2:	ロードアドレス待避
;	LBUF+3:	子音字連打フラグ	= (IX)
;	LBUF+4:	残り文字数		= (IX+1)
;	LBUF+5:	00
;	DE?変換後ファイル名
TPMKDOSFNAME:
		PUSH		DE
		POP		HL
;出力先33バイトを0DHで埋める。
		LD		B,32+1
TPMKDOSFN_INIT:
		LD		(HL),0DH
		INC		HL
		DJNZ		TPMKDOSFN_INIT
;		CALL		TRIM_AFTER_FNAME	;変換元後ろTrim
;変換メイン
		PUSH		DE
		LD		HL,FNAME		;HL=変換元ポインタ
		CALL		TPSKIPSPC2		;前Trim2024. 3.24
		LD		IX,LBUF+3		;(IX):子音字連打フラグ,(IX+1):残り文字数
		XOR		A
		LD		(IX),A			;子音字連打フラグクリア
		LD		(IX+1),16		;最大16文字 (変換先は32文字なので1文字当たり2バイトに変換してもOK)
		DEC		DE
		LD		(DE),A			;変換後の1バイト前からの値はNON-ASCIIで保証する
		INC		DE			;DE=変換先ポインタ
TPMKDOSFNLOOP:
		LD		A,(HL)
		INC		HL			;HL=次の文字
TPMKDOSFN01:
		CP		0DH
		JP		Z,TPMKDOSFNEND

TPMKDOSFN02:
; Aがファイル名に許されるかチェック
; 20H?5DH, ただし *?<>:\/ を除く
; 05Hも許す
		CP		'*'
TPMKDOSFN03:
		JP		Z,TPMKDOSFNCTRL
		CP		'?'
		JR		Z,TPMKDOSFN03		;バイト数節約
		CP		'<'
		JR		NZ,TPMKDOSFN10
		LD		A,'['
TPMKDOSFN05:
		JP		TPMKDOSFNNEXT
TPMKDOSFN10:
		CP		'>'
		JR		NZ,TPMKDOSFN20
		LD		A,']'
		JR		TPMKDOSFN05		;バイト数節約
TPMKDOSFN20:
		CP		':'
TPMKDOSFN22	JP		Z,TPMKDOSFNCTRL
		CP		5CH			;\
		JR		Z,TPMKDOSFN22		;バイト数節約
		CP		'/'
		JR		Z,TPMKDOSFN22		;バイト数節約
		CP		05H			;大文字/小文字切替は素通し 2024. 3.13
		JR		Z,TPMKDOSFN05		;バイト数節約
;20-5D?
		CP		20H
		JP		C,TPMKDOSFNCTRL
		CP		5EH
		JR		C,TPMKDOSFN05		;バイト数節約

;==== [ A,(HL)のファイル名文字のマップ ====
TPMKDOSFNMAP:
		PUSH		DE
		POP		IY			;変換後の前後を見たい
		CP		81H
		JP		C,TPMKDOSFNEMOJI	;?$80:マップ対象外
;81-BF = カナ===
TPMKDOSFNMAPKANA:
				;81-85H: 。「」、・
		CP		86H
		JR		NC,TPMKDOSFN30
		SUB		81H
		PUSH		HL
		LD		HL,TPNMAP8185
		JP		TPMKDOSFNNEXT_1_1	;HLの1バイトテーブル引いて1バイトストア+POP HL

TPMKDOSFN30:
		JR		NZ,TPMKDOSFN40
				;86H:"ヲ"
		PUSH		HL
		LD		HL,"WO"
		JP		TPMKDOSFNNEXT_HL_2	;HLの2バイトをストア

; (IY-1)(IY-2)がDEに等しいかチェック
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
				;87-8BH: ァィゥェォ
		CP		8CH
		JR		NC,TPMKDOSFN50
		SUB		87H
		LD		C,A			;C:=0:ァ, 1:ィ, 2:ゥ, 3:ェ, 4:ォ
; ->前がTIかつェならCHE
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

; ->前がHUだったならHUを取ってFA/FI/FU/FU/FE/FO : ファ?フォ
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
;ファ?フォ
		LD		A,"F"
		LD		(IY-2),A
		DEC		DE
TPMKDOSFN46:
		LD		A,C
		JP		TPMKDOSFNNEXT_AIUEO	;Aに従ってAIUEOのストア

TPMKDOSFN50:
;8C-8E: ャュョ
		CP		8FH
		JR		NC,TPMKDOSFN60
		SUB		8CH			;↓x2することでAIUEOのテーブル流用できる
		ADD		A,A			;0:ャ, 2:ュ, 4:ョ => 0:A, 2:U, 4:O
		LD		C,A
	; 前がTIならTIを取ってCHA/CHU/CHOとする
	; 前がIならIを取ってYA/YU/YOとする
	; そうでないとき、'LYA'は3バイトになるのでやらない。代わりに'YA'にするので前を取らないだけ
		LD		A,(IY-1)
		CP		'I'
		JR		NZ,TPMKDOSFN55
		DEC		DE			;前を取る
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
		JP		TPMKDOSFNNEXT_AIUEO	;Aに従ってAIUEOのストア

TPMKDOSFN60:
				;8FH: ッ
		JR		NZ,TPMKDOSFN70
	;変換の次がアイウエオ(91H-95H)以外のカナならその文字を反復 = 子音連打フラグ立てるだけ
	;->86-8F,96-BDの範囲なら子音連打フラグ立てる
		LD		A,(IX+1)		;残り文字数
		CP		2
		JR		C,TPMKDOSFN63		;次がない(自分を含め残り2文字未満)
		LD		A,(HL)
		CP		86H
		JR		C,TPMKDOSFN63		;次は子音でない
		CP		90H
		JR		C,TPMKDOSFN66		;次は子音なのでフラグセットのみ
		CP		96H
		JR		C,TPMKDOSFN63		;次は子音でない
		CP		0BEH
		JR		C,TPMKDOSFN66		;次は子音なのでフラグセットのみ
TPMKDOSFN63:
	;そうでなければ"TU"とする。
		PUSH		HL
		LD		HL,"TU"
		JP		TPMKDOSFNNEXT_HL_2	;HLの2バイトをストア
TPMKDOSFN66:
		LD		(IX),1			;子音連打フラグセット
		JP		TPMKDOSFNNEXT_NOP	;何もせず次の文字へ

TPMKDOSFN70:
;90H:長音
		CP		90H
		JR		NZ,TPMKDOSFN80
		LD		A,'-'
		JP		TPMKDOSFNNEXT		;Aをストアして次へ

TPMKDOSFN80:
;91-95: アイウエオ
		CP		96H
		JR		NC,TPMKDOSFN90
		SUB		91H
		LD		C,A
		CP		2			;ヴの対応
		JR		NZ,TPMKDOSFN83
		CALL		TP_IS_DAKUTEN
		JR		NZ,TPMKDOSFN83
		LD		A,'V'
		CALL		TPMKDOSFN_SCONS		;子音連打フラグを見ながら子音のストア(Store Consonant)+INC DE
		INC		HL			;1文字消費
		DEC		(IX+1)
TPMKDOSFN83:
		LD		A,C
		JP		TPMKDOSFNNEXT_AIUEO	;Aに従ってAIUEOのストア

TPMKDOSFN90:
				;96-FF
				;ランダムは先に分岐
		CP		0BDH
		JR		Z,TPMKDOSFN_NN		;ン
		CP		0BEH
		JR		Z,TPMKDOSFN_DAKU	;゛単独
		CP		0BFH
		JR		Z,TPMKDOSFN_HDAKU	;゜単独
		CP		0FFH
		JR		Z,TPMKDOSFN_PI		;π

				;96-B3: カ行?マ行
				;B7-BC: ラ行、ワ
				;共通処理
		CP		0BDH
		JR		NC,TPMKDOSFNEMOJI	;BD-FFマップ対象外

		CP		0B4H			;96-B3
		JR		C,TPMKDOSFN100
		CP		0B7H			;B4-B6
		JR		C,TPMKDOSFN_YAYUYO	;ヤユヨ
		SUB		3			;ラリルレロワはヤユヨのぶん詰める
TPMKDOSFN100:
;5で割って子音と母音の検索、濁点、半濁点処理
		SUB		96H
;==== (DE++) = TPMAPTBL_K2R[A/5]; A = TPMAPTBL_AIUEO[A%5]
TPNMAP2:
	; A/5 : 遅くても良いので5を引き続ける
		LD		C,0FFH			; -1
		LD		B,5
TNMAP2_10:
		INC		C			; 商を+1
		SUB		B
		JR		NC,TNMAP2_10		; 引ければもう1回
		ADD		A,B			; 余りを戻す
	; ここで A:余り, C:商
		LD		B,0
		PUSH		DE
		PUSH		HL
		LD		HL,TPMAPTBL_K2R
		ADD		HL,BC
		LD		D,(HL)			;D=(HL + A/5)　子音
		LD		E,A			;E=余り
		POP		HL
		LD		A,D			;A=子音字
		CALL		TP_IS_DAKUTEN		;次は濁点?
		JR		C,TNMAP2_20
		JR		Z,TNMAP2_30:
		JR		TNMAP2_50
TNMAP2_20:
				;半濁点
		CP		'H'			;半濁点はHの時のみ
		JR		NZ,TNMAP2_60		;半濁点不可
		LD		A,'P'
		JR		TNMAP2_40
TNMAP2_30:
	;濁点
	;商が0-2,4の時のみ
		LD		A,C
		CP		3
		JR		Z,TNMAP2_50		;濁点不可
		CP		5
		JR		NC,TNMAP2_50		;濁点不可
		PUSH		HL
		LD		HL,TPMAPTBL_GZDB	; ガザダバ行
		CALL		TPNMAP1
		POP		HL
TNMAP2_40:
		INC		HL			;(半)濁点スキップ
		DEC		(IX+1)			;残り文字数消費
		JR		TNMAP2_60
TNMAP2_50:
		LD		A,D			;A=子音字

TNMAP2_60:
	;子音連打フラグを見ながら子音のストア
		LD		C,E			;C=余り
		POP		DE
		CALL		TPMKDOSFN_SCONS
		LD		A,C			;余り
		JR		TPMKDOSFNNEXT_AIUEO	;Aに従ってAIUEOのストア

TPMKDOSFN_YAYUYO:
;B4-B6: ヤユヨ
		SUB		0B4H
		ADD		A,A
		LD		B,A			;母音の保存
		LD		A,"Y"
		CALL		TPMKDOSFN_SCONS		;子音
		LD		A,B
		JR		TPMKDOSFNNEXT_AIUEO	;Aに従ってAIUEOのストア

TPMKDOSFN_NN:
;ン=NN
		LD		A,'N'
		CALL		TPMKDOSFN_SCONS		;子音
		JR		TPMKDOSFNNEXT

TPMKDOSFN_DAKU:
;゛単独
		LD		A,'"'
		JR		TPMKDOSFNNEXT
TPMKDOSFN_HDAKU:
;゜単独
		LD		A,'.'
		JR		TPMKDOSFNNEXT
TPMKDOSFN_PI:
; π
		PUSH		HL
		LD		HL,"PI"
		JR		TPMKDOSFNNEXT_HL_2	;HLの2バイトをストア

TPMKDOSFNEMOJI:
		LD		A,'@'
		JR		TPMKDOSFNNEXT
TPMKDOSFNCTRL:
		LD		A,'='
		JR		TPMKDOSFNNEXT
;==== ] A,(HL)のファイル名文字のマップここまで ====

;共通部
;HLの1バイトテーブル引いて1バイトストア+POP HL
TPMKDOSFNNEXT_1_1:
	;1バイトテーブル引いて1バイトストア
		CALL		TPNMAP1			; テーブルで変換

TPMKDOSFNNEXT_HL_2_0:
		POP		HL
		JR		TPMKDOSFNNEXT

TPMKDOSFNNEXT_HL_2:
	;HLの2バイトをストア
		LD		A,H
		CALL		TPMKDOSFN_SCONS		;子音
		LD		A,L
		JR		TPMKDOSFNNEXT_HL_2_0

TPMKDOSFNNEXT_AIUEO:
	;Aに従ってAIUEOのストア
		PUSH		HL
		LD		HL,TPMAPTBL_AIUEO
		CALL		TPNMAP1
		JR		TPMKDOSFNNEXT_HL_2_0

;Aの内容をDOS FILENAMEにストアして次へ
TPMKDOSFNNEXT:
		LD		C,A
		LD		A,(IX+1)		; 残り
		OR		A
		LD		A,C
		JR		Z,TPMKDOSFNEND		; 既に残り0の場合以下はやらない
		LD		(DE),A
		INC		DE
TPMKDOSFNNEXT_NOP:
		DEC		(IX+1)
		JP		NZ,TPMKDOSFNLOOP

TPMKDOSFNEND:
		LD		A,0DH
		LD		(DE),A
; 名前無し判定
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


;=== (DE)?にAを16進2桁でストア, DEは次へ ===
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

;==== 子音連打フラグを見ながら子音のストア(Store Consonant)+INC DE
TPMKDOSFN_SCONS:
		PUSH		BC
		LD		B,A
		LD		A,(IX)
		OR		A			;ZF=子音連打フラグ
		LD		A,B
		LD		(DE),A			;子音ストア
		LD		(IX),0			;連打フラグクリア
		JR		Z,TPMKDOSFN_SCONS10
		INC		DE			;連打
		LD		(DE),A
TPMKDOSFN_SCONS10:
		INC		DE
		POP		BC
		RET

;==== (HL)の指す文字が濁点か半濁点か調べる
;Z=0,C=0:どちらでもない
;Z=1,C=0:濁点
;Z=0,C=1:半濁点
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

;カナ文字変換⇒ファイル名内文字テーブル
TPMAPTBL_AIUEO:
		DB		"AIUEO"			;アイウエオ
TPMAPTBL_K2R:
		DB		"KSTNHMRW"		;カサタナハマラワ行
TPMAPTBL_GZDB:
		DB		"GZDNB"			; ガザダバ行
TPNMAP8185:
		DB		".[],-"			;。「」、・

;**** [kaokun] テープ用 MESSAGE DATA ********************
TMSG_FOUND:
		DB		'FOUND '
		DB		0DH
;TMSG_LOADING:						;SD用流用
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

;**** 1BYTE受信 ****
;受信DATAをAレジスタにセットしてリターン
RCVBYTE:
		CALL		F1CHK			;PORTC BIT7が1になるまでLOOP
		IN		A,(0D9H)		;PORTB -> A
		PUSH 		AF
		LD		A,05H
		OUT		(0DBH),A		;PORTC BIT2 <- 1
		CALL		F2CHK			;PORTC BIT7が0になるまでLOOP
		LD		A,04H
		OUT		(0DBH),A		;PORTC BIT2 <- 0
		POP 		AF
		RET

;**** 1BYTE送信 ****
;Aレジスタの内容をPORTA下位4BITに4BITずつ送信
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

;**** 4BIT送信 ****
;Aレジスタ下位4ビットを送信する
SND4BIT:
		OUT		(0D8H),A
		LD		A,05H
		OUT		(0DBH),A		;PORTC BIT2 <- 1
		CALL		F1CHK			;PORTC BIT7が1になるまでLOOP
		LD		A,04H
		OUT		(0DBH),A		;PORTC BIT2 <- 0
		CALL		F2CHK
		RET

;**** BUSYをCHECK(1) ****
; 82H BIT7が1になるまでLOP
F1CHK:
		IN		A,(0DAH)
		AND		80H			;PORTC BIT7 = 1?
		JR		Z,F1CHK
		RET

;**** BUSYをCHECK(0) ****
; 82H BIT7が0になるまでLOOP
F2CHK:
		IN		A,(0DAH)
		AND		80H			;PORTC BIT7 = 0?
		JR		NZ,F2CHK
		RET

;****** FILE NAME 取得 (IN:DE コマンド文字の次の文字 OUT:HL ファイルネームの先頭)*********
STFN:
		PUSH	AF
STFN1:
		INC		DE			;ファイルネームまでスペース読み飛ばし
		LD		A,(DE)
		CP		20H
		JR		Z,STFN1
		CP		05H			; 05Hは許す
		JR		Z,STFN2
;		CP		30H			;「0」以上の文字でなければエラーとする
		CP		21H			;[kaokun] ! 以降で
		JP		C,STSV2
STFN2:
		EX		DE,HL
		POP		AF
		RET

;**** コマンド送信 (IN:A コマンドコード)****
STCD:
		CALL		SNDBYTE			;Aレジスタのコマンドコードを送信
		CALL		RCVBYTE			;状態取得(00H=OK)
		OR		A			;NO ERRORならZF
		RET

;**** ファイルネーム送信(IN:HL ファイルネームの先頭) ******
STFS:
		LD		B,32
STFS1:
		LD		A,(HL)			;FNAME送信
		CALL		SNDBYTE
		INC		HL
		DJNZ		STFS1
		LD		A,0DH
		CALL		SNDBYTE
		CALL		RCVBYTE			;状態取得(00H=OK)
		RET

;**** コマンド、ファイル名送信 (IN:A コマンドコード DE+1:ファイルネームの先頭)****
STCMD:
		CALL		STFN			;ファイルネーム取得
STCMD2:
		PUSH		HL
		CALL		STCD			;00以外(ZFが立っていない)ならERROR
		POP		HL
		JP		NZ,SVER0
		CALL		STFS			;ファイルネーム送信
		AND		A			;00以外ならERROR
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
		DB		'DOS FILE:'				; 9文字
MSG_DNAMEEND:;			 1234567890123456789012345678		; +28文字=37文字出力
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
		DB		'*FD   '		;*FDCD↓と合わせるため空白を1つ追加
DEND:

STR_FDCD:	DB		'*FDCD '
STR_FDCD_END:

;
;ファイル名の後ろTrim
;S-OS SWORD、8080用テキスト・エディタ?アセンブラはファイルネームの後ろが20h詰めとなるため0dhに修正
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
		LD		HL,FNAME+10H		;ファイルネーム
TRIM_AFTER_FNAME2:
		LD		C,0DH
		LD		(HL),C			;ストッパ
TAF0:
		LD		A,(HL)
		CP		C			;0DHであればひとつ前の文字の検査に移る
		JR		Z,TAF2
		CP		05H			;20H,05H,0DHのパターンは無視
		JR		Z,TAF1
		CP		05H			;20H,05H,0DHのパターンは無視
		JR		Z,TAF1
		CP		20H			;20Hであれば0DHをセットしてひとつ前の文字の検査に移る
		JR		NZ,TAF3			;05H, 0DH、20H以外の文字であれば終了
TAF1:
		LD		(HL),C
TAF2:
		DEC		HL
		DJNZ		TAF0
TAF3:
		POP		HL
		POP		BC
		RET

;*********************** 0436H MONITOR ライト インフォメーション代替処理 ************
MSHED:
		DI
		PUSH		DE
		PUSH		BC
		PUSH		HL
		CALL		INIT
		LD		A,91H			;HEADER SAVEコマンド91H
		CALL		MCMD			;コマンドコード送信
;;		AND		A			;00以外ならERROR
		JP		NZ,MERR

		CALL		TRIM_AFTER_FNAME	;後ろTrim

	; WRITING ファイル名
		LD		DE,WRMSG		;'WRITING '
		CALL		TPDISP_FN

		LD		HL,IBUFE
		LD		B,128
MSH3:
		LD		A,(HL)			;インフォメーション ブロック送信
		CALL		SNDBYTE
		INC		HL
		DJNZ		MSH3

		CALL		RCVBYTE			;状態取得(00H=OK)
		AND		A			;00以外ならERROR
		JP		NZ,MERR

		JP		MRET			;正常RETURN

;******************** 0475H MONITOR ライト データ代替処理 **********************
MSDAT:
		DI
		PUSH		DE
		PUSH		BC
		PUSH		HL
		LD		A,92H			;DATA SAVEコマンド92H
		CALL		MCMD			;コマンドコード送信
;;		AND		A			;00以外ならERROR
		JP		NZ,MERR

		LD		HL,FSIZE		;FSIZE送信
		LD		A,(HL)
		CALL		SNDBYTE
		INC		HL
		LD		A,(HL)
		CALL		SNDBYTE

		CALL		RCVBYTE			;状態取得(00H=OK)
		AND		A			;00以外ならERROR
		JP		NZ,MERR

		LD		DE,(FSIZE)
		LD		HL,(SADRS)
MSD1:
		LD		A,(HL)
		CALL		SNDBYTE			;SADRSからFSIZE Byteを送信。分割セーブの場合、直前に0436HでOPENされたファイルを対象として256バイトずつ0475HがCALLされる。
		DEC		DE
		LD		A,D
		OR		E
		INC		HL
		JR		NZ,MSD1

		JP		MRET			;正常RETURN


;**** 行をきれいにする ****
CLRLINE:
		PUSH		BC
		PUSH		DE
		LD		A,2			;2桁目でDELx2
		LD		(DSPX),A
		LD		B,A
CL10:
		LD		A,0C7H			;[DEL]
		CALL		DPCT
		DJNZ		CL10
;		XOR		A
;		LD		(DSPX),A
		LD		DE,MSG_38SPC		;37個スペース出力
		CALL		MSGPR
		XOR		A
		LD		(DSPX),A
		POP		DE
		POP		BC
		RET
;				 00000000011111111112222222222333333333
;				 12345678901234567890123456789012345678
MSG_38SPC:	DB		'                                      ',0DH

;**** LBUFをきれいにする ****
;LBUFを0DHで埋めファイルネームが指定されなかったことにする
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

;************************** 04D8H MONITOR リード インフォメーション代替処理 *****************
MLHED:
		DI
		PUSH		DE
		PUSH		BC
		PUSH		HL
		CALL		INIT

;;		LD		A,00H
;;		LD		DE,0000H
;;		CALL		TIMST

; 連続ロードモードの時はUIをスキップ
		LD		A,(CONTF)		;(CONTF)が
		CP		CONTF_ON		;':'では
		JR		NZ,MLH0			;ないならUIあり
		LD		A,0DH
		LD		DE,LBUF
		LD		(DE),A			;ファイル名無し、とする
		JR		MLH_CONT		;Arduinoからロード
MLH0:
;;		CALL		CLRLINE			;行クリア←何故かROPOKOでクリアできないのでここだけ特殊クリア
		PUSH		BC
		LD		A,39			;39桁目でDELx39
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
;;		LD		A,09H			;カーソルを9文字目に戻す
;;		LD		(DSPX),A

;;;;		LD		DE,MBUF			;ファイルネームを指示するための苦肉の策。LOADコマンドとしてはファイルネームなしとして改行したのちに行バッファの位置をずらしてDOSファイルネームを入力する。
		LD		DE,LBUF
		CALL		GETL
		CALL		TRIM_LBUF
;;		LD		DE,MBUF+9
		LD		DE,LBUF+9

		LD		A,(DE)
;**** ファイルネームの先頭が'*'なら拡張コマンド処理へ移行 ****
		CP		'*'
		JR		Z,MLHCMD
MLH_CONT:
		LD		A,93H			;HEADER LOADコマンド93H
		CALL		MCMD			;コマンドコード送信
;;		AND		A			;00以外ならERROR
		JP		NZ,MERR

MLH1:
		LD		A,(DE)
		CP		20H			;行頭のスペースをファイルネームまで読み飛ばし
		JR		NZ,MLH2
		INC		DE
		JR		MLH1

MLH2:
		LD		B,20H
MLH4:
		LD		A,(DE)			;FNAME送信
		CALL		SNDBYTE
		INC		DE
		DJNZ		MLH4
		LD		A,0DH
		CALL		SNDBYTE
		CALL		RCVBYTE			;状態取得(00H=OK)
		AND		A			;00以外ならERROR
		JP		NZ,MERR

		CALL		RCVBYTE			;状態取得(00H=OK)
		AND		A			;00以外ならERROR
		JP		NZ,MERR

		LD		HL,IBUFE
		LD		B,80H
MLH5:
		CALL		RCVBYTE			;読みだされたインフォメーションブロックを受信
		LD		(HL),A
		INC		HL
		DJNZ		MLH5

		CALL		RCVBYTE			;状態取得(00H=OK)
		AND		A			;00以外ならERROR
		JP		NZ,MERR

		JP		MRET			;正常RETURN

;**************************** アプリケーション内SD-CARD操作処理 **********************
MLHCMD:
;**** HL、DE、BCレジスタを保存 ****
		PUSH		HL
		PUSH		DE
		PUSH		BC
		INC		DE			;'*'の次
;**** FDLコマンド ****
		LD		HL,CMD_FDL
		LD		B,3			;FDLで3文字
		CALL		CMPSTR
		JR		Z,MLHFDLCMD
;**** FDCDコマンド ****
		LD		HL,CMD_FDCD
		LD		B,4			;FD[CM]Dで4文字
		CALL		CMPSTR
		LD		A,0A6H			;CHDIRコマンドA6H
		JR		Z,MLHFDCDMD
;**** FDMDコマンド ****
		LD		HL,CMD_FDMD
		CALL		CMPSTR
		LD		A,0A7H			;MKDIRコマンドA7H
		JR		Z,MLHFDCDMD
MLHCMD_R:
		POP		BC
		POP		DE
		POP		HL
;**** ファイルネーム入力へ復帰 ****
		JP		MLH0

MLHFDLCMD:
				; アプリ内 FDL 処理
		INC		DE			;'F'の次
		INC		DE			;'D'の次
		INC		DE			;'L'の次
		LD		HL,MSG_DNAME		;行頭に'DOS FILE:'を付けることでカーソルを移動させリターンで実行できるように
		LD		BC,MSG_DNAMEEND-MSG_DNAME	;"DOS FILE:" の文字数=9
;**** FDLコマンド呼び出し ****
		CALL		DIRLIST
		AND		A			;00以外ならERROR
		JR		NZ,SERR
		JR		MLHCMD_R

MLHFDCDMD:
				; アプリ内 FDCD/FDMD 処理
		INC		DE			;'F'の次
		INC		DE			;'D'の次
		INC		DE			;'C'/'M'の次
		INC		DE			;'D'の次
		CALL		CHMKDIR			;00Hを受信すればCD/MD完了
		JR		Z,MLHCMD_R		; エラーでなければアプリ内処理を続ける
;;		JR		SERR

;******* アプリケーション内SD-CARD操作処理用ERROR処理 **************
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
;**** ファイルネーム入力へ復帰 ****
		JP		MLH0

;**** コマンド文字列比較 ****
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

;**** コマンドリスト ****
; 将来拡張用
CMD_FDL:
		DB		'FDL',0DH
CMD_FDCD:
		DB		'FDCD',0DH
CMD_FDMD:
		DB		'FDMD',0DH


;**************************** 04F8H MONITOR リード データ代替処理 ********************
MLDAT:
		DI
		PUSH		DE
		PUSH		BC
		PUSH		HL
		LD		A,94H			;DATA LOADコマンド94H
		CALL		MCMD			;コマンドコード送信
;;		AND		A			;00以外ならERROR
		JP		NZ,MERR

		CALL		RCVBYTE			;状態取得(00H=OK)
		AND		A			;00以外ならERROR
		JP		NZ,MERR

		CALL		RCVBYTE			;状態取得(00H=OK)
		AND		A			;00以外ならERROR
		JP		NZ,MERR

		LD		DE,FSIZE		;FSIZE送信
		LD		A,(DE)
		CALL		SNDBYTE
		INC		DE
		LD		A,(DE)
		CALL		SNDBYTE
		CALL		DBRCV			;FSIZE分のデータを受信し、SADRSから格納。分割ロードの場合、直前に0436HでOPENされたファイルを対象として256バイトずつSADRSが加算されて04F8HがCALLされる。

		CALL		RCVBYTE			;状態取得(00H=OK)
		AND		A			;00以外ならERROR
		JP		NZ,MERR

		JR		MRET			;正常RETURN

;************************** 0588H VRFY CMT ベリファイ代替処理 *******************
MVRFY:
		DI
		XOR		A			;正常終了フラグ
;		EI

		RET

;******* 代替処理用コマンドコード送信 (IN:A コマンドコード) **********
MCMD:
;		PUSH		AF
;		CALL		INIT
;		POP		AF
		CALL		SNDBYTE			;コマンドコード送信
		CALL		RCVBYTE			;状態取得(00H=OK)
		AND		A			;バイト数節約のためここでゼロ判定しておく
		RET

;****** 代替処理用正常RETURN処理 **********
MRET:
		POP		HL
		POP		BC
		POP		DE
		XOR		A			;正常終了フラグ
;		EI

		RET

;******* 代替処理用ERROR処理 **************
MERR:
		CP		0F0H
		JR		NZ,MERR3
		LD		DE,MSG_F0
		JR		MERRMSG
;代替処理ではファイル種類コードの判別なし
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
		LD		(CONTF),A	; 連続ロードモードクリア
		POP		HL
		POP		BC
		POP		DE
		LD		A,02H
		SCF
;		EI

		RET

		END
