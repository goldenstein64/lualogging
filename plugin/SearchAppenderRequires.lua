local SearchRequires = require("plugin.SearchRequires")
local appenderDiff = require("plugin.importAppenderDiff")

local appenders = {
	"console",
	"email",
	"file",
	"nginx",
	"rolling_file",
	"rsyslog",
	"socket",
	"sql",
}

---@class plugin.lualogging.SearchAppenderRequires : plugin.util.SearchRequires
local SearchAppenderRequires = setmetatable({}, SearchRequires)
SearchAppenderRequires.__index = SearchAppenderRequires

for _, appender in ipairs(appenders) do
	SearchAppenderRequires.diffMap["logging." .. appender] = {
		start = 1,
		finish = 0,
		text = appenderDiff:format(appender, appender),
	}
end

return SearchAppenderRequires
