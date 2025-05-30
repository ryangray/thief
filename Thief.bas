    1 REM \::THIEF\::
    2 REM Ryan Gray 18 April 1990
    3 REM v1.1 Feb 2024
    4 REM v1.2 May 2025
    5 DEF FN s(a$)=(a$="\::" OR a$="\c"): REM is block "solid"
    6 DEF FN o(a$)=(a$=" " OR a$="\g" OR a$="\k"): REM is block "open"
    7 DEF FN x(x$)=PEEK 23563+256*PEEK 23564: REM DEFADD reusable
    8 DEF FN v(x$)=PEEK (FN x(x$)+4)+256*PEEK (FN x(x$)+5): REM addr of x$
    9 DEF FN d(x$,y$)=PEEK 23563+256*PEEK 23564: REM DEFADD for copying a$ to ATTRIBs
   10 DEF FN a(r,c)=22528+r*32+c-1: REM attrib mem location of a$(r,c) on screen
   11 DEF FN c(c$)=CODE o$(CODE c$)+bg*8: REM attrib for char
   12 DEF FN b(a$,b$)=PEEK 23563+256*PEEK 23564: REM DEFADD for copying a$ to b$ and back
   13 DEF FN i$(c$)=CHR$ 16+o$(CODE c$)+c$: REM PRINT FN i$(c$)
   40 INK 0: PAPER 7: FLASH 0: BRIGHT 0: OVER 0: INVERSE 0: BORDER 0: CLS 
   42 GO SUB 9000: REM init
   44 GO TO 500: REM Main menu
   49 REM Auto start from tape at 50
   50 LOAD "Thief UDGs"CODE USR "a",168
   52 INK 0: PAPER 7: FLASH 0: BRIGHT 0: OVER 0: INVERSE 0: BORDER 0: CLS 
   54 PRINT AT 12,9; FLASH 1;"STOP THE TAPE"
   59 GO TO 42
   99 REM MAIN LOOP
  100 DIM b$(43,32): GO SUB 650: BORDER bg: PAPER bg: INK fg: CLS 
  101 LET m=0: LET d=2
  102 LET ti=20*CODE a$(22,3): REM Time allotment, 20 per treasure
  103 INK 8: GO SUB 5000: LET r=m1: LET c=m2: REM Draw level
  104 POKE 23672,0: POKE 23673,0: REM Reset FRAMES (lower 2 bytes)
  105 SOUND 0,0;1,10;2,2;3,10;4,4;5,10;6,0;7,56;8,16;9,16;10,16;11,24;12,ti;13,14
  106 PRINT INK fg;AT 0,0;"SCORE:";TAB 11;"LEVEL:";TAB 24;"TIME:"
  107 PRINT INK bf;AT 0,6;sc;AT 0,17;l;AT 0,19;" \a\a\a"( TO q);AT 0,29;ti
  108 LET x=r: LET y=c: LET z$="."
  109 LET p$=a$(r,c)
  120 LET m$="\m\a\l\i"(d): LET n$=a$(r+1,c)
  121 IF FN o(n$) OR n$="\h" THEN LET m$="\n"
  123 LET te=INT (PEEK 23672/64)+4*PEEK 23673
  124 LET tr=ti-te
  125 PRINT AT r,c-1;m$;AT 0,29;tr;" " AND tr<100
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
  150 LET x=r: LET y=c
  151 IF k$="" THEN LET s= STICK (1,1): LET n= STICK (2,1): LET k$=".az-k..-l...D.-Kxn-Lcm"(s+1+11*n): IF z$="D" AND k$="a" THEN LET k$="d"
  152 LET z$=k$
  153 IF k$="z" THEN IF r<21 THEN IF NOT FN s(a$(r+1,c)) THEN GO SUB 240: GO TO 166
  154 IF k$="a" THEN IF r>1 THEN LET n$=a$(r-1,c): IF n$="\h" OR (p$="\h" AND NOT FN s(n$)) THEN GO SUB 230: GO TO 166
  155 IF k$="l" THEN IF c<32 THEN IF NOT FN s(a$(r,c+1)) THEN GO SUB 220: GO TO 166
  156 IF k$="k" THEN IF c>1 THEN IF NOT FN s(a$(r,c-1)) THEN GO SUB 210: GO TO 166
  157 IF k$="x" THEN IF r>1 AND c>1 THEN IF FN o(a$(r-1,c)) AND FN o(a$(r-1,c-1)) THEN GO SUB 230: LET p$=a$(r,c): LET x=r: LET y=c: GO SUB 210: GO TO 166
  158 IF k$="c" THEN IF r>1 AND c<32 THEN IF FN o(a$(r-1,c)) AND FN o(a$(r-1,c+1)) THEN GO SUB 230: LET p$=a$(r,c): LET x=r: LET y=c: GO SUB 220: GO TO 166
  159 IF k$="p" THEN GO TO 190: REM Pause
  161 IF k$="d" THEN GO TO 7000: REM Die
  162 IF k$="m" THEN GO SUB 400: REM Dig right
  163 IF k$="n" THEN GO SUB 430: REM Dig left
  164 IF k$="L" THEN LET d=2: REM Face right
  165 IF k$="K" THEN LET d=1: REM Face left
  166 LET p$=a$(r,c)
  167 IF p$="\j" THEN LET sc=sc+10: BEEP .01,10: BEEP .04,20: LET a$(r,c)=" ": LET p$=" ": LET a$(r+22,c)=CHR$ FN c(" "): LET m=m+1: PRINT AT r,c-1;FN i$(" ");AT 0,6; INK bf;sc: IF m=CODE a$(22,3) THEN GO TO 2000
  170 GO TO 120
  190 PAUSE 30
  192 INPUT "": PRINT #0;" PAUSED: press a key or button"
  194 GO SUB 710
  196 GO SUB 5040
  198 LET ti=tr: GO TO 104
  200 REM MOVES
  209 REM left
  210 LET c=c-1: LET d=1
  211 IF m$="\n" THEN LET m$="\b"
  212 IF m$<>"\b" THEN LET m$="\l"
  213 PRINT AT r,c-1;m$;p$
  215 RETURN 
  219 REM right
  220 LET c=c+1: LET d=2
  221 IF m$="\n" THEN LET m$="\b"
  222 IF m$<>"\b" THEN LET m$="\i"
  223 PRINT AT x,y-1;p$;m$
  225 RETURN 
  229 REM up
  230 LET r=r-1
  231 IF m$="\n" THEN LET m$="\b"
  232 PRINT AT x,y-1;p$;AT r,c-1;m$
  234 RETURN 
  239 REM down
  240 LET r=r+1
  241 IF m$="\n" THEN LET m$="\b"
  242 PRINT AT x,y-1;p$;AT r,c-1;m$
  244 RETURN 
  400 PRINT AT r,c-1;"\i": LET d=2: IF c=32 OR r=21 THEN RETURN 
  402 IF NOT FN o(a$(r,c+1)) THEN RETURN : REM Not open above dig spot
  406 IF b$(r+1,c+1)<>"\c" THEN RETURN : REM Not diggable
  408 IF a$(r+1,c+1)="\g" THEN GO TO 420: REM Dug
  410 PRINT AT r+1,c;"\d";AT r,c-1;"\q": BEEP .01,0: PAUSE 10
  412 PRINT AT r+1,c;"\e";AT r,c-1;"\r": BEEP .01,0: PAUSE 10
  414 PRINT AT r+1,c;"\g";AT r,c-1;"\q": BEEP .01,0
  416 LET a$(r+1,c+1)="\g"
  418 RETURN 
  420 IF r<21 AND NOT FN s(a$(r+2,c+1)) THEN RETURN : REM No support below
  422 PRINT AT r+1,c;"\e";AT r,c-1;"\q": BEEP .01,0: PAUSE 10
  424 PRINT AT r+1,c;"\d";AT r,c-1;"\r": BEEP .01,0: PAUSE 10
  426 PRINT AT r+1,c;"\c";AT r,c-1;"\q": BEEP .01,0
  428 LET a$(r+1,c+1)="\c"
  429 RETURN 
  430 PRINT AT r,c-1;"\l": LET d=1: IF c=1 OR r=21 THEN RETURN 
  432 IF NOT FN o(a$(r,c-1)) THEN RETURN 
  436 IF b$(r+1,c-1)<>"\c" THEN RETURN 
  438 IF a$(r+1,c-1)="\g" THEN GO TO 450
  440 PRINT AT r+1,c-2;"\d";AT r,c-1;"\o": BEEP .01,0: PAUSE 10
  442 PRINT AT r+1,c-2;"\e";AT r,c-1;"\p": BEEP .01,0: PAUSE 10
  444 PRINT AT r+1,c-2;"\g";AT r,c-1;"\o": BEEP .01,0
  446 LET a$(r+1,c-1)="\g"
  448 RETURN 
  450 IF r<21 AND NOT FN s(a$(r+2,c-1)) THEN RETURN 
  452 PRINT AT r+1,c-2;"\e";AT r,c-1;"\o": BEEP .01,0: PAUSE 10
  454 PRINT AT r+1,c-2;"\d";AT r,c-1;"\p": BEEP .01,0: PAUSE 10
  456 PRINT AT r+1,c-2;"\c";AT r,c-1;"\o": BEEP .01,0
  458 LET a$(r+1,c-1)="\c"
  459 RETURN 
  500 SOUND 0,0;1,10;2,10;3,10;4,20;5,10;6,0;7,56;8,16;9,16;10,16;12,30;13,14
  502 GO SUB 8500: REM Draw top of title screen
  504 PRINT AT 14,10;"Please wait"
  506 GO SUB 6600: REM Fake brick
  508 GO SUB 8560: REM Draw bottom of screen
  510 PRINT AT 12,9;"\ :"; INVERSE 1;"P"; INVERSE 0;"\: lay game   "
  512 PRINT AT 14,9;"\ :"; INVERSE 1;"K"; INVERSE 0;"\: eys \ :"; INVERSE 1;"H"; INVERSE 0;"\: elp"
  516 PRINT AT 16,9;"\ :"; INVERSE 1;"E"; INVERSE 0;"\: dit levels"
  520 INPUT "": SOUND 6,31;7,28;10,12
  521 FOR b=13 TO 0 STEP -1: SOUND 10,b
  522 FOR a=31 TO 0 STEP -1: SOUND 6,a
  523 LET k$=INKEY$
  524 IF k$="" AND NOT STICK (2,1) THEN GO TO 530
  525 SOUND 13,0;7,63;8,0;9,0;10,0
  526 IF k$="h" THEN GO SUB 8100: INK 0: PAPER 7: BORDER bg: CLS : GO TO 502
  527 IF k$="p" OR STICK (2,1) THEN GO TO 900
  528 IF k$="e" THEN GO TO 6000
  529 IF k$="k" THEN GO SUB 8000: GO TO 510
  530 NEXT a: NEXT b
  535 SOUND 7,56;10,16;6,0
  540 LET k$=INKEY$
  541 IF k$="" AND NOT STICK (2,1) THEN GO TO 540
  542 SOUND 13,0;7,63;8,0;9,0;10,0
  543 IF k$="p" OR STICK (2,1) THEN GO TO 900
  544 IF k$="e" THEN GO TO 6000
  545 IF k$="k" THEN GO SUB 8000: GO TO 510
  546 IF k$="h" THEN GO SUB 8100: INK 0: PAPER 7: BORDER bg: CLS : GO TO 502
  550 GO TO 540
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
  700 INPUT "": PRINT #0;"   Press a key or button ..."
  710 IF INKEY$="" AND STICK (2,1)=0 THEN GO TO 710
  720 INPUT "": RETURN 
  900 BORDER bg: PAPER bg: INK fg: CLS 
  902 PRINT AT 10,0;"     Press a key or button"'"     when ready to load the"'"     first level from tape"
  904 PAUSE 20
  906 GO SUB 710
  910 LOAD "" DATA A$()
  911 GO SUB 5200
  912 CLS 
  915 PRINT AT 10,9; FLASH 1;"STOP THE TAPE"
  916 IF a$(22,32)=" " THEN GO SUB 5100
  920 LET q=3: LET sc=0: LET l=1
  930 GO TO 2039
 2000 FOR a=20 TO 50 STEP 5: BEEP .01,a: NEXT a
 2001 SOUND 13,0
 2010 CLS 
 2012 LET sc=sc+tr: REM Bonus for time
 2014 PRINT AT 8,11; INK bf;"Bonus: ";tr
 2020 PRINT AT 10,0;"     Prepare the tape for"'"        the next level"
 2022 PRINT '"   or press R to replay level"
 2024 GO SUB 700
 2026 IF INKEY$="r" THEN GO SUB 660: GO TO 101
 2030 LOAD "" DATA A$()
 2031 GO SUB 5200
 2032 IF a$(22,32)=" " THEN GO SUB 5100
 2035 LET l=l+1
 2037 CLS 
 2038 PRINT AT 10,9; FLASH 1;"STOP THE TAPE"
 2039 PRINT AT 12,0;"    PRESS ANY KEY or button    "'"        to start level";AT 15,15; INK bf;l: GO SUB 710
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
 5104 PRINT AT 0,0;"  Colorizing old v1 level ...   "
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
 6007 IF k$="l" THEN GO TO 6400
 6008 IF k$<>"n" THEN GO TO 6004
 6010 DIM a$(43,32): LET m1=10: LET a$(22,1)=CHR$ m1: LET m2=15: LET a$(22,2)=CHR$ m2: LET a$(22,32)="2": LET t$=""
 6011 PRINT AT m1,m2-1; FLASH 1;"\m": PRINT #0;"Wait...": LET n$=CHR$ FN c(" ")
 6012 FOR b=1 TO 32: LET a$(23,b)=n$: NEXT b
 6013 FOR a=2 TO 21: LET a$(22+a)=a$(23): NEXT a
 6014 DIM b$(43,32): GO SUB 650
 6015 INPUT "": GO TO 6019
 6016 REM Edit current level
 6018 GO SUB 5000: PRINT AT 0,0; INVERSE 1;"N"; INVERSE 0;"ame: ";t$;TAB 31;" "
 6019 LET r=m1: LET c=m2: LET m=0: LET m$="": LET z$="."
 6020 INPUT ""
 6021 PRINT #0;"1";FN i$("\c");
 6022 PRINT #0;"2";FN i$("\u");
 6023 PRINT #0;"3";FN i$("\g");
 6024 PRINT #0;"4";FN i$("\::");
 6025 PRINT #0;"5";FN i$("\h");
 6026 PRINT #0;"6";FN i$("\k");
 6027 PRINT #0;"7";FN i$("\j");
 6028 PRINT #0;"8";FN i$("\i");
 6029 PRINT #0;" spc  "; INVERSE 1;"S"; INVERSE 0;"ave "; INVERSE 1;"G"; INVERSE 0;"et "; INVERSE 1;"X"
 6030 PRINT AT r,c-1; FLASH 1; INK 8; PAPER 8; OVER 1;" "
 6040 LET k$=INKEY$
 6042 LET x=r: LET y=c
 6044 IF k$="" THEN LET s= STICK (1,1): LET k$=".az-k..-l.."(s+1)
 6046 IF k$="." THEN IF STICK (2,1) THEN LET k$=z$
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
 6120 LET a$(r,c)=i$: LET z$=k$
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
 6430 IF f$="" THEN GO SUB 5200
 6440 PRINT AT 10,10; FLASH 1;"STOP THE TAPE"
 6450 IF a$(22,32)=" " THEN GO SUB 5100
 6460 DIM b$(43,32): GO SUB 650
 6470 GO TO 6016: REM Start editing
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
 7002 LET q=q-1: IF q=0 THEN GO TO 7500
 7004 SOUND 12,0
 7006 FOR a=1 TO 21: SOUND 11,a: NEXT a
 7008 SOUND 13,0
 7020 INPUT "Continue/Redo/Next/Quit? ";k$
 7022 PAUSE 30
 7024 IF k$="c" THEN GO TO 7040
 7026 GO SUB 660
 7030 IF k$="n" THEN GO TO 2010
 7032 IF k$="q" THEN GO TO 7530
 7034 IF k$="e" THEN GO TO 6000
 7036 IF k$="r" THEN GO TO 101
 7039 GO TO 7020
 7040 LET ti=tr+2
 7042 IF tr<=0 THEN LET ti=20*(CODE a$(22,3)-m)+20
 7049 GO TO 103
 7500 SOUND 8,15;9,15;7,39;6,0;12,50;13,0
 7502 FOR a=30 TO 0 STEP -4: SOUND 6,a: NEXT a
 7504 FOR a=0 TO 31: SOUND 6,a: NEXT a
 7506 SOUND 8,16;9,16;13,0
 7510 PRINT AT 10,10;"           ";AT 11,10;" GAME OVER ";AT 12,10;"           "
 7520 PAUSE 240
 7530 INK 0: PAPER 7: BORDER bg: CLS 
 7540 GO TO 500
 8000 PRINT AT 11,1;"A - Up      N - Dig/fill left "
 8010 PRINT AT 12,1;"Z - Down    M - Dig/fill right"
 8020 PRINT AT 13,1;"K - Left    X - Jump Left     "
 8030 PRINT AT 14,1;"L - Right   C - Jump right    "
 8040 PRINT AT 15,1;"D - Die     P - Pause game    "
 8050 PRINT AT 16,1;"Shift+K/L - Face L/R          "
 8070 GO SUB 700
 8072 GO SUB 8300
 8090 FOR a=11 TO 16
 8092 PRINT AT a,1;"                              "
 8094 NEXT a
 8099 RETURN 
 8100 INK fg: PAPER bg: BORDER bg: CLS 
 8110 PRINT INK 7; PAPER 1; BRIGHT 1;" Thief Game Help "''
 8120 PRINT FN i$("\a");" \i \n"; INK fg;" You    ";
 8122 PRINT FN i$("\j"); INK fg;" Treasure"
 8124 PRINT "               (10 points)"''
 8126 PRINT FN i$("\k"); INK fg;" Overhead bar"
 8128 PRINT FN i$("\h"); INK fg;" Ladder"
 8130 PRINT FN i$("\t"); INK fg;" Diggable Floor"
 8132 PRINT FN i$("\::"); INK fg;" Solid Floor"
 8134 PRINT FN i$("\u"); INK fg;" False floor (edit mode)"
 8136 PRINT FN i$("\g"); INK fg;" Passage or dug out floor"
 8140 PRINT '"Walk left/right on floors and"
 8142 PRINT "through passages, climb ladders"
 8144 PRINT "or bars, dig the floor (don't"
 8146 PRINT "get trapped) or fill it in"
 8148 PRINT "(can't fill in if empty below)."
 8150 PRINT "You can fall any distance. Pick"
 8152 PRINT "up all treasures before time"
 8154 PRINT "runs out. Bonus for any time"
 8156 PRINT "remaining. H for help in editor."
 8158 GO SUB 700
 8199 RETURN 
 8200 CLS : PRINT AT 0,0; INK 7; PAPER 1; BRIGHT 1;" Thief Edit Help "
 8210 PRINT '"Use a/z/k/l or joystick to move"
 8212 PRINT "cursor. Keys 1-7 and space sets"
 8214 PRINT "block & moves in last direction."
 8216 PRINT "Button repeats last block."
 8220 PRINT '"1 ";FN i$("\c"); INK fg;" - Diggable floor"
 8222 PRINT "2 ";FN i$("\u"); INK fg;" - False floor"
 8224 PRINT "3 ";FN i$("\g"); INK fg;" - Passage"
 8226 PRINT "4 ";FN i$("\::"); INK fg;" - Solid floor"
 8228 PRINT "5 ";FN i$("\h"); INK fg;" - Ladder"
 8230 PRINT "6 ";FN i$("\k"); INK fg;" - Overhead bar"
 8232 PRINT "7 ";FN i$("\j"); INK fg;" - Treasure"
 8240 PRINT "8 ";FN i$("\i"); INK fg;" - Set the player start."
 8242 PRINT "      You can set the player at"
 8244 PRINT "      any walkable location"
 8246 PRINT "      except for a treasure."
 8250 PRINT "S   - Save the level"
 8252 PRINT "G   - Load (get) a level"
 8254 PRINT "X   - Quit without saving"
 8270 GO SUB 700
 8299 RETURN 
 8300 PRINT AT 11,1;"Joystick: Up/Down/L/R - Move  "
 8310 PRINT AT 12,1;"Button:                       "
 8320 PRINT AT 13,1;"+Down+L/R      - Dig/fill L/R "
 8330 PRINT AT 14,1;"+Up+Left/Right - Jump L/R     "
 8340 PRINT AT 15,1;"+Left/Right    - Face L/R     "
 8350 PRINT AT 16,1;"Up+Btn,release - Die/Next/Quit"
 8370 GO SUB 700
 8380 RETURN 
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
 8555 BORDER bg
 8556 INK 0
 8558 RETURN 
 8560 INK 2
 8565 PLOT 0,32: DRAW 255,0: DRAW 0,143: DRAW -255,0: DRAW 0,-143
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
 9054 LET o$(158)=CHR$ 7: REM \o Player, dig left down
 9056 LET o$(159)=CHR$ 7: REM \p Player, dig left up
 9058 LET o$(160)=CHR$ 7: REM \q Player, dig right down
 9060 LET o$(161)=CHR$ 7: REM \r Player, dig right up
 9062 LET o$(162)=CHR$ 5: REM \s Dug dirt pile
 9064 LET o$(163)=CHR$ 5: REM \t Brick, diggable, play mode copy
 9066 LET o$(164)=CHR$ 5: REM \u Brick, fake, edit mode copy
 9069 RETURN 
 9990 CLEAR 
 9992 SAVE "Thief" LINE 50
 9994 RUN 50
