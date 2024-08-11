#include <BufferedPrint.h>
#include <FreeStack.h>
#include <MinimumSerial.h>
#include <RingBuf.h>
#include <SdFat.h>
#include <SdFatConfig.h>
#include <sdios.h>

// 2022. 1.24 ファイルネームの後ろの20h詰めを0dhに修正するための処理をArduino側からMZ-80K側に修正
//           比較演算子の記述を見直し
// 2022. 1.25 各コマンド受信時のdelay()を廃止
// 2022. 1.26 FDコマンドでロード可能なファイル種類コードは0x01のみとしていた制限を撤廃
// 2022. 1.29 FDPコマンドのbug修正
// 2022. 1.30 FDLコマンド仕様変更 FDL A～Zの場合、ファイル名先頭一文字を比較して一致したものだけを出力
// 2022. 1.31 FDLコマンド仕様変更 FDL xの場合、ファイル名先頭一文字を比較して一致したものだけを出力
//            Bキーで前の20件を表示
// 2022. 2. 2 DOSファイル名がアルファベット小文字でもFDL xで検索できるように修正
// 2022. 2. 4 MZ-1200対策　初期化時にdelay(1000)を追加
// 2022. 2. 8 FDLコマンド仕様変更 FDL xの場合、ファイル名先頭1文字～32文字までに拡張
// 2023. 6.19 MZ-2000_SDの起動方式追加によりBOOT LOADER読み込みを追加。MZ-80K_SDには影響なし。
// 2024. 3. 4 sd-card再挿入時の初期化処理を追加
//

// [kaokun]
// 2023.12.01 SAVE/LOADで、ファイルタイプ01以外に対応できるようにタイプ付きの別コマンド追加 
// 2023.12.30 chdir / mkdir / rmdir /rendir に対応。
//            ただしヒープが全然足りていなくてハングするので、パスの最大長はSDFatの最大255文字ではなく、127文字とする
// 2024.01.21 dirlist で、ディレクトリとそうでないファイルを区別できるコマンドを追加
//            f_match(), upper()を標準ライブラリ化
// 2024. 3.13 DOSファイル名中の0x05は大文字/小文字切替えトグルとして処理(MZ-700のモニタがそうしているらしい。0x06ではなく)
// 2024. 6.23 1本のテープに複数ファイルが保存してあってチェーンロードしているタイプのゲームなどをSDの1つのディレクトリに入れた物に対応(FD:コマンド)
//            セーブ系で指定されたファイル名が無い場合、"(no name)"をセットするようにした。(Z80側の拡張子の省略表示に対応するため)

#include <ctype.h>
#include <string.h>
#include "SdFat.h"
#include <SPI.h>
SdFat SD;
unsigned long m_lop=128;
unsigned int m_skip=0;  //連続ロードモード用

// chdir 対応
#define PATHMAX 80      // 128だとまだダメかも
char cwd_name[PATHMAX + 1];

#define NAME_MAX_MZ  32
#define NAME_MAX  (NAME_MAX_MZ + 4)   /* ".mzt" のぶんだけ多い */
#define PADDING   4

char m_name[NAME_MAX + PADDING];  //代替処理用ファイル名
byte s_data[256 + PADDING];
char f_name[NAME_MAX + PADDING];
char c_name[PATHMAX + 1];
char new_name[NAME_MAX + PADDING];

#define CABLESELECTPIN  (10)
#define CHKPIN          (15)
#define PB0PIN          (2)
#define PB1PIN          (3)
#define PB2PIN          (4)
#define PB3PIN          (5)
#define PB4PIN          (6)
#define PB5PIN          (7)
#define PB6PIN          (8)
#define PB7PIN          (9)
#define FLGPIN          (14)
#define PA0PIN          (16)
#define PA1PIN          (17)
#define PA2PIN          (18)
#define PA3PIN          (19)
// ファイル名は、ロングファイルネーム形式対応
boolean eflg;

void sdinit(void){
  // SD初期化
  if( !SD.begin(CABLESELECTPIN,8) )
  {
////    Serial.println("Failed : SD.begin");
    eflg = true;
  } else {
////    Serial.println("OK : SD.begin");
    eflg = false;
  }

////    Serial.println("START");
}

void setup(){
////  Serial.begin(9600);
// CS=pin10
// pin10 output

  pinMode(CABLESELECTPIN,OUTPUT);
  pinMode( CHKPIN,INPUT);  //CHK
  pinMode( PB0PIN,OUTPUT); //送信データ
  pinMode( PB1PIN,OUTPUT); //送信データ
  pinMode( PB2PIN,OUTPUT); //送信データ
  pinMode( PB3PIN,OUTPUT); //送信データ
  pinMode( PB4PIN,OUTPUT); //送信データ
  pinMode( PB5PIN,OUTPUT); //送信データ
  pinMode( PB6PIN,OUTPUT); //送信データ
  pinMode( PB7PIN,OUTPUT); //送信データ
  pinMode( FLGPIN,OUTPUT); //FLG

  pinMode( PA0PIN,INPUT_PULLUP); //受信データ
  pinMode( PA1PIN,INPUT_PULLUP); //受信データ
  pinMode( PA2PIN,INPUT_PULLUP); //受信データ
  pinMode( PA3PIN,INPUT_PULLUP); //受信データ

  digitalWrite(PB0PIN,LOW);
  digitalWrite(PB1PIN,LOW);
  digitalWrite(PB2PIN,LOW);
  digitalWrite(PB3PIN,LOW);
  digitalWrite(PB4PIN,LOW);
  digitalWrite(PB5PIN,LOW);
  digitalWrite(PB6PIN,LOW);
  digitalWrite(PB7PIN,LOW);
  digitalWrite(FLGPIN,LOW);

// 2022. 2. 4 MZ-1200対策
  delay(1500);

  sdinit();

  // カレントディレクトリ = "/"
  strcpy(cwd_name, "/");
  m_skip = 0;
}

