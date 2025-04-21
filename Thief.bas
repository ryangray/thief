    1 REM \::THIEF\::
    2 REM Ryan Gray 18 April 1990
    3 REM v1.1 Feb 2024, v1.2 April 2025
    5 DEF FN x(x$)=PEEK 23563+256*PEEK 23564: REM DEFADD reusable
    6 DEF FN v(x$)=PEEK (FN x(x$)+4)+256*PEEK (FN x(x$)+5): REM addr of x$
    7 DEF FN d(x$,y$)=PEEK 23563+256*PEEK 23564: REM DEFADD copying a$ to ATTRIBs
    8 DEF FN a(r,c)=22528+r*32+c-1: REM attrib mem location of a$(r,c) on screen
    9 DEF FN c(c$)=CODE o$(CODE c$)+bg*8: REM attrib for char
   90 INK 0: PAPER 7: FLASH 0: BRIGHT 0: OVER 0: INVERSE 0: BORDER 7: CLS 
   92 GO SUB 9000: REM init
   94 GO TO 500: REM Main menu
   99 REM Auto start from tape at 100
  100 INK 0: PAPER 7: FLASH 0: BRIGHT 0: OVER 0: INVERSE 0: BORDER 7: CLS 
  110 PRINT AT 12,9; FLASH 1;"STOP THE TAPE"
  120 GO TO 92
  400 REM MOVES
  409 REM left
  410 LET c=c-1: LET d=1
  411 IF m$="\n" THEN LET m$="\b"
  412 IF m$<>"\b" THEN LET m$="\l"
  413 PRINT AT r,c-1;m$;a$(x,y)
  414 POKE FN a(x,y),CODE a$(x+22,y)
  415 RETURN 
  419 REM right
  420 LET c=c+1: LET d=2
  421 IF m$="\n" THEN LET m$="\b"
  422 IF m$<>"\b" THEN LET m$="\i"
  423 PRINT AT x,y-1;a$(x,y);m$
  424 POKE FN a(x,y),CODE a$(x+22,y)
  425 RETURN 
  429 REM up
  430 LET r=r-1
  431 IF m$="\n" THEN LET m$="\b"
  432 PRINT AT x,y-1;a$(x,y);AT r,c-1;m$
  433 POKE FN a(x,y),CODE a$(x+22,y)
  434 RETURN 
  439 REM down
  440 LET r=r+1
  441 IF m$="\n" THEN LET m$="\b"
  442 PRINT AT x,y-1;a$(x,y);AT r,c-1;m$
  443 POKE FN a(x,y),CODE a$(x+22,y)
  444 RETURN 
  500 SOUND 0,0;1,10;2,10;3,10;4,20;5,10;6,0;7,56;8,16;9,16;10,16;12,30;13,14
  502 GO SUB 8500: REM Draw top of title screen
  504 PRINT AT 14,10;"Please wait"
  506 GO SUB 9100: REM Load UDGs
  508 GO SUB 8560: REM Draw bottom of screen
  510 PRINT AT 12,9;"\ :P\: lay game   ";AT 14,9;"\ :K\: eys      ";AT 16,9;"\ :E\: dit levels"
  512 PRINT AT 12,10; INVERSE 1; FLASH 1;"P";AT 16,10;"E"; INVERSE 0;AT 14,10;"K"
  520 INPUT "": SOUND 6,31;7,28;10,12
  521 FOR b=13 TO 0 STEP -1: SOUND 10,b
  522 FOR a=31 TO 0 STEP -1: SOUND 6,a
  523 LET k$=INKEY$
  524 IF k$="" THEN GO TO 530
  525 SOUND 13,0;7,63;8,0;9,0;10,0
  527 IF k$="p" THEN GO TO 900
  528 IF k$="e" THEN GO TO 6000
  529 IF k$="k" THEN GO SUB 8000: GO TO 510
  530 NEXT a: NEXT b
  535 SOUND 7,56;10,16;6,0
  540 LET k$=INKEY$
  541 IF k$="" THEN GO TO 540
  542 SOUND 13,0;7,63;8,0;9,0;10,0
  543 IF k$="p" THEN GO TO 900
  544 IF k$="e" THEN GO TO 6000
  545 IF k$="k" THEN GO SUB 8000: GO TO 510
  550 GO TO 530
  600 REM Copy attribs from a$ to ATTRIB memory
  620 LET z=FN v(a$(1)): REM Get a$ addr
  622 LET z=z+22*32: REM offset to attribs part
  624 LET zh=INT (z/256): LET zl=z-256*zh
  626 POKE da+12,0: POKE da+13,zl: POKE da+14,zh: REM a$ attrib address
  628 POKE 23563,dl: POKE 23564,dh: REM Set DEFADD
  630 LET x$=y$: REM Copy data
  632 POKE 23563,0: POKE 23564,0: REM Reset DEFADD
  639 RETURN 
  900 BORDER 7: CLS 
  902 PRINT AT 10,0;"Press a key when ready to load     the first level from tape"
  904 PAUSE 20
  906 PAUSE 0
  910 LOAD "" DATA A$()
  912 CLS 
  915 PRINT AT 10,10; FLASH 1;"STOP THE TAPE"
  916 IF a$(22,32)=" " THEN GO SUB 5100
  920 LET q=3: LET sc=0: LET l=1
  930 GO TO 2039
  999 REM MAIN LOOP
 1000 DIM b$(21,32): FOR z=1 TO 21: LET b$(z)=a$(z): BEEP .001,z+14: NEXT z: BORDER bg: PAPER bg: INK fg
 1001 GO SUB 5000: REM Draw level
 1002 LET ti=20*CODE a$(22,3): REM Time allotment, 20 per treasure
 1003 POKE 23672,0: POKE 23673,0: REM Reset FRAMES (lower 2 bytes)
 1004 SOUND 0,0;1,10;2,2;3,10;4,4;5,10;6,0;7,56;8,16;9,16;10,16;11,24;12,ti;13,14
 1005 PRINT AT 0,0;"SCORE:";TAB 11;"LEVEL:";TAB 24;"TIME:"
 1006 LET r=CODE a$(22,1): LET c=CODE a$(22,2): LET m=0: LET d=1
 1007 PRINT INK bf;AT 0,6;sc;AT 0,17;l;AT 0,20;"\a\a\a"( TO q);AT 0,29;ti
 1008 LET x=r: LET y=c: LET xd=d: LET a$(r,c)=" "
 1020 LET m$="\m\a\l\i"(d): LET n$=a$(r+1,c)
 1021 IF a$(r,c)="\k" OR a$(r,c)="\h" AND (n$=" " OR n$="\k" OR n$="\h" OR n$="\j") THEN LET m$="\n"
 1023 LET te=INT (PEEK 23672/64)+4*PEEK 23673
 1024 LET tr=ti-te
 1025 PRINT AT r,c-1;m$;AT 0,29; INK 8;tr;" " AND tr<100
 1026 SOUND 12,tr
 1028 IF te=ti THEN GO TO 7000: REM Time expired
 1030 IF a$(r,c)="\k" OR a$(r,c)="\h" THEN GO TO 1040
 1031 IF n$<>"\k" AND n$<>" " AND n$<>"\f" AND n$<>"\j" THEN GO TO 1040
 1032 LET x=r: LET y=c: GO SUB 440
 1033 IF a$(r,c)="\j" THEN GO TO 1061
 1034 LET n$=a$(r+1,c)
 1035 GO TO 1030
 1040 IF a$(r,c)="\k" OR a$(r,c)="\h" THEN LET m$="\n"
 1041 LET k$=INKEY$
 1050 LET x=r: LET y=c: LET d=xd-(2 AND xd>2)
 1051 IF k$="z" THEN IF r<21 THEN LET n$=a$(r+1,c): IF n$<>"\c" AND n$<>"\::" THEN GO SUB 440: GO TO 1066
 1052 IF k$="a" THEN IF r>1 THEN LET n$=a$(r-1,c): IF a$(r-1,c)="\h" OR (a$(r,c)="\h" AND n$<>"\::" AND n$<>"\c") THEN GO SUB 430: GO TO 1066
 1053 IF k$="l" THEN IF c<32 THEN LET n$=a$(r,c+1): IF n$<>"\c" OR n$="\::" THEN GO SUB 420: GO TO 1066
 1054 IF k$="k" THEN IF c>1 THEN LET n$=a$(r,c-1): IF n$<>"\c" AND n$<>"\::" THEN GO SUB 410: GO TO 1066
 1061 IF k$="d" THEN GO TO 7000: REM Die
 1062 IF k$="m" THEN GO TO 1080: REM Dig right
 1063 IF k$="n" THEN GO TO 1090: REM Dig left
 1064 IF k$="L" THEN LET d=2: REM Face right
 1065 IF k$="K" THEN LET d=1: REM Face left
 1066 IF a$(r,c)="\j" THEN LET sc=sc+10: BEEP .01,10: BEEP .04,20: LET a$(r,c)=" ": LET m=m+1: PRINT AT 0,6; INK bf;sc: IF m=CODE a$(22,3) THEN GO TO 2000
 1067 LET xd=d
 1070 GO TO 1020
 1080 PRINT AT r,c-1;"\i": LET d=2: LET xd=d: IF c=32 THEN GO TO 1020
 1081 IF a$(r+1,c+1)=" " THEN GO TO 2100
 1082 IF a$(r,c+1)<>" " AND a$(r,c+1)<>"\k" OR a$(r+1,c+1)<>"\c" THEN GO TO 1020
 1083 PRINT AT r+1,c; INK 8;"\d": BEEP .01,0: PAUSE 10
 1084 PRINT AT r+1,c; INK 8;"\e": BEEP .01,0: PAUSE 10
 1085 PRINT AT r+1,c; INK 8;" ": BEEP .01,0: LET a$(r+1,c+1)=" "
 1086 GO TO 1020
 1090 PRINT AT r,c-1;"\l": LET d=1: LET xd=d: IF c=1 THEN GO TO 1020
 1091 IF a$(r+1,c-1)=" " THEN GO TO 2120
 1092 IF a$(r,c-1)<>" " AND a$(r,c-1)<>"\k" OR a$(r+1,c-1)<>"\c" THEN GO TO 1020
 1093 PRINT AT r+1,c-2; INK 8;"\d": BEEP .01,0: PAUSE 10
 1094 PRINT AT r+1,c-2; INK 8;"\e": BEEP .01,0: PAUSE 10
 1095 PRINT AT r+1,c-2; INK 8;" ": BEEP .01,0: LET a$(r+1,c-1)=" "
 1096 GO TO 1020
 2000 FOR a=20 TO 50 STEP 5: BEEP .01,a: NEXT a
 2001 SOUND 13,0
 2010 CLS 
 2020 PRINT AT 10,0;"Prepare the tape for the next   level and press a key ..."
 2022 IF INKEY$="" THEN GO TO 2022
 2030 LOAD "" DATA A$()
 2032 IF a$(22,32)=" " THEN GO SUB 5100
 2035 LET l=l+1
 2036 LET sc=sc+tr
 2037 CLS 
 2038 PRINT AT 10,10; FLASH 1;"STOP THE TAPE"
 2039 PRINT AT 12,0;"PRESS ANY KEY to start level ";l: PAUSE 0
 2040 GO TO 1000
 2100 PRINT AT r,c-1;"\i": LET d=2: LET xd=d: IF c=32 THEN GO TO 1020
 2102 IF (a$(r,c+1)=" " OR a$(r,c+1)="\k") AND a$(r+1,c+1)=" " AND b$(r+1,c+1)="\c" THEN GO TO 2104
 2103 GO TO 1020
 2105 PRINT AT r+1,c; INK 8;"\e": BEEP .01,0: PAUSE 10
 2106 PRINT AT r+1,c; INK 8;"\d": BEEP .01,0: PAUSE 10
 2107 PRINT AT r+1,c; INK 8;"\c": BEEP .01,0: LET a$(r+1,c+1)="\c"
 2110 GO TO 1020
 2120 PRINT AT r,c-1;"\l": LET d=1: LET xd=d: IF c=1 THEN GO TO 1020
 2122 IF (a$(r,c-1)=" " OR a$(r,c-1)="\k") AND a$(r+1,c-1)=" " AND b$(r+1,c-1)="\c" THEN GO TO 2124
 2123 GO TO 1020
 2124 PRINT AT r+1,c-2; INK 8;"\e": BEEP .01,0: PAUSE 10
 2125 PRINT AT r+1,c-2; INK 8;"\d": BEEP .01,0: PAUSE 10
 2126 PRINT AT r+1,c-2; INK 8;"\c": BEEP .01,0: LET a$(r+1,c-1)="\c"
 2130 GO TO 1020
 5000 REM Draw level
 5010 INK fg: PAPER bg: BORDER bg
 5011 LET r=CODE a$(22,1): LET c=CODE a$(22,2)
 5012 CLS 
 5020 FOR a=1 TO 21
 5023 BEEP .001,35-a
 5024 PRINT AT a,0;a$(a);AT r,c-1; FLASH 1;"\m"
 5025 NEXT a
 5030 GO SUB 600
 5090 RETURN 
 5100 REM Colorize a v1 level
 5102 DIM b$(22,32)
 5104 PRINT AT 0,1;" Colorizing old v1 level ..."
 5105 BORDER bg: PAPER bg: INK fg
 5106 FOR r=1 TO 22: LET b$(r)=a$(r): NEXT r
 5108 DIM a$(43,32)
 5109 LET a$(22)=b$(22): LET a$(22,32)="2"
 5110 FOR r=1 TO 21
 5112 LET a$(r)=b$(r)
 5114 PRINT AT r,0;a$(r)
 5120 FOR c=1 TO 32
 5122 LET i=FN c(a$(r,c))
 5132 LET a$(r+22,c)=CHR$ (i)
 5140 NEXT c: NEXT r
 5150 CLS 
 5190 RETURN 
 6000 REM LEVEL EDITOR
 6001 GO SUB 6500
 6002 INK fg: PAPER bg: BORDER bg: CLS 
 6004 INPUT "New, ";"Current, " AND l;"Load ? ";k$
 6005 IF k$="c" THEN GO TO 6014
 6006 IF k$="n" THEN GO TO 6010
 6008 IF k$="l" THEN GO TO 6400
 6009 GO TO 6004
 6010 DIM a$(43,32): LET m1=10: LET a$(22,1)=CHR$ m1: LET m2=15: LET a$(22,2)=CHR$ m2: LET a$(22,32)="2"
 6011 FOR b=1 TO 32: LET a$(23,b)=CHR$ (fg+bg*8): NEXT b
 6012 FOR a=2 TO 21: LET a$(22+a)=a$(23): NEXT a
 6013 GO TO 6019
 6014 CLS 
 6015 LET m1=CODE a$(22,1): LET m2=CODE a$(22,2)
 6016 LET r=m1: LET c=m2
 6017 GO SUB 5000
 6019 BORDER 6
 6020 LET r=1: LET c=1
 6021 INPUT "": PRINT #0;"1\c2\u3\g4\::5\h6\k7\j8\i spc  "; INVERSE 1;"S"; INVERSE 0;"ave "; INVERSE 1;"G"; INVERSE 0;"et "; INVERSE 1;"X"
 6022 PRINT AT 0,0;"SCORE:xxx  LEVEL:xx \m\m\m TIME:xxx"
 6030 PRINT AT r,c-1; FLASH 1; INK 8; PAPER 8; OVER 1;" "
 6040 LET k$=INKEY$
 6050 IF k$="s" THEN GO TO 6200
 6052 IF k$="g" THEN GO TO 6400
 6054 IF k$="x" THEN GO TO 6300
 6060 IF k$=" " THEN LET i$=" ": GO TO 6120
 6062 IF k$="1" THEN LET i$="\c": GO TO 6120
 6064 IF k$="2" THEN LET i$="\f": GO TO 6120
 6066 IF k$="3" THEN LET i$="\g": GO TO 6120
 6068 IF k$="4" THEN LET i$="\::": GO TO 6120
 6070 IF k$="5" THEN LET i$="\h": GO TO 6120
 6072 IF k$="6" THEN LET i$="\k": GO TO 6120
 6074 IF k$="7" THEN LET i$="\j": GO TO 6120
 6078 IF k$="8" THEN LET i$="\i": GO TO 6150
 6080 LET x=r: LET y=c
 6090 IF k$="a" AND r>1 THEN LET r=r-1: GO TO 6100
 6092 IF k$="z" AND r<21 THEN LET r=r+1: GO TO 6100
 6094 IF k$="l" AND c<32 THEN LET c=c+1: GO TO 6100
 6096 IF k$="k" AND c>1 THEN LET c=c-1: GO TO 6100
 6099 GO TO 6040
 6100 PRINT AT x,y-1; FLASH 0; INK 8; PAPER 8; OVER 1;" "
 6110 GO TO 6030
 6120 LET a$(r,c)=i$
 6122 LET i=FN c(i$)
 6124 LET a$(r+22,c)=CHR$ (i)
 6126 PRINT AT r,c-1;i$: POKE FN a(r,c),i
 6128 GO TO 6030
 6150 LET i=FN c(a$(m1,m2))
 6152 PRINT AT m1,m2-1;a$(m1,m2): POKE FN a(m1,m2),i
 6154 LET m1=r: LET m2=c
 6156 LET a$(22,1)=CHR$ m1: LET a$(22,2)=CHR$ m2
 6158 LET i=FN c(i$)
 6160 PRINT AT r,c-1;"\i": POKE FN a(r,c),i
 6162 GO TO 6030
 6200 INPUT "": PRINT #0;"Scanning level, please wait."
 6205 LET m=NOT PI
 6210 FOR a=1 TO 21: PRINT AT a,0;a$(a): FOR b=1 TO 32: LET m=m+(a$(a,b)="\j"): NEXT b: NEXT a
 6215 LET a$(m1,m2)=" "
 6220 LET a$(22,3)=CHR$ m
 6230 INPUT "Name [blank to stop]:";f$: IF LEN f$>10 THEN GO TO 6230
 6232 IF f$="" THEN GO TO 6021
 6240 SAVE f$ DATA a$()
 6250 PRINT #0; FLASH 1;"STOP THE TAPE": PAUSE 120
 6300 INPUT "": INPUT "Edit, Play, Quit? ";f$
 6310 IF f$="e" THEN GO TO 6002
 6320 IF f$="p" THEN CLS : GO SUB 6600: GO TO 920
 6330 IF f$="q" THEN GO SUB 6600: GO TO 7530
 6340 GO TO 6300
 6400 INPUT "LOAD [$ TO abort]:";f$: IF f$="$" THEN GO TO 6021
 6410 CLS : PRINT AT 10,10;"Loading..."
 6420 LOAD f$ DATA a$()
 6421 PRINT AT 10,10; FLASH 1;"STOP THE TAPE"
 6422 IF a$(22,32)=" " THEN GO SUB 5100
 6430 GO TO 6014: REM Start editing
 6500 REM Level edit mode brick is checkerboard
 6510 LET b=USR "u"
 6520 GO TO 6620
 6600 REM Play mode solid brick is normal looking
 6610 LET b=USR "t"
 6620 FOR i=0 TO 7: POKE USR "f"+i,PEEK (b+i): NEXT i
 6630 RETURN 
 7000 IF q=0 THEN GO TO 7500
 7001 LET q=q-1: IF q=0 THEN GO TO 7500
 7002 FOR a=1 TO 21: SOUND 11,a: LET a$(a)=b$(a): NEXT a: SOUND 13,0
 7010 IF k$<>"d" THEN GO TO 1001
 7020 INPUT "Replay, Next level, Quit? ";k$
 7022 PAUSE 30
 7030 IF k$="n" THEN GO TO 2010
 7040 IF k$="q" THEN GO TO 7530
 7042 IF k$="e" THEN GO TO 6000
 7050 GO TO 1001
 7500 SOUND 8,15;9,15;7,39;6,0;12,50;13,0
 7502 FOR a=30 TO 0 STEP -4: SOUND 6,a: NEXT a
 7504 FOR a=0 TO 31: SOUND 6,a: NEXT a
 7506 SOUND 8,16;9,16;13,0
 7510 PRINT AT 10,10;"           ";AT 11,10;" GAME OVER ";AT 12,10;"           "
 7520 PAUSE 240
 7530 INK 0: PAPER 7: BORDER 7: CLS 
 7540 GO TO 500
 8000 PRINT AT 12,1;"A - Up      N - Dig/fill left"
 8030 PRINT AT 13,1;"Z - Down    M - Dig/fill right"
 8040 PRINT AT 14,1;"K - Left    Shift+N - Face L"
 8050 PRINT AT 15,1;"L - Right   Shift+M - Face R"
 8060 PRINT AT 16,1;"D - Die (if you get stuck)"
 8070 INPUT "Press ENTER: ";k$
 8090 FOR a=12 TO 16
 8092 PRINT AT a,1;"                              "
 8094 NEXT a
 8099 RETURN 
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
 8556 INK 0
 8558 RETURN 
 8560 INK 2
 8565 PLOT 0,33: DRAW 255,0: DRAW 0,142: DRAW -255,0: DRAW 0,-142
 8570 PRINT AT 18,0; PAPER 2; INK 7;"Guide the thief quickly through the castle while no one is aboutand steal the treasure "; INK 6;"\j"; INK 7;" within.Be quick or be dead.            "
 8598 INK 0
 8599 RETURN 
 9000 LET l=0
 9002 LET bg=0: LET fg=7: LET bf=6
 9009 REM Set up DEFADD FN for copying a$(23 TO 43) to ATTRIB memory at row 1
 9010 LET da=FN d("",""): POKE da+3,0: POKE da+4,32: POKE da+5,88: REM ATTRIB address (row 1)
 9012 POKE da+6,160: POKE da+7,2: POKE da+15,160: POKE da+16,2: REM ATTRIB length
 9014 LET dh=INT (da/256): LET dl=da-256*dh: REM lo/hi bytes of da
 9020 REM Make color map (inks only for now)
 9022 DIM o$(165): REM o$(CODE b$(r,c))=color_attrib
 9023 LET o$(32)=CHR$ 7: REM  Empty space
 9024 LET o$(143)=CHR$ 5: REM \:: Solid brick
 9026 LET o$(144)=CHR$ 7: REM \a Player, stand right
 9028 LET o$(145)=CHR$ 7: REM \b Player, climb left
 9030 LET o$(146)=CHR$ 5: REM \c Brick, undug
 9032 LET o$(147)=CHR$ 5: REM \c Brick, dug 1
 9034 LET o$(148)=CHR$ 5: REM \d Brick, dug 2
 9036 LET o$(149)=CHR$ 5: REM \f Brick, fake
 9038 LET o$(150)=CHR$ 1: REM \g Passage brick
 9040 LET o$(151)=CHR$ 4: REM \h Ladder
 9042 LET o$(152)=CHR$ 7: REM \i Player, walk right
 9044 LET o$(153)=CHR$ 6: REM \j Treasure
 9046 LET o$(154)=CHR$ 3: REM \k Overhead bar
 9048 LET o$(155)=CHR$ 7: REM \l Player, walk left
 9050 LET o$(156)=CHR$ 7: REM \m Player, stand left
 9052 LET o$(157)=CHR$ 7: REM \n Player, climb right
 9054 LET o$(163)=CHR$ 2: REM SPECTRUM  Brick, solid play mode copy
 9056 LET o$(164)=CHR$ 2: REM PLAY  Brick, fake, edit mode
 9059 RETURN 
 9098 REM UDG's
 9099 REM \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s SPECTRUM PLAY 
 9100 RESTORE 9160
 9101 LET a=10: LET b=11
 9102 LET c=12: LET d=13
 9103 LET e=14: LET f=15
 9109 SOUND 10,12;5,2
 9110 LET g=USR "a"
 9111 LET m=0
 9112 READ k$
 9113 FOR i=1 TO LEN k$-1 STEP 2
 9114 LET j=PEEK g
 9115 LET k=VAL k$(i)*16+VAL k$(i+1)
 9116 IF j<>k THEN LET m=1
 9117 POKE g,k: SOUND 4,k
 9118 LET g=g+1
 9119 NEXT i
 9120 IF m=0 THEN GO TO 9150: REM Skip the rest
 9130 FOR h=2 TO 21
 9132 READ k$
 9134 FOR i=1 TO LEN k$-1 STEP 2
 9136 LET k=VAL k$(i)*16+VAL k$(i+1)
 9138 POKE g,k: SOUND 4,k
 9140 LET g=g+1
 9142 NEXT i
 9144 NEXT h
 9150 SOUND 10,16;4,20;5,10
 9152 RETURN 
 9159 REM UDG data
 9160 DATA "181810383C18181C"
 9161 DATA "58584A3E18386406"
 9162 DATA "FFCC3333CCCC3333"
 9163 DATA "81800333CCCC3333"
 9164 DATA "0000000180C43333"
 9165 DATA "FFCC3333CCCC3333"
 9166 DATA "AA55AA55AA55AA55"
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
 9179 DATA "FFCC3333CCCC3333"
 9180 DATA "AAAA5555AAAA5555"
 9989 STOP 
 9990 CLEAR 
 9992 SAVE "Thief" LINE 100
 9994 RUN 100
