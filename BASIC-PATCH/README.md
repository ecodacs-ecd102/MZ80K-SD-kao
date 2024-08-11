# MZ-700 S-BASIC 1Z-007B, 1Z-013B, HuBASICをMZ-80K_SD対応にするパッチ

　MZ-700のS-BASIC,Hu-BASICはモニタROMをコールせず、RAM上に独自のIOCSを持っていて、かつ、$D000～$FFFFをRAMバンクに切り替えてBASICのエリアとしているため、$F000からのROM内ルーチンが使えません。
　また、IOCSそのものも、ROM内の物とはエントリや仕様が微妙に異なるため、単にバンクを切り戻してROMをコールする、といった手法が使えません。

　従って、BASICが抱え込むIOCS部分そのものにパッチを当てて、直接MZ-80K_SDを制御するようにパッチを当てる必要がありました。

  BASIC の LOAD コマンドで以下が使えます。

  - LOAD"*L : DIRLIST 後ろにファイル名先頭を指定
  - LOAD"*M : MKDIR 後ろにディレクトリ名を指定
  - LOAD"*C : CHDIR 後ろにディレクトリ名を指定
 
 