//4BIT受信
byte rcv4bit(void){
//HIGHになるまでループ
  while(digitalRead(CHKPIN) != HIGH){
  }
//受信
  byte j_data = digitalRead(PA0PIN)+digitalRead(PA1PIN)*2+digitalRead(PA2PIN)*4+digitalRead(PA3PIN)*8;
//FLGをセット
  digitalWrite(FLGPIN,HIGH);
//LOWになるまでループ
  while(digitalRead(CHKPIN) == HIGH){
  }
//FLGをリセット
  digitalWrite(FLGPIN,LOW);
  return(j_data);
}

//1BYTE受信
byte rcv1byte(void){
  byte i_data = 0;
  i_data=rcv4bit()*16;
  i_data=i_data+rcv4bit();
  return(i_data);
}

//1BYTE送信
void snd1byte(byte i_data){
//下位ビットから8ビット分をセット
  digitalWrite(PB0PIN,(i_data)&0x01);
  digitalWrite(PB1PIN,(i_data>>1)&0x01);
  digitalWrite(PB2PIN,(i_data>>2)&0x01);
  digitalWrite(PB3PIN,(i_data>>3)&0x01);
  digitalWrite(PB4PIN,(i_data>>4)&0x01);
  digitalWrite(PB5PIN,(i_data>>5)&0x01);
  digitalWrite(PB6PIN,(i_data>>6)&0x01);
  digitalWrite(PB7PIN,(i_data>>7)&0x01);
  digitalWrite(FLGPIN,HIGH);
//HIGHになるまでループ
  while(digitalRead(CHKPIN) != HIGH){
  }
  digitalWrite(FLGPIN,LOW);
//LOWになるまでループ
  while(digitalRead(CHKPIN) == HIGH){
  }
}

//ファイル名整形。MZT付加無し版
void delcr(char *f_name) {
  unsigned int lp1=0;
  unsigned int lp2=0;
  bool sft = false;
  while (f_name[lp2] != 0x0D && f_name[lp2] != 0x00){
    if (f_name[lp2] == 0x05){
      sft = !sft;
      lp2++;
      if (f_name[lp2] == 0x0D || f_name[lp2] == 0x00) break;
    }
    if (sft){
      f_name[lp1++] = tolower(f_name[lp2++]);
    }
    else{
      f_name[lp1++] = f_name[lp2++];
    }
  }
  f_name[lp1] = 0x00;
}

//ファイル名の最後が「.mzt」でなければ付加
void addmzt(char *f_name){
  unsigned int lp1=0;
  unsigned int lp2=0;
  bool sft = false;
  while (f_name[lp2] != 0x0D && f_name[lp2] != 0x00){
    if (f_name[lp2] == 0x05){
      sft = !sft;
      lp2++;
      if (f_name[lp2] == 0x0D || f_name[lp2] == 0x00) break;
    }
    if (sft){
      f_name[lp1++] = tolower(f_name[lp2++]);
    }
    else{
      f_name[lp1++] = f_name[lp2++];
    }
  }
  if (lp1 < 4 ||
      f_name[lp1-4]!='.' ||
    ( f_name[lp1-3]!='M' &&
      f_name[lp1-3]!='m' ) ||
    ( f_name[lp1-2]!='Z' &&
      f_name[lp1-2]!='z' ) ||
    ( f_name[lp1-1]!='T' &&
      f_name[lp1-1]!='t' &&
      f_name[lp1-1]!='F' &&   // MZFも良い
      f_name[lp1-1]!='f' ) ){
         f_name[lp1++] = '.';
         f_name[lp1++] = 'm';
         f_name[lp1++] = 'z';
         f_name[lp1++] = 't';
  }
  f_name[lp1] = 0x00;
}

// ファイル名が空ならファイル名に "(no name)"をセット
void chk_noname(char *name)
{
  if (name[0] == 0x0D || name[0] == 0) {
    strcpy(name, "(no name)");
  }
}


//C文字列をMZへ送信
void sendstr2MZ(char *s)
{
  unsigned int lp1;
  while (s[lp1] != 0x00){
    snd1byte(toupper(s[lp1]));
    lp1++;
  }
}

// chdirに対応したパス名作成 -> s_data
char *mkpath(char *s)
{
  strcpy(s_data, &cwd_name[1]);
  strcat(s_data, "/");
  strcat(s_data, s);
  return s_data;
}

// カレントディレクトリのn番目のファイル名をnameにセット
void dir_get(char *name, unsigned int n)
{
  File file = SD.open( cwd_name );
  if (! file) {
    sdinit();
    // ディレクトリオープンできないので、カレントディレクトリ = "/"とする。
    strcpy(cwd_name, "/");
    strcpy(name, ":");  // エラーになるファイル名
    return;
  }
  File entry;
  do {
    entry =  file.openNextFile();
    if (entry){
      entry.getName(name, NAME_MAX);
    }
    else {
      strcpy(name, ":");  // エラーになるファイル名
      break;
    }
  } while (n--);
  file.close();
  return;
}  

