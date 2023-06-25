---@meta

--[[
The submodule `logging.envconfig` allows to configure the default logger via
environment variables. This is done based on a `prefix` for the environment
variables (with default value `"LL"`). The variables are the logger options
names with the prefix in all-caps separated by `"_"`. So if a logger takes
an option `"opts.logLevel"`, then it can be configured using environment
variable `LL_LOGLEVEL=warn`.

The type of logger can be set using environment variable `LL_LOGGER=console`
(assuming the default prefix `"LL"`).

The defaults are `"LL"` for the prefix, and a console logger to `"stderr"`.
]]
local envconfig = {}

---Sets the default prefix and loads the configuration.
---
---@param prefix string
---@return boolean? success, string? error
---
---Returns `true` on success, `nil, "already set a default"` if it was called
---before. Will throw an error if something during the configuration fails (bad
---user input in environment variables for example).
---
---This method should be called by applications at startup, to set the default
---prefix.
function envconfig.set_default_settings(prefix) end

---returns the appender name (eg. "file", "console", etc), and the options
---table for configuring the appender.
---
---@return string name
---@return table opts
---
---The options table has a metatable that will dynamically lookup fields in
---environment variables, this ensures that any option an appender checks will
---be read and returned. Boolean and number values will be converted to their
---respective types (case insensitive).
---
---The common `logPatterns` field is a special case where each level can be
---configured by appending the level with an `"_"`. See example below:
---
---Set these environment variables:
---
---```sh
---export MYAPP_LOGGER="console"
---export MYAPP_LOGLEVEL="info"
---export MYAPP_LOGPATTERN = "%message"
---export MYAPP_LOGPATTERNS_DEBUG = "%message %source"
---export MYAPP_LOGPATTERNS_FATAL = "Oh my!! %message"
---```
---
---Lua code (see `envconfig.set_default_logger` for a shorter version):
---
---```lua
---local logging = require("logging")
---local logenv = require("logging.envconfig")
---assert(logenv.set_default_settings("MYAPP"))
---local logger_name, logger_opts = logenv.get_default_settings()
---local logger = assert(require("logging."..logger_name)(logger_opts))
---logging.setdefaultLogger(logger)
---
---logger:info("configured via environment!")
---```
function envconfig.get_default_settings() end

---Sets (and returns) the default logger from the environment.
---@param prefix string
---@return logging.logger defaultLogger
---
---Set these environment variables:
---
---```sh
---export MYAPP_LOGGER="console"
---export MYAPP_LOGLEVEL="info"
---export MYAPP_LOGPATTERN = "%message"
---export MYAPP_LOGPATTERNS_DEBUG = "%message %source"
---export MYAPP_LOGPATTERNS_FATAL = "Oh my!! %message"
---```
---
---Lua code:
---
---```lua
---local logenv = require "logging.envconfig"
---local logger = assert(logenv.set_default_logger("MYAPP"))
---
---logger:info("configured via environment!")
---```
function envconfig.set_default_logger(prefix) end

return envconfig
