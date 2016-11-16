--CyanPower_hud_beta ( Тут был Дениска )
--   __  __   ___                                  __   __
--  /\ \/\ \ /\_ \                             __ /\ \ /\ \
--  \ \ \/'/ \//\ \    __  __     __      ___ /\_\\ `\`\/'/'
--   \ \   <   \ \ \  /\ \/\ \  /'__`\  /' _ `\/\ \`\/ > <
--    \ \ \\`\  \_\ \_\ \ \_\ \/\ \_\.\_/\ \/\ \ \ \  \/'/\`\
--     \ \_\ \_\/\____\\/`____ \ \__/.\_\ \_\ \_\ \_\ /\_\\ \_\
--      \/_/\/_/\/____/ `/___/  \/__/\/_/\/_/\/_/\/_/ \/_/ \/_/
--                         /\___/
--                         \/__/
CreateClientConVar( "cph_displayRounds", "0", true, false )
CreateClientConVar( "cph_displayCrosshire", "0", true, false )
CreateClientConVar( "cph_displayFPS", "1", true, false )
CreateClientConVar( "cph_displayClocks", "1", true, false )
CreateClientConVar( "cph_displayCompass", "1", true, false )
CreateClientConVar( "cph_displayPropInfo", "1", true, false )
CreateClientConVar( "cph_hudcolor_plycolor", "0", true, false )
CreateClientConVar( "cph_hudwepcolor_physcolor", "0", true, false )
CreateClientConVar( "cph_maxHP_r", "0", true, false )
CreateClientConVar( "cph_maxHP_g", "255", true, false )
CreateClientConVar( "cph_maxHP_b", "255", true, false )
CreateClientConVar( "cph_lowHP_r", "255", true, false )
CreateClientConVar( "cph_lowHP_g", "0", true, false )
CreateClientConVar( "cph_lowHP_b", "0", true, false )
CreateClientConVar( "cph_maxArmor_r", "0", true, false )
CreateClientConVar( "cph_maxArmor_g", "255", true, false )
CreateClientConVar( "cph_maxArmor_b", "255", true, false )
CreateClientConVar( "cph_lowArmor_r", "255", true, false )
CreateClientConVar( "cph_lowArmor_g", "0", true, false )
CreateClientConVar( "cph_lowArmor_b", "0", true, false )
CreateClientConVar( "cph_weapon_r", "0", true, false )
CreateClientConVar( "cph_weapon_g", "255", true, false )
CreateClientConVar( "cph_weapon_b", "255", true, false )
CreateClientConVar( "cph_ch_r", "0", true, false )
CreateClientConVar( "cph_ch_g", "255", true, false )
CreateClientConVar( "cph_ch_b", "255", true, false )
CreateClientConVar( "cph_chds_r", "0", true, false )
CreateClientConVar( "cph_chds_g", "255", true, false )
CreateClientConVar( "cph_chds_b", "255", true, false )
CreateClientConVar( "cph_chdl_r", "0", true, false )
CreateClientConVar( "cph_chdl_g", "255", true, false )
CreateClientConVar( "cph_chdl_b", "123", true, false )
CreateClientConVar( "cph_clocks_r", "0", true, false )
CreateClientConVar( "cph_clocks_g", "255", true, false )
CreateClientConVar( "cph_clocks_b", "255", true, false )
CreateClientConVar( "cph_blursize", "7", true, false )
CreateClientConVar( "cph_ch_dot_from_clip", "1", true, false )
CreateClientConVar( "cph_ch_dots", "60", true, false )
CreateClientConVar( "cph_ch_dots_radius", "22", true, false )
CreateClientConVar( "cph_ch_dots_speed", "0.01", true, false )
CreateClientConVar( "cph_ch_dots_size", "2", true, false )
CreateClientConVar( "cph_ch_size", "8", true, false )
CreateClientConVar( "cph_ch_pos_mode", "0", true, false )

local s64 = 0
local cph_HealthPos = -s64
local cph_clocks_h = os.date( "%H" , os.time() )
local cph_blursize = GetConVarNumber("cph_blursize")
local cph_ArmorAlpha = 0
local cph_WeaponAlpha = 0
local cph_Ammo1Alpha = 0
local cph_Ammo2Alpha = 0
local cph_ch_speed = 0.01
local cph_ch_dotsrad = 0
local Pitch, Yaw, VelX, VelY = 0, 0, 0, 0
local hide_ch = true

local hide =
{
	["CHudAmmo"] = true,
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudCrosshair"] = true,
	["CHudSecondaryAmmo"] = true,
}
local function HUDShouldDraw(name)
	if GetConVarNumber("cph_displayCrosshire") == 1 then
		hide["CHudCrosshair"] = true
	else
		hide["CHudCrosshair"] = false
	end
	return not hide[name]
