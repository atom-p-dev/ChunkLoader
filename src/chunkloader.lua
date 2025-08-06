--[[
    ChunkLoader - Package Manager for ComputerCraft
    File: chunkloader.lua
    Description: tbd
    Author: atom-p-dev
    License: GNU General Public License V
]]

-- Libraries
local pretty = require "cc.pretty"

local args = { ... }

-- PROJECT URL INFO
local DOMAIN = "https://raw.githubusercontent.com"
local DEV_USERNAME = ""
local PROGRAM = ""
local URL = ""

-- LOCAL COMPUTER INFO
local PROGRAM_PATH = "hdd/rom/chunks"

if #args ~= 2 then
    local programName = arg[0] or fs.getName(shell.getRunningProgram())
    print("Usage: " .. programName .. " <dev> <program>")
    return
end

DEV_USERNAME = args[1]
PROGRAM = args[2]

function getFile(url) 
    local response = http.get(url)
    local content
    if response then
        content = response.readAll()
        print("Response received\n")
        response.close()
    else
        error("Download failed\n")
    end

    return content
end

function installFile(file, path)
    local c_path = path
    while string.find(c_path, "/") do
        local p = string.sub(1, string.find(c_path, "/") - 1)
        if not fs.exists(p) then
            fs.makeDir(p)
        end
        c_path = string.sub(string.find(c_path, "/") + 1)
    end
    local file = fs.open(path, "w")
    file.write(file)
    file.clos()
end

-- URL for Manifest File
 URL = DOMAIN .. "/" .. DEV_USERNAME .. "/" .. PROGRAM .. "/main/package.json"

print("Checking URL " .. URL .. "\n")
local programJSON = getFile(URL)
local data = textutils.unserializeJSON(programJSON)

pretty.pretty_print(data["name"])
pretty.pretty_print(data["files"])

-- 
for file, info in pairs(data["files"]) do 
    print("Getting file: " .. info["source_url"])
    local programFile = getFile(info["source_url"])
    print("Installing file...")
    installFile(programFile, info["target_path"])
end