---@meta

local logging = require("logging")

--[[
# Console appender

Console is the simplest appender. It just writes the log messages to
`io.stdout` or `io.stderr`.

```lua
function logging.console {
  [destination = "stdout"|"stderr",]

  [logPattern = string,]
  [logPatterns = {
    [logging.DEBUG = string,]
    [logging.INFO  = string,]
    [logging.WARN  = string,]
    [logging.ERROR = string,]
    [logging.FATAL = string,]
  },]
  [timestampPattern = string,]
  [logLevel = log-level-constant,]
}
```

Example:

```lua
local ansicolors = require("ansicolors") -- https://github.com/kikito/ansicolors.lua
local ll = require("logging")
require("logging.console")

-- set up the default logger to stderr + colorization
ll.defaultLogger(ll.console {
  logLevel = ll.DEBUG,
  destination = "stderr",
  timestampPattern = "%y-%m-%d %H:%M:%S",
  logPatterns = {
    [ll.DEBUG] = ansicolors("%date%{cyan} %level %message %{reset}(%source)\n"),
    [ll.INFO] = ansicolors("%date %level %message\n"),
    [ll.WARN] = ansicolors("%date%{yellow} %level %message\n"),
    [ll.ERROR] = ansicolors("%date%{red bright} %level %message %{reset}(%source)\n"),
    [ll.FATAL] = ansicolors("%date%{magenta bright} %level %message %{reset}(%source)\n"),
  }
})

local log = ll.defaultLogger()

log:info("logging.console test")
log:debug("debugging...")
log:error("error!")
```
]]
---@class logging.console
---@overload fun(options: logging.console.options): logging.logger
local console = {}

---@class logging.console.options
---The destination stream, optional. The value can be either `"stdout"`, or
---`"stderr"`. The default is `"stdout"`.
---@field destination? "stdout" | "stderr"
---This value will be used as the default value for each log-level that was
---omitted in `logPatterns`.
---@field logPattern? string
---A table with `logPattern` strings indexed by the log-levels. A `logPattern`
---specifies how the message is written.
---
---If this parameter is omitted, a patterns table will be created with the
---parameter `logPattern` as the default value for each log-level. If
---`logPattern` also is omitted then each level will fall back to the current
---default setting, see `logging.defaultLogPatterns`.
---@field logPatterns? { [logging.loglevel]: string }
---This is an optional parameter that can be used to specify a date/time
---formatting in the log message. See `logging.date` for the format. The
---default is taken from `logging.defaultTimestampPattern()`.
---@field timestampPattern? string
---The initial log-level to set for the created logger.
---@field logLevel? logging.loglevel

---@param options logging.console.options
---@return logging.logger
function console.new(options) end

return console