end
hook.Add( "HUDShouldDraw", "HudHider", HUDShouldDraw )
local FPS = 0
timer.Create("fps", 0.8 , 0 , function()
	FPS = math.floor( 1 / RealFrameTime() )
end )

function draw.Circle( x, y, radius, seg, color )
	local cir = {}

	table.insert( cir, { x = x, y = y} )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius } )
	end

	surface.SetDrawColor(color.r, color.g, color.b, color.a)
	surface.DrawPoly( cir )
end

local weapon2secondfireTable =
{
	weapon_ar2 = "z",
	weapon_smg1 = "t"
}

local function weapon2secondfire(weapon_class)
	return weapon2secondfireTable[ weapon_class ] or ""
end

local weapon2shellsTable =
{
	weapon_357 = "q",
	weapon_ar2 = "u",
	weapon_crossbow = "w",
	weapon_smg1 = "r",
	weapon_shotgun = "s",
	weapon_rpg = "3",
	weapon_pistol = "p",
	weapon_physgun = "9",
	weapon_physcannon = "9"
}
local function weapon2shells(weapon_class)
	return weapon2shellsTable[ weapon_class ] or "p"
end

local weapon2iconTable =
{
	weapon_357 = "e",
	weapon_ar2 = "l",
	weapon_crossbow = "g",
	weapon_smg1 = "a",
	weapon_shotgun = "b",
	weapon_rpg = "i",
	weapon_pistol = "d",
	weapon_stunstick = "n",
	weapon_slam = "o",
	weapon_crowbar = "c",
	weapon_physgun = "m",
	weapon_frag = "k",
	weapon_physcannon = "m",
	weapon_bugbait = "j"
}
local function weapon2icon(weapon_class)
	return weapon2iconTable[ weapon_class ] or ""
end

local function sec2str( sec )
 return string.format( "%01dh %02dm %02dc", math.floor( sec / 3600 ), math.floor( sec / 60 ) % 60, math.floor( sec ) % 60 )
end

local function UpdateResolution()

	cph_blursize = GetConVarNumber( "cph_blursize" )
	s64 = (ScrH()/18)

	surface.CreateFont( "Text", {
		font = "AmazObitaemOstrovV.2",
		size = s64,
		antialias = true,
		shadow = true,
	} )

	surface.CreateFont( "Text_small", {
		font = "AmazObitaemOstrovV.2",
		size = s64/2,
		antialias = true,
		shadow = true,
	} )

	surface.CreateFont( "Text_smallest", {
		font = "AmazObitaemOstrovV.2",
		size = s64/3,
		antialias = true,
		shadow = true,
	} )


	surface.CreateFont( "Text_propinfo", {
		font = "Roboto-Black",
		size = s64/3,
		antialias = true,
		shadow = true,
	} )

	surface.CreateFont( "Hightlight", {
		font = "AmazObitaemOstrovV.2",
		size = s64,
		blursize = cph_blursize,
	} )

	surface.CreateFont( "Hightlight_small", {
	  font = "AmazObitaemOstrovV.2",
		size = s64/2,
		blursize = cph_blursize,
	} )

	surface.CreateFont( "Hightlight_smallest", {
	  font = "AmazObitaemOstrovV.2",
		size = s64/3,
		blursize = cph_blursize,
	} )

	surface.CreateFont( "FPS", {
		font = "AmazObitaemOstrovV.2",
		size = s64/2,
		antialias = true,
		shadow = true,
	} )

	surface.CreateFont( "FPS_HL", {
		font = "AmazObitaemOstrovV.2",
		size = s64/2,
		blursize = cph_blursize,
	} )

	surface.CreateFont( "Icons", {
		font = "Webdings",
		size = s64,
		//antialias = true,
		symbol = true,
		shadow = true,
	} )

	surface.CreateFont( "DamageType", {
		font = "HL2MP",
		size = s64,
		antialias = true,
	} )

	surface.CreateFont( "Weapon", {
		font = "HALFLIFE2",
		size = s64,
		antialias = true,
	} )

	surface.CreateFont( "WeaponHl", {
		font = "HALFLIFE2",
		size = s64,
		blursize = cph_blursize,
		antialias = true,
	} )
