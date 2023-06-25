---@meta

--[[
# Nginx/Openresty appender

This appender has no configuration options, and simply forwards whatever is
being logged to the configured Nginx log. LuaLogging log-levels will be
converted to the equivalent Nginx ones, and initial log-level will be set to
match the Nginx system level.

It makes sense to configure this logger and set it as the default logger on
Nginx/OpenResty startup. Any libraries will then be able to just grab the
defaultLogger from `logging.defaultLogger()` and won't need any modifications
to work with Nginx/OpenResty.

Example:

```lua
require("logging.nginx")
local logging = require("logging")

local logger = logging.nginx()
logging.defaultLogger(logger)

logger:info("logging.nginx test")
logger:debug("debugging...")
logger:error("error!")
```
]]
---@overload fun(options?: table): logging.logger
local nginx = {}

---@param options? table
---@return logging.logger
function nginx.new(options) end

return nginx
