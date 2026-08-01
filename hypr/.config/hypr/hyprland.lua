-- alvesafk hyprland config 3 (lua edition)

-- monitor config
hl.monitor({
	output = "HDMI-A-1",
	mode = "preferred",
	position = "auto",
	scale = "1",
})

hl.monitor({
	output = "DP-1",
	mode = "preferred",
	position = "auto",
	scale = "1",
})

-- Program variables
local terminal = "kitty"
local fileManager = "nemo"
local menu = "/home/afk/.config/rofi/launchers/type-1/launcher.sh"
local browser = "zen-browser"

-- Auto start
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("waybar")
	hl.exec_cmd("dunst")
	hl.exec_cmd("hyprctl setcursor Venat\\ Cursor 62")
end)

-- env variables
hl.env("XCURSOR_SIZE", 62)
hl.env("HYPRCURSOR_SIZE", 62)

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

hl.config({
	general = {
		gaps_in          = 2,
		gaps_out         = 5,

		border_size      = 1,

		col              = {
			active_border   = "rgba(ffffff30)",
			inactive_border = "rgba(282828ff)",
		},

		resize_on_border = false,

		allow_tearing    = false,

		layout           = "master",
	},

	decoration = {
		rounding         = 12,
		rounding_power   = 5,

		active_opacity   = 1.0,
		inactive_opacity = 1.0,

		shadow           = {
			enabled      = false,
			range        = 4,
			render_power = 3,
			color        = 0xee1a1a1a,
		},

		blur             = {
			enabled  = true,
			size     = 3,
			passes   = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

-- misc
hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = false,
	}
})

-- input
hl.config({
	cursor = {
		no_hardware_cursors = true
	},

	input = {
		kb_layout = "br",
		follow_mouse = 1,
		sensitivity = 0,
		accel_profile = "flat",
		kb_options = "ctrl:nocaps"
	}
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5
})

-- keybinds
local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + Escape",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("/home/afk/.config/rofi/applets/bin/powermenu.sh"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty nvim"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("killall hyprpaper && hyprpaper &"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("killall waybar && waybar &"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("waybar &"))
hl.bind(mainMod .. " + SHIFT + S",
	hl.dsp.exec_cmd([[bash -c 'grim -g "$(slurp)" - | tee ~/Images/Screenshots/$(date +%s).png | wl-copy']]))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + Right", hl.dsp.exec_cmd("playerctl next"))
hl.bind(mainMod .. " + Up", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(mainMod .. " + Down", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(mainMod .. " + Left", hl.dsp.exec_cmd("playerctl previous"))
