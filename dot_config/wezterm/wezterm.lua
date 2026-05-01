local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local home = os.getenv("USERPROFILE") or os.getenv("HOME") or "~"
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

local last_title_per_tab = {}
wezterm.on("update-status", function(window, pane)
	local cwd_uri = pane:get_current_working_dir()
	if not cwd_uri or not cwd_uri.file_path then
		return
	end

	local cwd = cwd_uri.file_path
	local tab = window:active_tab()
	local tab_id = tab:tab_id()

	local new_title = ""

	if string.find(string.lower(cwd), "chezmoi", 1, true) then
		new_title = " chezmoi"
	elseif string.find(string.lower(cwd), "vdr", 1, true) then
		new_title = "󰆼 VDR"
	elseif string.find(string.lower(cwd), "fss", 1, true) then
		new_title = "  FSS"
	end

	if new_title then
		if last_title_per_tab[tab_id] ~= new_title then
			tab:set_title(new_title)
			last_title_per_tab[tab_id] = new_title
		end
	end
end)

config.default_prog = { "zsh" }
config.default_cwd = "~"
config.initial_cols = 122
config.initial_rows = 50
config.window_close_confirmation = "NeverPrompt"

--[
-- Appearance
--]
function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return {
			name = "Catppuccin Macchiato",
			light_mode = "false",
			image = "background.jpg",
			brightness = 0.005,
		}
	else
		return {
			name = "Catppuccin Latte",
			light_mode = "true",
			image = "background_light.jpg",
			brightness = 1,
		}
	end
end
local theme = scheme_for_appearance(get_appearance())
config.set_environment_variables = {
	LIGHT_MODE = theme.light_mode,
}
config.color_scheme = theme.name
config.window_background_image = home .. "/.config/wezterm/" .. theme.image
config.window_background_image_hsb = { brightness = theme.brightness }
config.font = wezterm.font_with_fallback({
	"BigBlueTermPlus Nerd Font",
})

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false

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
	{ key = "R", mods = "CTRL|SHIFT", action = act.EmitEvent("rename-tab") },
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