end
UpdateResolution()
local function hud()
		if s64 != ScrH()/18 or cph_blursize != GetConVarNumber( "cph_blursize" ) then
			UpdateResolution()
		end
		--Thinks stuff, but think doesn't work twer swag 228
		local Player_Vel = LocalPlayer():GetVelocity()
		local Screen_Vel = { x = Pitch - EyeAngles().pitch, y = Yaw - EyeAngles().yaw }

		Player_Vel:Rotate( Angle( 0, -EyeAngles().yaw, 0 ) )
		Pitch, Yaw = EyeAngles().pitch, EyeAngles().yaw

		if math.abs( Screen_Vel.y ) >= 300 then Screen_Vel.y = 0 end
		local To_VelX = math.Clamp( ( Player_Vel.x / 10 ) + ( Screen_Vel.x / 15 ) / FrameTime(), -s64, s64 )
		local To_VelY = math.Clamp( ( Player_Vel.y / 10 ) - ( Screen_Vel.y / 15 ) / FrameTime(), -s64, s64 )

		VelX = math.Approach( VelX, To_VelX, ( math.abs( VelX - To_VelX ) + 0.5 ) * 10 * FrameTime() )
		VelY = math.Approach( VelY, To_VelY, ( math.abs( VelY - To_VelY ) + 0.5 ) * 10 * FrameTime() )
		--if LocalPlayer():Alive() and LocalPlayer():IsConnected() then
		if LocalPlayer():Alive() then
			if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass()!="gmod_camera" then
			--Health Bar--
			local cph_Health = LocalPlayer():Health()
			local cph_MaxHealth = LocalPlayer():GetMaxHealth()
			local cph_HealthColorValue = math.Clamp(cph_Health/cph_MaxHealth, 0, 1)
			local cph_mhr = cph_HealthColorValue * GetConVarNumber("cph_maxHP_r")
			local cph_mhg = cph_HealthColorValue * GetConVarNumber("cph_maxHP_g")
			local cph_mhb = cph_HealthColorValue * GetConVarNumber("cph_maxHP_b")
			local cph_lhr = (1 - cph_HealthColorValue) * GetConVarNumber("cph_lowHP_r")
			local cph_lhg = (1 - cph_HealthColorValue) * GetConVarNumber("cph_lowHP_g")
			local cph_lhb = (1 - cph_HealthColorValue) * GetConVarNumber("cph_lowHP_b")
			local cph_HealthColor = Color(cph_mhr + cph_lhr, cph_mhg + cph_lhg, cph_mhb + cph_lhb)
			local cph_HP_bar_size = string.len(cph_Health.."") - 3
			cph_HealthPos=s64

			if GetConVarNumber("cph_hudcolor_plycolor") == 1 then
				LocalPlayer():SetPlayerColor( Vector(cph_HealthColor.r, cph_HealthColor.g, cph_HealthColor.b) / 255 )
				--GetConVarNumber("cl_playercolor")
				--cl_weaponcolor
			end

			draw.RoundedBoxEx(10, cph_HealthPos + VelY, ScrH() - cph_HealthPos - s64 + VelX, s64, s64, Color(0,0,0,150), true, false, true, false)
			draw.RoundedBoxEx(10, cph_HealthPos * 2 + VelY, ScrH() - cph_HealthPos - s64 + VelX, s64 * 2 +  s64 * cph_HP_bar_size/2, s64, ColorAlpha(cph_HealthColor,30), false, true, false, true)
			draw.SimpleText(cph_Health, "Text", 2 * cph_HealthPos + s64 / 4 + VelY, ScrH() - cph_HealthPos - s64 + VelX, cph_HealthColor)
			draw.SimpleText(cph_Health, "Hightlight", 2 * cph_HealthPos + s64 / 4 + VelY, ScrH() - cph_HealthPos - s64 + VelX, cph_HealthColor)

			local m = Material("CyanPowerHUD/heart.png")
			 surface.SetMaterial(m)
			 surface.SetDrawColor(cph_HealthColor)
			 surface.DrawTexturedRect( cph_HealthPos + VelY + (s64 * (1 - cph_HealthColorValue))/2, ScrH() - cph_HealthPos - s64 + VelX + (s64 * (1 - cph_HealthColorValue))/2, s64 * cph_HealthColorValue, s64 * cph_HealthColorValue )
			//draw.SimpleText("Y", "Icons", cph_HealthPos + VelY , ScrH() - cph_HealthPos - s64 + VelX, cph_HealthColor)

			--ArmorBar--
			local cph_Armor = LocalPlayer():Armor()
			local cph_Armor_Draw = cph_Armor > 0 and 1 or 0
			cph_ArmorAlpha = math.Approach(cph_ArmorAlpha, cph_Armor_Draw * 255, (cph_Armor_Draw * 255 - cph_ArmorAlpha) * FrameTime())
			if cph_ArmorAlpha > 0 then
				local cph_MaxArmor = 100
				local cph_Armor_bar_size = string.len(cph_Armor.."") - 3
				local cph_ArmorColorValue = math.Clamp(cph_Armor/cph_MaxArmor, 0, 1)
				local cph_mar = cph_ArmorColorValue * GetConVarNumber("cph_maxArmor_r")
				local cph_mag = cph_ArmorColorValue * GetConVarNumber("cph_maxArmor_g")
				local cph_mab = cph_ArmorColorValue * GetConVarNumber("cph_maxArmor_b")
				local cph_lar = (1 - cph_ArmorColorValue) * GetConVarNumber("cph_lowArmor_r")
				local cph_lag = (1 - cph_ArmorColorValue) * GetConVarNumber("cph_lowArmor_g")
				local cph_lab = (1 - cph_ArmorColorValue) * GetConVarNumber("cph_lowArmor_b")
				local cph_ArmorColor= Color( cph_mar + cph_lar, cph_mag + cph_lag, cph_mab + cph_lab, cph_ArmorAlpha)

				draw.RoundedBoxEx(10, cph_HealthPos + VelY, ScrH() - cph_HealthPos - 2 * s64 - s64 / 2 + VelX, s64, s64, Color(0, 0, 0, math.Clamp(cph_ArmorAlpha, 0, 155)), true, false, true, false)
				draw.RoundedBoxEx(10, cph_HealthPos * 2 + VelY, ScrH() - cph_HealthPos - 2 * s64 - s64 / 2 + VelX, s64 * 2 + s64 * cph_Armor_bar_size / 2, s64, ColorAlpha(cph_ArmorColor, math.Clamp(cph_ArmorAlpha, 0, 30)), false, true, false, true)
				draw.SimpleText(cph_Armor, "Text", 2 * cph_HealthPos + s64 / 4 + VelY, ScrH() - cph_HealthPos - 2 * s64 - s64 / 2 + VelX, cph_ArmorColor)
				draw.SimpleText(cph_Armor, "Hightlight", 2 * cph_HealthPos + s64 / 4 + VelY, ScrH() - cph_HealthPos - 2 * s64 - s64 / 2 + VelX, cph_ArmorColor)
				local ms = Material("CyanPowerHUD/shield.png")
				 surface.SetMaterial(ms)
				 surface.SetDrawColor(cph_ArmorColor)
				 surface.DrawTexturedRect( cph_HealthPos + VelY + (s64 * (1 - cph_ArmorColorValue))/2, ScrH() - cph_HealthPos - 2 * s64 - s64 / 2 + VelX + (s64 * (1 - cph_ArmorColorValue))/2, s64 * cph_ArmorColorValue, s64 * cph_ArmorColorValue )
				//draw.SimpleText("d", "Icons", cph_HealthPos + VelY , ScrH() - cph_HealthPos - 2 * s64 - s64 / 2 + VelX, cph_ArmorColor)
			end

			--AmmoBar--
			local cph_weapon = LocalPlayer():GetActiveWeapon()

			local cph_WeaponColor = Color(GetConVarNumber("cph_weapon_r"), GetConVarNumber("cph_weapon_g"), GetConVarNumber("cph_weapon_b"), cph_WeaponAlpha)
			local cph_Ammo1Color = Color(GetConVarNumber("cph_weapon_r"), GetConVarNumber("cph_weapon_g"), GetConVarNumber("cph_weapon_b"), cph_Ammo1Alpha)
			local cph_Ammo2Color = Color(GetConVarNumber("cph_weapon_r"), GetConVarNumber("cph_weapon_g"), GetConVarNumber("cph_weapon_b"), cph_Ammo2Alpha)

			if GetConVarNumber("cph_hudwepcolor_physcolor") == 1 then
				LocalPlayer():SetWeaponColor( Vector(GetConVarNumber("cph_weapon_r"), GetConVarNumber("cph_weapon_g"), GetConVarNumber("cph_weapon_b")) / 255 )
			end

			if IsValid( cph_weapon ) and not LocalPlayer():InVehicle() then
				local cph_Ammo1Type = cph_weapon:GetPrimaryAmmoType()
				local cph_Ammo2Type = cph_weapon:GetSecondaryAmmoType()
				local cph_Ammo1 = LocalPlayer():GetAmmoCount(cph_Ammo1Type)
				local cph_Ammo2 = LocalPlayer():GetAmmoCount(cph_Ammo2Type)
				local cph_Clip = cph_weapon:Clip1()
				if weapon2icon(cph_weapon:GetClass())!="" then
					BoxRoundWeapon = false
					cph_WeaponAlpha = math.Approach(cph_WeaponAlpha, 255, (255 - cph_WeaponAlpha) * 2 * FrameTime())
				else
					BoxRoundWeapon = true
					cph_WeaponAlpha = math.Approach(cph_WeaponAlpha, 0,  -cph_WeaponAlpha * 2 * FrameTime())
				end
				draw.RoundedBoxEx(10, ScrW() - s64*4 - s64 + VelY , ScrH() - s64 - s64 + VelX, s64*2, s64, Color(0,0,0,math.Clamp(cph_WeaponAlpha,0,150)), BoxRoundAmmo1, BoxRoundAmmo1, true, BoxRoundAmmoS)
				draw.SimpleText(weapon2icon(cph_weapon:GetClass()), "Weapon", ScrW() - s64*4 + VelY , ScrH() - s64 - s64 + VelX, cph_WeaponColor,TEXT_ALIGN_CENTER)
				draw.SimpleText(weapon2icon(cph_weapon:GetClass()), "WeaponHl", ScrW() - s64*4 + VelY , ScrH() - s64 - s64 + VelX, cph_WeaponColor,TEXT_ALIGN_CENTER)
				if cph_Ammo1Type>0 then
					cph_Ammo1Alpha = math.Approach(cph_Ammo1Alpha, 255, (255 - cph_Ammo1Alpha) * 2 * FrameTime())
					BoxRoundAmmo1 = false
				else
					BoxRoundAmmo1 = true
					cph_Ammo1Alpha = math.Approach(cph_Ammo1Alpha, 0, -cph_Ammo1Alpha * 2 * FrameTime())
				end
				draw.RoundedBoxEx(10, ScrW() - s64*4 - s64 + VelY , ScrH() - s64*2 - s64 + VelX, s64*4, s64, Color(0,0,0,math.Clamp(cph_Ammo1Alpha,0,150)), true, true, BoxRoundWeapon, BoxRoundAmmoS)
				if cph_Clip>0 then
					draw.SimpleText(cph_Clip, "Text", ScrW() - s64*2.7 - s64 + VelY , ScrH() - s64*2 - s64 + VelX, cph_Ammo1Color,TEXT_ALIGN_RIGHT)
					draw.SimpleText(cph_Clip, "Hightlight", ScrW() - s64*2.7 - s64 + VelY , ScrH() - s64*2 - s64 + VelX, cph_Ammo1Color,TEXT_ALIGN_RIGHT)

					draw.SimpleText("|", "Text", ScrW() - s64*2 - s64*1.5 + VelY , ScrH() - s64*2 - s64 + VelX, cph_Ammo1Color,TEXT_ALIGN_CENTER)
					draw.SimpleText("|", "Hightlight", ScrW() - s64*2 - s64*1.5 + VelY , ScrH() - s64*2 - s64 + VelX, cph_Ammo1Color,TEXT_ALIGN_CENTER)

					if GetConVarNumber("cph_displayRounds") == 1 then
						for i=1,math.Clamp(cph_Clip,0,45) do
							if (i < cph_Clip) then
								draw.SimpleText(weapon2shells(cph_weapon:GetClass()), "Weapon", ScrW() - s64/1.5 + VelY , ScrH() - s64 - (i-1)*s64/4 + VelX, cph_Ammo1Color)
							end
							--draw.SimpleText(weapon2shells(cph_weapon), "WeaponHl", ScrW() - 64 , ScrH() - 64 - (i-1)*13, Color(0,255,255,255))
						end
					end
				else
				end
				draw.SimpleText(cph_Ammo1, "Text", ScrW() - s64*2.35 - s64 + VelY , ScrH() - s64*2 - s64 + VelX, cph_Ammo1Color)
				draw.SimpleText(cph_Ammo1, "Hightlight", ScrW() - s64*2.35 - s64 + VelY , ScrH() - s64*2 - s64 + VelX, cph_Ammo1Color)
				if cph_Ammo2Type > 0 then
					BoxRoundAmmoS = false
					cph_Ammo2Alpha = math.Approach(cph_Ammo2Alpha, 255, (255 - cph_Ammo2Alpha) * 2 * FrameTime())
				else
					BoxRoundAmmoS = true
					cph_Ammo2Alpha = math.Approach(cph_Ammo2Alpha, 0, -cph_Ammo2Alpha * 2 * FrameTime())
				end
				draw.RoundedBoxEx(10, ScrW() - s64*2 - s64 + VelY , ScrH() - s64*1 - s64 + VelX, s64*2, s64, Color(0,0,0,math.Clamp(cph_Ammo2Alpha,0,150)), BoxRoundAmmoS, BoxRoundAmmoS, BoxRoundAmmoS, true)
				draw.SimpleText(cph_Ammo2, "Text", ScrW() - s64*1.4 - s64 + VelY , ScrH() - s64*1 - s64 + VelX, cph_Ammo2Color)
				draw.SimpleText(cph_Ammo2, "Hightlight", ScrW() - s64*1.4 - s64 + VelY , ScrH() - s64*1 - s64 + VelX, cph_Ammo2Color)
				draw.SimpleText(weapon2secondfire(cph_weapon:GetClass()) , "Weapon", ScrW() - s64*2.4 - s64 + VelY , ScrH() - s64 * 0.8 - s64 + VelX, cph_Ammo2Color)
			end
			--Crosshire--
			if GetConVarNumber("cph_displayCrosshire") == 1 and not LocalPlayer():InVehicle() then
				local cph_CrossHireColor = Color(GetConVarNumber("cph_ch_r") ,GetConVarNumber("cph_ch_g"), GetConVarNumber("cph_ch_b"))
				cph_aiming = LocalPlayer():GetEyeTrace()
				if GetConVarNumber("cph_ch_pos_mode") == 1 then
					cph_ch_pos = cph_aiming.HitPos:ToScreen()
				else
					cph_ch_pos = { x = ScrW() / 2 , y = ScrH() / 2 }
				end
				draw.NoTexture()
				draw.Circle( cph_ch_pos.x, cph_ch_pos.y, GetConVarNumber("cph_ch_size"), 360 ,  ColorAlpha(cph_CrossHireColor, 100))
				draw.Circle( cph_ch_pos.x, cph_ch_pos.y, GetConVarNumber("cph_ch_size") - 2, 360 , ColorAlpha(cph_CrossHireColor, 150))

				if LocalPlayer():KeyPressed( IN_ATTACK ) and cph_weapon:GetClass()=="weapon_physgun" then
					cph_ch_speed = GetConVarNumber("cph_ch_dots_speed") * 3 * math.Clamp(FrameTime() * 100, 1, 60)
				elseif LocalPlayer():KeyReleased( IN_ATTACK ) and cph_weapon:GetClass()=="weapon_physgun" then
					cph_ch_speed = GetConVarNumber("cph_ch_dots_speed") * math.Clamp(FrameTime() * 100, 1, 60)
				elseif cph_weapon:GetClass()!="weapon_physgun" then
					cph_ch_speed = GetConVarNumber("cph_ch_dots_speed") * math.Clamp(FrameTime() * 100, 1, 60)
				end
				cph_ch_dotsrad = (cph_ch_dotsrad + cph_ch_speed )%360
				if (GetConVarNumber("cph_ch_dot_from_clip")) == 1 and IsValid(cph_weapon) and cph_weapon:Clip1() < 360 and LocalPlayer():GetActiveWeapon():GetClass()!="weapon_physgun" then
					for i=1 , cph_weapon:Clip1() do
						local cph_ch_color_r = (GetConVarNumber("cph_chds_r") * (cph_weapon:Clip1()/2 - i%(cph_weapon:Clip1()/2) + 1) / (cph_weapon:Clip1()/2) + GetConVarNumber("cph_chdl_r") * math.abs(i%(cph_weapon:Clip1()/2 + 1) / (cph_weapon:Clip1()/2)))
						local cph_ch_color_b = (GetConVarNumber("cph_chds_g") * (cph_weapon:Clip1()/2 - i%(cph_weapon:Clip1()/2) + 1) / (cph_weapon:Clip1()/2) + GetConVarNumber("cph_chdl_g") * math.abs(i%(cph_weapon:Clip1()/2 + 1) / (cph_weapon:Clip1()/2)))
						local cph_ch_color_g = (GetConVarNumber("cph_chds_b") * (cph_weapon:Clip1()/2 - i%(cph_weapon:Clip1()/2) + 1) / (cph_weapon:Clip1()/2) + GetConVarNumber("cph_chdl_b") * math.abs(i%(cph_weapon:Clip1()/2 + 1) / (cph_weapon:Clip1()/2)))
						local cph_dotColor = Color(cph_ch_color_r, cph_ch_color_b  , cph_ch_color_g, 150)
						draw.Circle( cph_ch_pos.x + math.cos(i * math.pi / cph_weapon:GetMaxClip1() * 2 + cph_ch_dotsrad) * GetConVarNumber("cph_ch_dots_radius"), cph_ch_pos.y + math.sin(i * math.pi  / cph_weapon:GetMaxClip1() * 2 + cph_ch_dotsrad) * GetConVarNumber("cph_ch_dots_radius"), GetConVarNumber("cph_ch_dots_size"), 50 , cph_dotColor)
					end
				else
					for i=1 , GetConVarNumber("cph_ch_dots") do
						local cph_ch_color_r = (GetConVarNumber("cph_chds_r") * (GetConVarNumber("cph_ch_dots")/2 - i%(GetConVarNumber("cph_ch_dots")/2) + 1) / (GetConVarNumber("cph_ch_dots")/2) + GetConVarNumber("cph_chdl_r") * math.abs(i%(GetConVarNumber("cph_ch_dots")/2 + 1) / (GetConVarNumber("cph_ch_dots")/2)))
						local cph_ch_color_b = (GetConVarNumber("cph_chds_g") * (GetConVarNumber("cph_ch_dots")/2 - i%(GetConVarNumber("cph_ch_dots")/2) + 1) / (GetConVarNumber("cph_ch_dots")/2) + GetConVarNumber("cph_chdl_g") * math.abs(i%(GetConVarNumber("cph_ch_dots")/2 + 1) / (GetConVarNumber("cph_ch_dots")/2)))
						local cph_ch_color_g = (GetConVarNumber("cph_chds_b") * (GetConVarNumber("cph_ch_dots")/2 - i%(GetConVarNumber("cph_ch_dots")/2) + 1) / (GetConVarNumber("cph_ch_dots")/2) + GetConVarNumber("cph_chdl_b") * math.abs(i%(GetConVarNumber("cph_ch_dots")/2 + 1) / (GetConVarNumber("cph_ch_dots")/2)))
						local cph_dotColor = Color(cph_ch_color_r, cph_ch_color_b  , cph_ch_color_g, 150)
						draw.Circle( cph_ch_pos.x + math.cos(i * math.pi / GetConVarNumber("cph_ch_dots") * 2 + cph_ch_dotsrad) * GetConVarNumber("cph_ch_dots_radius"), cph_ch_pos.y + math.sin(i * math.pi  / GetConVarNumber("cph_ch_dots") * 2 + cph_ch_dotsrad) * GetConVarNumber("cph_ch_dots_radius"), GetConVarNumber("cph_ch_dots_size"), 50 , cph_dotColor)
					end
				end
			end
			--PropInfo
			if GetConVarNumber("cph_displayPropInfo") == 1 then
				if IsValid(cph_weapon) and cph_weapon:GetClass() == "weapon_physgun" then
					cph_aiming = LocalPlayer():GetEyeTrace()
					cph_aim_entity = cph_aiming.Entity
					--local cph_ch_pos = cph_aiming.HitPos:ToScreen()
					if IsValid(cph_aim_entity) then
						if (LocalPlayer():GetPos() - cph_aim_entity:GetPos()):Length() < 500 then
							draw.RoundedBox(0, ScrW() / 2 + VelY - s64 * 4 , ScrH() - s64 * 3 + VelX , s64 * 8, s64 * 2, Color(0,0,0,150))
							draw.SimpleText("Model : "..cph_aim_entity:GetModel(), "Text_propinfo", ScrW() / 2 + VelY - s64 * 3.9 , ScrH() - s64 * 3 + VelX, cph_WeaponColor)
							draw.SimpleText("Position : x:"..math.Round(cph_aim_entity:GetPos().x,2).." y:"..math.Round(cph_aim_entity:GetPos().y,2).." z:"..math.Round(cph_aim_entity:GetPos().z,2), "Text_propinfo", ScrW() / 2 + VelY - s64 * 3.9 , ScrH() - s64 * 2.6 + VelX, cph_WeaponColor)
							draw.SimpleText("Angle : pitch: "..math.Round(cph_aim_entity:GetAngles().pitch,2).." yaw: "..math.Round(cph_aim_entity:GetAngles().yaw,2).." roll:"..math.Round(cph_aim_entity:GetAngles().roll,2), "Text_propinfo", ScrW() / 2 + VelY - s64 * 3.9 , ScrH() - s64 * 2.2 + VelX, cph_WeaponColor)
							draw.SimpleText("Material : "..cph_aim_entity:GetMaterial(), "Text_propinfo", ScrW() / 2 + VelY - s64 * 3.9 , ScrH() - s64 * 1.8 + VelX, cph_WeaponColor)
							draw.SimpleText("Color : red: "..cph_aim_entity:GetColor().r.." green: "..cph_aim_entity:GetColor().g.." blue: "..cph_aim_entity:GetColor().b.." alpha: "..cph_aim_entity:GetColor().a, "Text_propinfo", ScrW() / 2 + VelY - s64 * 3.9 , ScrH() - s64 * 1.4 + VelX, cph_WeaponColor)
						end
					end
				end
			end
			--Clocks
			if GetConVarNumber("cph_displayClocks") == 1 then
				if ConVarExists( "utime_enable" ) and GetConVarNumber("utime_enable") == 1.0 then
					GetConVar("utime_enable"):SetFloat(0)
				end
				if ConVarExists( "utime_enable" ) then
					local cph_clocks_color = Color(GetConVarNumber("cph_clocks_r"), GetConVarNumber("cph_clocks_g"), GetConVarNumber("cph_clocks_b"))
					draw.RoundedBox(10, ScrW() - s64 * 3.5 - s64 + VelY , s64 * 3 + VelX, s64 * 3.5, s64 * 1, Color(0,0,0,150))
					draw.SimpleText( "Session time: "..sec2str(LocalPlayer():GetUTimeSessionTime()) , "Text_smallest", ScrW() - s64 * 1.75 - s64 + VelY , s64 * 3 + VelX, cph_clocks_color, TEXT_ALIGN_CENTER)
					draw.SimpleText( "Session time: "..sec2str(LocalPlayer():GetUTimeSessionTime()) , "Hightlight_smallest", ScrW() - s64 * 1.75 - s64 + VelY , s64 * 3 + VelX, cph_clocks_color, TEXT_ALIGN_CENTER)
					draw.SimpleText( "Total time: "..sec2str(LocalPlayer():GetUTimeTotalTime()) , "Text_smallest", ScrW() - s64 * 1.75 - s64 + VelY , s64 * 3.5 + VelX, cph_clocks_color, TEXT_ALIGN_CENTER)
					draw.SimpleText( "Total time: "..sec2str(LocalPlayer():GetUTimeTotalTime()) , "Hightlight_smallest", ScrW() - s64 * 1.75 - s64 + VelY , s64 * 3.5 + VelX, cph_clocks_color, TEXT_ALIGN_CENTER)
				end
				if cph_clocks_h < os.date( "%H" , os.time()) then
					cph_clocks_h = os.date( "%H" , os.time())
					surface.PlaySound("npc/turret_floor/click1.wav")
				end
				local cph_clocks_color = Color(GetConVarNumber("cph_clocks_r"), GetConVarNumber("cph_clocks_g"), GetConVarNumber("cph_clocks_b"))
				draw.RoundedBox(10, ScrW() - s64 * 3.5 - s64 + VelY , s64 + VelX, s64 * 3.5, s64 * 2, Color(0,0,0,150))
				draw.SimpleText( os.date( "%X" , os.time() ), "Text", ScrW() - s64 * 1.75 - s64 + VelY , s64 + VelX, cph_clocks_color, TEXT_ALIGN_CENTER)
				draw.SimpleText( os.date( "%X" , os.time() ), "Hightlight", ScrW() - s64 * 1.75 - s64 + VelY , s64 + VelX, cph_clocks_color, TEXT_ALIGN_CENTER)
				draw.SimpleText( os.date( "%A" , os.time() ), "Text_small", ScrW() - s64 * 1.75 - s64 + VelY , s64 * 2 + VelX, cph_clocks_color, TEXT_ALIGN_CENTER)
				draw.SimpleText( os.date( "%A" , os.time() ), "Hightlight_small", ScrW() - s64 * 1.75 - s64 + VelY , s64 * 2 + VelX, cph_clocks_color, TEXT_ALIGN_CENTER)
				draw.SimpleText( os.date( "%B" , os.time() ), "Text_small", ScrW() - s64 * 1.75 - s64 + VelY , s64 * 2.5 + VelX, cph_clocks_color, TEXT_ALIGN_CENTER)
				draw.SimpleText( os.date( "%B" , os.time() ), "Hightlight_small", ScrW() - s64 * 1.75 - s64 + VelY , s64 * 2.5 + VelX, cph_clocks_color, TEXT_ALIGN_CENTER)
				--draw.SimpleText( os.date( "%Y" , os.time() ), "Text", ScrW() - s64 * 2 - s64 + VelY , s64 * 2 + VelX, cph_clocks_color)
				--draw.SimpleText( os.date( "%Y" , os.time() ), "Hightlight", ScrW() - s64*2 - s64 + VelY , s64 * 2 + VelX, cph_clocks_color)
			end
			--FPS
			if GetConVarNumber("cph_displayFPS") == 1 then
				draw.SimpleText( FPS.." FPS", "FPS", s64/4 , s64/8 , cph_HealthColor)
				draw.SimpleText( FPS.." FPS", "FPS_HL", s64/4 , s64/8 , cph_HealthColor)
			end
		end
	end
end
hook.Add("HUDPaint", "CyanPowerHud", hud)
