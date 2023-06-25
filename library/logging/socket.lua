---@meta

--[[
# Socket appender

This appender can be used to send log requests through a socket. Socket
appender relies on LuaSocket to do its job.

Upon each log request a connection is opened, the message is sent and the
connection is closed.

```lua
function logging.socket {
  hostname = string,
  port = number,

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
require("logging.socket")

local logger = logging.socket {
  hostname = "localhost",
  port = 5000,
}

logger:info("logging.socket test")
logger:debug("debugging...")
logger:error("error!")
```
]]
---@class logging.socket
---@overload fun(options: logging.socket.options): logging.logger
local socket = {}

---@class logging.socket.options
---Hostname can be an IP address or a host name of the server where the log
---message will be sent.
---@field hostname string
---The port must be an integer number in the range [1..64K).
---@field port integer
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

---@param options logging.socket.options
---@return logging.logger
function socket.new(options) end

return socket
