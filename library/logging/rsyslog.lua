---@meta

--[[
# Remote syslog appender

This appender can be used to send syslog formatted log requests to a remote
syslog server. This appender relies on
[LuaSocket](https://github.com/lunarmodules/luasocket) to do its job. 
Optionally [Copas](https://github.com/lunarmodules/copas) can be used for async
sending of log messages over TCP.

If you want to log to the local syslog daemon, then please use
[luasyslog](https://github.com/lunarmodules/luasyslog).

The LuaLogging log-levels will be mapped to the syslog levels by their name,
where `logging.FATAL` maps to syslog `ALERT`. Since LuaLogging only has 5
levels, the syslog levels `EMERG`, `CRIT`, and `NOTICE` remain unused.

```lua
function logging.rsyslog {
  hostname = string,
  [port = number,]
  [protocol = "udp" | "tcp",]
  [rfc = "rfc5424" | "rfc3164",]
  [maxsize = number,]
  [facility = facility-constant,]
  [ident = string,]
  [procid = string,]
  [msgid = string,]

  [logPattern = string,]
  [logPatterns = {
    [logging.DEBUG = string,]
    [logging.INFO  = string,]
    [logging.WARN  = string,]
    [logging.ERROR = string,]
    [logging.FATAL = string,]
  },]
  [logLevel = log-level-constant,]
}
```

Example:

```lua
local rsyslog = require("logging.rsyslog")

rsyslog.copas() -- switch to using non-blocking Copas sockets

local logger = rsyslog {
  hostname = "syslog.mycompany.com",
  port = 514,
  protocol = "tcp",
  rfc = "rfc5424",
  maxsize = 8000,
  facility = rsyslog.FACILITY_LOCAL2,
  ident = "my_lua_app",
  procid = "socket_mod",
  logPattern = "%message %source",
}

copas.loop(function()
  logger:info("logging.rsyslog test")
  logger:debug("debugging...")
  logger:error("error!")

  -- destroy to ensure threads are shutdown (only for Copas)
  logger:destroy()
end)
```
]]
---@class logging.rsyslog
---@field FACILITY_KERN logging.rsyslog.facility
---@field FACILITY_USER logging.rsyslog.facility
---@field FACILITY_MAIL logging.rsyslog.facility
---@field FACILITY_DAEMON logging.rsyslog.facility
---@field FACILITY_AUTH logging.rsyslog.facility
---@field FACILITY_SYSLOG logging.rsyslog.facility
---@field FACILITY_LPR logging.rsyslog.facility
---@field FACILITY_NEWS logging.rsyslog.facility
---@field FACILITY_UUCP logging.rsyslog.facility
---@field FACILITY_CRON logging.rsyslog.facility
---@field FACILITY_AUTHPRIV logging.rsyslog.facility
---@field FACILITY_FTP logging.rsyslog.facility
---@field FACILITY_NTP logging.rsyslog.facility
---@field FACILITY_SECURITY logging.rsyslog.facility
---@field FACILITY_CONSOLE logging.rsyslog.facility
---@field FACILITY_NETINFO logging.rsyslog.facility
---@field FACILITY_REMOTEAUTH logging.rsyslog.facility
---@field FACILITY_INSTALL logging.rsyslog.facility
---@field FACILITY_RAS logging.rsyslog.facility
---@field FACILITY_LOCAL0 logging.rsyslog.facility
---@field FACILITY_LOCAL1 logging.rsyslog.facility
---@field FACILITY_LOCAL2 logging.rsyslog.facility
---@field FACILITY_LOCAL3 logging.rsyslog.facility
---@field FACILITY_LOCAL4 logging.rsyslog.facility
---@field FACILITY_LOCAL5 logging.rsyslog.facility
---@field FACILITY_LOCAL6 logging.rsyslog.facility
---@field FACILITY_LOCAL7 logging.rsyslog.facility
---@overload fun(options: logging.rsyslog.options): logging.logger
local rsyslog = {}

---@class logging.rsyslog.options
---Hostname can be an IP address or a host name of the server where the log
---message will be sent.
---@field hostname string
---The port must be an integer number in the range [1..64K). The default is
---`514`.
---@field port? integer
---The network protocol to use, either `"udp"` or `"tcp"`. The default is `"tcp"`.
---
---Note: TCP sending is a blocking operation. For non-blocking use
---[Copas](https://github.com/lunarmodules/copas) is supported, see `rsyslog`
---example.
---@field protocol? "udp" | "tcp"
---The message format. 2 options:
---* for the old BSD style use `"rfc3164"` (the default)
---* for the IETF standard use `"rfc5424"`.
---@field rfc? "rfc5424" | "rfc3164"
---The maximum message size. Longer messages will be truncated. The minimum
---value is 480. The defaults are `1024` for `"rfc3164"`, and `2048` for
---`"rfc5424"`.
---@field maxsize? integer
---The syslog facility to use, use one of the constants. The default value is
---the "user" facility.
---
---```lua
---rsyslog.FACILITY_KERN
---rsyslog.FACILITY_USER
---rsyslog.FACILITY_MAIL
---rsyslog.FACILITY_DAEMON
---rsyslog.FACILITY_AUTH
---rsyslog.FACILITY_SYSLOG
---rsyslog.FACILITY_LPR
---rsyslog.FACILITY_NEWS
---rsyslog.FACILITY_UUCP
---rsyslog.FACILITY_CRON
---rsyslog.FACILITY_AUTHPRIV
---rsyslog.FACILITY_FTP
---rsyslog.FACILITY_NTP
---rsyslog.FACILITY_SECURITY
---rsyslog.FACILITY_CONSOLE
---rsyslog.FACILITY_NETINFO
---rsyslog.FACILITY_REMOTEAUTH
---rsyslog.FACILITY_INSTALL
---rsyslog.FACILITY_RAS
---rsyslog.FACILITY_LOCAL0
---rsyslog.FACILITY_LOCAL1
---rsyslog.FACILITY_LOCAL2
---rsyslog.FACILITY_LOCAL3
---rsyslog.FACILITY_LOCAL4
---rsyslog.FACILITY_LOCAL5
---rsyslog.FACILITY_LOCAL6
---rsyslog.FACILITY_LOCAL7
---```
---@field facility? logging.rsyslog.facility
---The value for the APP-NAME field (rfc5424, called TAG field in rfc3164).
---Default value is `"lua"`.
---@field ident? string
---The process id value (only applicable for rfc5424 format). Default value is
---`"-"` (absent).
---@field procid? string
---The message id value (only applicable for rfc5424 format). Default value is
---`"-"` (absent).
---@field msgid? string
---This value will be used as the default value for each log-level that was
---omitted in `logPatterns`, this defaults to `"%message"`. The default pattern
---deviates from standard LuaLogging defaults since those do not make sense for
---syslog.
---@field logPattern? string
---A table with `logPattern` strings indexed by the log-levels. A `logPattern`
---specifies how the message is written.
---
---If this parameter is omitted, a patterns table will be created with the
---parameter `logPattern` as the default value for each log-level.
---@field logPatterns? { [logging.loglevel]: string }
---The initial log-level to set for the created logger.
---@field logLevel? logging.loglevel

---@class logging.rsyslog.facility

---@param options logging.rsyslog.options
---@return logging.logger
function rsyslog.new(options) end

return rsyslog
