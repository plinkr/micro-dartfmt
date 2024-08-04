VERSION = "0.1.0"
PLUGIN_NAME = "dartfmt"

local micro = import("micro")
local config = import("micro/config")
local shell = import("micro/shell")

local COMMAND_NAME = "dartfmt"
local LINTER_NAME = "dartfmt"

local function fullOptionName(name)
  return PLUGIN_NAME .. "." .. name
end

local ONSAVE_OPTION_NAME = "fmt"
local ONSAVE_OPTION = fullOptionName(ONSAVE_OPTION_NAME)
local LINTER_OPTION_NAME = "lint"
local LINTER_OPTION = fullOptionName(LINTER_OPTION_NAME)

-- Output example for `dart analyze --format=machine`:
-- ERROR|SYNTACTIC_ERROR|EXPECTED_TOKEN|/home/plinkr/git/dart_test/src/hello_world.dart|16|70|1|Expected to find ';'.
local ERROR_PATTERN = ".+|.+|.+|%f|%l|%c|.+|%m"

config.RegisterCommonOption(PLUGIN_NAME, ONSAVE_OPTION_NAME, true)
config.RegisterCommonOption(PLUGIN_NAME, LINTER_OPTION_NAME, true)

function init()
  config.MakeCommand(COMMAND_NAME, dartfmt, config.NoComplete)
  config.AddRuntimeFile(PLUGIN_NAME, config.RTHelp, "help/dartfmt.md")

  if linter then
    linter.makeLinter(LINTER_NAME, "dart", "dart", {"analyze", "--format=machine", "%f"}, ERROR_PATTERN, {}, false, false, 0, 0, function(buf)
      return buf.Settings[LINTER_OPTION]
    end)
  end
end

function onSave(bp)
  local shouldFmt = bp.Buf:FileType() == "dart" and bp.Buf.Settings[ONSAVE_OPTION]
  if shouldFmt then
    dartfmt(bp)
  end
  return true
end

function dartfmt(bp)
  bp:Save()
  local output, err = shell.ExecCommand("dart", "format", bp.Buf.Path)
  -- any failure here is a parse error, the linter will handle that
  if err then
  -- will send an error message if there is a problem formatting
    micro.InfoBar():Error(output:match("Could not format because the source could not be parsed:\n\n(line %d+, column %d+ of [^:]+: [^\n]+)"))
    return
  end
  -- no files were changed (`dart format` prints the name of changed files)
  if output == "" then
    return
  end
  -- the file was changed by `dart format`, so reload it
  bp.Buf:ReOpen()
  micro.InfoBar():Message("Formatted " .. bp.Buf.Path)
end