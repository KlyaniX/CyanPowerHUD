--KlyaniX_HUD_configuration
--   __  __   ___                                  __   __
--  /\ \/\ \ /\_ \                             __ /\ \ /\ \
--  \ \ \/'/ \//\ \    __  __     __      ___ /\_\\ `\`\/'/'
--   \ \   <   \ \ \  /\ \/\ \  /'__`\  /' _ `\/\ \`\/ > <
--    \ \ \\`\  \_\ \_\ \ \_\ \/\ \_\.\_/\ \/\ \ \ \  \/'/\`\
--     \ \_\ \_\/\____\\/`____ \ \__/.\_\ \_\ \_\ \_\ /\_\\ \_\
--      \/_/\/_/\/____/ `/___/  \/__/\/_/\/_/\/_/\/_/ \/_/ \/_/
--                         /\___/
--                         \/__/
local function getConvarColor(STR)
	return Color(GetConVarNumber(STR.."_r"), GetConVarNumber(STR.."_g"), GetConVarNumber(STR.."_b"))
end
local VariableColor = "cph_maxHP"
local Colors = {
	{ "Maximum HP color", "cph_maxHP" },
	{ "Low HP color", "cph_lowHP" },
	{ "Maximum AP color", "cph_maxArmor" },
	{ "Low AP color", "cph_lowArmor" },
	{ "Weapons color", "cph_weapon" },
	{ "Clock color", "cph_clocks" },
	{ "Crosshair color", "cph_ch" },
	{ "Crosshair first dot color", "cph_chds" },
	{ "Crosshair last dot color", "cph_chdl" },
}

local GeneralConfigs = {
	{ "Display rounds", "cph_displayRounds" },
	{ "Use custom crosshair", "cph_displayCrosshire" },
	{ "Use hud health color for player color (exprement)", "cph_hudcolor_plycolor" },
	{ "Use hud weapon color for physgun color (exprement)", "cph_hudwepcolor_physcolor" },
	{ "Display FPS", "cph_displayFPS" },
	{ "Display clocks", "cph_displayClocks" },
	{ "Display info about aiming prop", "cph_displayPropInfo" },
	{ "Amount dots will borrow ammo", "cph_ch_dot_from_clip" },
	{ "Dynamic crosshair position", "cph_ch_pos_mode" },
}

local CrosshireSliders = {
	{ "Size of crosshair", "cph_ch_size", 1, 8 },
	{ "Amount of crosshair dots", "cph_ch_dots", 0, 360 },
	{ "Size of crosshair dots", "cph_ch_dots_size", 1, 12 },
	{ "Speed of crosshair dots", "cph_ch_dots_speed", -0.1, 0.1 },
	{ "Distance of crosshair dots", "cph_ch_dots_radius", 3, 100 },
}

local cph_blursize=GetConVarNumber("cph_blursize")

surface.CreateFont( "Symbol", {
	font = "Webdings", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 25,
	symbol = true,
} )
surface.CreateFont( "DText", {
	size = 25,
	antialias = true,
	shadow = true,
} )

surface.CreateFont( "DTextButton", {
	size = 20,
	antialias = true,
	shadow = true,
} )

surface.CreateFont( "DTextButtonHL", {
	size = 20,
	antialias = true,
	blursize = cph_blursize,
} )

surface.CreateFont( "DHightlight", {
	size = 25,
	blursize = cph_blursize,
} )

surface.CreateFont( "Watermark", {
	font = "AmazObitaemOstrovV.2",
	size = 60,
	antialias = true,
} )

