--[[

     Licensed under GNU General Public License v2
      * (c) 2021, github.com/jumbub

--]]

local helpers = require("lain.helpers")
local wibox = require("wibox")
local gears = require("gears")
local math = math
local string = string
local popen = io.popen

-- GPU usage
-- lain.widget.contrib.nvidia_gpu

local COMMAND = 'nvidia-smi -q -d UTILIZATION | grep "        Gpu\\|        Memory\\|        Encoder\\|        Decoder"'
-- Expected output is as follows (repeating for multi-gpu rigs):
--         Gpu                               : 30 %
--         Memory                            : 34 %
--         Encoder                           : 0 %
--         Decoder                           : 0 %

local function factory(args)
  args = args or {}

  local nvidia_gpu = { widget = args.widget or wibox.widget.textbox() }
  local timeout = args.timeout or 2
  local settings = args.settings or function() end

  function nvidia_gpu.update()
    local file = popen(COMMAND, "r")

    local gpus = {}
    for line in file:lines() do
      for key, value in string.gmatch(line, " +(%w+) +: +(%d+)") do
        if key == "Gpu" then
          table.insert(gpus, {})
        end
        if key == "Gpu" then
          key = "usage"
        end
        if key == "Memory" then
          key = "mem_usage"
        end
        if key == "Decoder" then
          key = "decoder_usage"
        end
        if key == "Encoder" then
          key = "encoder_usage"
        end
        gpus[#gpus][key] = tonumber(value)
      end
    end
    nvidia_gpu_now = gpus
    widget = nvidia_gpu.widget

    settings()
  end

  helpers.newtimer("nvidia_gpu", timeout, nvidia_gpu.update)

  return nvidia_gpu
end

return factory