//SDカードにSAVE
void f_save(byte cmd){
char p_name[20];
char filetype[1];

m_skip = 0;  //連続ロードモードフラグのクリア

//file type
  filetype[0] = 0x01;
  if (cmd == 0xa0){
    filetype[0] = rcv1byte();
  }
//保存ファイルネーム取得
  for (unsigned int lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++){
    f_name[lp1] = rcv1byte();
  }
  // ファイル名が空ならファイル名に "(no name)"をセット
  chk_noname(f_name);
  addmzt(f_name);
//プログラムネーム取得
  for (unsigned int lp1 = 0, d, e = 0; lp1 < 17; lp1++){
    d = rcv1byte();
    if (d == 0x0D) e = 1;   // 0DH以降は0DHでパディングする
    if (e) d = 0x0D;
    p_name[lp1] = d;
  }
  p_name[16] =0x0D;
//以下若干リファクタリング
//スタートアドレス取得
  byte s_adrs1[2]; 
  s_adrs1[0] = rcv1byte();
  s_adrs1[1] = rcv1byte();
//エンドアドレス取得
  byte e_adrs1[2];
  e_adrs1[0] = rcv1byte();
  e_adrs1[1] = rcv1byte();
//実行アドレス取得
  byte g_adrs1[2];
  g_adrs1[0] = rcv1byte();
  g_adrs1[1] = rcv1byte();
//ファイルサイズ算出
  unsigned int f_length = (e_adrs1[1]*256 + e_adrs1[0]) - (s_adrs1[1]*256 + s_adrs1[0]) + 1;
  byte f_length1[2];
  f_length1[0] = f_length % 256;
  f_length1[1] = f_length / 256;
//ファイルが存在すればdelete
  if (SD.exists(mkpath(f_name)) == true){
    SD.remove(mkpath(f_name));
  }
//ファイルオープン
  File file = SD.open( mkpath(f_name), FILE_WRITE );
  if( true == file ){
//状態コード送信(OK)
    snd1byte(0x00);
//ファイルタイプ      OFFSET 00h
    file.write(filetype,1);
//プログラムネーム    OFFSET 01h～11h 
    file.write(p_name,17);  // MZ側から00Hを含むデータが来ると誤動作するので長さをちゃんと指定する。以下同様。
//ファイルサイズ      OFFSET 12h～13h
    file.write(f_length1,2);
//スタートアドレス    OFFSET 14h～15h
    file.write(s_adrs1,2);
//実行アドレス        OFFSET 16h～17h
    file.write(g_adrs1,2);
// 18h～7Fhまで00埋め
    byte padding[1] = {0x00};
    for (unsigned int lp1 = 0x18; lp1 < 0x80; lp1++){
      file.write(padding, 1);
    }
//実データ
    long lp1 = 0;
    while (lp1 < f_length){
      int i=0;
      while(i < 256 && lp1 < f_length){
        s_data[i]=rcv1byte();
        i++;
        lp1++;
      }
      file.write(s_data,i);
    }
    file.close();
  } else {
//状態コード送信(FILE NOT FOUND ERROR)
    snd1byte(0xf1);
    sdinit();
  }
}

//SDカードから読込
void f_load(byte cmd){
//ファイルネーム取得
  for (unsigned int lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++){
    f_name[lp1] = rcv1byte();
  }
  //連続ロードモードか?
  if (f_name[0] != ':') {
    m_skip = 0;
  }
  else {
    dir_get(f_name, 0);   // カレントディレクトリのn番目のファイル名をf_nameにセット
    m_skip = 1;   // 次は1ファイルスキップ
  }
  addmzt(f_name);
//ファイルが存在しなければERROR
  if (SD.exists(mkpath(f_name)) == true) {
//ファイルオープン
    File file = SD.open( mkpath(f_name), FILE_READ );
    if( true == file ){
//状態コード送信(OK)
        snd1byte(0x00);
        int wk1 = 0;
        wk1 = file.read();
        //file type
        if (cmd == 0xa1){
          snd1byte(wk1);
        }
         for (unsigned int lp1 = 0;lp1 <= 16;lp1++){
          wk1 = file.read();
          snd1byte(wk1);
        }
//ファイルサイズ取得
        int f_length2 = file.read();
        int f_length1 = file.read();
        unsigned int f_length = f_length1*256+f_length2;
//スタートアドレス取得
        int s_adrs2 = file.read();
        int s_adrs1 = file.read();
        unsigned int s_adrs = s_adrs1*256+s_adrs2;
//実行アドレス取得
        int g_adrs2 = file.read();
        int g_adrs1 = file.read();
        unsigned int g_adrs = g_adrs1*256+g_adrs2;
        snd1byte(s_adrs2);
        snd1byte(s_adrs1);
        snd1byte(f_length2);
        snd1byte(f_length1);
        snd1byte(g_adrs2);
        snd1byte(g_adrs1);
        file.seek(128);
//データ送信
        for (unsigned int lp1 = 0;lp1 < f_length;lp1++){
            byte i_data = file.read();
            snd1byte(i_data);
        }
        file.close();
      } else {
//状態コード送信(ERROR)
      snd1byte(0xff); // Cannot open file
    }  
  } else {
//状態コード送信(FILE NOT FOUND ERROR)
    snd1byte(0xf1);
    sdinit();
  }
}

//ASTART 指定されたファイルをファイル名「0000.mzt」としてコピー
void astart(void){
char w_name[]="0000.mzt";

  m_skip = 0;  //連続ロードモードフラグのクリア

//ファイルネーム取得
  for (unsigned int lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++){
    f_name[lp1] = rcv1byte();
  }
  addmzt(f_name);
//ファイルが存在しなければERROR
  if (SD.exists(mkpath(f_name)) == true){
//0000.mztが存在すればdelete
    if (SD.exists(mkpath(w_name)) == true){
      SD.remove(mkpath(w_name));
    }
//ファイルオープン
    File file_r = SD.open( mkpath(f_name), FILE_READ );
    File file_w = SD.open( mkpath(w_name), FILE_WRITE );
      if( true == file_r ){
//実データ
        unsigned int f_length = file_r.size();
        long lp1 = 0;
        while (lp1 <= f_length-1){
          int i=0;
          while(i<=255 && lp1<=f_length-1){
            s_data[i]=file_r.read();
            i++;
            lp1++;
          }
          file_w.write(s_data,i);
        }
        file_w.close();
        file_r.close();
//状態コード送信(OK)
        snd1byte(0x00);
      } else {
//状態コード送信(FILE NOT FOUND ERROR)
      snd1byte(0xf1);
      sdinit();
   }
  } else {
//状態コード送信(FILE NOT FOUND ERROR)
    snd1byte(0xf1);
    sdinit();
  }  
}