list.Set(
	"DesktopWindows",
	"CyanPowerHUD",
	{
		title = "CyanPowerHUD",
		icon = "CyanPowerHUD/CyanPowerHudIcon.png",
		width = 600,
		height = 500,
		onewindow = true,
		init = function(_,Panel)
				Panel:ShowCloseButton(false)
				Panel:SetTitle("")
				Panel.Paint = function(self,w,h)
					draw.RoundedBox(math.Round(ScrH()/100), 0, 0, w, h, Color(135,135,135,150))
					draw.RoundedBoxEx(math.Round(ScrH()/100), 0, 0, w, 35, Color(135,135,135,200), true, true, false, false)
					--draw.RoundedBoxEx(math.Round(ScrH()/100), 300, 35, 300, 295, Color(35,35,35,150), false, false, true, true)
					draw.SimpleText("CyanPowerHUD", "DText", 300, 5, getConvarColor("cph_maxHP"), TEXT_ALIGN_CENTER)
					draw.SimpleText("CyanPowerHUD", "DHightlight", 300, 5, getConvarColor("cph_maxHP"), TEXT_ALIGN_CENTER)
					draw.SimpleText("KlyaniX", "Watermark", 575, 425, Color( 255, 255, 255, 80), TEXT_ALIGN_RIGHT)
					--draw.SimpleText("Color of max HP", "DText", 450, 50 , getConvarColor("cph_maxHP"), TEXT_ALIGN_CENTER)
					--draw.SimpleText("Color of max HP", "DHightlight", 450, 50, getConvarColor("cph_maxHP"), TEXT_ALIGN_CENTER)
				end
				local HeartButton = vgui.Create("DButton",Panel)
				HeartButton:SetPos( 5, 5 )
				HeartButton:SetSize( 25, 25 )
				HeartButton:SetText("")
				HeartButton.Paint = function(self,w,h)
					draw.SimpleText("Y","Symbol",0,0,getConvarColor("cph_maxHP"))
				end
				HeartButton.DoClick = function()
					gui.OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=508326891")
					--http://www.fonts2u.com/amazobitaemostrovv2.font
				end
				local CloseButton = vgui.Create("DButton", Panel)
				CloseButton:SetPos(575,5)
				CloseButton:SetSize(25,25)
				CloseButton:SetText("")
				CloseButton.Paint = function(self,w,h)
					draw.SimpleText("r", "Symbol", 0, 0, getConvarColor("cph_maxHP"))
				end
				CloseButton.DoClick = function()
					Panel:Remove()
				end
				local Sheet = vgui.Create( "DPropertySheet", Panel )
				Sheet:Dock( FILL )
				--Sheet.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 100 ) ) end
				local GeneralSettings = vgui.Create( "DPanel", Sheet )
				GeneralSettings.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 50 ) ) end
				Sheet:AddSheet( "General settings", GeneralSettings)

				local CrossHireSettings = vgui.Create( "DPanel", Sheet )
				CrossHireSettings.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 50 ) ) end
				Sheet:AddSheet( "Crosshair settings", CrossHireSettings)

				local ColorsSettings = vgui.Create( "DPanel", Sheet )
				ColorsSettings.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 50 ) ) end
				Sheet:AddSheet( "Colors settings", ColorsSettings)

				local ConvarName = vgui.Create("DLabel",ColorsSettings)
				ConvarName:SetText("Maximum HP color")
				ConvarName:SetSize( 300, 50	)
				ConvarName:SetColor(getConvarColor("cph_maxHP"))
				ConvarName:SetPos( 325, 0 )
				ConvarName:SetFont("DText")
				local ConvarNameHL = vgui.Create("DLabel",ColorsSettings)
				ConvarNameHL:SetText("Maximum HP color")
				ConvarNameHL:SetSize( 300, 50	)
				ConvarNameHL:SetColor(getConvarColor("cph_maxHP"))
				ConvarNameHL:SetPos( 325, 0 )
				ConvarNameHL:SetFont("DHightlight")
				local Mixer = vgui.Create( "DColorMixer", ColorsSettings )
				Mixer:SetPos(330, 65)
				Mixer:SetSize(260, 180)
				Mixer:SetColor(getConvarColor(VariableColor))
				Mixer:SetPalette(false)
				Mixer:SetAlphaBar(false)
				for i, data in pairs( Colors ) do
				local ColorButton = vgui.Create("DButton",ColorsSettings)
					ColorButton:SetPos(50, i * 40 - 25)
					ColorButton:SetSize(200,35)
					ColorButton:SetText("")
					ColorButton.Paint = function(self,w,h)
						draw.RoundedBox(10, 0, 0, w, h, Color(35,35,35,100))
						draw.RoundedBox(10, 2, 2, w - 4, h - 4, Color(255,255,255,5))
						draw.SimpleText(data[1], "DTextButton", w / 2, h / 2, getConvarColor(data[2]), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						draw.SimpleText(data[1], "DTextButtonHL", w / 2, h / 2, getConvarColor(data[2]), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
					ColorButton.DoClick = function()
						VariableColor=data[2]
						Mixer:SetColor(getConvarColor(VariableColor))
						ConvarName:SetText(data[1])
						ConvarNameHL:SetText(data[1])
						ConvarName:SetColor(getConvarColor(VariableColor))
						ConvarNameHL:SetColor(getConvarColor(VariableColor))
					end
				end
				function Mixer:ValueChanged(Col)
					ConvarName:SetColor(Col)
					ConvarNameHL:SetColor(Col)
					GetConVar(VariableColor.."_r"):SetInt(Col.r)
					GetConVar(VariableColor.."_g"):SetInt(Col.g)
					GetConVar(VariableColor.."_b"):SetInt(Col.b)
				end
				for i, data in pairs( GeneralConfigs ) do
					local DermaCheckbox = vgui.Create( "DCheckBoxLabel", GeneralSettings )
					--	DermaCheckbox:SetParent( GeneralSettings )
					DermaCheckbox:SetPos( 25, 25 * (i + 1) )
					DermaCheckbox:SetText( data[1] )
					DermaCheckbox:SetConVar( data[2] )
					DermaCheckbox:SizeToContents()
				end
				local BlurSlider = vgui.Create( "DNumSlider", GeneralSettings )
				BlurSlider:SetPos( 25, 25 )
				BlurSlider:SetSize( 250, 25 )
				BlurSlider:SetText( "Text Blur size" )
				BlurSlider:SetMin( 0 )
				BlurSlider:SetMax( 10 )
				BlurSlider:SetDecimals( 10 )
				BlurSlider:SetConVar( "cph_blursize" )
				for i, data in pairs( CrosshireSliders ) do
					local Slider = vgui.Create( "DNumSlider", CrossHireSettings )
					Slider:SetPos( 25, 25 * i )
					Slider:SetSize( 400, 25 )
					Slider:SetText( data[1] )
					Slider:SetMin( data[3] )
					Slider:SetMax( data[4] )
					--	Slider:SetDecimals( 1 )
					Slider:SetConVar( data[2] )
				end
		end
	}
)
