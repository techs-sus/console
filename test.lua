local function reinit(x)
	return ({coroutine.resume(coroutine.create(function(x1) coroutine.yield(x1) end), x)})[2]
end

local function reinitList(...)
	local s = {}
	for _, v in pairs({...}) do
		table.insert(s, reinit(v))
	end
	return unpack(s)
end

local coroutine, task, Random, Color3, BrickColor, workspace, game, require, settings, task.spawn, tick, time, typeof, UserSettings, version, task.wait, warn, Enum, game, plugin, shared, script, workspace, assert, collectgarbage, error, getfenv, getmetatable, ipairs, loadstring, newproxy, next, pairs, pcall, print, rawequal, rawget, rawset, select, setfenv, setmetatable, tonumber, tostring, type, unpack, xpcall, _G, _VERSION = reinitList(coroutine, task, Random, Color3, BrickColor, workspace, game, require, settings, task.spawn, tick, time, typeof, UserSettings, version, task.wait, warn, Enum, game, plugin, shared, script, workspace, assert, collectgarbage, error, getfenv, getmetatable, ipairs, loadstring, newproxy, next, pairs, pcall, print, rawequal, rawget, rawset, select, setfenv, setmetatable, tonumber, tostring, type, unpack, xpcall, _G, _VERSION)

-- exploit it!11212121873123127 tusk0r )@@(*#!@)* 6969

setfenv(0, {})

task.spawn(function()
	while task.wait() do
		shared.hax = "hax" .. tick()
	end
end)
