-- Imports
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local theme_assets = require("beautiful.theme_assets")
local naughty = require("naughty")
local freedesktop = require("freedesktop")

-- Constants
local browser = "google-chrome-stable"
local filemanager = "thunar"
local terminal = "kitty"
local modkey = "Mod4"

require('custom')

handleStartupErrors()
handleRuntimeErrors()
configureTheme()
setLayouts()
addColorsToGlobalNamespace()

local guiMenu = createGuiMenu()
local guiMenuWidget = createGuiMenuWidget(guiMenu)

mytextclock = wibox.widget.textclock("%d/%m %H:%M")

separator = wibox.widget.textbox(' <span color="' .. white .. '">  </span>')
spacer = wibox.widget.textbox(' <span color="' .. white .. '">    </span>')

-- Create a wibox for each screen and add it
screen.connect_signal("property::geometry", setWallpaper)

awful.screen.connect_for_each_screen(function(s)
  setWallpaper(s)

  awful.tag({ "1" }, s, awful.layout.layouts[1])

  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, tagListButtons())

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, windowButtons)

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "bottom", screen = s, height = 16, border_width = 0, opacity = 1 })

  -- Add widgets to the wibox
  s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      {
          layout = wibox.layout.fixed.horizontal,
          guiMenuWidget,
          s.mypromptbox,
          separator,
      },
      s.mytasklist,
      {
          layout = wibox.layout.fixed.horizontal,
          wibox.widget.systray(),
          mykeyboardlayout,
          separator,
          mytextclock,
      },
  }
end)

root.buttons(gears.table.join(
	awful.button({ }, 1, function () guiMenu:hide() end),
  awful.button({ }, 3, function () guiMenu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
))

root.keys(gears.table.join(
  -- change
  awful.key({ modkey }, "j", function () awful.client.focus.byidx( 1) end),
  awful.key({ modkey }, "k", function () awful.client.focus.byidx(-1) end),

  -- resize
  awful.key({ modkey }, "Down", function () awful.client.incwfact( 0.1)    end),
  awful.key({ modkey }, "Up", function () awful.client.incwfact(-0.1)    end),
  awful.key({ modkey }, "l", function () awful.tag.incmwfact( 0.05) end),
  awful.key({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end),

  -- move
  awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(  1)    end),
  awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx( -1)    end),

  -- screen
  awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
  awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),

  -- layout
  awful.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster( 1, nil, true) end),
  awful.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1, nil, true) end),

  -- lock
  awful.key({ "Control", "Mod1"  }, "l", function () awful.spawn.with_shell("~/scripts/lock") end),

  -- programs
  awful.key({ modkey }, "Return", function () awful.spawn(terminal) end),
  awful.key({ modkey }, "r", function () awful.spawn("/usr/bin/rofi -show run") end),
  awful.key({ modkey }, "c", function () awful.spawn("/home/jamie/scripts/clipboard-manager") end),

  -- awesome
  awful.key({ modkey, "Control" }, "r", awesome.restart),
  awful.key({ modkey, "Control" }, "n", unminimiseClient)
))

clientkeys = gears.table.join(
  awful.key({ modkey }, "f", function (c) c.fullscreen = not c.fullscreen c:raise() end),
  awful.key({ modkey }, "x",  function (c) c:kill() end),
  awful.key({ modkey }, "o",  function (c) c:move_to_screen() end),
  awful.key({ modkey }, "n", function (c) c.minimized = true end),
  awful.key({ modkey }, "m", function (c) c.maximized = not c.maximized c:raise() end)
)

clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() guiMenu:hide() end)
)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  {
    rule = {},
    properties = {
      titlebars_enabled = false,
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      size_hints_honor = false, -- Remove gaps between terminals
      screen = awful.screen.preferred,
      callback = awful.client.setslave,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
   }
  },
  -- Floating clients.
  {
    rule_any = {
      instance = { "DTA", "copyq", },
      class = { "Arandr", "Gpick", "Kruler", "MessageWin", "Sxiv", "Wpa_gui", "pinentry", "veromix", "xtightvncviewer"},
      name = { "Event Tester", },
      role = { "AlarmWindow", "pop-up", }
    },
    properties = { floating = false }
  },
  { rule_any = { type = { "dialog" } }, properties = { titlebars_enabled = true } },
  { rule = { class = "Google-chrome", name="DevTools*" }, properties = { screen = 2 } },
}

client.connect_signal("manage", function (c)
  if awesome.startup and
    not c.size_hints.user_position
    and not c.size_hints.program_position then
      awful.placement.no_offscreen(c)
  end
end)

client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

for s = 1, screen.count() do
  screen[s]:connect_signal("arrange", function ()
    for _, c in pairs(awful.client.visible(s)) do
      c.border_width = c.maximized and 0 or beautiful.border_width
    end
  end)
end

function withColor(color, func)
  awful.spawn.with_line_callback('/home/jamie/scripts/colors ' .. color, {
      stdout = func
  })
end

withColor('THEME_BLACK', function(color)
  beautiful.bg_normal = color
  beautiful.bg_normal = color
  beautiful.bg_focus = color
  beautiful.bg_urgent = color
  beautiful.bg_minimize = color
  beautiful.bg_systray = color
  beautiful.bg_normal = color
  beautiful.bg_focus = color
  beautiful.titlebar_bg_focus = color
  beautiful.border_normal = color
  beautiful.border_focus = color
  beautiful.border_marked = color
end)

withColor('THEME_WHITE', function(color)
  beautiful.fg_normal = color
  beautiful.fg_focus = color
  beautiful.fg_urgent = color
  beautiful.fg_minimize = color
end)

withColor('THEME_ORANGE', function(color)
  beautiful.border_focus = color
  beautiful.titlebar_bg_focus = color
end)

awful.spawn.with_shell("~/.config/awesome/autorun.sh")
