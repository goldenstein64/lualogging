---@meta

---@class logging.loglevel

---@alias logging.append fun(self: logging.logger, level: logging.loglevel, message: string): any

---Logger objects are created by loading the 'appender' module, and calling on it. For example:
---
---```lua
---local logger = require("logging.console") {
---  -- options go here (see appenders for options)
---}
---```
---
---Log-levels can be one of:
---
---* `DEBUG` - designates fine-grained informational events that are most
---useful to debug an application
---* `INFO` - designates informational messages that highlight the progress of
---the application at coarse-grained level
---* `WARN` - designates potentially harmful situations
---* `ERROR` - designates error events that might still allow the application
---to continue running
---* `FATAL` - designates very severe error events that would presumably lead
---the application to abort
---* `OFF` - stops all log messages
---
---The values are presented in descending criticality, so if the minimum level
---is defined as `logger.WARN` then `logger.INFO` and `logger.DEBUG` level
---messages are not logged. The default set level at startup is logger.DEBUG.
---@class logging.logger
---@field append logging.append
---The *DEBUG* level designates fine-grained informational events that are most
---useful to debug an application.
---@field DEBUG logging.loglevel
---The *INFO* level designates informational messages that highlight the
---progress of the application at coarse-grained level.
---@field INFO logging.loglevel
---The *WARN* level designates potentially harmful situations.
---@field WARN logging.loglevel
---The *ERROR* level designates error events that might still allow the
---application to continue running.
---@field ERROR logging.loglevel
---The *FATAL* level designates very severe error events that would presumably
---lead the application to abort.
---@field FATAL logging.loglevel
---The *OFF* level will stop all log messages.
---@field OFF logging.loglevel
local logger = {}

---logs a message with the specified level
---@param level logging.loglevel
---@param format string -- a format string
---@param ... any -- parameters to the format string
function logger:log(level, format, ...) end

---logs a message with the specified level
---@param level logging.loglevel
---@param getter fun(...): string -- a function that returns a string
---@param ... any -- parameters to `getter`
function logger:log(level, getter, ...) end

---logs a message with the specified level
---@param level logging.loglevel
---@param value any -- The value to log. Tables are pretty-printed using `logging.tostring`
function logger:log(level, value) end

---sets a minimum level for messages to be logged
---@param level logging.loglevel
function logger:setLevel(level) end

---returns a print-like function that redirects all output to the logger
---instead of the console. The `level` parameter specifies the log-level of the
---output.
function logger:getPrint(level) end

---Logs a message with DEBUG level.
---@param format string -- a format string
---@param ... any -- parameters to the format string
function logger:debug(format, ...) end

---Logs a message with DEBUG level.
---@param getter fun(...): string -- a function that returns a string
---@param ... any -- parameters to `getter`
function logger:debug(getter, ...) end

---Logs a message with DEBUG level.
---@param value any -- The value to log. Tables are pretty-printed using `logging.tostring`
function logger:debug(value) end

---Logs a message with INFO level.
---@param format string -- a format string
---@param ... any -- parameters to the format string
function logger:info(format, ...) end

---Logs a message with INFO level.
---@param getter fun(...): string -- a function that returns a string
---@param ... any -- parameters to `getter`
function logger:info(getter, ...) end

---Logs a message with INFO level.
---@param value any -- The value to log. Tables are pretty-printed using `logging.tostring`
function logger:info(value) end

---Logs a message with WARN level.
---@param format string -- a format string
---@param ... any -- parameters to the format string
function logger:warn(format, ...) end

---Logs a message with WARN level.
---@param getter fun(...): string -- a function that returns a string
---@param ... any -- parameters to `getter`
function logger:warn(getter, ...) end

---Logs a message with WARN level.
---@param value any -- The value to log. Tables are pretty-printed using `logging.tostring`
function logger:warn(value) end

---Logs a message with ERROR level.
---@param format string -- a format string
---@param ... any -- parameters to the format string
function logger:error(format, ...) end

---Logs a message with ERROR level.
---@param getter fun(...): string -- a function that returns a string
---@param ... any -- parameters to `getter`
function logger:error(getter, ...) end

---Logs a message with ERROR level.
---@param value any -- The value to log. Tables are pretty-printed using `logging.tostring`
function logger:error(value) end

---Logs a message with FATAL level.
---@param format string -- a format string
---@param ... any -- parameters to the format string
function logger:fatal(format, ...) end

---Logs a message with FATAL level.
---@param getter fun(...): string -- a function that returns a string
---@param ... any -- parameters to `getter`
function logger:fatal(getter, ...) end

---Logs a message with FATAL level.
---@param value any -- The value to log. Tables are pretty-printed using `logging.tostring`
function logger:fatal(value) end