// SD-CARDのFILELIST
void dirlist(byte cmd){
  m_skip = 0;  //連続ロードモードフラグのクリア

//比較文字列取得 NAME_MAX_MZ+1文字まで
  for (unsigned int lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++){
    c_name[lp1] = rcv1byte();
//  Serial.print(c_name[lp1],HEX);
//  Serial.println("");
  }
  c_name[NAME_MAX_MZ]=0x00;
  delcr(c_name);
//
  //chdir に対応する
  File file = SD.open( cwd_name );
  if (! file) {
    //処理終了指示
    snd1byte(0xff);
    snd1byte(0x00);
    sdinit();
    // ディレクトリオープンできないので、カレントディレクトリ = "/"とする。
    strcpy(cwd_name, "/");
    return;
  }

  File entry =  file.openNextFile();
  int cntl2 = 0;
  unsigned int br_chk =0;
  int page = 1;
//全件出力の場合には20件出力したところで一時停止、キー入力により継続、打ち切りを選択
  while (br_chk == 0) {
    if(entry){
      entry.getName(f_name,NAME_MAX);
      unsigned int lp1=0;
//一件送信
//比較文字列でファイルネームを先頭10文字まで比較して一致するものだけを出力
      if (f_match(f_name,c_name)) {
        if (cmd == 0xa3) {
          // ディレクトリどうかのフラグを行頭に送信
          // 真面目にやると遅いので、拡張子があるかどうかで振り分け
          if (NULL == strchr(f_name,'.')) {
            snd1byte('D');
          }
          else {
            snd1byte('F');
          }
        }
        while (lp1<=NAME_MAX && f_name[lp1]!=0x00){
          snd1byte(toupper(f_name[lp1]));
          lp1++;
        }
        snd1byte(0x0D);
        snd1byte(0x00);
        cntl2++;
      }
    }
    if (!entry || cntl2 > 19){
//継続・打ち切り選択指示要求
      snd1byte(0xfe);

//選択指示受信(0:継続 B:前ページ 以外:打ち切り)
      br_chk = rcv1byte();
//前ページ処理
      if (br_chk==0x42){
//先頭ファイルへ
        file.rewindDirectory();
//entry値更新
        entry =  file.openNextFile();
//もう一度先頭ファイルへ
        file.rewindDirectory();
        if(page <= 2){
//現在ページが1ページ又は2ページなら1ページ目に戻る処理
          page = 0;
        } else {
//現在ページが3ページ以降なら前々ページまでのファイルを読み飛ばす
          page = page -2;
          cntl2=0;
          while(cntl2 < page*20){
            entry =  file.openNextFile();
            if (f_match(f_name,c_name)){
              cntl2++;
            }
          }
        }
        br_chk=0;
      }
      page++;
      cntl2 = 0;
    }
//ファイルがまだあるなら次読み込み、なければ打ち切り指示
    if (entry){
      entry =  file.openNextFile();
    }else{
      br_chk=1;
    }
//FDLの結果が20件未満なら継続指示要求せずにそのまま終了
    if (!entry && cntl2 < 20 && page ==1){
      break;
    }
  }
//処理終了指示
  snd1byte(0xff);
  snd1byte(0x00);
  file.close();
}

//f_nameとc_nameをc_nameに0x00が出るまで比較
//FILENAME COMPARE
boolean f_match(char *f_name,char *c_name){
  boolean flg1 = true;
  size_t lc = strlen(c_name);
  if (lc > 0) {
    flg1 = (0 == strncasecmp(f_name, c_name, lc));
  }
  return flg1;
}

//FILE DELETE
void f_del(void){
  unsigned int lp1;
  bool isdir = false;

//ファイルネーム取得
  for (lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++){
    f_name[lp1] = rcv1byte();
  }
  //そのままのファイル名でまずrmdir処理か判定するため、ディレクトリ文字列整形
  delcr(f_name);

  //ディレクトリがあるか調べる
  if (SD.exists(mkpath(f_name))) {
    File file = SD.open(s_data, FILE_READ);
    if (file) {
      if (file.isDir()) {
        isdir = true;
      }
      file.close();
    }
  }
  else {
    //ディレクトリがないので.mztとしてファイル扱い
    addmzt(f_name);
  }

//ファイルが存在しなければERROR
  if (SD.exists(mkpath(f_name)) == true){
//状態コード送信(OK)
    snd1byte(0x00);

//処理選択を受信(0:継続してDELETE 0以外:CANCEL)
    if (rcv1byte() == 0x00){
      if (isdir) {
        if (SD.rmdir(mkpath(f_name))) {
          //状態コード送信(OK)
          snd1byte(0x00);
        }
        else {
          //状態コード送信(FILE EXISTS ERROR)
          snd1byte(0xf3);
        }
      }
      else {
        if (SD.remove(mkpath(f_name))) {
          //状態コード送信(OK)
          snd1byte(0x00);
        }
        else {
          //状態コード送信(FILE NOT FOUND ERROR)
          snd1byte(0xf1);
        }
      }
    }
    else {
      //状態コード送信(Cancel)
      snd1byte(0x01);
    }
  }
  else {
    //状態コード送信(FILE NOT FOUND ERROR)
    snd1byte(0xf1);
  }
}

