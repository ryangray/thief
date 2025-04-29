    1 REM \::THIEF\::
    2 REM Ryan Gray 18 April 1990
    3 REM v1.1 Feb 2024
    4 REM v2.0 April 2025
    5 DEF FN x(x$)=PEEK 23563+256*PEEK 23564: REM DEFADD reusable
    6 DEF FN v(x$)=PEEK (FN x(x$)+4)+256*PEEK (FN x(x$)+5): REM addr of x$
    7 DEF FN d(x$,y$)=PEEK 23563+256*PEEK 23564: REM DEFADD for copying a$ to ATTRIBs
    8 DEF FN a(r,c)=22528+r*32+c-1: REM attrib mem location of a$(r,c) on screen
    9 DEF FN c(c$)=CODE o$(CODE c$)+bg*8: REM attrib for char
   10 DEF FN b(a$,b$)=PEEK 23563+256*PEEK 23564: REM DEFADD for copying a$ to b$ and back
   11 DEF FN s(a$)=(a$="\::" OR a$="\c"): REM is block "solid"
   12 DEF FN o(a$)=(a$=" " OR a$="\g" OR a$="\k"): REM is block "open"
   40 INK 0: PAPER 7: FLASH 0: BRIGHT 0: OVER 0: INVERSE 0: BORDER 7: CLS 
   42 GO SUB 9000: REM init
   44 GO TO 500: REM Main menu
   49 REM Auto start from tape at 50
   50 INK 0: PAPER 7: FLASH 0: BRIGHT 0: OVER 0: INVERSE 0: BORDER 7: CLS 
   52 PRINT AT 12,9; FLASH 1;"STOP THE TAPE"
   54 GO TO 42
   99 REM MAIN LOOP
  100 DIM b$(43,32): GO SUB 650: BORDER bg: PAPER bg: INK fg: CLS 
  101 GO SUB 5000: REM Draw level
  102 LET ti=20*CODE a$(22,3): REM Time allotment, 20 per treasure
  103 POKE 23672,0: POKE 23673,0: REM Reset FRAMES (lower 2 bytes)
  104 SOUND 0,0;1,10;2,2;3,10;4,4;5,10;6,0;7,56;8,16;9,16;10,16;11,24;12,ti;13,14
  105 PRINT AT 0,0;"SCORE:";TAB 11;"LEVEL:";TAB 24;"TIME:"
  106 LET r=m1: LET c=m2: LET m=0: LET d=2
  107 PRINT INK bf;AT 0,6;sc;AT 0,17;l;AT 0,20;"\a\a\a"( TO q);AT 0,29;ti
  108 LET x=r: LET y=c: LET xd=d
  109 LET p$=a$(r,c)
  120 LET m$="\m\a\l\i"(d): LET n$=a$(r+1,c)
  121 IF FN o(n$) OR n$="\h" THEN LET m$="\n"
  123 LET te=INT (PEEK 23672/64)+4*PEEK 23673
  124 LET tr=ti-te
  125 PRINT AT r,c-1;m$;AT 0,29; INK 8;tr;" " AND tr<100
  126 SOUND 12,tr
  128 IF tr<=0 THEN GO TO 7000: REM Time expired
  130 IF p$="\k" THEN GO TO 145
  131 IF p$="\h" THEN GO TO 145
  132 IF r=21 THEN GO TO 145
  133 IF n$=" " THEN GO TO 140
  134 IF n$="\k" THEN GO TO 140
  135 IF n$="\f" THEN GO TO 140
  136 IF n$="\j" THEN GO TO 140
  137 IF n$="\g" THEN GO TO 140
  139 GO TO 145
  140 LET x=r: LET y=c: GO SUB 240
  141 LET p$=n$: IF FN o(p$) OR p$="\h" THEN LET m$="\n"
  142 IF p$="\j" THEN GO TO 167
  143 LET p$=n$: LET n$=a$(r+1,c)
  144 GO TO 130
  145 LET k$=INKEY$
  150 LET x=r: LET y=c: LET d=xd-(2 AND xd>2)
  151 IF k$="z" THEN IF r<21 THEN IF NOT FN s(a$(r+1,c)) THEN GO SUB 240: GO TO 166
  152 IF k$="a" THEN IF r>1 THEN LET n$=a$(r-1,c): IF n$="\h" OR (p$="\h" AND NOT FN s(n$)) THEN GO SUB 230: GO TO 166
  153 IF k$="l" THEN IF c<32 THEN IF NOT FN s(a$(r,c+1)) THEN GO SUB 220: GO TO 166
  154 IF k$="k" THEN IF c>1 THEN IF NOT FN s(a$(r,c-1)) THEN GO SUB 210: GO TO 166
  155 IF k$="x" THEN IF r>1 AND c>1 THEN IF FN o(a$(r-1,c)) AND FN o(a$(r-1,c-1)) THEN GO SUB 230: LET p$=a$(r,c): LET x=r: LET y=c: GO SUB 210: GO TO 166
  156 IF k$="c" THEN IF r>1 AND c<32 THEN IF FN o(a$(r-1,c)) AND FN o(a$(r-1,c+1)) THEN GO SUB 230: LET p$=a$(r,c): LET x=r: LET y=c: GO SUB 220: GO TO 166
  161 IF k$="d" THEN GO TO 7000: REM Die
  162 IF k$="m" THEN GO SUB 400: REM Dig right
  163 IF k$="n" THEN GO SUB 430: REM Dig left
  164 IF k$="L" THEN LET d=2: REM Face right
  165 IF k$="K" THEN LET d=1: REM Face left
  166 LET p$=a$(r,c)
  167 IF p$="\j" THEN LET sc=sc+10: BEEP .01,10: BEEP .04,20: LET a$(r,c)=" ": LET p$=" ": LET a$(r+22,c)=CHR$ FN c(" "): LET m=m+1: PRINT AT 0,6; INK bf;sc: IF m=CODE a$(22,3) THEN GO TO 2000
  168 LET xd=d
  170 GO TO 120
  200 REM MOVES
  209 REM left
  210 LET c=c-1: LET d=1
  211 IF m$="\n" THEN LET m$="\b"
  212 IF m$<>"\b" THEN LET m$="\l"
  213 PRINT AT r,c-1;m$;p$
  214 POKE FN a(x,y),CODE a$(x+22,y)
  215 RETURN 
  219 REM right
  220 LET c=c+1: LET d=2
  221 IF m$="\n" THEN LET m$="\b"
  222 IF m$<>"\b" THEN LET m$="\i"
  223 PRINT AT x,y-1;p$;m$
  224 POKE FN a(x,y),CODE a$(x+22,y)
  225 RETURN 
  229 REM up
  230 LET r=r-1
  231 IF m$="\n" THEN LET m$="\b"
  232 PRINT AT x,y-1;p$;AT r,c-1;m$
  233 POKE FN a(x,y),CODE a$(x+22,y)
  234 RETURN 
  239 REM down
  240 LET r=r+1
  241 IF m$="\n" THEN LET m$="\b"
  242 PRINT AT x,y-1;p$;AT r,c-1;m$
  243 POKE FN a(x,y),CODE a$(x+22,y)
  244 RETURN 
  400 PRINT AT r,c-1;"\i": LET d=2: LET xd=d: IF c=32 OR r=21 THEN RETURN 
  402 IF NOT FN o(a$(r,c+1)) THEN RETURN : REM Not open above dig spot
  406 IF b$(r+1,c+1)<>"\c" THEN RETURN : REM Not diggable
  408 IF a$(r+1,c+1)="\g" THEN GO TO 420: REM Dug
  410 PRINT AT r+1,c; INK 8;"\d": BEEP .01,0: PAUSE 10
  412 PRINT AT r+1,c; INK 8;"\e": BEEP .01,0: PAUSE 10
  414 PRINT AT r+1,c; INK 8;"\g": BEEP .01,0: LET a$(r+1,c+1)="\g"
  416 RETURN 
  420 IF r<21 AND NOT FN s(a$(r+2,c+1)) THEN RETURN : REM No support below
  422 PRINT AT r+1,c; INK 8;"\e": BEEP .01,0: PAUSE 10
  424 PRINT AT r+1,c; INK 8;"\d": BEEP .01,0: PAUSE 10
  426 PRINT AT r+1,c; INK 8;"\c": BEEP .01,0: LET a$(r+1,c+1)="\c"
  428 RETURN 
  430 PRINT AT r,c-1;"\l": LET d=1: LET xd=d: IF c=1 OR R=21 THEN RETURN 
  432 IF NOT FN o(a$(r,c-1)) THEN RETURN 
  436 IF b$(r+1,c-1)<>"\c" THEN RETURN 
  438 IF a$(r+1,c-1)="\g" THEN GO TO 450
  440 PRINT AT r+1,c-2; INK 8;"\d": BEEP .01,0: PAUSE 10
  442 PRINT AT r+1,c-2; INK 8;"\e": BEEP .01,0: PAUSE 10
  444 PRINT AT r+1,c-2; INK 8;"\g": BEEP .01,0: LET a$(r+1,c-1)="\g"
  446 RETURN 
  450 PRINT AT r,c-1;"\l": LET d=1: LET xd=d: IF c=1 THEN RETURN 
  452 IF NOT FN o(a$(r,c-1)) OR a$(r+1,c-1)<>"\g" OR b$(r+1,c-1)<>"\c" OR (r<21 AND NOT FN s(a$(r+2,c-1))) THEN RETURN 
  454 PRINT AT r+1,c-2; INK 8;"\e": BEEP .01,0: PAUSE 10
  455 PRINT AT r+1,c-2; INK 8;"\d": BEEP .01,0: PAUSE 10
  456 PRINT AT r+1,c-2; INK 8;"\c": BEEP .01,0: LET a$(r+1,c-1)="\c"
  458 RETURN 
  500 SOUND 0,0;1,10;2,10;3,10;4,20;5,10;6,0;7,56;8,16;9,16;10,16;12,30;13,14
  502 GO SUB 8500: REM Draw top of title screen
  504 PRINT AT 14,10;"Please wait"
  506 GO SUB 9100: REM Load UDGs
  507 GO SUB 6600: REM Fake brick
  508 GO SUB 8560: REM Draw bottom of screen
  510 PRINT AT 12,9;"\ :"; INVERSE 1;"P"; INVERSE 0;"\: lay game   "
  512 PRINT AT 14,9;"\ :"; INVERSE 1;"K"; INVERSE 0;"\: eys \ :"; INVERSE 1;"H"; INVERSE 0;"\: elp"
  516 PRINT AT 16,9;"\ :"; INVERSE 1;"E"; INVERSE 0;"\: dit levels"
  520 INPUT "": SOUND 6,31;7,28;10,12
  521 FOR b=13 TO 0 STEP -1: SOUND 10,b
  522 FOR a=31 TO 0 STEP -1: SOUND 6,a
  523 LET k$=INKEY$
  524 IF k$="" THEN GO TO 530
  525 SOUND 13,0;7,63;8,0;9,0;10,0
  526 IF k$="h" THEN GO SUB 8100: INK 0: PAPER 7: BORDER 7: CLS : GO TO 502
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
  546 IF k$="h" THEN GO SUB 8100: INK 0: PAPER 7: BORDER 7: CLS : GO TO 502
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
  650 REM Copy a$ to b$ using DEFADD
  652 GO SUB 670
  654 LET b$=a$
  656 GO TO 632
  660 REM Copy b$ to a$ using DEFADD
  662 GO SUB 670
  664 LET a$=b$
  666 GO TO 632
  670 REM Set up DEF FN b with a$ and b$ addresses
  672 LET z=FN v(a$(1)): REM Get a$ addr
  674 LET zh=INT (z/256): LET zl=z-256*zh
  676 POKE ba+3,0: POKE ba+4,zl: POKE ba+5,zh: REM a$ address
  678 LET z=FN v(b$(1)): REM Get b$ addr
  680 LET zh=INT (z/256): LET zl=z-256*zh
  682 POKE ba+12,0: POKE ba+13,zl: POKE ba+14,zh: REM b$ address
  684 POKE 23563,bl: POKE 23564,bh: REM Set DEFADD
  686 RETURN 
  900 BORDER 7: CLS 
  902 PRINT AT 10,0;"Press a key when ready to load     the first level from tape"
  904 PAUSE 20
  906 PAUSE 0
  910 LOAD "" DATA A$()
  911 GO SUB 5200
  912 CLS 
  915 PRINT AT 10,10; FLASH 1;"STOP THE TAPE"
  916 IF a$(22,32)=" " THEN GO SUB 5100
  920 LET q=3: LET sc=0: LET l=1
  930 GO TO 2039
 2000 FOR a=20 TO 50 STEP 5: BEEP .01,a: NEXT a
 2001 SOUND 13,0
 2010 CLS 
 2020 PRINT AT 10,0;"Prepare the tape for the next     level and press a key ..."
 2022 IF INKEY$="" THEN GO TO 2022
 2030 LOAD "" DATA A$()
 2031 GO SUB 5200
 2032 IF a$(22,32)=" " THEN GO SUB 5100
 2035 LET l=l+1
 2036 LET sc=sc+tr: REM Bonus for time
 2037 CLS 
 2038 PRINT AT 10,10; FLASH 1;"STOP THE TAPE"
 2039 PRINT AT 12,0;"PRESS ANY KEY to start level ";l: PAUSE 0
 2040 GO TO 100
 5000 REM Draw level
 5011 LET m1=CODE a$(22,1): LET m2=CODE a$(22,2)
 5020 FOR a=1 TO 21
 5023 BEEP .001,35-a
 5024 PRINT AT a,0;a$(a);AT m1,m2-1; FLASH 1;"\i"
 5025 NEXT a
 5030 GO SUB 600
 5040 INPUT "": PRINT #0;TAB INT ((32-LEN t$)/2);t$
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
 5200 REM Read name of file loaded from the screen
 5202 LET b=24-PEEK 23689-1
 5204 LET f$="": LET f=0
 5210 FOR a=10 TO 1 STEP -1
 5212 LET k$=SCREEN$ (b,16+a): REM "Character array: xxxxx"
 5214 IF k$<>" " OR f THEN LET f=a: LET f$=k$+f$
 5216 NEXT a
 5218 GO SUB 5300
 5220 IF t$="" THEN LET t$=f$: LET a$(22,4 TO 27)=f$
 5222 RETURN 
 5300 REM Get level title
 5310 LET t$=a$(22,4 TO 27)
 5312 IF t$(1)=" " THEN LET t$="": RETURN 
 5320 LET t=LEN t$
 5330 IF t$(t)=" " AND t>0 THEN LET t=t-1: GO TO 5330
 5340 LET t$=t$( TO t)
 5350 RETURN 
 6000 REM LEVEL EDITOR
 6001 GO SUB 6500
 6002 INK fg: PAPER bg: BORDER bg: CLS 
 6003 PRINT "EDIT LEVELS"
 6004 INPUT "New";", Current," AND l;" or Load ? ";k$
 6005 PRINT AT 0,0; INK fg; PAPER bg;"SCORE:xxxx LEVEL:xx \m\m\m TIME:xxx"
 6006 IF k$="c" THEN GO SUB 660: GO TO 6016
 6007 IF k$="n" THEN GO TO 6010
 6008 IF k$="l" THEN GO TO 6400
 6009 GO TO 6004
 6010 DIM a$(43,32): LET m1=10: LET a$(22,1)=CHR$ m1: LET m2=15: LET a$(22,2)=CHR$ m2: LET a$(22,32)="2": LET t$=""
 6011 PRINT AT m1,m2-1; FLASH 1;"\m": PRINT #0;"Wait...": LET n$=CHR$ FN c(" ")
 6012 FOR b=1 TO 32: LET a$(23,b)=n$: NEXT b
 6013 FOR a=2 TO 21: LET a$(22+a)=a$(23): NEXT a
 6014 INPUT ""
 6015 GO TO 6019
 6016 REM Edit current level
 6018 GO SUB 5000: PRINT AT 0,0; INVERSE 1;"N"; INVERSE 0;"ame: ";t$;TAB 31;" "
 6019 LET r=m1: LET c=m2: LET m=0: LET m$=""
 6020 INPUT ""
 6021 PRINT #0;"1"; INK CODE o$(CODE "\c");"\c";
 6022 PRINT #0;"2"; INK CODE o$(CODE "\u");"\u";
 6023 PRINT #0;"3"; INK CODE o$(CODE "\g");"\g";
 6024 PRINT #0;"4"; INK CODE o$(CODE "\::");"\::";
 6025 PRINT #0;"5"; INK CODE o$(CODE "\h");"\h";
 6026 PRINT #0;"6"; INK CODE o$(CODE "\k");"\k";
 6027 PRINT #0;"7"; INK CODE o$(CODE "\j");"\j";
 6028 PRINT #0;"8"; INK CODE o$(CODE "\i");"\i";
 6029 PRINT #0;" spc  "; INVERSE 1;"S"; INVERSE 0;"ave "; INVERSE 1;"G"; INVERSE 0;"et "; INVERSE 1;"X"
 6030 PRINT AT r,c-1; FLASH 1; INK 8; PAPER 8; OVER 1;" "
 6040 LET k$=INKEY$
 6042 LET x=r: LET y=c
 6050 IF k$="a" THEN LET r=r-1+(21 AND r=1): GO TO 6100
 6052 IF k$="z" THEN LET r=r+1-(21 AND r=21): GO TO 6100
 6054 IF k$="l" THEN LET c=c+1-(32 AND c=32): GO TO 6100
 6056 IF k$="k" THEN LET c=c-1+(32 AND c=1): GO TO 6100
 6060 IF k$=" " THEN LET i$=" ": GO TO 6120
 6062 IF k$="1" THEN LET i$="\c": GO TO 6140
 6064 IF k$="2" THEN LET i$="\f": GO TO 6120
 6066 IF k$="3" THEN LET i$="\g": GO TO 6120
 6068 IF k$="4" THEN LET i$="\::": GO TO 6140
 6070 IF k$="5" THEN LET i$="\h": GO TO 6120
 6072 IF k$="6" THEN LET i$="\k": GO TO 6120
 6074 IF k$="7" THEN LET i$="\j": GO TO 6140
 6078 IF k$="8" THEN LET i$="\i": GO TO 6150
 6080 IF k$="s" THEN GO TO 6200
 6082 IF k$="g" THEN GO TO 6400
 6084 IF k$="x" THEN GO TO 6300
 6086 IF k$="h" THEN GO SUB 8200: CLS : LET k$="c": GO TO 6005
 6088 IF k$="n" THEN GO TO 6800
 6099 GO TO 6040
 6100 PRINT AT x,y-1; FLASH 0; INK 8; PAPER 8; OVER 1;" "
 6102 LET m$=k$
 6110 GO TO 6030
 6120 LET a$(r,c)=i$
 6122 LET i=FN c(i$)
 6124 LET a$(r+22,c)=CHR$ (i)
 6126 PRINT AT r,c-1;i$: POKE FN a(r,c),i
 6128 IF r=m1 AND c=m2 THEN GO TO 6164
 6130 LET r=r+(m$="z" AND r<21)-(m$="a" AND r>1)
 6132 LET c=c+(m$="l" AND c<32)-(m$="k" AND c>1)
 6134 GO TO 6030
 6140 REM Can't set block if player starts there
 6142 IF r=m1 AND c=m2 THEN BEEP 0.1,0: GO TO 6030
 6144 GO TO 6120
 6150 LET n$=a$(r,c)
 6152 IF n$="\c" OR n$="\::" OR n$="\j" THEN BEEP 0.1,0: GO TO 6030
 6154 LET i=FN c(a$(m1,m2))
 6156 PRINT AT m1,m2-1;a$(m1,m2): POKE FN a(m1,m2),i
 6158 LET m1=r: LET m2=c
 6160 LET a$(22,1)=CHR$ m1: LET a$(22,2)=CHR$ m2
 6162 LET i=FN c(a$(m1,m2))
 6164 PRINT AT m1,m2-1;"\i": POKE FN a(m1,m2),i
 6168 GO TO 6030
 6200 GO SUB 6700
 6210 IF m=0 THEN GO TO 6016
 6230 INPUT "Name [Empty for: ";VAL$ "f$";"]: "'"STOP to cancel: ";k$: IF LEN k$>10 THEN GO TO 6230
 6232 IF k$=CHR$ 226 THEN GO TO 6016
 6234 IF k$<>"" THEN LET f$=k$
 6240 SAVE f$ DATA a$()
 6250 PRINT #0; FLASH 1;"STOP THE TAPE": PAUSE 120
 6300 INPUT "": INPUT "Edit, Play, Quit? ";k$
 6310 IF k$="e" THEN GO TO 6002
 6320 IF k$="q" THEN GO SUB 6600: GO TO 7530
 6330 IF k$<>"p" THEN GO TO 6300
 6350 IF m=0 THEN GO SUB 6700
 6360 CLS : GO SUB 6600: GO TO 920
 6400 INPUT "Name (STOP=cancel):";f$: IF f$=CHR$ 226 THEN GO TO 6020
 6410 PRINT AT 10,10;"Loading..."
 6420 LOAD f$ DATA a$()
 6422 IF f$="" THEN GO SUB 5200
 6424 PRINT AT 10,10; FLASH 1;"STOP THE TAPE"
 6426 IF a$(22,32)=" " THEN GO SUB 5100
 6430 GO TO 6016: REM Start editing
 6500 REM Level edit mode brick is checkerboard
 6510 LET b=USR "u"
 6520 GO TO 6620
 6600 REM Play mode solid brick is normal looking
 6610 LET b=USR "t"
 6620 FOR i=0 TO 7: POKE USR "f"+i,PEEK (b+i): NEXT i
 6630 RETURN 
 6700 INPUT "": PRINT #0;"Scanning level, please wait."
 6705 LET m=NOT PI
 6710 FOR a=1 TO 21
 6715 PRINT AT a,0; INK 8; PAPER 8; INVERSE 1;a$(a)
 6720 FOR b=1 TO 32: LET m=m+(a$(a,b)="\j"): NEXT b: NEXT a
 6730 LET a$(22,3)=CHR$ m
 6740 IF m=0 THEN INPUT "No treasures. Press ENTER: ";k$
 6750 RETURN 
 6800 REM Rename level
 6810 INPUT "Name:";t$
 6812 IF LEN t$>24 THEN LET t$=t$( TO 24)
 6820 IF t$<>"" THEN LET a$(22,4 TO 27)=t$
 6830 GO TO 6018
 7000 IF q=0 THEN GO TO 7500
 7001 LET q=q-1: IF q=0 THEN GO TO 7500
 7002 GO SUB 660: SOUND 13,0
 7010 IF k$<>"d" THEN GO TO 101
 7020 INPUT "Replay, Next level, Quit? ";k$
 7022 PAUSE 30
 7030 IF k$="n" THEN GO TO 2010
 7040 IF k$="q" THEN GO TO 7530
 7042 IF k$="e" THEN GO TO 6000
 7050 GO TO 101
 7500 SOUND 8,15;9,15;7,39;6,0;12,50;13,0
 7502 FOR a=30 TO 0 STEP -4: SOUND 6,a: NEXT a
 7504 FOR a=0 TO 31: SOUND 6,a: NEXT a
 7506 SOUND 8,16;9,16;13,0
 7510 PRINT AT 10,10;"           ";AT 11,10;" GAME OVER ";AT 12,10;"           "
 7520 PAUSE 240
 7530 INK 0: PAPER 7: BORDER 7: CLS 
 7540 GO TO 500
 8000 PRINT AT 11,1;"A - Up      N - Dig/fill left"
 8010 PRINT AT 12,1;"Z - Down    M - Dig/fill right"
 8020 PRINT AT 13,1;"K - Left    X - Jump Left"
 8030 PRINT AT 14,1;"L - Right   C - Jump right"
 8040 PRINT AT 15,1;"Shift+N/M - Face L/R"
 8050 PRINT AT 16,1;"D - Die (if you get stuck)"
 8070 INPUT "Press ENTER: ";k$
 8090 FOR a=11 TO 16
 8092 PRINT AT a,1;"                              "
 8094 NEXT a
 8099 RETURN 
 8100 INK fg: PAPER bg: BORDER bg: CLS 
 8110 PRINT INK 7; PAPER 1; BRIGHT 1;" Thief Game Help "''
 8120 PRINT INK CODE o$(CODE "\i");"\a \i \n"; INK fg;" You    ";
 8122 PRINT INK CODE o$(CODE "\j");"\j"; INK fg;" Treasure"
 8124 PRINT "               (10 points)"''
 8126 PRINT INK CODE o$(CODE "\k");"\k"; INK fg;" Overhead bar"
 8128 PRINT INK CODE o$(CODE "\h");"\h"; INK fg;" Ladder"
 8130 PRINT INK CODE o$(CODE "\t");"\t"; INK fg;" Diggable Floor"
 8132 PRINT INK CODE o$(CODE "\::");"\::"; INK fg;" Solid Floor"
 8134 PRINT INK CODE o$(CODE "\u");"\u"; INK fg;" False floor (edit mode)"
 8136 PRINT INK CODE o$(CODE "\g");"\g"; INK fg;" Passage or dug out floor"
 8140 PRINT '"Walk left/right on floors and"
 8142 PRINT "through passages, climb ladders"
 8144 PRINT "or bars, dig the floor (don't"
 8146 PRINT "get trapped) or fill it in"
 8148 PRINT "(can't fill in if empty below)."
 8150 PRINT "You can fall any distance. Pick"
 8152 PRINT "up all treasures before time"
 8154 PRINT "runs out. Bonus for any time"
 8156 PRINT "remaining. H for help in editor."
 8158 INPUT "Press ENTER:";k$
 8199 RETURN 
 8200 CLS : PRINT AT 0,0; INK 7; PAPER 1; BRIGHT 1;" Thief Edit Help "
 8210 PRINT '"Use a/z/k/l to move the cursor."
 8212 PRINT "Use 1-7 to set the block type,"'"space to clear it:"
 8220 PRINT '"1 "; INK CODE o$(CODE "\c");"\c"; INK fg;" - Diggable floor"
 8222 PRINT "2 "; INK CODE o$(CODE "\u");"\u"; INK fg;" - False floor"
 8224 PRINT "3 "; INK CODE o$(CODE "\g");"\g"; INK fg;" - Passage"
 8226 PRINT "4 "; INK CODE o$(CODE "\::");"\::"; INK fg;" - Solid floor"
 8228 PRINT "5 "; INK CODE o$(CODE "\h");"\h"; INK fg;" - Ladder"
 8230 PRINT "6 "; INK CODE o$(CODE "\k");"\k"; INK fg;" - Overhead bar"
 8232 PRINT "7 "; INK CODE o$(CODE "\j");"\j"; INK fg;" - Treasure"
 8240 PRINT '"8 "; INK CODE o$(CODE "\i");"\i"; INK fg;" - Set the player start. You"
 8242 PRINT "      can set the player at any"
 8244 PRINT "      walkable location except"
 8246 PRINT "      for a treasure."
 8250 PRINT "S   - Save the level"
 8252 PRINT "G   - Load (get) a level"
 8254 PRINT "X   - Quit without saving"
 8270 INPUT "Press ENTER:";k$
 8299 RETURN 
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
 9010 LET da=FN d("",""): REM FN d address
 9011 POKE da+3,0: POKE da+4,32: POKE da+5,88: REM ATTRIB address (row 1)
 9012 POKE da+6,160: POKE da+7,2: POKE da+15,160: POKE da+16,2: REM ATTRIB length
 9014 LET dh=INT (da/256): LET dl=da-256*dh: REM lo/hi bytes of da
 9015 REM Set up DEFADD FN for copying a$ to b$ and back
 9016 LET ba=FN b("",""): REM FN b address
 9017 POKE ba+6,96: POKE ba+7,5: POKE ba+15,96: POKE ba+16,5: REM Array size 43*32=96+256*5
 9018 LET bh=INT (ba/256): LET bl=ba-256*bh: REM lo/hi bytes of ba
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
 9038 LET o$(150)=CHR$ 5: REM \g Passage brick
 9040 LET o$(151)=CHR$ 4: REM \h Ladder
 9042 LET o$(152)=CHR$ 7: REM \i Player, walk right
 9044 LET o$(153)=CHR$ 6: REM \j Treasure
 9046 LET o$(154)=CHR$ 3: REM \k Overhead bar
 9048 LET o$(155)=CHR$ 7: REM \l Player, walk left
 9050 LET o$(156)=CHR$ 7: REM \m Player, stand left
 9052 LET o$(157)=CHR$ 7: REM \n Player, climb right
 9054 LET o$(163)=CHR$ 5: REM \t Brick, diggable, play mode copy
 9056 LET o$(164)=CHR$ 5: REM \u Brick, fake, edit mode copy
 9059 RETURN 
 9098 REM UDG's
 9099 REM \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u
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
 9163 DATA "89802333CCCC3333"
 9164 DATA "8800240188C43333"
 9165 DATA "FFCC3333CCCC3333"
 9166 DATA "8800220088002200"
 9167 DATA "427E4242427E4242"
 9168 DATA "181810385E186446"
 9169 DATA "000000003C5E7E00"
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
 9180 DATA "8888222288882222"
 9989 STOP 
 9990 CLEAR 
 9992 SAVE "Thief" LINE 100
 9994 RUN 100
