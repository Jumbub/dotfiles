local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local theme_assets = require("beautiful.theme_assets")
local naughty = require("naughty")
local menubar = require("menubar")
local freedesktop = require("freedesktop")

function handleStartupErrors()
  if awesome.startup_errors then
    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors
    })
  end
end

function handleRuntimeErrors()
  do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
      -- Make sure we don't go into an endless error loop
      if in_error then return end
      in_error = true
      naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, an error happened!",
        text = tostring(err)
      })
      in_error = false
    end)
  end
end

function getColor()
  return '#000'
end

function addColorsToGlobalNamespace()
  black             = '#000' or getColor('THEME_BLACK')
  white             = '#fff' or getColor('THEME_WHITE')
  gray_darker       = getColor('THEME_GRAY_DARKER')
  gray_dark         = getColor('THEME_GRAY_DARK')
  gray              = getColor('THEME_GRAY')
  gray_light        = getColor('THEME_GRAY_LIGHT')
  gray_lighter      = getColor('THEME_GRAY_LIGHTER')
  yellow_dark       = getColor('THEME_YELLOW_DARK')
  yellow            = getColor('THEME_YELLOW')
  red_dark          = getColor('THEME_RED_DARK')
  red               = getColor('THEME_RED')
  red_light         = getColor('THEME_RED_LIGHT')
  orange            = getColor('THEME_ORANGE')
  orange_light      = getColor('THEME_ORANGE_LIGHT')
  green_dark        = getColor('THEME_GREEN_DARK')
  green             = getColor('THEME_GREEN')
  green_light       = getColor('THEME_GREEN_LIGHT')
  blue_dark         = getColor('THEME_BLUE_DARK')
  blue              = getColor('THEME_BLUE')
  blue_light        = getColor('THEME_BLUE_LIGHT')
  cyan              = getColor('THEME_CYAN')
  cyan_light        = getColor('THEME_CYAN_LIGHT')
  pink_dark         = getColor('THEME_PINK_DARK')
  pink              = getColor('THEME_PINK')
  pink_light        = getColor('THEME_PINK_LIGHT')
  purple_dark       = getColor('THEME_PURPLE_DARK')
  purple            = getColor('THEME_PURPLE')
  purple_light      = getColor('THEME_PURPLE_LIGHT')
end

function client_menu_toggle_fn()
    local instance = nil
    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

function unminimiseClient(c)
    local c = awful.client.restore()
    -- Focus restored client
    if c then
        client.focus = c
        c:raise()
    end
end

function createGuiMenu()
  guiMenuButtons = {
    { "log out", function() awesome.quit() end, menubar.utils.lookup_icon("system-log-out") },
    { "suspend", "systemctl suspend", menubar.utils.lookup_icon("system-suspend") },
    { "hibernate", "systemctl hibernate", menubar.utils.lookup_icon("system-suspend-hibernate") },
    { "reboot", "systemctl reboot", menubar.utils.lookup_icon("system-reboot") },
    { "shutdown", "poweroff", menubar.utils.lookup_icon("system-shutdown") }
  }

  return freedesktop.menu.build({
    icon_size = 32,
    before = guiMenuButtons,
  })
end

function createGuiMenuWidget(guiMenu)
  return awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = guiMenu
  })
end

function setWallpaper(s)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

function windowButtons()
  return gears.table.join(
    awful.button({ }, 1, function (c)
      if c == client.focus then
        c.minimized = true
      else
        c.minimized = false
        if not c:isvisible() and c.first_tag then
          c.first_tag:view_only()
        end
        client.focus = c
        c:raise()
      end
    end)
  )
end

function tagListButtons()
  return gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
  )
end