---The `logging` module holds a `new` function to create new `logger` objects.
---
---Example:
---
---```lua
---local Logging = require "logging"
---
---local appender = function(self, level, message)
---  print(level, message)
---  return true
---end
---
---local logger = Logging.new(appender)
---
---logger:setLevel(logger.WARN)
---logger:log(logger.INFO, "sending email")
---
---logger:info("trying to contact server")
---logger:warn("server did not respond yet")
---logger:error("server unreachable")
---
----- dump a table in a log message
---local tab = { a = 1, b = 2 }
---logger:debug(tab)
---
----- use string.format() style formatting
---logger:info("val1='%s', val2=%d", "string value", 1234)
---
----- complex log formatting.
---local function log_callback(val1, val2)
---  -- Do some complex pre-processing of parameters, maybe dump a table to a string.
---  return string.format("val1='%s', val2=%d", val1, val2)
---end
---
----- function 'log_callback' will only be called if the current log level is "DEBUG"
---logger:debug(log_callback, "string value", 1234)
---
----- create a print that redirects to the logger at level "INFO"
---logger:setLevel (logger.INFO)
---local print = logger:getPrint(logger.INFO)
---print "hello\nthere!"
---```
---
---Upon execution of the above example the following lines will show in the standard output. Notice that some of the INFO log requests are not handled because the minimum level is set to WARN.
---
---```plain
---WARN server did not respond yet
---ERROR server unreachable
---INFO hello
---INFO there!
---```
---@class logging
---The *DEBUG* level designates fine-grained informational events that are most
---useful to debug an application.
---@field DEBUG logging.loglevel
---The *INFO* level designates informational messages that highlight the
---progress of the application at coarse-grained level.
---@field INFO logging.loglevel
---The *WARN* level designates potentially harmful situations.
---@field WARN logging.loglevel
---The *ERROR* level designates error events that might still allow the
---application to continue running.
---@field ERROR logging.loglevel
---The *FATAL* level designates very severe error events that would presumably
---lead the application to abort.
---@field FATAL logging.loglevel
---The *OFF* level will stop all log messages.
---@field OFF logging.loglevel
---@field _COPYRIGHT string -- the copyright notice
---@field _DESCRIPTION string -- a short description of this module
---@field _VERSION string -- the module version
local logging = {}

---Creates a new logger object from a custom `appender` function.
---@param appender logging.append -- used by the logger to append a message with a log-level to the log stream.
---@param logLevel logging.loglevel -- log-level to start with. Defaults to `logging.defaultLevel()`.
---@return logging.logger? logger -- the new logger object
---@return string err -- present if there was any error setting the custom levels if provided
---
---The `appender` function signature is `function(self, level, message)`. The
---optional `logLevel` argument specifies the initial log-level to set (the
---value must be a valid log-level constant). If omitted defaults to
---`logging.defaultLevel`.
function logging.new(appender, logLevel) end

---Creates a log-patterns table.
---@param logPatterns? { [logging.loglevel]: string } -- table containing `logPattern` strings per level, defaults to `{}`
---@param default? string -- the `logPattern` to be used for levels not yet present in 'patterns', defaults to each value in `defaultLogPatterns`
---@return table logPatterns -- a table with a logPattern for every log-level constant
---The returned table will for each level have the `logPattern` set to
---
---1. the value in the table,
---2. the string value, or
---3. the pattern from the global defaults
---
---Example logging source info only on debug-level, and coloring error and
---fatal messages:
---
---```lua
---local patterns = logging.buildLogPatterns(
---  {
---    [logging.DEBUG] = "%date %level %message (%source)\n"
---    [logging.ERROR] = "%date "..ansi_red.."%level %message"..ansi_reset.."\n"
---    [logging.FATAL] = "%date "..ansi_red.."%level %message"..ansi_reset.."\n"
---  }, "%date %level %message\n"
---)
---```
function logging.buildLogPatterns(logPatterns, default) end

---@class logging.osdate : osdate
---@field secf number -- the number of seconds below 1

---Compatible with standard Lua `os.date()` function, but supports second
---fractions. The placeholder in the format string is `"%q"`, or `"%1q"` to
---`"%6q"`, where the number 1-6 specifies the number of decimals. The default
---is 3, so `"%q"` is the same as `"%3q"`. The format will always have the
---specified length, padded with leading and trailing 0's where necessary.
---@param format string? Defaults to `"%c"`.
---@param time number? Defaults to `require("socket").gettime()` or `os.time()`.
---@return string | logging.osdate
---
---If the pattern is `"*t"`, then the returned table will have an extra field
---`secf` that holds the fractional part.
---
---Example: `"%y-%m-%d %H:%M:%S.%6q"`
---
---Note: if the `time` parameter is not provided, it will try and use the
---LuaSocket function `gettime()` to get the time. If unavailable, the
---fractional part will be set to 0.
function logging.date(format, time) end

