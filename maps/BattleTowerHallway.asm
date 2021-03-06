BattleTowerHallway_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	dw .Trigger0, 0
	dw .Trigger1, 0

.MapCallbacks:
	db 0

.Trigger0:
	priorityjump .ChooseBattleRoom
	dotrigger $1
.Trigger1:
	end

.ChooseBattleRoom:
	follow $2, PLAYER
	callasm .asm_load_battle_room
	jump .WalkToChosenBattleRoom


.asm_load_battle_room:
	ld a, [rSVBK]
	push af

	ld a, BANK(wBTChoiceOfLvlGroup)
	ld [rSVBK], a
	ld a, [wBTChoiceOfLvlGroup]
	ld [ScriptVar], a

	pop af
	ld [rSVBK], a
	ret


; enter different rooms for different levels to battle against
; at least it should look like that
; because all warps lead to the same room
.WalkToChosenBattleRoom: ; 0x9f5dc
	if_equal 3, .L30L40
	if_equal 4, .L30L40
	if_equal 5, .L50L60
	if_equal 6, .L50L60
	if_equal 7, .L70L80
	if_equal 8, .L70L80
	if_equal 9, .L90L100
	if_equal 10, .L90L100
	applymovement $2, MovementData_0x9e57a
	jump .EnterBattleRoom

.L30L40: ; 0x9f603
	applymovement $2, MovementData_0x9e57c
	jump .EnterBattleRoom

.L50L60: ; 0x9f60a
	applymovement $2, MovementData_0x9e586
	jump .EnterBattleRoom

.L70L80: ; 0x9f611
	applymovement $2, MovementData_0x9e584
	jump .EnterBattleRoom

.L90L100: ; 0x9f618
	applymovement $2, MovementData_0x9e582
	jump .EnterBattleRoom

.EnterBattleRoom: ; 0x9f61f
	faceperson PLAYER, $2
	loadfont
	writetext Text_PleaseStepThisWay
	closetext
	loadmovesprites
	stopfollow
	applymovement PLAYER, MovementData_0x9e576
	warpcheck
	end

BattleTowerHallway_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $1, $b, 1, BATTLE_TOWER_ELEVATOR
	warp_def $0, $5, 1, BATTLE_TOWER_BATTLE_ROOM
	warp_def $0, $7, 1, BATTLE_TOWER_BATTLE_ROOM
	warp_def $0, $9, 1, BATTLE_TOWER_BATTLE_ROOM
	warp_def $0, $d, 1, BATTLE_TOWER_BATTLE_ROOM
	warp_def $0, $f, 1, BATTLE_TOWER_BATTLE_ROOM

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_RECEPTIONIST, 2, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BattleTowerHallway_MapEventHeader, -1
