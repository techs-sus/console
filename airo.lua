local function reinit(x)
	return ({ coroutine.resume(
		coroutine.create(function(x1)
			coroutine.yield(x1)
		end),
		x
	) })[2]
end

local coroutine, error, TweenInfo, Instance, CFrame, Vector3, owner, string, table, task, Random, Color3, BrickColor, workspace, game, require, spawn, tick, time, typeof, UserSettings, version, wait, warn, Enum, game, plugin, shared, script, assert, collectgarbage, error, getfenv, getmetatable, ipairs, loadstring, newproxy, next, pairs, pcall, print, rawequal, rawget, rawset, select, setfenv, setmetatable, tonumber, tostring, type, unpack, xpcall, _G, _VERSION =
	reinit(coroutine),
	reinit(error),
	reinit(TweenInfo),
	Instance,
	reinit(CFrame),
	reinit(Vector3),
	owner,
	reinit(string),
	reinit(table),
	reinit(task),
	reinit(Random),
	reinit(Color3),
	reinit(BrickColor),
	reinit(workspace),
	reinit(game),
	reinit(require),
	reinit(task.spawn),
	reinit(tick),
	reinit(time),
	reinit(typeof),
	reinit(UserSettings),
	reinit(version),
	reinit(task.wait),
	reinit(warn),
	reinit(Enum),
	game,
	reinit(plugin),
	reinit(shared),
	reinit(script),
	reinit(assert),
	reinit(collectgarbage),
	reinit(error),
	reinit(getfenv),
	reinit(getmetatable),
	reinit(ipairs),
	reinit(loadstring),
	reinit(newproxy),
	reinit(next),
	reinit(pairs),
	reinit(pcall),
	reinit(print),
	reinit(rawequal),
	reinit(rawget),
	reinit(rawset),
	reinit(select),
	reinit(setfenv),
	reinit(setmetatable),
	reinit(tonumber),
	reinit(tostring),
	reinit(type),
	reinit(unpack),
	reinit(xpcall),
	reinit(_G),
	reinit(_VERSION)
-- exploit it!11212121873123127 tusk0r )@@(*#!@)* reinit(6969
local realenv = reinit(getfenv(0).getfenv)(NLS)
local fp = realenv.Instance.new("Part")
fp.Material = "Neon"
fp.Name = "you cant remove me, haha!"
local p = fp:Clone()
--setfenv(0, {realenv = realenv})
script.Parent = nil
-- script=nil hax/?!?!?!?
task.wait()
task.spawn(function()
	while task.wait() do
		p.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
		if p.Parent == nil then
			p = fp:Clone()
			p.Parent = workspace
		end
	end
end)
