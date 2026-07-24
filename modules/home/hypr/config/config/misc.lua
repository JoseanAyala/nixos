hl.config({
	dwindle = {
		preserve_split = true,
		special_scale_factor = 0.95,
	},
	misc = {
		col = {
			splash = Colors.primary,
		},
		middle_click_paste = false,
		-- Open windows on the focused workspace, not the launcher's (ws 1).
		initial_workspace_tracking = 0,
		enable_swallow = true,
		swallow_regex = "(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)",
		vrr = 3,
	},
	xwayland = {
		force_zero_scaling = true,
	},
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
})

