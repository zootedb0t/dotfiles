local color = require("colors")

-- General config
swayimg.set_mode("viewer") -- mode at startup
swayimg.enable_antialiasing(true) -- anti-aliasing
swayimg.enable_decoration(false) -- window title/buttons/borders
swayimg.enable_overlay(false) -- window overlay mode
swayimg.enable_exif_orientation(true) -- image orientation by EXIF
swayimg.set_dnd_button("MouseRight") -- drag-and-drop mouse button

-- Image list configuration
swayimg.imagelist.set_order("numeric") -- list order
swayimg.imagelist.enable_reverse(false) -- reverse order
swayimg.imagelist.enable_recursive(false) -- recursive directory reading
swayimg.imagelist.enable_adjacent(false) -- add adjacent files from same dir
swayimg.imagelist.enable_fsmon(true) -- enable file system monitoring

-- Text overlay configuration
swayimg.text.set_font("monospace") -- font name
swayimg.text.set_size(24) -- font size in pixels
swayimg.text.set_spacing(0) -- line spacing
swayimg.text.set_padding(10) -- padding from window edge
swayimg.text.set_foreground(0xffcccccc) -- foreground text color
swayimg.text.set_background(color.background) -- text background color
swayimg.text.set_shadow(0x0d000000) -- text shadow color
swayimg.text.set_timeout(5) -- layer hide timeout
swayimg.text.set_status_timeout(3) -- status message hide timeout

-- Image viewer mode
swayimg.viewer.set_default_scale("optimal") -- default image scale
swayimg.viewer.set_default_position("center") -- default image position
swayimg.viewer.set_drag_button("MouseLeft") -- mouse button to drag image
swayimg.viewer.set_window_background(0xff000000) -- window background color
swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c) -- chessboard
swayimg.viewer.enable_centering(true) -- enable automatic centering
swayimg.viewer.enable_loop(true) -- enable image list loop mode
swayimg.viewer.limit_preload(1) -- number of images to preload
swayimg.viewer.limit_history(1) -- number of the history cache
swayimg.viewer.set_mark_color(0xff808080) -- mark icon color
swayimg.viewer.set_pinch_factor(1.0) -- pinch gesture factor
swayimg.viewer.set_text("topleft", { -- top left text block scheme
	"File: {name}",
	"Format: {format}",
	"File size: {sizehr}",
	"File time: {time}",
	"EXIF date: {meta.Exif.Photo.DateTimeOriginal}",
	"EXIF camera: {meta.Exif.Image.Model}",
})
swayimg.viewer.set_text("topright", { -- top right text block scheme
	"Image: {list.index} of {list.total}",
	"Frame: {frame.index} of {frame.total}",
	"Size: {frame.width}x{frame.height}",
})
swayimg.viewer.set_text("bottomleft", { -- bottom left text block scheme
	"Scale: {scale}",
})

-- bind mouse vertical scroll button with pressed Ctrl to zoom in the image at mouse pointer coordinates
swayimg.viewer.on_mouse("Ctrl-ScrollUp", function()
	local pos = swayimg.get_mouse_pos()
	local scale = swayimg.viewer.get_scale()
	scale = scale + scale / 10
	swayimg.viewer.set_abs_scale(scale, pos.x, pos.y)
end)

-- Gallery mode
swayimg.gallery.set_aspect("fill") -- thumbnail aspect ratio
swayimg.gallery.set_thumb_size(200) -- thumbnail size in pixels
swayimg.gallery.set_padding_size(5) -- padding between thumbnails
swayimg.gallery.set_border_size(5) -- border size for selected thumbnail
swayimg.gallery.set_border_color(0xffaaaaaa) -- border color for selected thumbnail
swayimg.gallery.set_selected_scale(1.15) -- scale for selected thumbnail
swayimg.gallery.set_selected_color(0xff404040) -- background color for selected thumbnail
swayimg.gallery.set_unselected_color(0xff202020) -- background color for unselected thumbnail
swayimg.gallery.set_window_color(0xff000000) -- window background color
swayimg.gallery.set_pinch_factor(100.0) -- pinch gesture factor
swayimg.gallery.limit_cache(100) -- number of thumbnails stored in memory
swayimg.gallery.enable_preload(false) -- preloading invisible thumbnails
swayimg.gallery.enable_pstore(false) -- enable persistent storage for thumbnails
swayimg.gallery.set_text("topleft", { -- top left text block scheme
	"File: {name}",
})
swayimg.gallery.set_text("topright", { -- top right text block scheme
	"{list.index} of {list.total}",
})

-- force set scale mode on window resize (useful for tiling compositors)
swayimg.on_window_resize(function()
	swayimg.viewer.set_fix_scale("optimal")
end)

-- Keybindings
-- bind q key for exit
for _, mode in ipairs({ swayimg.viewer, swayimg.gallery, swayimg.slideshow }) do
	mode.on_key("q", function()
		swayimg.exit()
	end)
end

-- bind Enter key or Mouse middle key to open image in viewer/gallery
swayimg.gallery.on_key("Return", function()
	swayimg.set_mode("viewer")
end)

swayimg.viewer.on_mouse("MouseMiddle", function()
	swayimg.set_mode("gallery")
end)

-- Set wallpaper or delete image
local all_modes = { swayimg.viewer, swayimg.gallery, swayimg.slideshow }

local function bind_all(key, fn)
	for _, mode in ipairs(all_modes) do
		mode.on_key(key, function()
			local image = mode.get_image()
			if image then
				fn(image)
			end
		end)
	end
end

-- Delete current file
bind_all("Delete", function(image)
	os.remove(image.path)
	swayimg.text.set_status("File " .. image.path .. " removed")
end)

-- Set as wallpaper
bind_all("w", function(image)
	os.execute(string.format("foot -e matugen image %q", image.path))
	os.execute(string.format("notify-send 'Wallpaper updated' -i %q", image.path))
end)

-- Make swayimg fullscreen
swayimg.viewer.on_key("f", function()
	swayimg.toggle_fullscreen()
end)
