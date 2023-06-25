---@meta

--[[
# SQL appender

The SQL appender can be used to write log messages to a SQL database table. It
uses [LuaSQL](https://keplerproject.github.io/luasql/), therefore any database
supported by LuaSQL can be used.

```lua
function logging.sql {
  connectionfactory = function,
  [tablename = string,]
  [logdatefield = string,]
  [loglevelfield = string,]
  [logmessagefield = string,]
  [keepalive = boolean,]

  [logLevel = log-level-constant,]
}
```

Example:

```lua
require("logging.sql")
require("luasql.jdbc")

local env, err = luasql.jdbc('com.mysql.jdbc.Driver')

local logger = logging.sql {
  connectionfactory = function()
    local con, err = env:connect('jdbc:mysql://localhost/test',
                                 'tcp', '123')
    assert(con, err)
    return con
  end,
  keepalive = true,
}

logger:info("logging.sql test")
logger:debug("debugging...")
logger:error("error!")
```
]]
---@class logging.sql
---@overload fun(options: logging.sql.options): logging.logger
local sql = {}

---TODO: Add a type for a LuaSQL connection

---@class logging.sql.options
---This must be a function that creates a LuaSQL connection object. This
---function will be called everytime a connection needs to be created.
---@field connectionfactory fun(): any
---The name of the table to write the log requests. Default value is
---`"LogTable"`.
---@field tablename? string
---The name of the field to write the date of each log request. Default value
---is `"LogDate"`.
---@field logdatefield? string
---The name of the field to write the level of each log request. Default value
---is `"LogLevel"`.
---@field loglevelfield? string
---The name of the field to write the message of each log request. Default
---value is `"LogMessage"`.
---@field logmessagefield? string
---In every log request a connection to the database is opened, the message is
---written, and the connection is closed.
---
---If the user wants to keep the connection opened he can specify
---`keepalive = true`.
---@field keepalive? boolean
---The initial log-level to set for the created logger.
---@field logLevel logging.loglevel

---@param options logging.sql.options
---@return logging.logger
function sql.new(options) end

return sql
