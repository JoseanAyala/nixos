-----------------------------------------------------
-- PICTURE-IN-PICTURE

hl.window_rule({
	match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
	float = true,
	keep_aspect_ratio = true,
	move = "73% 72%",
	size = "25% 25%",
	pin = true,
})

-----------------------------------------------------
-- GAMING

local gamingApps = "^(steam_app.*|gamescope)$"
local gamingWorkspace = 10

-- Dedicated gaming workspace: clean edge-to-edge surface (no gaps/borders/rounding).
hl.workspace_rule({
	workspace = tostring(gamingWorkspace),
	gaps_in = 0,
	gaps_out = 0,
	no_border = true,
	no_rounding = true,
	decorate = false,
})
hl.window_rule({
	match = { content = "game" },
	-- Requires general.allow_tearing = true.
	immediate = true,
	workspace = gamingWorkspace,
})
hl.window_rule({ match = { class = gamingApps }, workspace = gamingWorkspace })
hl.window_rule({ match = { class = "^(steam)$", title = "^(Friends List)$" }, float = true })
hl.window_rule({
	match = {
		class = "^(steam)$",
		title = "^(Launching\\.{3})$",
	},
	float = true,
	center = true,
	workspace = gamingWorkspace,
})
hl.window_rule({
	match = {
		class = gamingApps,
		title = "^(.+)$",
		initial_title = "negative:^(.*\\\\home\\\\.*)$",
	},
	size = "monitor_w monitor_h",
	fullscreen_state = 2,
	content = "game",
})
hl.window_rule({
	match = {
		class = "^(steam_app.*)$",
		initial_title = "^$",
	},
	float = true,
	center = true,
	fullscreen_state = 0,
})

-----------------------------------------------------
-- APPS

local primaryWorkspace = 1

hl.window_rule({
	match = { class = "^(.*\\.exe)$" },
	float = true,
	workspace = primaryWorkspace,
	center = true,
	fullscreen_state = 0,
})
hl.window_rule({ match = { class = "^(vesktop|discord)$" }, workspace = primaryWorkspace })
hl.window_rule({ match = { class = "^(.*[Cc]alculator.*)$" }, float = true, size = "380 616" })
hl.window_rule({ match = { class = "^(org.kde.keditfiletype)$" }, float = true })
hl.window_rule({ match = { class = "^(org.kde.ark)$" }, size = "(monitor_w*0.40) (monitor_h*0.40)" })
hl.window_rule({
	match = {
		class = "^(org.kde.dolphin)$",
		title = "negative:^(Moving.*|Create New.*|Extract.*|Compress.*|Copying.*|Progress.*|Configure.*|Properties.*|Choose\\sApplication.*)$",
	},
	float = true,
	center = true,
	size = "1300 800",
})

-----------------------------------------------------
-- FLOATING

-- Utility windows
local floatApps = {
	{ class = "^(kvantummanager|qt[56]ct|nwg-look)$" },
	{ class = "^(org.pulseaudio.pavucontrol|blueman-manager|nm-applet|nm-connection-editor)$" },
	{ title = "^(Winetricks.*|Protontricks.*)$" },
}
for _, m in ipairs(floatApps) do
	hl.window_rule({ match = m, float = true })
end

-- Default placement for floating windows
hl.window_rule({ match = { float = true }, move = "50% 50%" })

-- Common modal dialogs
local modalMatches = {
	{
		title = "^(Open|Authentication Required|Add Folder to Workspace|Choose Files|Save As|Confirm to replace files|File Operation Progress)$",
	},
	{ initial_title = "^(Open File)$" },
	{ class = "^([Xx]dg-desktop-portal-gtk)$" },
	{ title = "^(File Upload|Choose wallpaper|Library)(.*)$" },
	{ class = "^(.*dialog.*)$" },
	{ title = "^(.*dialog.*)$" },
	{ class = "^(hyprland-share-picker)$" },
}
for _, m in ipairs(modalMatches) do
	hl.window_rule({ match = m, float = true })
end

-----------------------------------------------------
-- FIXES

-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})
