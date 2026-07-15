-- Look and feel configuration

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,
		border_size = 1,
		extend_border_grab_area = 10,
		resize_on_border = true,
		col = {
			-- Active window: light font color. Inactive: transparent (no border).
			active_border = { colors = { Colors.on_surface } },
			inactive_border = "rgba(00000000)",
		},
	},
	group = {
		col = {
			border_active = Colors.tertiary,
			border_inactive = Colors.outline,
			border_locked_active = Colors.error,
			border_locked_inactive = Colors.outline,
		},
		groupbar = {
			col = {
				active = Colors.primary,
				inactive = Colors.outline,
				locked_active = Colors.error,
				locked_inactive = Colors.outline,
			},
		},
	},
	decoration = {
		dim_special = 0.3,
		rounding = 10,
		active_opacity = 0.95,
		inactive_opacity = 0.85,
		fullscreen_opacity = 1,
		blur = {
			size = 5,
			passes = 4,
			special = false,
		},
	},
})