//FILE/DIR RENAME
void f_ren(void){
  bool isdir = false;
  int  isdir2 = 0;

  m_skip = 0;  //連続ロードモードフラグのクリア

  //現ファイルネーム取得
  for (unsigned int lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++){
    f_name[lp1] = rcv1byte();
  }
  //そのままのファイル名でまずrendir処理か判定するため、ディレクトリ文字列整形
  delcr(f_name);
  mkpath(f_name);

  //指定した名前のディレクトリがあるか調べる
  if(SD.exists(s_data)) {
    File file = SD.open(s_data, FILE_READ);
    if (file) {
      if (file.isDir()) {
        isdir = true;
      }
      file.close();
    }
  }
  else {
    //ディレクトリがないので.mztとしてファイル扱い
    addmzt(f_name);
  }

//ファイルが存在しなければERROR
  if (SD.exists(mkpath(f_name)) == true) {
//状態コード送信(OK)
    snd1byte(0x00);

//新ファイルネーム取得
    for (unsigned int lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++){
      new_name[lp1] = rcv1byte();
    }
    // ファイル名が空ならファイル名に "(no name)"をセット
    chk_noname(new_name);
    delcr(new_name);
//状態コード送信(OK)
    snd1byte(0x00);

    // 絶対パスの作成
    if (byte ret = mk_abs_path(s_data, new_name) != 0x00) {
      //状態コード送信(ERROR)
      snd1byte(ret);
      return;
    }

//リネーム先が存在するディレクトリかどうか調べる
    if (strcmp(s_data, "/")==0) {
      isdir2 = 2;   // root
    }
    else if (SD.exists(s_data)) {
      File file = SD.open(s_data, FILE_READ);
      if (file) {
        if (file.isDir()) {
          isdir2 = 1;
        }
        file.close();
      }
    }

    // リネーム先のファイル名の作成 --> c_name へ
    // リネーム先(s_data)がディレクトリ名だった場合、
    if (isdir2) {
      // 新ファイル名は s_data / f_name
      if (isdir2 != 2) strcat(s_data, "/");   // non-root dir のときのみ / 付加
      strcat(s_data, f_name);
      if (strlen(s_data) > PATHMAX) {
        //状態コード送信(FILE NOT FOUND ERROR)
        snd1byte(0xf1);
        return;
      }
      strcpy(c_name, s_data);
    }
    else {
      // 新ファイル名の作成
      if (!isdir) {
        //元が通常ファイルだった場合、new_nameの末尾は*.mztとする
        addmzt(new_name);
      }
      //改めて絶対パスを生成
      if (byte ret = mk_abs_path(s_data, new_name) != 0x00) {
        //状態コード送信(ERROR)
        snd1byte(ret);
        return;
      }
      strcpy(c_name, s_data);
    }

    // SD.rename()を使う
    if (SD.rename(mkpath(f_name), c_name)) {
      //状態コード送信(OK)
      snd1byte(0x00);
    }
    else {
      //状態コード送信(FF)
      snd1byte(0xff); // Rename Failed
    }

  }
  else {
//状態コード送信(FILE NOT FOUND ERROR)
    snd1byte(0xf1);
  }
}

//FILE DUMP
void f_dump(void){
  unsigned int br_chk =0;
    m_skip = 0;  //連続ロードモードフラグのクリア

  //ファイルネーム取得
  for (unsigned int lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++){
    f_name[lp1] = rcv1byte();
  }
  addmzt(f_name);

//ファイルが存在しなければERROR
  if (SD.exists(mkpath(f_name)) == true){
//状態コード送信(OK)
    snd1byte(0x00);

//ファイルオープン
    File file = SD.open( mkpath(f_name), FILE_READ );
      if( true == file ){
//実データ送信(1画面:128Byte)
        unsigned int f_length = file.size();
        long lp1 = 0;
        while (lp1 <= f_length-1){
//画面先頭ADRSを送信
          snd1byte(lp1 % 256);
          snd1byte(lp1 / 256);
          int i=0;
//実データを送信
          while(i<128 && lp1<=f_length-1){
            snd1byte(file.read());
            i++;
            lp1++;
          }
//FILE ENDが128Byteに満たなかったら残りByteに0x00を送信
          while(i<128){
            snd1byte(0x00);
            i++;
          }
//指示待ち
          br_chk=rcv1byte();
//BREAKならポインタをFILE ENDとする
          if (br_chk==0xff){
            lp1 = f_length; 
          }
//B:BACKを受信したらポインタを256Byte戻す。先頭画面なら0に戻してもう一度先頭画面表示
          if (br_chk==0x42){
            if(lp1>255){
              if (lp1 % 128 == 0){
                lp1 = lp1 - 256;
              } else {
                lp1 = lp1 - 128 - (lp1 % 128);
              }
              file.seek(lp1);
            } else{
              lp1 = 0;
              file.seek(0);
            }
          }
        }
//FILE ENDもしくはBREAKならADRSに終了コード0FFFFHを送信
        if (lp1 > f_length-1){
          snd1byte(0xff);
          snd1byte(0xff);
        };
        file.close();
//状態コード送信(OK)
        snd1byte(0x00);
      } else {
//状態コード送信(FILE NOT FOUND ERROR)
      snd1byte(0xf1);
    }
  }else{
//状態コード送信(FILE NOT FOUND ERROR)
        snd1byte(0xf1);
  }
}

