-- Imports
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local themeAssets = require("beautiful.theme_assets")
local naughty = require("naughty")
local freedesktop = require("freedesktop")

require('custom')

-- Constants
local browser = "google-chrome-stable"
local terminal = "kitty"
local modkey = "Mod4"

local di = {
  awesome = awesome,
  screen = screen,
  client = client,

  setWallpaper = setWallpaper,

  gears = gears,
  awful = awful,
  wibox = wibox,
  beautiful = beautiful,
  naughty = naughty,
  freedesktop = freedesktop,
  themeAssets = themeAssets,

  browser = browser,
  terminal = terminal,
  modkey = modkey
}

handleStartupErrors()
handleRuntimeErrors()
addColorsToGlobalNamespace()

local guiMenu = createGuiMenu()
local guiMenuWidget = createGuiMenuWidget(guiMenu)

mytextclock = wibox.widget.textclock("%d/%m %H:%M")

awful.layout.layouts = {
  awful.layout.suit.tile,
}

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
      },
      s.mytasklist,
      {
          layout = wibox.layout.fixed.horizontal,
          wibox.widget.systray(),
          mykeyboardlayout,
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

clientKeys = gears.table.join(
  awful.key({ modkey }, "f", function (c) c.fullscreen = not c.fullscreen c:raise() end),
  awful.key({ modkey }, "x",  function (c) c:kill() end),
  awful.key({ modkey }, "o",  function (c) c:move_to_screen() end),
  awful.key({ modkey }, "n", function (c) c.minimized = true end),
  awful.key({ modkey }, "m", function (c) c.maximized = not c.maximized c:raise() end),

  awful.key({ modkey, "Control" }, "h", function (c)
    awful.client.setmaster(c)
    awful.tag.incnmaster(1, nil, true)
  end),
  awful.key({ modkey, "Control" }, "l", function (c)
    awful.client.setslave(c)
    awful.tag.incnmaster(-1, nil, true)
  end)
)

clientButtons = gears.table.join(
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
      keys = clientKeys,
      buttons = clientButtons,
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

require('local.beautiful')(di)
require('local.client')(di)
require('local.screen')(di)

awful.spawn.with_shell("~/.config/awesome/autorun.sh")
