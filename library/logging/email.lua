---@meta

--[[
# Email Appender

This appender can be used to send log requests through email. One email message 
is sent for each log request.

```lua
function logging.email {
  from = string,
  rcpt = string or string-table,
  [user = string,]
  [password = string,]
  [server = string,]
  [port = number,]
  [domain = string,]
  [headers = table,]

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
require("logging.email")

local logger = logging.email {
  rcpt = "mail@host.com",
  from = "mail@host.com",
  headers = {
    subject = "[%level] logging.email test",
  },
}

logger:info("logging.email test")
logger:debug("debugging...")
logger:error("error!")
```
]]
---@class logging.email
---@overload fun(options: logging.email.options): logging.email
local email = {}

---@class logging.email.options.headers
---The recipient of the message, as an extended description.
---@field to string
---The sender of the message, as an extended description.
---@field from string
---The subject of the message sent. This can contain patterns like the
---`logPattern` parameter.
---@field subject string

---@class logging.email.options
---The sender of the email message.
---@field from string
---The recipient of the email message.
---@field rcpt string | string[]
---User for authentication.
---@field user? string
---Password for authentication.
---@field password? string
---Server to connect to. Default is `"localhost"`.
---@field server? string
---Port to connect to. Default is `25`.
---@field port? number
---Domain name used to greet the server. Defaults to the local machine host
---name.
---@field domain? string
---@field headers? logging.email.options.headers
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
---formatting in the log message. The default is taken from
---`logging.defaultTimestampPattern()`.
---@field timestampPattern? string
---The initial log-level to set for the created logger.
---@field logLevel? logging.loglevel

---@param options logging.email.options
---@return logging.email
function email.new(options) end

return email