//FILE COPY
void f_copy(void){
  int isdir2 = 0;

  m_skip = 0;  //連続ロードモードフラグのクリア

  //現ファイルネーム取得
  for (unsigned int lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++){
    f_name[lp1] = rcv1byte();
  }
  addmzt(f_name);

//ファイルが存在しなければERROR
  if (SD.exists(mkpath(f_name)) == true) {
//状態コード送信(OK)
    snd1byte(0x00);

//新ファイルネーム取得
    for (unsigned int lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++){
      new_name[lp1] = rcv1byte();
    }
    // ファイル名が空ならファイル名に "(no name)"をセット
    chk_noname(new_name);
    delcr(new_name);
//状態コード送信(OK)
    snd1byte(0x00);

    // 絶対パスの作成
    if (byte ret = mk_abs_path(s_data, new_name) != 0x00) {
      //状態コード送信(ERROR)
      snd1byte(ret);
      return;
    }

//コピー先が存在するディレクトリかどうか調べる
    if (strcmp(s_data, "/")==0) {
      isdir2 = 2;   // root
    }
    else if (SD.exists(s_data)) {
      File file = SD.open(s_data, FILE_READ);
      if (file) {
        if (file.isDir()) {
          isdir2 = 1;
        }
        file.close();
      }
    }

    // コピー先のファイル名の作成 --> c_name へ
    // コピー先(s_data)がディレクトリ名だった場合、
    if (isdir2) {
      // 新ファイル名は s_data / f_name
      if (isdir2 != 2) strcat(s_data, "/");   // non-root dir のときのみ / 付加
      strcat(s_data, f_name);
      if (strlen(s_data) > PATHMAX) {
        //状態コード送信(FILE NOT FOUND ERROR)
        snd1byte(0xf1);
        return;
      }
      strcpy(c_name, s_data);
    }
    else {
      //new_nameの末尾は*.mztとする
      addmzt(new_name);
      //改めて絶対パスを生成
      if (byte ret = mk_abs_path(s_data, new_name) != 0x00) {
        //状態コード送信(ERROR)
        snd1byte(ret);
        return;
      }
      strcpy(c_name, s_data);
    }

//新ファイルネームと同じファイルネームが存在すればERROR
    if (SD.exists(c_name) == false) {
//ファイルオープン
      File file_r = SD.open( mkpath(f_name), FILE_READ );
      File file_w = SD.open( c_name, FILE_WRITE );

      if( true == file_r ) {
//実データコピー
        unsigned int f_length = file_r.size();
        long lp1 = 0;
        while (lp1 <= f_length-1){
          int i=0;
          while(i<=255 && lp1<=f_length-1){
            s_data[i]=file_r.read();
            i++;
            lp1++;
          }
          file_w.write(s_data,i);
        }
        file_w.close();
        file_r.close();
//状態コード送信(OK)
        snd1byte(0x00);
      }
      else {
        // if( true != file_r )
//状態コード送信(FILE NOT FOUND ERROR)
        snd1byte(0xf1);
      }
    }
    else {
      // if (SD.exists(mkpath(new_name)) != false)
//状態コード送信(FILE EXISTS ERROR)
        snd1byte(0xf3);
    }
  }
  else {
    // if (SD.exists(mkpath(f_name)) != true)
//状態コード送信(FILE NOT FOUND ERROR)
      snd1byte(0xf1);
  }
}

//91hで0436H MONITOR ライト インフォメーション代替処理
void mon_whead(void){
char m_info[128];

  m_skip = 0;  //連続ロードモードフラグのクリア

//インフォメーションブロック受信
  for (unsigned int lp1 = 0;lp1 < 128;lp1++){
    m_info[lp1] = rcv1byte();
  }
//ファイルネーム取り出し
  m_info[0x11] = 0x0d;  // エンドマークの保証
  for (unsigned int lp1 = 0; lp1 < 17; lp1++){  // エンドマーク込みで17バイト取り出し
    m_name[lp1] = m_info[lp1+1];
  }
  // ファイル名が空ならファイル名に "(no name)"をセット
  chk_noname(m_name);
//DOSファイルネーム用に.MZTを付加
  addmzt(m_name);
//ファイルが存在すればdelete
  if (SD.exists(mkpath(m_name)) == true){
    SD.remove(s_data);
  }
//ファイルオープン
  File file = SD.open( s_data, FILE_WRITE );
  if( true == file ) {
//状態コード送信(OK)
    snd1byte(0x00);
//インフォメーションブロックwrite
    file.write(m_info, 128);
    file.close();
  } else {
//状態コード送信(FILE NOT FOUND ERROR)
    snd1byte(0xf1);
  }
}

//92hで0475H MONITOR ライト データ代替処理
void mon_wdata(void){
//ファイルサイズ取得
  int f_length1 = rcv1byte();
  int f_length2 = rcv1byte();

//ファイルサイズ算出
  unsigned int f_length = f_length1+f_length2*256;
//ファイルオープン
  File file = SD.open( mkpath(m_name), FILE_WRITE );
  if( true == file ){
//状態コード送信(OK)
    snd1byte(0x00);
//実データ
    long lp1 = 0;
    while (lp1 <= f_length-1){
      int i=0;
      while(i<=255 && lp1<=f_length-1){
        s_data[i]=rcv1byte();
        i++;
        lp1++;
      }
      file.write(s_data,i);
    }
    file.close();
  } else {
//状態コード送信(FILE NOT FOUND ERROR)
    snd1byte(0xf1);
  }
}

//04D8H MONITOR リード インフォメーション代替処理
void mon_lhead(void){
//リード データ POINTクリア
  m_lop=128;
//ファイルネーム取得
  for (unsigned int lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++){
    m_name[lp1] = rcv1byte();
  }
  // ファイル名が空なら連続ロードモードかチェック
  if ((m_name[0] == 0 || m_name[0] == 0x0D) && (m_skip > 0)) {
    //連続ロードモード: 次のファイル名をm_nameにセット
    dir_get(m_name, m_skip++);   // カレントディレクトリのm_skip++番目のファイル名をm_nameにセット
  }
  addmzt(m_name);
//ファイルが存在しなければERROR
  if (SD.exists(mkpath(m_name)) == true){
    snd1byte(0x00);
//ファイルオープン
    File file = SD.open( s_data, FILE_READ );
    if( true == file ){
      snd1byte(0x00);
      for (unsigned int lp1 = 0;lp1 < 128;lp1++){
          byte i_data = file.read();
          snd1byte(i_data);
      }
      file.close();
      snd1byte(0x00);
    } else {
//状態コード送信(ERROR)
      snd1byte(0xff); // Cannot open file
    }  
  } else {
//状態コード送信(FILE NOT FOUND ERROR)
    snd1byte(0xf1);
  }
}

