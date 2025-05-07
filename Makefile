
dev: Thief_noauto.tap Thief_UDG.tap Thief_levels.tap

udg: Thief_UDG.tap

levels: Thief_levels.tap

Thief_levels.tap: 1_CASTLE_DATA.tap 3_VAULT_DATA.tap 4_BIG\ ROOM_DATA.tap 5_BASEMENT_DATA.tap 6_KING'S\ DEN_DATA.tap
	cat 1_CASTLE_DATA.tap 3_VAULT_DATA.tap "4_BIG ROOM_DATA.tap" 5_BASEMENT_DATA.tap "6_KING'S DEN_DATA.tap" > Thief_levels.tap

Thief_UDG.tap: UDGgen.tap

UDGgen.tap: UDGgen.bas
	zmakebas -a 1 -n UDGgen -o UDGgen.tap UDGgen.bas
	fuse UDGgen.tap

dist: Thief.tap

Thief_noauto.tap: Thief_zmb.bas
	zmakebas -n Thief -o Thief_noauto.tap Thief_zmb.bas
	listbasic Thief_noauto.tap > Thief_tap.bas

Thief_auto.tap: Thief_zmb.bas
	zmakebas -a 50 -n Thief -o Thief_auto.tap Thief_zmb.bas
	listbasic Thief_auto.tap > Thief.bas

Thief.tap: Thief_auto.tap Thief_UDG.tap Thief_levels.tap
	cat Thief_auto.tap Thief_UDG.tap Thief_levels.tap > Thief.tap
