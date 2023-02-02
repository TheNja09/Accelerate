Timer = 5
function _OnFrame()
    World = ReadByte(Now + 0x00)
    Room = ReadByte(Now + 0x01)
    Place = ReadShort(Now + 0x00)
    Door = ReadShort(Now + 0x02)
    Map = ReadShort(Now + 0x04)
    Btl = ReadShort(Now + 0x06)
    Evt = ReadShort(Now + 0x08)
    Cheats()
end

function _OnInit()
    if GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301 and ENGINE_TYPE == "ENGINE" then--PCSX2
        Platform = 'PS2'
        Now = 0x032BAE0 --Current Location
        Save = 0x032BB30 --Save File
        Obj0 = 0x1C94100 --00objentry.bin
        Sys3 = 0x1CCB300 --03system.bin
        Btl0 = 0x1CE5D80 --00battle.bin
        Slot1 = 0x1C6C750 --Unit Slot 1
    elseif GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then--PC
        Platform = 'PC'
        Now = 0x0714DB8 - 0x56454E
        Save = 0x09A7070 - 0x56450E
        Obj0 = 0x2A22B90 - 0x56450E
		Cntrl = 0x2A148A8 - 0x56450E
        Sys3 = 0x2A59DB0 - 0x56450E
        Btl0 = 0x2A74840 - 0x56450E
        Slot1 = 0x2A20C58 - 0x56450E
    end
end

function Events(M,B,E) --Check for Map, Btl, and Evt
    return ((Map == M or not M) and (Btl == B or not B) and (Evt == E or not E))
end