//04F8H MONITOR リード データ代替処理
void mon_ldata(void){
//ファイルが存在しなければERROR
  if (SD.exists(mkpath(m_name)) == true){
    snd1byte(0x00);
//ファイルオープン
    File file = SD.open( s_data, FILE_READ );
    if( true == file ){
      snd1byte(0x00);
      file.seek(m_lop);
//読み出しサイズ取得
      int f_length2 = rcv1byte();
      int f_length1 = rcv1byte();
      unsigned int f_length = f_length1*256+f_length2;
      for (unsigned int lp1 = 0;lp1 < f_length;lp1++){

        byte i_data = file.read();
        snd1byte(i_data);
      }
      file.close();
      m_lop=m_lop+f_length;
      snd1byte(0x00);
    } else {
//状態コード送信(ERROR)
      snd1byte(0xff); // Cannot open file
    }  
  } else {
//状態コード送信(FILE NOT FOUND ERROR)
    snd1byte(0xf1);
  }
}

//BOOT処理(MZ-2000_SD専用)
void boot(void){
  m_skip = 0;  //連続ロードモードフラグのクリア

//ファイルネーム取得
  for (unsigned int lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++){
    m_name[lp1] = rcv1byte();
  }
////  Serial.print("m_name:");
////  Serial.println(m_name);
//ファイルが存在しなければERROR
  if (SD.exists(mkpath(m_name)) == true){
    snd1byte(0x00);
//ファイルオープン
    File file = SD.open( mkpath(m_name), FILE_READ );
    if( true == file ){
      snd1byte(0x00);
//ファイルサイズ送信
      unsigned long f_length = file.size();
      unsigned int f_len1 = f_length / 256;
      unsigned int f_len2 = f_length % 256;
      snd1byte(f_len2);
      snd1byte(f_len1);
////  Serial.println(f_length,HEX);
////  Serial.println(f_len2,HEX);
////  Serial.println(f_len1,HEX);

//実データ送信
      for (unsigned long lp1 = 1;lp1 <= f_length;lp1++){
         byte i_data = file.read();
         snd1byte(i_data);
      }

    } else {
//状態コード送信(ERROR)
      snd1byte(0xff); // Cannot open file
    }
  } else {
//状態コード送信(FILE NOT FOUND ERROR)
    snd1byte(0xf1);
  }
}

//-----------------------------------------------------------------

// 絶対パス作成
// カレントディレクトリ と f_name から、絶対パスをcwd_tmpにストアする
// f_name が / から始まっていた場合は絶対パス指定とみなす
// それ以外はカレントディレクトリと f_name から絶対パスを作成
byte mk_abs_path(char *cwd_tmp, char *f_name)
{
  unsigned int lp1;
  char *p;
  size_t l1, l2;
  byte ret;

  // 状態コード初期値の設定
  ret = 0x00;  // OK

  // 仮に積み込み
  if (f_name[0] == '/') {
    // 絶対パス
    strcpy(cwd_tmp, f_name);
  }
  else {
    l1 = strlen(cwd_name);
    l2 = strlen(f_name);
    if ((l1 + l2 + NAME_MAX + 2) > PATHMAX) {
      //状態コード設定(FILE NOT FOUND ERROR)
      ret = 0xf1;
    }
    else {
      // とりあえず連結
      strcpy(cwd_tmp,cwd_name);
      strcat(cwd_tmp,"/");
      strcat(cwd_tmp,f_name);
      strcat(cwd_tmp,"/");
    }
  }

  // 整形する
  if (ret == 0x00) {
    // "//"は"/"に
    while (p = strstr(cwd_tmp, "//")) strcpy(p, p+1);

    // /./は"/"に /ABC/./DEF -> /ABC/DEF (2文字詰め)
    while (p = strstr(cwd_tmp, "/./")) strcpy(p, p+2);

    // /../は一つ前を取る
    // /ABC/../DEF -> /DEF
    // /../DEF     -> /DEF (ルートの上には行けない)
    while (p = strstr(cwd_tmp, "/../")) {
      *p = 0x00; // /../ の所で切る
      char *q = strrchr(cwd_tmp, '/'); // その1つ前の / を探して
      if (!q) q = cwd_tmp;
      strcpy(q, p+3); // "/../"の後ろの "/"を1つ前の / に重ねる
    }
  
    // 最後の / を取る
    l1 = strlen(cwd_tmp);
    while (l1 > 1 && cwd_tmp[l1 - 1] == '/') {
      cwd_tmp[--l1] = 0x00;
    }

    if (cwd_tmp[0] == 0x00) {
      // 空ならルートへ
      strcpy(cwd_tmp, "/");
    }
  }
  return ret;
}

//CHDIR
void f_chdir(void)
{
  unsigned int lp1;
  char *cwd_tmp = s_data;
  byte ret;

  m_skip = 0;  //連続ロードモードフラグのクリア

  //ディレクトリ名取得
  for (lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++) {
    f_name[lp1] = rcv1byte();
  }
  // 受け取り完了(OK)
    snd1byte(0x00);

  //ディレクトリ文字列整形
  delcr(f_name);

  ret = mk_abs_path(cwd_tmp, f_name);

  if (ret == 0x00) {
    // 実際にchdirはしない: ヒープ足りなくてハングアップするから
    // 代わりに、chdir先の存在をチェックをする
    File file;
    bool ok = (strcmp(cwd_tmp, "/")==0);
    if (!ok && SD.exists(cwd_tmp)) {
      file = SD.open(cwd_tmp, FILE_READ);
      if (file) {
        ok = file.isDir();
        file.close();
      }
    }
    if (ok) {
      strcpy(cwd_name, cwd_tmp);
    }
    else {
      //状態コード送信(FILE NOT FOUND ERROR)
      ret = 0xf1;
    }
  }
// 成功しても失敗してもカレントディレクトリを送る
  sendstr2MZ("CURRENT DIRECTORY IS\r");
  sendstr2MZ(cwd_name);
  sendstr2MZ("\r");
  snd1byte(0x00);

//状態コード送信(OK / FILE NOT FOUND ERROR)
  snd1byte(ret);
}

