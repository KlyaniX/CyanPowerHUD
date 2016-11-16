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
function cph_GeneralSettingsPanel(Panel)
	Panel:AddControl("Label", {Text = "CyanPower HUD General Configuration"})
	Panel:AddControl("CheckBox", {Label = "Display Rounds", Command = "cph_displayRounds"})
	Panel:AddControl("CheckBox", {Label = "Use custom Crosshire", Command = "cph_displayCrosshire"})
	Panel:AddControl("CheckBox", {Label = "Use hud health color for player color (exprement)", Command = "cph_hudcolor_plycolor"})
	Panel:AddControl("CheckBox", {Label = "Use hud weapon color for physgun color (exprement)", Command = "cph_hudwepcolor_physcolor"})
	Panel:AddControl("CheckBox", {Label = "Display FPS", Command = "cph_displayFPS"})
	Panel:AddControl("CheckBox", {Label = "Display Clocks", Command = "cph_displayClocks"})
	--Panel:AddControl("CheckBox", {Label = "Display Compass", Command = "cph_displayCompass"})
	Panel:AddControl("CheckBox", {Label = "Display info about aiming prop", Command = "cph_displayPropInfo"})
	Panel:AddControl("Slider", {Label = "Blur size", Min = "0", Max = "10", Command = "cph_blursize"})
	Panel:AddControl("Label", {Text = "Created by KlyaniX"})
end
function cph_CrossHireSettingsPanel(Panel)
	Panel:AddControl("CheckBox", {Label = "Dynamic crosshire position", Command = "cph_ch_pos_mode"})
	Panel:AddControl("Slider", {Label = "Size of crosshire", Type = "Float", Min = "1", Max = "8", Command = "cph_ch_size"})
	Panel:AddControl("Color", {Label = "Color of crosshire", Red = "cph_ch_r", Green = "cph_ch_g", Blue = "cph_ch_b", ShowHSV = 1, ShowRGB = 1})
	Panel:AddControl("CheckBox", {Label = "Amount dots will borrow ammo", Command = "cph_ch_dot_from_clip"})
	Panel:AddControl("Slider", {Label = "Amount of crosshires dots", Min = "0", Max = "360", Command = "cph_ch_dots"})
	Panel:AddControl("Slider", {Label = "Size of crosshires dots", Min = "1", Max = "12", Command = "cph_ch_dots_size"})
	Panel:AddControl("Slider", {Label = "Speed of crosshires dots", Type = "Float", Min = "-0.1", Max = "0.1", Command = "cph_ch_dots_speed"})
	Panel:AddControl("Slider", {Label = "Distance of crosshires dots", Type = "Float", Min = "3", Max = "100", Command = "cph_ch_dots_radius"})
	Panel:AddControl("Color", {Label = "Color of first dot", Red = "cph_chds_r", Green = "cph_chds_g", Blue = "cph_chds_b", ShowHSV = 1, ShowRGB = 1})
	Panel:AddControl("Color", {Label = "Color of last dot", Red = "cph_chdl_r", Green = "cph_chdl_g", Blue = "cph_chdl_b", ShowHSV = 1, ShowRGB = 1})
	Panel:AddControl("Label", {Text = "Created by KlyaniX"})
end
function cph_ColorSettingsPanel(Panel)
	Panel:AddControl("Label", {Text = "CyanPower HUD Colors Configuration"})
	Panel:AddControl("Color", {Label = "Color of MaxHP", Red = "cph_maxHP_r", Green = "cph_maxHP_g", Blue = "cph_maxHP_b", ShowHSV = 1, ShowRGB = 1})
	Panel:AddControl("Color", {Label = "Color of LowHP", Red = "cph_lowHP_r", Green = "cph_lowHP_g", Blue = "cph_lowHP_b", ShowHSV = 1, ShowRGB = 1})
	Panel:AddControl("Color", {Label = "Color of MaxArmor", Red = "cph_maxArmor_r", Green = "cph_maxArmor_g", Blue = "cph_maxArmor_b", ShowHSV = 1, ShowRGB = 1})
	Panel:AddControl("Color", {Label = "Color of LowArmor", Red = "cph_lowArmor_r", Green = "cph_lowArmor_g", Blue = "cph_lowArmor_b", ShowHSV = 1, ShowRGB = 1})
	Panel:AddControl("Color", {Label = "Color of CrossHire & Weapon bar", Red = "cph_weapon_r", Green = "cph_weapon_g", Blue = "cph_weapon_b", ShowHSV = 1, ShowRGB = 1})
	Panel:AddControl("Color", {Label = "Color of clock", Red = "cph_clocks_r", Green = "cph_clocks_g", Blue = "cph_clocks_b", ShowHSV = 1, ShowRGB = 1})
	Panel:AddControl("Label", {Text = "Created by KlyaniX"})
end

function cph_PopulateToolMenu()
	spawnmenu.AddToolMenuOption("Options", "CyanPower HUD", "cphGeneralSettings", "General", "", "", cph_GeneralSettingsPanel)
	spawnmenu.AddToolMenuOption("Options", "CyanPower HUD", "cphCrossHireSettings", "CrossHire", "", "", cph_CrossHireSettingsPanel)
	spawnmenu.AddToolMenuOption("Options", "CyanPower HUD", "cphColorSettings", "Colors", "", "", cph_ColorSettingsPanel)
end

hook.Add("PopulateToolMenu", "cph_PopulateToolMenu", cph_PopulateToolMenu)