function Cheats()
--WriteByte(Slot1+0x1B0,100) --Starting Drive %
--WriteByte(Slot1+0x1B1,5)   --Starting Drive Current
--WriteByte(Slot1+0x1B2,5)   --Starting Drive Max
local DriveDepleterPointer = 0x2A20238 - 0x56454E
local animpointer=ReadLong(0x1B2512)+0x2A8
local _CurrAnimPointer = ReadShort(ReadLong(0x00AD4218-0x56454E) + 0x180, true)
local soraJumpStrengthPointer=ReadLong(0x1B2512)+0x130
local L2 = ReadLong(0x2494573) > 500000 and ReadLong(0x2494573) < 900000
local SoraCurrentSpeed = 0x00716A60-0x56454E
local soraGravityPointer=ReadLong(0x1B2512)+0x138
	if L2 == true and ReadByte(Slot1+0x1B0) > 0 and ReadByte(Cntrl) == 0 and ReadByte(Now+0) ~= 0x0A then
		if ReadByte(Save+0x3524) == 1 or ReadByte(Save+0x3524) == 2 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 36, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 6, true)
		elseif ReadByte(Save+0x3524) == 4 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 30, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 6, true)
		elseif ReadByte(Save+0x3524) == 5 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 48, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 6, true)
		elseif ReadByte(Save+0x3524) == 6 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 54, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 6, true)
		else
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 24, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 6, true)
		end
	elseif L2 == true and ReadByte(Cntrl) == 0 and ReadByte(Now+0) == 0x0A then
	WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 54, true)
	WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 6, true)
	elseif L2 == false and ReadByte(Cntrl) == 0 and ReadByte(Now+0) ~= 0x0A or ReadByte(Slot1+0x1B0) == 0 and ReadByte(Slot1+0x1B1) == 0 then
		if ReadByte(Save+0x3524) == 1 or ReadByte(Save+0x3524) == 2 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 12, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 2, true)
		elseif ReadByte(Save+0x3524) == 4 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 10, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 2, true)
		elseif ReadByte(Save+0x3524) == 5 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 16, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 2, true)
		elseif ReadByte(Save+0x3524) == 6 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 18, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 2, true)
		else
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 8, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 2, true)
		end
	elseif L2 == false and ReadByte(Cntrl) == 0 and ReadByte(Now+0) == 0x0A then
	WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 18, true)
	WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 2, true)
	end
	--Universal Applications
	if L2 == true and ReadByte(Cntrl) == 0 and ReadByte(Slot1+0x1B0) > 0 then
	WriteFloat(soraJumpStrengthPointer, 185 * 2, true)
	WriteFloat(soraGravityPointer, 16 * 4, true)
	WriteFloat(0x250D332, 16 * 2) -- Glide 1 Speed (Default: 16)
	WriteFloat(0x250D376, 20 * 2) -- Glide 2 Speed (Default: 20)
	WriteFloat(0x250D3BA, 24 * 2) -- Glide 3 Speed (Default: 24)
	WriteFloat(0x250D3FE, 32 * 2) -- Glide MAX Speed (Default: 32)
	WriteFloat(0x250D442, 64 * 2) -- Glide AX2 Speed (Default: 64)
	WriteFloat(0x250D312, 235 * 2) -- Sora Base Jump Height
	WriteFloat(0x250D356, 310 * 2) -- Sora High Jump 2
	WriteFloat(0x250D39A, 385 * 2) -- Sora High Jump 3
	WriteFloat(0x250D3DE, 585 * 2) -- Sora High Jump MAX
	WriteFloat(0x250D422, 585 * 2) -- Sora High Jump AX2
	WriteFloat(0x250D322, 30 * 2) -- QR1 Speed
	WriteFloat(0x250D366, 34 * 3) -- QR2 Speed
	WriteFloat(0x250D3AA, 38 * 3) -- QR3 Speed
	WriteFloat(0x250D3EE, 38 * 3.25) -- QR4 Speed
	WriteFloat(0x250D432, 38 * 3.5) -- QRAX2 Speed
	WriteFloat(0x250D316, 145 * 2.5) -- AD1 Height
	WriteFloat(0x250D31A, 18 * 1.5) -- AD1 Speed
	WriteFloat(0x250D35A, 155 * 2.5) -- AD2 Height
	WriteFloat(0x250D35E, 24 * 1.5) -- AD2 Speed
	WriteFloat(0x250D39E, 200 * 2.5) -- AD3 Height
	WriteFloat(0x250D3A2, 30 * 1.5) -- AD3 Speed
	WriteFloat(0x250D3E2, 300 * 2.5) -- AD4 Height
	WriteFloat(0x250D3E6, 36 * 1.5) -- AD4 Speed
	WriteFloat(0x250D426, 1700 * 2.5) -- ADAX2 Height
	WriteFloat(0x250D42A, 36 * 1.5) -- ADAX2 Speed
	Timer = Timer - 1
		if Timer <= 0 then
			if ReadByte(Slot1+0x1B0) > 0 and ReadByte(Save+0x3524) == 0 then
			WriteByte(Slot1+0x1B0, ReadByte(Slot1+0x1B0) - 1)
			Timer = 5
			elseif ReadByte(Slot1+0x1B0) > 0 and ReadByte(Slot1+0x1B1) > 0 and ReadByte(Save+0x3524) ~= 0 then
			WriteFloat(ReadLong(DriveDepleterPointer) + 0xE6C, 3, true)
			end
		end
		if _CurrAnimPointer == 1 or _CurrAnimPointer == 2 or _CurrAnimPointer == 201 or _CurrAnimPointer == 4 or _CurrAnimPointer == 202 or _CurrAnimPointer == 205 or _CurrAnimPointer == 206 or _CurrAnimPointer == 3 then
			if ReadByte(Slot1+0x1B0) > 0 then
			WriteFloat(animpointer, 3, true)
			else WriteFloat(animpointer, 1, true)
			end
		else WriteFloat(animpointer, 1, true)
		end
		if ReadByte(Slot1+0x1B0) == 0 and ReadByte(Slot1+0x1B1) > 0 then
		WriteByte(Slot1+0x1B0, 100)
		WriteByte(Slot1+0x1B1, ReadByte(Slot1+0x1B1) - 1)
		end
	elseif L2 == false or ReadByte(Slot1+0x1B0) == 0 and ReadByte(Slot1+0x1B1) == 0 then
	WriteFloat(soraGravityPointer, 16, true)
	WriteFloat(soraJumpStrengthPointer, 185, true)
	WriteFloat(0x250D332, 16) -- Glide 1 Speed (Default: 16)
	WriteFloat(0x250D376, 20) -- Glide 2 Speed (Default: 20)
	WriteFloat(0x250D3BA, 24) -- Glide 3 Speed (Default: 24)
	WriteFloat(0x250D3FE, 32) -- Glide MAX Speed (Default: 32)
	WriteFloat(0x250D442, 64) -- Glide AX2 Speed (Default: 64)
	WriteFloat(0x250D312, 235) -- Sora Base Jump Height
	WriteFloat(0x250D356, 310) -- Sora High Jump 2
	WriteFloat(0x250D39A, 385) -- Sora High Jump 3
	WriteFloat(0x250D3DE, 585) -- Sora High Jump MAX
	WriteFloat(0x250D422, 585) -- Sora High Jump AX2
	WriteFloat(0x250D322, 30) -- QR1 Speed
	WriteFloat(0x250D366, 34) -- QR2 Speed
	WriteFloat(0x250D3AA, 38) -- QR3 Speed
	WriteFloat(0x250D3EE, 38) -- QR4 Speed
	WriteFloat(0x250D432, 38) -- QRAX2 Speed
	WriteFloat(0x250D316, 145) -- AD1 Height
	WriteFloat(0x250D31A, 18) -- AD1 Speed
	WriteFloat(0x250D35A, 155) -- AD2 Height
	WriteFloat(0x250D35E, 24) -- AD2 Speed
	WriteFloat(0x250D39E, 200) -- AD3 Height
	WriteFloat(0x250D3A2, 30) -- AD3 Speed
	WriteFloat(0x250D3E2, 300) -- AD4 Height
	WriteFloat(0x250D3E6, 36) -- AD4 Speed
	WriteFloat(0x250D426, 1700) -- ADAX2 Height
	WriteFloat(0x250D42A, 36) -- ADAX2 Speed
	WriteFloat(animpointer, 1, true)
	WriteFloat(ReadLong(DriveDepleterPointer) + 0xE6C, 1, true)
		if ReadByte(Save+0x3524) == 1 or ReadByte(Save+0x3524) == 2 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 12, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 2, true)
		elseif ReadByte(Save+0x3524) == 4 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 10, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 2, true)
		elseif ReadByte(Save+0x3524) == 5 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 16, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 2, true)
		elseif ReadByte(Save+0x3524) == 6 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 18, true)
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x128, 2, true)
		end
	end
end
