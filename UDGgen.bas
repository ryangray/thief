# Load UDGs
# Sound channel C is fine tuned based on the UDG data byte while loading.
 9000 PRINT "Loading UDGs ..."
 9010 GO SUB 9100
 9020 PRINT "Saving UDGs as ""Thief UDGs"""
 9030 SAVE "Thief UDGs"CODE USR "a",168
 9040 PRINT "Done."
 9050 STOP
 9098 REM UDG's
 9099 REM \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u
 9100 RESTORE 9160
 9101 LET a=10: LET b=11
 9102 LET c=12: LET d=13
 9103 LET e=14: LET f=15
 9105 SOUND 0,0;1,10;2,2;3,10;4,4;5,10;6,0;7,56;8,16;9,16;10,16;11,24;12,180;13,14
 9109 SOUND 10,12;5,2
 9110 LET g=USR "a"
# 9111 LET m=0
 9112 READ k$
 9113 FOR i=1 TO LEN k$-1 STEP 2
 9114 LET j=PEEK g
 9115 LET k=VAL k$(i)*16+VAL k$(i+1)
# 9116 IF j<>k THEN LET m=1
 9117 POKE g,k: SOUND 4,k
 9118 LET g=g+1
 9119 NEXT i
# 9120 IF m=0 THEN GO TO 9150: REM Skip the rest
 9130 FOR h=2 TO 21
 9132 READ k$
 9134 FOR i=1 TO LEN k$-1 STEP 2
 9136 LET k=VAL k$(i)*16+VAL k$(i+1)
 9138 POKE g,k: SOUND 4,k
 9140 LET g=g+1
 9142 NEXT i
 9144 NEXT h
# Ch. C note before menu?
 9150 SOUND 10,16;4,20;5,10;13,0
 9152 RETURN 
 9159 REM UDG data
# \a Player stand right
 9160 DATA "181810383C18181C"
# \b Player climb left
 9161 DATA "58584A3E18386406"
# \c Brick solid
 9162 DATA "FFCC3333CCCC3333"
# \d Brick dug 1
 9163 DATA "89802333CCCC3333"
# \e Brick dug 2
 9164 DATA "8800240188C43333"
# \f Brick fake (looks like solid for play mode, checker for edit mode)
 9165 DATA "FFCC3333CCCC3333"
# \g Passage brick (walk through like in background)
 9166 DATA "8800220088002200"
# \h Ladder
 9167 DATA "427E4242427E4242"
# \i Player walk right
 9168 DATA "181810385E186446"
# \j Treasure
 9169 DATA "000000003C5E7E00"
# \k Overhead bar
 9170 DATA "00FF000000000000"
# \l Player walk left
 9171 DATA "1818081C7A182662"
# \m Player stand left
 9172 DATA "1818081C3C181838"
# \n Player climb right
 9173 DATA "1A1A527C181C2660"
# \o Player dig left down
 9174 DATA "3030181C1C3854D4"
# \p Player dig left up
 9175 DATA "1898C83C1C181414"
# \q Player dig right down
 9176 DATA "0C0C1838381C2A2B"
# \r Player dig right up
 9177 DATA "1819133C38182828"
# \s Dug dirt pile
 9178 DATA "0000000000142A55"
# \t Brick solid duplicate
 9179 DATA "FFCC3333CCCC3333"
# \u Brick fake for edit mode
 9180 DATA "8888222288882222"
