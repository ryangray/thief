
dev: dev.tap

levels: 1_CASTLE_DATA.tap 3_VAULT_DATA.tap 4_BIG\ ROOM_DATA.tap 5_BASEMENT_DATA.tap 6_KING\'S\ DEN_DATA.tap
    cat 1_CASTLE_DATA.tap 3_VAULT_DATA.tap 4_BIG\ ROOM_DATA.tap 5_BASEMENT_DATA.tap 6_KING\'S\ DEN_DATA.tap > Thief_levels.tap

dist: Thief_all.tap

dev.tap: Thief_zmb.bas
    zmakebas -n Thief -o dev.tap Thief_zmb.bas

Thief_all.tap: Thief.tap Thief_levels.tap
    cat Thief.tap Thief_levels.tap > Thief_all.tap

