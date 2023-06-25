---@meta

--[[
# File appender

The file appender can be used to write log messages to a file. It uses Lua I/O
routines to do its job.

```lua
function logging.file {
  [filename = string,]
  [datePattern = string,]

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
require("logging.file")

local logger = logging.file {
  filename = "test%s.log",
  datePattern = "%Y-%m-%d",
}

logger:info("logging.file test")
logger:debug("debugging...")
logger:error("error!")
```
]]
---@class logging.file
---@overload fun(options: logging.file.options): logging.file
local file = {}

---@class logging.file.options
---The name of the file to be written to. On each call to log a message the
---file is opened for appending and closed immediately.
---
---If the file cannot be opened for appending the logging request returns `nil`
---and an error message.
---
---The default value is `"lualogging.log"`.
---@field filename? string
---This is an optional parameter that can be used to specify a date pattern
---that will be passed to the `os.date` function to compose the filename.
---
---This is useful to create daily or monthly log files. If the user wants to
---create one log file per day he specifies a `"%Y-%m-%d"` pattern and a
---filename like `"temp%s.log"`.
---@field datePattern? string
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

---@param options logging.file.options
---@return logging.file
function file.new(options) end

return file
