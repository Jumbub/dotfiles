pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
menubar.utils.terminal = terminal
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

local f = require("functions")
f.setupTheme()
f.setGlobals()
f.setupErrorHandlers()
f.setupLayouts()
f.setupScreens(screen)
f.setupClientRules()
f.setupClientSignals(client, beautiful)
f.setupGlobalBindings()

awful.spawn.with_shell("~/.config/awesome/autorun.sh")
