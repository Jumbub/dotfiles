local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local freedesktop = require("freedesktop")

local f = {}

f.setupTheme = function()
  awful.spawn.with_line_callback('/home/jamie/scripts/awesome-theme-generator', {
    stdout = function (output)
      if output == 'Restart' then
        naughty.notify {text="Please restart Awesome, then theme was updated!"}
        require('theme')
      end
    end
  })

  pcall(function ()
    beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
    require('theme')
  end)
end

f.setGlobals = function ()
  -- Fucking bullshit implicitly required to be a global
  modkey = "Mod4"

  -- Globals because I'm lazy
  terminal = "kitty"
  editor = "nvim"
  guieditor = "code"
end

f.setupErrorHandlers = function ()
  if awesome.startup_errors then naughty.notify {
      preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors
  } end

	local in_error = false

	awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
    if in_error then
      return
    end
    in_error = true

    naughty.notify {
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err)
    }

    in_error = false
  end)
end


f.clockWidget = function ()
  return wibox.widget.textclock("%d/%m %H:%M")
end

f.setupClientSignals = function(client)
  client.connect_signal("manage", function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      awful.placement.no_offscreen(c)
    end
    if not awesome.startup then
      awful.client.setslave(c)
    end
  end)

  client.connect_signal("request::titlebars", function(c)
    local buttons = gears.table.join(
      awful.button({}, 1, function()
          c:emit_signal("request::activate", "titlebar", {raise = true})
          awful.mouse.client.move(c)
      end),
      awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
      end)
    )

    awful.titlebar(c):setup {
      {
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout = wibox.layout.fixed.horizontal
      },
      {
        {
          align = "center",
          widget = awful.titlebar.widget.titlewidget(c)
        },
        buttons = buttons,
        layout = wibox.layout.flex.horizontal
      },
      {
        awful.titlebar.widget.floatingbutton(c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton(c),
        awful.titlebar.widget.ontopbutton(c),
        awful.titlebar.widget.closebutton(c),
        layout = wibox.layout.fixed.horizontal()
      },
      layout = wibox.layout.align.horizontal
    }
  end)

  client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
  end)

  client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
  end)
  client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
  end)
end

f.setWallpaper = function (s)
  gears.wallpaper.maximized('/home/jamie/.config/awesome/wallpaper' .. s.index .. '.png', s, false)
end

f.setupGlobalBindings = function ()
  root.buttons(gears.table.join())

  root.keys(gears.table.join(
    awful.key({ modkey }, "j", function () awful.client.focus.byidx( 1) end),
    awful.key({ modkey }, "k", function () awful.client.focus.byidx(-1) end),

    awful.key({ modkey }, "Down", function () awful.client.incwfact( 0.1)    end),
    awful.key({ modkey }, "Up", function () awful.client.incwfact(-0.1)    end),
    awful.key({ modkey }, "l", function () awful.tag.incmwfact( 0.05) end),
    awful.key({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end),

    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx( -1)    end),

    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),

    awful.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster( 1, nil, true) end),
    awful.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1, nil, true) end),

    awful.key({ "Control", "Mod1"  }, "l", function () awful.spawn.with_shell("~/scripts/lock") end),

    awful.key({ modkey }, "Return", function () awful.spawn(terminal) end),
    awful.key({ modkey }, "e", function () awful.spawn(guieditor) end),
    awful.key({ modkey }, "r", function () awful.spawn("/usr/bin/rofi -show run") end),
    awful.key({ modkey }, "c", function () awful.spawn("/home/jamie/scripts/clipboard-manager") end),

    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Control" }, "n", unminimiseClient)
  ))
end

f.setupLayouts = function ()
  awful.layout.layouts = { awful.layout.suit.tile, awful.layout.suit.max }
end

