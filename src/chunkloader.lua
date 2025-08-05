--[[
    ChunkLoader - Package Manager for ComputerCraft
    File: chunkloader.lua
    Description: tbd
    Author: atom-p-dev
    License: GNU General Public License V
]]

local args = { ... }

-- PROJECT URL INFO
local DOMAIN = "https://raw.githubusercontent.com"
local DEV_USERNAME = ""
local PROGRAM = ""

-- LOCAL COMPUTER INFO
local PROGRAM_PATH = "hdd/rom/programs"

if #args ~= 2 then
    local programName = arg[0] or fs.getName(shell.getRunningProgram())
    print("Usage: " .. programName .. " <dev> <program>")
end

DEV_USERNAME = args[0]
PROGRAM = args[1]

function getFile(url) 
    local response = http.get(url)
    if response then
        local content = response.readAll()
        response.close()
    else
        error("Download failed")
    end

    return content
end

local programFile = getFile(DOMAIN .. "/" .. DEV_USERNAME .. "/" .. PROGRAM)