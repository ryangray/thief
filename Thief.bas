    1 REM \::THIEF\::
    2 REM Ryan Gray 18 April 1990
    4 SOUND 0,0;1,10;2,10;3,10;4,20;5,10;6,0;7,56;8,16;9,16;10,16;12,30;13,14
    5 GO SUB 8500
    6 GO TO 508
  400 REM MOVES
  409 REM left
  410 LET c=c-1: LET d=1: IF m$="\n" THEN LET m$="\b"
  411 IF m$<>"\b" THEN LET m$="\l"
  412 PRINT AT r,c-1;m$;a$(xr,xc)
  413 RETURN 
  419 REM right
  420 LET c=c+1: LET d=2: IF m$="\n" THEN LET m$="\b"
  421 IF m$<>"\b" THEN LET m$="\i"
  422 PRINT AT xr,xc-1;a$(xr,xc);m$
  423 RETURN 
  429 REM up
  430 IF m$="\n" THEN LET m$="\b"
  431 LET r=r-1: PRINT AT xr,xc-1;a$(xr,xc);AT r,c-1;m$
  432 RETURN 
  439 REM down
  440 IF m$="\n" THEN LET m$="\b"
  441 LET r=r+1: PRINT AT xr,xc-1;a$(xr,xc);AT r,c-1;m$
  442 RETURN 
  500 REM autorun here
  501 POKE 23658,0
  506 SOUND 0,0;1,10;2,10;3,10;4,20;5,10;6,0;7,56;8,16;9,16;10,16;12,30;13,14
  507 GO TO 9000
  508 PRINT AT 14,8;"\ :P\: lay game   ";AT 16,8;"\ :C\: reate levels"
  509 PRINT AT 12,9;" - CHOOSE -  "
  510 SOUND 6,31;7,28;10,12
  511 FOR b=13 TO 0 STEP -1: SOUND 10,b
  512 FOR a=31 TO 0 STEP -1: SOUND 6,a
  513 LET k$=INKEY$
  514 IF k$="p" THEN SOUND 13,0;7,63;8,0;9,0;10,0: GO TO 900
  515 IF k$="c" THEN SOUND 13,0;7,63;8,0;9,0;10,0: GO TO 6000
  520 NEXT a: NEXT b
  525 SOUND 7,56;10,16;6,0
  530 LET k$=INKEY$
  531 IF k$="p" THEN GO TO 900
  532 IF k$="c" THEN SOUND 13,0;7,63;8,0;9,0;10,0: GO TO 6000
  550 GO TO 530
  900 CLS : PRINT AT 10,0;"Load the first level from tape  by starting the cassette player"
  901 PRINT AT 13,14; FLASH 1;"NOW"
  902 BORDER 7
  905 DIM a$(21,32)
  910 LOAD "" DATA A$()
  912 CLS 
  915 PRINT AT 10,10; FLASH 1;"STOP THE TAPE"
  920 LET q=3: LET sc=0: LET l=1
  930 GO TO 2039
  999 REM MAIN LOOP
 1000 DIM b$(21,32): FOR z=1 TO 21: LET b$(z)=a$(z): BEEP .001,z+14: NEXT z
 1001 GO SUB 5000: GO TO 1002: FOR z=1 TO 21: LET a$(z)=b$(z): PRINT AT z,0;b$(z): BEEP .001,21-z+14: NEXT z
 1002 LET ti=20*CODE a$(22,3)
 1003 POKE 23672,0: POKE 23673,0
 1004 SOUND 0,0;1,10;2,2;3,10;4,4;5,10;6,0;7,56;8,16;9,16;10,16;11,24;12,ti;13,14
 1005 PRINT AT 0,23; INK 1;"\o"; INK 3;"\p"; INK 2;"\q"; INK 4;"\r"; INK 5;"\s"
 1006 LET r=CODE a$(22,1): LET c=CODE a$(22,2): LET m=0: LET d=1: PRINT AT 0,0;"SCORE:";sc;AT 0,28;ti;AT 0,10;"LEVEL:";l;AT 0,18;"\a\a\a"( TO q)
 1007 LET xr=r: LET xc=c: LET xd=d: LET a$(r,c)=" "
 1020 LET m$="\m\a\l\i"(d): LET n$=a$(r+1,c)
 1021 IF a$(r,c)="\k" OR a$(r,c)="\h" AND (n$=" " OR n$="\k" OR n$="\h" OR n$="\j") THEN LET m$="\n"
 1023 LET te=INT (PEEK 23672/64)+4*PEEK 23673
 1024 PRINT AT r,c-1;m$;AT 0,28;ti-te;" "
 1025 SOUND 12,ti-te
 1026 IF te=ti THEN GO TO 7000
 1030 IF a$(r+1,c)<>"\k" AND a$(r+1,c)<>" " AND a$(r+1,c)<>"\f" AND a$(r+1,c)<>"\j" THEN GO TO 1040
 1031 IF a$(r,c)="\k" OR a$(r,c)="\h" THEN GO TO 1040
 1032 LET xr=r: LET xc=c: GO SUB 440
 1033 IF a$(r,c)="\j" THEN GO TO 1061
 1034 GO TO 1030
 1040 IF a$(r,c)="\k" OR a$(r,c)="\h" THEN LET m$="\n"
 1041 LET k$=INKEY$
 1050 LET xr=r: LET xc=c: LET d=xd-(2 AND xd>2)
 1051 IF k$="z" THEN IF a$(r+1,c)=" " OR a$(r+1,c)="\h" OR a$(r+1,c)="\j" OR a$(r+1,c)="\k" THEN GO SUB 440: GO TO 1066
 1052 IF k$="a" THEN IF a$(r-1,c)="\h" OR (a$(r,c)="\h" AND a$(r-1,c)<>"\::" AND a$(r-1,c)<>"\c") THEN GO SUB 430: GO TO 1066
 1053 IF c<32 AND k$="l" THEN IF a$(r,c+1)=" " OR a$(r,c+1)="\h" OR a$(r,c+1)="\j" OR a$(r,c+1)="\k" THEN GO SUB 420: GO TO 1066
 1054 IF c>1 AND k$="k" THEN IF a$(r,c-1)=" " OR a$(r,c-1)="\h" OR a$(r,c-1)="\j" OR a$(r,c-1)="\k" THEN GO SUB 410: GO TO 1066
 1061 IF k$="d" THEN GO TO 7000
 1062 IF k$="m" THEN GO TO 1080
 1063 IF k$="n" THEN GO TO 1090
 1064 IF k$="c" THEN GO TO 2100
 1065 IF k$="x" THEN GO TO 2120
 1066 IF a$(r,c)="\j" THEN LET sc=sc+10: BEEP .01,10: BEEP .04,20: LET a$(r,c)=" ": LET m=m+1: PRINT AT 0,6;sc: IF m=CODE a$(22,3) THEN GO TO 2000
 1067 LET xd=d
 1070 GO TO 1020
 1080 PRINT AT r,c-1;"\i": LET d=2: LET xd=d: IF c=32 THEN GO TO 1020
 1082 IF a$(r,c+1)<>" " AND a$(r,c+1)<>"\k" OR a$(r+1,c+1)<>"\c" THEN GO TO 1020
 1083 PRINT AT r+1,c;"\d": BEEP .01,0: PAUSE 10
 1084 PRINT AT r+1,c;"\e": BEEP .01,0: PAUSE 10
 1085 PRINT AT r+1,c;" ": BEEP .01,0: LET a$(r+1,c+1)=" "
 1086 GO TO 1020
 1090 PRINT AT r,c-1;"\l": LET d=1: LET xd=d: IF c=1 THEN GO TO 1020
 1092 IF a$(r,c-1)<>" " AND a$(r,c-1)<>"\k" OR a$(r+1,c-1)<>"\c" THEN GO TO 1020
 1093 PRINT AT r+1,c-2;"\d": BEEP .01,0: PAUSE 10
 1094 PRINT AT r+1,c-2;"\e": BEEP .01,0: PAUSE 10
 1095 PRINT AT r+1,c-2;" ": BEEP .01,0: LET a$(r+1,c-1)=" "
 1096 GO TO 1020
 2000 FOR a=20 TO 50 STEP 5: BEEP .01,a: NEXT a
 2001 SOUND 13,0
 2010 CLS 
 2020 PRINT AT 10,0;"Load the next level by starting the cassette player"
 2021 PRINT AT 12,14; FLASH 1;"NOW"
 2030 LOAD "" DATA A$()
 2035 LET l=l+1
 2036 LET sc=sc+(50-PEEK 23673)
 2037 CLS 
 2038 PRINT AT 10,10; FLASH 1;"STOP THE TAPE"
 2039 PRINT AT 12,0;"PRESS ANY KEY to start level ";l: PAUSE 0
 2040 GO TO 1000
 2100 PRINT AT r,c-1;"\i": LET d=2: LET xd=d: IF c=32 THEN GO TO 1020
 2102 IF (a$(r,c+1)=" " OR a$(r,c+1)="\k") AND a$(r+1,c+1)=" " AND b$(r+1,c+1)="\c" THEN GO TO 2104
 2103 GO TO 1020
 2105 PRINT AT r+1,c;"\e": BEEP .01,0: PAUSE 10
 2106 PRINT AT r+1,c;"\d": BEEP .01,0: PAUSE 10
 2107 PRINT AT r+1,c;"\c": BEEP .01,0: LET a$(r+1,c+1)="\c"
 2110 GO TO 1020
 2120 PRINT AT r,c-1;"\l": LET d=1: LET xd=d: IF c=1 THEN GO TO 1020
 2122 IF (a$(r,c-1)=" " OR a$(r,c-1)="\k") AND a$(r+1,c-1)=" " AND b$(r+1,c-1)="\c" THEN GO TO 2124
 2123 GO TO 1020
 2124 PRINT AT r+1,c-2;"\e": BEEP .01,0: PAUSE 10
 2125 PRINT AT r+1,c-2;"\d": BEEP .01,0: PAUSE 10
 2126 PRINT AT r+1,c-2;"\c": BEEP .01,0: LET a$(r+1,c-1)="\c"
 2130 GO TO 1020
 5000 REM Coloring
 5001 REM \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s SPECTRUM PLAY 
 5002 DIM o$(165)
 5003 REM 123456789012345678901
 5004 LET o$(146)=CHR$ 5: LET o$(149)=CHR$ 5: LET o$(151)=CHR$ 2
 5005 LET o$(153)=CHR$ 6: LET o$(154)=CHR$ 4: LET o$(163)=CHR$ 2
 5006 LET o$(164)=CHR$ 2: LET o$(32)=CHR$ 7: LET o$(143)=CHR$ 2
 5010 INK 8: PAPER 0: BORDER 0
 5012 CLS : PRINT AT 1,0;
 5020 FOR r=1 TO 21
 5022 LET a$(r)=b$(r)
 5023 BEEP .001,35-r
 5024 FOR c=1 TO 32
 5030 LET k$=b$(r,c)
 5040 PRINT INK CODE o$(CODE k$);k$;
 5050 NEXT c: NEXT r
 5090 RETURN 
 6000 REM PUT EDITOR HERE
 6010 DIM a$(22,32)
 6012 LET a$(22,1 TO 2)=CHR$ 10+CHR$ 15
 6014 CLS : PRINT #0;"WAIT..."
 6015 LET m1=CODE a$(22,1): LET m2=CODE a$(22,2): LET a$(m1,m2)="\i"
 6016 FOR a=1 TO 21: FOR b=1 TO 32: PRINT AT a,b-1;(a$(a,b) AND a$(a,b)<>"\f");("\u" AND a$(a,b)="\f"): NEXT b: NEXT a
 6018 BORDER 6
 6020 LET r=1: LET c=1
 6021 INPUT "": PRINT #0;"1\c 2\u 3\:: 4\h 5\i 6\j 7 \k  Save Get"
 6030 PRINT AT r,c-1; FLASH 1;a$(r,c)
 6040 LET k$=INKEY$
 6041 IF k$>"0" AND k$<"8" THEN GO TO 6100
 6042 IF k$=" " AND a$(r,c)<>"\i" THEN LET a$(r,c)=k$
 6043 IF k$="s" THEN GO TO 6200
 6044 IF k$="g" THEN GO TO 6400
 6045 IF k$<>"a" AND k$<>"z" AND k$<>"l" AND k$<>"k" THEN GO TO 6040
 6050 LET xr=r: LET xc=c: LET r=r+(k$="z" AND r<21)-(k$="a" AND r>1): LET c=c+(k$="l" AND c<32)-(k$="k" AND c>1)
 6060 PRINT AT xr,xc-1;a$(xr,xc)
 6061 IF a$(xr,xc)="\f" THEN PRINT AT xr,xc-1;"\u"
 6070 GO TO 6030
 6100 LET a$(r,c)=("\::" AND k$="3")+("\c" AND k$="1")+("\f" AND k$="2")+("\h" AND k$="4")+("\i" AND k$="5")+("\j" AND k$="6")+("\k" AND k$="7")
 6110 IF k$="5" THEN LET a$(m1,m2)=" ": PRINT AT m1,m2-1;" ": LET m1=r: LET m2=c: LET a$(22,1 TO 2)=CHR$ m1+CHR$ m2: LET a$(r,c)="\i"
 6120 PRINT AT r,c-1;a$(r,c)
 6130 GO TO 6030
 6200 INPUT "": PRINT #0;"Scanning level, please wait."
 6205 LET m=NOT PI
 6210 FOR a=1 TO 21: FOR b=1 TO 32: LET m=m+(a$(a,b)="\j"): NEXT b: NEXT a
 6215 LET a$(m1,m2)=" "
 6220 LET a$(22,3)=CHR$ m
 6230 INPUT "FILENAME [10 max]:";f$: IF f$="" OR LEN f$>10 THEN GO TO 6021
 6240 SAVE f$ DATA a$()
 6250 PRINT #0; FLASH 1;"STOP THE TAPE": PAUSE 120
 6260 INPUT "": INPUT "Do another level? [y/n]:";f$
 6280 IF f$="n" THEN GO TO 6300
 6290 INPUT "Clear or Modify this level:";f$
 6295 IF f$="m" OR f$="M" THEN LET a$(m1,m2)="\i": GO TO 6021
 6296 IF f$="c" OR f$="C" THEN GO TO 6010
 6297 GO TO 6290
 6300 INPUT "Play the new level? [y/n]:";f$
 6305 BORDER 7
 6310 IF f$="y" OR f$="Y" THEN CLS : GO TO 920
 6320 GO TO 900
 6400 INPUT "LOAD [$ TO abort]:";f$: IF f$="$" THEN GO TO 6021
 6410 CLS : PRINT AT 10,10;"Loading..."
 6420 LOAD f$ DATA a$()
 6430 GO TO 6014
 7000 IF q=0 THEN GO TO 7500
 7001 LET q=q-1: IF q=0 THEN GO TO 7500
 7002 FOR a=1 TO 40: SOUND 11,a: NEXT a: SOUND 13,0
 7010 GO TO 1001
 7500 SOUND 8,15;9,15;7,39;6,0;12,50;13,0
 7502 FOR a=30 TO 0 STEP -4: SOUND 6,a: NEXT a
 7504 FOR a=0 TO 31: SOUND 6,a: NEXT a
 7506 SOUND 8,16;9,16;13,0
 7510 PRINT AT 10,10;"           ";AT 11,10;" GAME OVER ";AT 12,10;"           "
 7520 IF INKEY$="" THEN GO TO 7520
 7530 STOP 
 8500 REM title screen
 8510 PLOT 50,100: DRAW 6,6: DRAW 10,60: DRAW -8,1: DRAW -10,-57: DRAW 1,-9
 8511 PLOT 50,100: DRAW 8,48
 8512 PLOT 45,150: DRAW 27,-3,-PI/2: DRAW -27,3,PI/4
 8519 INK 4
 8520 PLOT 80,100: DRAW 11,66: PLOT 100,96: DRAW 9,70: PLOT 83,130: DRAW 24,2
 8529 INK 1
 8530 PLOT 110,100: DRAW 30,2: PLOT 120,160: DRAW 30,4: PLOT 125,100: DRAW 10,60
 8539 INK 3
 8540 PLOT 180,103: DRAW -30,-3: DRAW 10,60: DRAW 25,1
 8541 PLOT 155,145: DRAW 20,2
 8549 INK 2
 8550 PLOT 185,95: DRAW 9,67: DRAW 22,-2
 8551 PLOT 190,140: DRAW 14,4
 8555 BORDER 5
 8556 PLOT 0,34: DRAW 255,0: DRAW 0,141: DRAW -255,0: DRAW 0,-141
 8559 INK 0
 8560 PRINT AT 18,0; PAPER 2; INK 7;"Guide the thief quickly through the castle while no one is aboutand steal the treasure "; INK 6;"\j"; INK 7;" within.Be quick or be dead.            "
 8598 INK 0
 8599 RETURN 
 8999 REM UDG's
 9000 RESTORE 9160
 9001 LET a=10: LET b=11
 9002 LET c=12: LET d=13
 9003 LET e=14: LET f=15
 9005 INK 0: PAPER 7: FLASH 0: BRIGHT 0: OVER 0: INVERSE 0: BORDER 7: CLS 
 9006 PRINT AT 12,9; FLASH 1;"STOP THE TAPE"
 9007 PRINT AT 14,10;"Please wait"
 9008 GO SUB 8500
 9010 LET g=USR "a"
 9014 SOUND 10,12;5,2
 9020 FOR h=1 TO 21
 9030 READ k$
 9040 FOR i=1 TO LEN k$-1 STEP 2
 9050 POKE g,VAL k$(i)*16+VAL k$(i+1)
 9055 SOUND 4,PEEK g
 9060 LET g=g+1
 9070 NEXT i
 9080 NEXT h
 9085 SOUND 10,16;4,20;5,10
 9090 GO TO 508
 9159 REM UDG's
 9160 DATA "181810383C18181C"
 9161 DATA "58584A3E18386406"
 9162 DATA "FFCC3333CCCC33FF"
 9163 DATA "81800333CCCC33FF"
 9164 DATA "0000000180C433FF"
 9165 DATA "FFCC3333CCCC33FF"
 9166 DATA "0000000000000000"
 9167 DATA "7F637F637F637F63"
 9168 DATA "181810385E186446"
 9169 DATA "000000003C427E00"
 9170 DATA "00FF000000000000"
 9171 DATA "1818081C7A182662"
 9172 DATA "1818081C3C181838"
 9173 DATA "1A1A527C181C2660"
 9174 DATA "FFFF181818181818"
 9175 DATA "FFFF18181818FFFF"
 9176 DATA "C3E7FFDBC3C3C3C3"
 9177 DATA "FFFFC0FCFCC0FFFF"
 9178 DATA "0018180000181800"
 9179 DATA "FFCC3333CCCC33FF"
 9180 DATA "AA55AA55AA55AA55"
