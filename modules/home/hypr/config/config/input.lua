-- Input configuration

hl.config({
	input = {
		accel_profile = "flat",
		repeat_rate = 25,
		repeat_delay = 200,
		scroll_method = "on_button_down",
		scroll_button = 274, -- BTN_MIDDLE
	},
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", action = "close" })
hl.gesture({ fingers = 3, direction = "up", action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left", action = "float" })