f.clientKeyBindings = function()
  return gears.table.join(
    awful.key({ modkey }, "f", function (c) c.fullscreen = not c.fullscreen c:raise() end),
    awful.key({ modkey }, "x",  function (c) c:kill() end),
    awful.key({ modkey }, "o",  function (c) c:move_to_screen() end),
    awful.key({ modkey }, "n", function (c) c.minimized = true end),
    awful.key({ modkey }, "m", function () awful.layout.inc(1) end),
    awful.key({ modkey, "Shift" }, "m", function (c) c.maximized = not c.maximized c:raise() end),

    awful.key({ modkey, "Control" }, "h", function (c)
      awful.client.setmaster(c)
      awful.tag.incnmaster(1, nil, true)
    end),
    awful.key({ modkey, "Control" }, "l", function (c)
      awful.client.setslave(c)
      awful.tag.incnmaster(-1, nil, true)
    end)
  )
end

f.clientMouseBindings = function()
  return gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end)
  )
end

f.taskListBindings = function()
  return gears.table.join(
    awful.button({}, 1, function(c)
      if c == client.focus then
        c.minimized = true
      else
        c:emit_signal("request::activate", "tasklist", {raise = true})
      end
    end),
    awful.button({}, 3, function() awful.menu.client_list({theme = {width = 250}}) end),
    awful.button({}, 4, function() awful.client.focus.byidx(1) end),
    awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
  )
end

f.menuWidget = function ()
  return awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = awful.menu({items = {
      {"open terminal", terminal},
      {"edit config", terminal .. " -e " .. editor .. " " .. awesome.conffile},
      {"restart", awesome.restart},
      {"quit", function() awesome.quit() end}
    }})
  })
end

f.setupClientRules = function ()
  awful.rules.rules = {
    {
      rule = {},
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = f.clientKeyBindings(),
        buttons = f.clientMouseBindings(),
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen
      }
    },
    {
      rule_any = {
        instance = {
          "DTA",
          "copyq",
          "pinentry"
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",
          "Sxiv",
          "Tor Browser",
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"
        },
        name = {
          "Event Tester"
        },
        role = {
          "AlarmWindow",
          "ConfigManager"
        }
      },
      properties = { floating = true, titlebars_enabled = true }
    },
    {
      rule_any = {
        role = {
          "pop-up" -- Chrome debugger
        }
      },
      properties = {floating = false, titlebars_enabled = false}
    },
    {
      rule_any = {
        type = {"normal", "dialog"}
      },
      properties = { titlebars_enabled = false }
    },
    {
      rule_any = {
        name = {"NO_FOCUS"}
      },
      properties = {
        focusable = false,
        titlebars_enabled = true,
      }
    },
  }
end


f.setupScreens = function (screen)
  screen.connect_signal("property::geometry", f.setWallpaper)

  awful.screen.connect_for_each_screen(function(s)
    f.setWallpaper(s)

    awful.tag({"1"}, s, awful.layout.layouts[1])

    s.myLayoutBox = awful.widget.layoutbox(s)
    s.myLayoutBox:buttons(gears.table.join(
      awful.button({}, 1, function() awful.layout.inc(1) end),
      awful.button({}, 3, function() awful.layout.inc(-1) end),
      awful.button({}, 4, function() awful.layout.inc(1) end),
      awful.button({}, 5, function() awful.layout.inc(-1) end)
    ))

    s.myTaskList = awful.widget.tasklist {
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      buttons = f.taskListBindings()
    }

    s.myWibox = awful.wibar {
      position = "top",
      screen = s
    }
    s.myWibox:setup {
      layout = wibox.layout.align.horizontal,
      {
        layout = wibox.layout.fixed.horizontal,
        f.menuWidget(),
      },
      {
        layout = wibox.layout.fixed.horizontal,
        s.myTaskList,
      },
      {
        layout = wibox.layout.fixed.horizontal,
        require("awesome-wm-widgets.cpu-widget.cpu-widget")(),
        require("awesome-wm-widgets.ram-widget.ram-widget")(),
        require("awesome-wm-widgets.volume-widget.volume")({widget_type='arc'}),
        f.clockWidget()
      }
    }
  end)
end

f.asyncJobs = function()
  awful.spawn.with_shell("~/.config/awesome/autorun.sh")
end

return f
