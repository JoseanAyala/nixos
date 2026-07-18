-- Look and feel configuration

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,
		extend_border_grab_area = 10,
		resize_on_border = true,
		allow_tearing = true, -- required for the `immediate` game rule; only tears in fullscreen
		col = {
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
		rounding_power = 2.5,
		rounding = 18,

		blur = {
			xray = true,
			size = 2,
			input_methods = true,
			input_methods_ignorealpha = 0.8,
		},
		shadow = {
			range = 20,
			offset = { 0, 2 },
			render_power = 4,
			color = "rgba(00000020)",
		},
		-- Dim
		dim_inactive = true,
		dim_strength = 0.05,
	},
})
