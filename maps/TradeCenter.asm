TradeCenter_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	dw .Trigger1, 0
	dw .Trigger2, 0

.MapCallbacks:
	db 1

	; callbacks

	dbw 2, TradeCenter_SetWhichChris

.Trigger1:
	priorityjump TradeCenter_Initialize
	end

.Trigger2:
	end

TradeCenter_SetWhichChris:
	special Special_CableClubCheckWhichChris
	iffalse .Chris2
	disappear $3
	appear $2
	return

.Chris2:
	disappear $2
	appear $3
	return

TradeCenter_Initialize:
	dotrigger $1
	domaptrigger POKECENTER_2F, $1
	end

MapTradeCenterSignpost1Script:
	special Special_TradeCenter
	newloadmap MAPSETUP_LINKRETURN
	end

ChrisScript_0x19340b:
	loadfont
	writetext .FriendReadyText
	closetext
	loadmovesprites
	end

.FriendReadyText:
	text "Your friend is"
	line "ready."
	done

TradeCenter_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $4, 2, POKECENTER_2F
	warp_def $7, $5, 2, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 4, 4, SIGNPOST_RIGHT, MapTradeCenterSignpost1Script
	signpost 4, 5, SIGNPOST_LEFT, MapTradeCenterSignpost1Script

.PersonEvents:
	db 2
	person_event SPRITE_CHRIS, 4, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ChrisScript_0x193499, EVENT_GAVE_KURT_APRICORNS
	person_event SPRITE_CHRIS, 4, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ChrisScript_0x193499, EVENT_RECEIVED_BALLS_FROM_KURT
