
dev: Thief_prog.tap

levels: 
	cat 1_CASTLE_DATA.tap 3_VAULT_DATA.tap "4_BIG ROOM_DATA.tap" 5_BASEMENT_DATA.tap "6_KING'S DEN_DATA.tap" > Thief_levels.tap

dist: Thief.tap

Thief_prog.tap: Thief_zmb.bas
	zmakebas -n Thief -o Thief_prog.tap Thief_zmb.bas

Thief.tap: Thief_prog.tap Thief_levels.tap
	cat Thief_prog.tap Thief_levels.tap > Thief.tap

