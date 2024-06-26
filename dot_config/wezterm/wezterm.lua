local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local resize_small = 1
local resize_big = 15
local key_timeout = 1000

local function set_keymap(name)
	return act.ActivateKeyTable({
		name = name,
		timeout_milliseconds = key_timeout,
		one_shot = false,
	})
end

local function generate_tab_table()
	local keys = {}
	for i = 1, 9 do
		-- CTRL+ALT + number to activate that tab
		table.insert(keys, {
			key = tostring(i),
			action = act.ActivateTab(i - 1),
		})
	end
	return keys
end

config.default_prog = { "wsl" }
config.default_cwd = "~"

--[
-- Appearance
--]
config.color_scheme = "catppuccin-macchiato"
config.window_background_image = "%USERPROFILE%/.config/wezterm/background.jpg"
config.window_background_image_hsb = { brightness = 0.005 }
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font_with_fallback({
	"BigBlueTermPlus Nerd Font",
})

--[
-- Custom Hyperlinks
--]
config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
	regex = [[\bVDRDEV-?(\d+)\b]],
	format = "https://example.com/tasks/?t=$1",
})
table.insert(config.hyperlink_rules, {
	regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
	format = "https://www.github.com/$1/$3",
})

--[
-- Keybindings
--]
config.disable_default_key_bindings = true
config.leader = { key = ";", mods = "CTRL", timeout_milliseconds = key_timeout }
config.keys = {
	-- Pass through leader
	{ key = ";", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "Enter", mods = "LEADER", action = act.ShowLauncher },
	{ key = "p", mods = "LEADER", action = act.ActivateCommandPalette },

	-- Copy & Paste
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },

	-- Tabs
	{ key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "n", mods = "LEADER|SHIFT", action = act.SpawnTab("DefaultDomain") },
	{ key = "x", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },
	{ key = "t", mods = "LEADER", action = act.ActivateKeyTable({ name = "activate_tab" }) },
	{ key = "Tab", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "LEADER|SHIFT", action = act.ActivateTabRelative(-1) },

	-- Panes
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "m", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "0", mods = "LEADER", action = act.PaneSelect({ mode = "SwapWithActive" }) },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "r", mods = "LEADER", action = set_keymap("resize_pane") },
	{ key = "a", mods = "LEADER", action = set_keymap("activate_pane") },
	{ key = "Space", mods = "LEADER", action = act.RotatePanes("Clockwise") },
}

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", resize_small }) },
		{ key = "h", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", resize_big }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", resize_small }) },
		{ key = "j", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", resize_big }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", resize_small }) },
		{ key = "k", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", resize_big }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", resize_small }) },
		{ key = "l", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", resize_big }) },
	},
	activate_pane = {
		{ key = "h", action = act.ActivatePaneDirection("Left") },
		{ key = "j", action = act.ActivatePaneDirection("Down") },
		{ key = "k", action = act.ActivatePaneDirection("Up") },
		{ key = "l", action = act.ActivatePaneDirection("Right") },
	},
	activate_tab = generate_tab_table(),
}

return config
