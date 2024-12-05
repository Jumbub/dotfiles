require("awful.autofocus")

local f = require("functions")

-- Colours, borders, fonts
f.setupTheme()

-- Terminal constants, editors constants
f.setGlobals()

-- Runtime and startup error handlers
f.setupErrorHandlers()

-- Tiling layouts
f.setupLayouts()

-- Setup panel GUI and wallpaper
f.setupScreens()

-- Set client default keybindings, screen placement settings
f.setupClientRules()

-- Setup handler actions when clients are created, focused, or their titlebar is requested
f.setupClientSignals(client)

-- Setup global keybindings
f.setupGlobalBindings()

-- Run startup commands
f.asyncJobs()
