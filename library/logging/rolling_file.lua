---@meta

--[[
# Rolling File appender

The rolling file appender can be used to write log messages to a file. It uses
Lua I/O routines to do its job. The rolling file appender rolls over the
logfile once it has reached a certain size limit. It also mantains a maximum
number of log files.

```lua
function logging.rolling_file {
  [filename = string,]
  maxFileSize = number,
  [maxBackupIndex = number,]

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
require("logging.rolling_file")

local logger = logging.rolling_file {
  filename = "test.log",
  maxFileSize = 1024,
  maxBackupIndex = 5,
}

logger:info("logging.rolling_file test")
logger:debug("debugging...")
logger:error("error!")
```
]]
---@class logging.rolling_file
---@overload fun(options: logging.rolling_file.options): logging.logger
local rolling_file = {}

---@class logging.rolling_file.options
---The name of the file to be written to.
---
---If the file cannot be opened for appending the logging request returns `nil`
---and an error message.
---
---The default value is `"lualogging.log"`.
---@field filename? string
---The max size of the file in bytes. Every time the file reaches this size it
---will rollover, generating a new clean log file and storing the old log on a
---filename.n, where n goes from 1 to the configured `maxBackupIndex`.
---
---The more recent backup is the one with the lowest n on its filename. Eg.
---
---* test.log.1 (most recent backup)
---* test.log.2 (least recent backup)
---@field maxFileSize integer
---The number of backup files that will be generated. The default value is `1`.
---@field maxBackupIndex? integer
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

---@param options logging.rolling_file.options
---@return logging.logger
function rolling_file.new(options) end

return rolling_file