---Sets the default logPatterns (global!) if a parameter is given. If the
---parameter is a string then that string will be used as the pattern for all
---log-levels. If a table is given, then it must have all log-levels defined
---with a pattern string. See also `logging.buildLogPatterns`.
---@param logPatterns? string | { [logging.loglevel]: string }
---@return { [logging.loglevel]: string } logPatterns -- The current `defaultLogPatterns` value
---
---The default is `"%date %level %message\n"` for all log-levels.
---
---Available placeholders in the pattern string are:
---
---* `%date`
---* `%level`
---* `%message`
---* `%file`
---* `%line`
---* `%function`
---* `%source` - The `%source` placeholder evaluates to `"%file:%line in function'%function'"`.
---
---NOTE: since this is a global setting, libraries should never set it, only
---applications should.
function logging.defaultLogPatterns(logPatterns) end

---Sets the default timestampPattern (global!) if given. The default is `nil`,
---which results in a system-specific date/time format. The pattern should be
---accepted by the function `logging.date` for formatting.
---@param timestampPattern? string
---@return string timestampPattern -- the current `defaultTimestampPattern` value
---
---NOTE: since this is a global setting, libraries should never set it, only
---applications should.
function logging.defaultTimestampPattern(timestampPattern) end

---Sets the default log-level (global!) if given. Each new logger object
---created will start with the log-level as specified by this value. The
---`logLevel` parameter must be one of the log-level constants. The default is
---`logging.DEBUG`.
---@param logLevel? logging.loglevel
---@return logging.loglevel logLevel -- the current `defaultLevel` value
---
---NOTE: since this is a global setting, libraries should never set it, only
---applications should.
function logging.defaultLevel(logLevel) end

---Sets the default logger object (global!) if given. The `logger` parameter
---must be a LuaLogging logger object. The default is to generate a new console
---logger (with `destination` set to `stderr`) on the first call to get the
---default logger.
---@param logger? logging.logger
---@return logging.logger logger -- the current `defaultLogger` value
---
---NOTE: since this is a global setting, libraries should never set it, only
---applications should. Libraries should get this logger and use it, assuming
---the application has set it.
---
---Example: application setting the default logger
---
---```lua
---local color = require("ansicolors") -- https://github.com/kikito/ansicolors.lua
---local ll = require("logging")
---require "logging.console"
---ll.defaultLogger(ll.console {
---  destination = "stderr",
---  timestampPattern = "!%y-%m-%dT%H:%M:%S.%qZ", -- ISO 8601 in UTC
---  logPatterns = {
---    [ll.DEBUG] = color("%{white}%date%{cyan} %level %message (%source)\n"),
---    [ll.INFO] = color("%{white}%date%{white} %level %message\n"),
---    [ll.WARN] = color("%{white}%date%{yellow} %level %message\n"),
---    [ll.ERROR] = color("%{white}%date%{red bright} %level %message %{cyan}(%source)\n"),
---    [ll.FATAL] = color("%{white}%date%{magenta bright} %level %message %{cyan}(%source)\n"),
---  }
---})
---```
---
---Example: library using default if available (fallback to nop)
---
---```lua
---local log do
---  local ll = package.loaded.logging
---  if ll and type(ll) == "table" and ll.defaultLogger and
---    tostring(ll._VERSION):find("LuaLogging") then
---    -- default LuaLogging logger is available
---    log = ll.defaultLogger()
---  else
---    -- just use a stub logger with only no-op functions
---    local nop = function() end
---    log = setmetatable({}, {
---      __index = function(self, key) self[key] = nop return nop end
---    })
---  end
---end
---
---log:debug("starting my library")
---```
function logging.defaultLogger(logger) end

---Converts a Lua value to a string.
---@param value any
---@return string
---
---It pretty-prints tables and escapes strings in quotes using `%q`.
function logging.tostring(value) end

---Converts a log pattern into a function of signature
---`(timestampPattern, logLevel, message)`. Cached by `logging.prepareLogMsg`.
---@param pattern string
---@return fun(timestampPattern: string, logLevel: logging.loglevel, message: string): string
---
---NOTE: This function is an implementation detail, and should only be used for
---writing loggers. In those cases, use `logging.prepareLogMsg`.
function logging.compilePattern(pattern) end

---Formats a message using a log pattern.
---@param logPattern string
---@param timestampPattern string
---@param logLevel logging.loglevel
---@param message string
---@return string formattedMessage
---
---NOTE: This function is an implementation detail, and should only be used for
---writing loggers.
function logging.prepareLogMsg(logPattern, timestampPattern, logLevel, message) end

---Allows for backwards-compatible parameter handling with older versions of
---LuaLogging.
---@param lst string[]
---@param ... any
---@deprecated
function logging.getDeprecatedParams(lst, ...) end

-- TODO: set logging global

-- TODO: add loggers to logging when they get required (probably by parsing requires)
-- loggers:
-- - console
-- - file
-- - rolling file
-- - sql
-- - socket
-- - rsyslog
-- - email
-- - nginx/OpenResty

return logging
