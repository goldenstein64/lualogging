# LuaLogging Definitions

Definition files for [lunarmodules/lualogging](https://github.com/lunarmodules/lualogging) 1.8.2 to use with [LuaLS/lua-language-server](https://github.com/LuaLS/lua-language-server). The annotations have been manually re-written directly from the [docs](https://lunarmodules.github.io/lualogging) and [source code](https://github.com/lunarmodules/lualogging) to be parsable by the LSP.

The library should be pretty much fully supported. There's not much weird stuff that's hard to emulate.

## Usage

For manual installation, add these settings to your `settings.json` file.

```json
// settings.json
{
  "Lua.workspace.library": [
    // path to wherever this repo was cloned to
    "path/to/this/repo"
  ],
  "Lua.runtime.plugin": "path/to/this/repo/plugin.lua"
}
```

The plugin is used to catch appender require calls and add them to the main module's definition, so that examples like this work fine.

```lua
require("logging.console")
local logging = require("logging")

local logger = logging.console()
```

However, there are ways to write your code that ignore this quirk, so the plugin isn't necessary unless you're working with the examples.

```lua
-- variant 1
local logging = require("logging") 
local console = require("logging.console")

local logger = console()

-- variant 2
local logging = require("logging")
logging.console = require("logging.console")

local logger = logging.console()
```