//MKDIR
void f_mkdir(void)
{
  unsigned int lp1;
  char *cwd_tmp = s_data;
  byte ret;

  m_skip = 0;  //連続ロードモードフラグのクリア

  //ディレクトリ名取得
  for (lp1 = 0;lp1 <= NAME_MAX_MZ;lp1++) {
    f_name[lp1] = rcv1byte();
  }
  // ファイル名が空ならファイル名に "(no name)"をセット
  chk_noname(f_name);

  // 受け取り完了(OK)
  snd1byte(0x00);

  //ディレクトリ文字列整形
  delcr(f_name);

  ret = mk_abs_path(cwd_tmp, f_name);
  sendstr2MZ("ABS.DIR IS\r");
  sendstr2MZ(cwd_tmp);
  sendstr2MZ("\r");
  if (ret == 0x00) {
    // mkdir先の存在をチェックをする
    File file;
    if (strcmp(cwd_tmp, "/")==0 || SD.exists(cwd_tmp)) {
      //状態コード送信(FILE EXISTS ERROR)
      ret = 0xf3;
      sendstr2MZ("ERROR: ");
    }
    else {
      if (!SD.mkdir(cwd_tmp)) {
        //状態コード送信(FILE NOT FOUND ERROR)
        ret = 0xf1;   // error
        sendstr2MZ("MKDIR ERROR\r"); // DIR CREATION ERR
      }
      sendstr2MZ("MKDIR OK\r");
    }
  }
  // 文字列エンド
  snd1byte(0x00);

//状態コード送信
  snd1byte(ret);
}

//-----------------------------------------------------------------

void loop()
{
  digitalWrite(PB0PIN,LOW);
  digitalWrite(PB1PIN,LOW);
  digitalWrite(PB2PIN,LOW);
  digitalWrite(PB3PIN,LOW);
  digitalWrite(PB4PIN,LOW);
  digitalWrite(PB5PIN,LOW);
  digitalWrite(PB6PIN,LOW);
  digitalWrite(PB7PIN,LOW);
  digitalWrite(FLGPIN,LOW);
//コマンド取得待ち
////  Serial.print("cmd:");
  byte cmd = rcv1byte();
////  Serial.println(cmd,HEX);
  if (eflg == false){
    switch(cmd) {
//80hでSDカードにsave
      case 0x80:
      case 0xa0:  //[kaokun]type有り
////  Serial.println("SAVE START");
//状態コード送信(OK)
        snd1byte(0x00);
        f_save(cmd);
        break;
//81hでSDカードからload
      case 0x81:
      case 0xa1:  //[kaokun]type有り
////  Serial.println("LOAD START");
//状態コード送信(OK)
        snd1byte(0x00);
        f_load(cmd);
        break;
//82hで指定ファイルを0000.mztとしてリネームコピー
      case 0x82:
////  Serial.println("ASTART START");
//状態コード送信(OK)
        snd1byte(0x00);
        astart();
        break;
//83hでファイルリスト出力
      case 0x83:
      case 0xa3:
////  Serial.println("FILE LIST START");
//状態コード送信(OK)
        snd1byte(0x00);
        dirlist(cmd);
        break;
//84hでファイルDelete
      case 0x84:
////  Serial.println("FILE Delete START");
//状態コード送信(OK)
        snd1byte(0x00);
        f_del();
        break;
//85hでファイルリネーム
      case 0x85:
////  Serial.println("FILE Rename START");
//状態コード送信(OK)
        snd1byte(0x00);
        f_ren();
        break;
      case 0x86:  
//86hでファイルダンプ
////  Serial.println("FILE Dump START");
//状態コード送信(OK)
        snd1byte(0x00);
        f_dump();
        break;
      case 0x87:  
//87hでファイルコピー
////  Serial.println("FILE Copy START");
//状態コード送信(OK)
        snd1byte(0x00);
        f_copy();
        break;
      case 0x91:
//91hで0436H MONITOR ライト インフォメーション代替処理
////  Serial.println("0436H START");
//状態コード送信(OK)
        snd1byte(0x00);
        mon_whead();
        break;
//92hで0475H MONITOR ライト データ代替処理
      case 0x92:
////  Serial.println("0475H START");
//状態コード送信(OK)
        snd1byte(0x00);
        mon_wdata();
        break;
//93hで04D8H MONITOR リード インフォメーション代替処理
      case 0x93:
////  Serial.println("04D8H START");
//状態コード送信(OK)
        snd1byte(0x00);
        mon_lhead();
        break;
//94hで04F8H MONITOR リード データ代替処理
      case 0x94:
////  Serial.println("04F8H START");
//状態コード送信(OK)
        snd1byte(0x00);
        mon_ldata();
        break;
//95hでBOOT LOAD(MZ-2000_SD専用)
      case 0x95:
////  Serial.println("BOOT LOAD START");
//状態コード送信(OK)
        snd1byte(0x00);
        boot();
        break;
//0A6hでCHDIR
      case 0xA6:
////  Serial.println("CHDIR START");
//状態コード送信(OK)
        snd1byte(0x00);
        f_chdir();
        break;
//0A7hでMKDIR
      case 0xA7:
////  Serial.println("MKDIR START");
//状態コード送信(OK)
        snd1byte(0x00);
        f_mkdir();
        break;

      default:
//状態コード送信(CMD ERROR)
        snd1byte(0xf4);
    }
  } else {
//状態コード送信(SD-CARD INIT ERROR)
    snd1byte(0xf0);
  }
}