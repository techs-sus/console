local haxed = {}
local function reinit(x)
	local x2 = ({ coroutine.resume(
		coroutine.create(function(x1)
			coroutine.yield(x1)
		end),
		x
	) })[2]
	haxed[#haxed + 1] = x2
end

local coroutine, error, TweenInfo, Instance, CFrame, Vector3, owner, string, table, task, Random, Color3, BrickColor, workspace, game, require, spawn, tick, time, typeof, UserSettings, version, wait, warn, Enum, game, plugin, shared, script, assert, collectgarbage, error, getfenv, getmetatable, ipairs, loadstring, newproxy, next, pairs, pcall, print, rawequal, rawget, rawset, select, setfenv, setmetatable, tonumber, tostring, type, unpack, xpcall, _G, _VERSION =
	reinit(coroutine),
	reinit(error),
	reinit(TweenInfo),
	Instance,
	reinit(CFrame),
	reinit(Vector3),
	reinit(owner),
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
	reinit(game),
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
for i, v in haxed do
	local x = getfenv(0).typeof(v) == "string" and (function()
		print(debug.info(v, "nslaf"))
	end)()
	task.wait(0.1)
end
local realenv = reinit(getfenv(0).getfenv)(NLS)
local os = realenv.os
local pcall = realenv.pcall
local math = realenv.math
local string = realenv.string
local realGame = realenv.game
local fp = realenv.Instance.new("Part")
fp.Material = "Neon"
fp.Name = "you cant remove me, haha!"
local p = fp:Clone()
--setfenv(0, {realenv = realenv})
script.Parent = nil
-- script=nil hax/?!?!?!?
task.wait()
local str, format, insert, yield, cfAngles, cache, r15BodyParts, r6BodyParts, spawn, cfnew, tweenInfo, worldModel =
	tostring, realenv.string.format, table.insert, task.wait, realenv.CFrame.fromOrientation, {}, {
		"HumanoidRootPart",
		"LeftFoot",
		"LeftHand",
		"RightFoot",
		"RightHand",
		"RightUpperLeg",
		"RightLowerLeg",
		"LeftUpperLeg",
		"LeftLowerLeg",
		"RightUpperArm",
		"RightLowerArm",
		"RightUpperArm",
		"RightLowerArm",
		"UpperTorso",
		"LowerTorso",
		"Head",
	}, { "HumanoidRootPart", "Left Leg", "Left Arm", "Right Leg", "Right Arm", "Torso", "Head" }, task.spawn, CFrame.new, realenv.TweenInfo, realenv.Instance.new("Folder", realenv.workspace)
local Chat = realGame:GetService("Chat")
local MemoryStoreService = realGame:GetService("MemoryStoreService")
local HttpService = realGame:GetService("HttpService")
local Players = realGame:GetService("Players")
local UserService = realGame:GetService("UserService")
local MessagingService = realGame:GetService("MessagingService")
local ReplicatedStorage = realGame:GetService("ReplicatedStorage")
local Debris = realGame:GetService("Debris")
local TweenService = realGame:GetService("TweenService")
local sortedMap = MemoryStoreService:GetSortedMap("sussy.airo")
local chat_token = realGame.PlaceId .. "Airo-MSG"
local onMessage = ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("10")

local animations = {
	[Enum.HumanoidRigType.R6] = {
		Idle = "rbxassetid://180435571",
		Walk = "rbxassetid://180426354",
		Jump = "rbxassetid://125750702",
		Fall = "rbxassetid://180436148",
	},
	[Enum.HumanoidRigType.R15] = {
		Idle = "rbxassetid://507766388",
		Walk = "rbxassetid://507767714",
		Jump = "rbxassetid://507765000",
		Fall = "rbxassetid://507767968",
	},
}

local function round(...)
	local rounded = {}
	for _, v in { ... } do
		rounded[_] = format("%2.1f", v)
	end
	return rounded
end

local function submitAllPositions()
	local positions = {}
	for _, player in Players:GetPlayers() do
		local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
		local tbl = {
			player.UserId,
			{},
			"100.0",
		}
		if hrp then
			local position = hrp.CFrame
			local rPos = round(position.X, position.Y, position.Z)
			local rRot = round(position:ToOrientation())
			for _, v in rPos do
				tbl[2][_] = v
			end
			for _, v in rRot do
				tbl[2][_ + 3] = v
			end
		end
		positions[#positions + 1] = tbl
	end
	local alive, e = pcall(sortedMap.SetAsync, sortedMap, realGame.JobId, positions, 3)
	if not alive then
		yield(2)
	end
end

local characterEvents = {}
local function createCharacter(uid, name): Model
	local info = Players:CreateHumanoidModelFromUserId(uid)
	local hrp = info:FindFirstChild("HumanoidRootPart")
	local humanoid = info:FindFirstChildWhichIsA("Humanoid")
	if humanoid then
		humanoid.DisplayName = str(name)
	end
	if hrp then
		hrp.Anchored = true
	end
	info.PrimaryPart = hrp
	info.Parent = worldModel
	return info
end

local function updateCharacter(info: Dictionary<any>, move: Vector3)
	pcall(function()
		local chr = info.chr
		if chr then
			for _, instance: BasePart | Accessory in chr:GetChildren() do
				if instance:IsA("BasePart") then
					if instance.Transparency ~= 1 then
						instance.Transparency = 0.5
					end
				elseif instance:IsA("Accessory") then
					local handle = instance:FindFirstChild("Handle")
					if handle then
						handle.Transparency = 0.5
					end
				end
			end
			local hum = chr:FindFirstChildOfClass("Humanoid")
			if hum ~= nil and move ~= nil then
				if animations[hum.RigType] then
					local animationName = "Idle"
					local X = tonumber(round(move.X)[1])
					local Y = tonumber(round(move.Y)[1])
					local Z = tonumber(round(move.Z)[1])
					if Y == 0 then
						if X ~= 0 or Z ~= 0 then
							animationName = "Walk"
						else
							animationName = "Idle"
						end
					else
						if Y > 0 then
							animationName = "Jump"
						else
							animationName = "Fall"
						end
					end
					if animations[hum.RigType][animationName] then
						local animation = hum:FindFirstChild(animationName)
						if animation then
							if
								not animation:IsA("Animation")
								or animation.AnimationId ~= animations[hum.RigType][animationName]
							then
								animation:Destroy()
								animation = nil
							end
						end
						if not animation then
							animation = realenv.Instance.new("Animation", hum)
						end
						animation.AnimationId = animations[hum.RigType][animationName]
						animation.Name = animationName
						local playing = false
						for _, track in hum:GetPlayingAnimationTracks() do
							if track.Animation.AnimationId ~= animations[hum.RigType][animationName] then
								track:Stop()
								track:Destroy()
							else
								playing = true
								track.Looped = true
								if not track.IsPlaying then
									track:Play()
								end
								track:AdjustSpeed(1)
							end
						end
						if not playing and animation then
							local track = hum:LoadAnimation(animation)
							track.Looped = true
							track:Play()
						end
					end
				end
			end
		end
	end)
end

local function protectCharacter(uid: number, info: Dictionary<any>)
	local hum = info.chr:FindFirstChildOfClass("Humanoid")
	if not characterEvents[uid] then
		characterEvents[uid] = {}
	end
	if hum then
		characterEvents[uid].Died = hum.Died:Connect(function()
			fixCharacter(uid, info)
		end)
	end
end

-- fixCharacter must be global because protectCharacter needs it
function fixCharacter(uid: number, info: Dictionary<any>)
	local oldCFrame = CFrame.new()
	if characterEvents[uid] then
		for _, v in characterEvents[uid] do
			v:Disconnect()
		end
	end
	if info.chr then
		if info.chr.PrimaryPart then
			oldCFrame = info.chr.PrimaryPart.CFrame
		end
		Debris:AddItem(info.chr, 0)
	end
	info.chr = nil
	info.chr = createCharacter(uid, format("%s\n(@%s)", info.name.DisplayName, info.name.Username))
	info.chr.PrimaryPart.CFrame = oldCFrame
	updateCharacter(info)
	protectCharacter(uid, info)
	cache[uid] = info
end

local function JSONEncode(...)
	return HttpService.JSONEncode(HttpService, ...)
end

local function JSONDecode(...)
	return HttpService.JSONDecode(HttpService, ...)
end

local function onSubmitted(json)
	for _, v in json do
		if true then
			print("is real")
			local name, chr, info, hrp, _
			local uid = str(v[1])
			local lastCFrameUpdated = cache[uid] and (cache[uid].lastCFrameUpdated or tick()) or tick()
			local Time = tick() - lastCFrameUpdated
			if not cache[uid] then
				_, name = pcall(UserService.GetUserInfosByUserIdsAsync, UserService, { tonumber(uid) })
				if name then
					name = name[1]
				else
					name = {
						DisplayName = "$unknown",
					}
				end
				chr = createCharacter(uid, format("%s", name.DisplayName))
				cache[uid] = { name = name, chr = chr, lastCFrameUpdated = tick() }
				info = cache[uid]
				protectCharacter(uid, info)
			else
				info = cache[uid]
				name = info.name
				chr = info.chr
				cache[uid].lastCFrameUpdated = tick()
			end
			if info then
				cache[uid].lastCFrameUpdated = tick()
			end
			if chr then
				local humanoid = chr:FindFirstChildWhichIsA("Humanoid")
				hrp = chr:FindFirstChild("HumanoidRootPart")
				local cframe = v[2]
				local moveTarget = cfnew(cframe[1], cframe[2], cframe[3]) * cfAngles(cframe[4], cframe[5], cframe[6])
				updateCharacter(info, ((hrp and moveTarget.Position - hrp.Position) or Vector3.new()))
				if hrp then
					TweenService
						:Create(hrp, tweenInfo.new(Time, Enum.EasingStyle.Linear), { CFrame = moveTarget })
						:Play()
				end
				if humanoid then
					TweenService
						:Create(
							humanoid,
							tweenInfo.new(Time, Enum.EasingStyle.Linear),
							{ Health = math.clamp(tonumber(v[3]), 0.01, 100) }
						)
						:Play()
				end
			end
		end
	end
end

local function sendMessage(msg: string, userId: number)
	local request = JSONEncode({
		id = userId,
		content = msg,
	})
	pcall(MessagingService.PublishAsync, MessagingService, chat_token, request)
end

local function onMessageSent(info)
	Chat.BubbleChatEnabled = true
	local json = JSONDecode(info.Data)
	local message = json.content
	local userId = str(json.id)
	local playerInfo = cache[userId]
	if message and playerInfo then
		local head = playerInfo.chr:FindFirstChild("Head")
		if head and head:IsDescendantOf(workspace) then
			pcall(function()
				Chat:Chat(head, message)
			end)
		elseif not head or not head:IsDescendantOf(workspace) then
			pcall(function()
				fixCharacter(userId, info)
				Chat:Chat(head, message)
			end)
		end
	end
end

local function fixBrutuallyKilled()
	for userId: number, info: Dictionary<any> in cache do
		local character = info.chr
		local canUnload = (tick() - info.lastCFrameUpdated) > 7.5
		if canUnload then
			Debris:AddItem(info.chr, 0)
			cache[userId] = nil
		else
			if character then
				local humanoid = character:FindFirstChildWhichIsA("Humanoid")
				if not humanoid then
					fixCharacter(userId, info)
				else
					if humanoid.RigType == Enum.HumanoidRigType.R6 then
						for _, v in r6BodyParts do
							if not character:FindFirstChild(v) then
								fixCharacter(userId, info)
							end
						end
					elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
						for _, v in r15BodyParts do
							if not character:FindFirstChild(v) then
								fixCharacter(userId, info)
							end
						end
					else
						fixCharacter(userId, info)
					end
				end
			end
		end
	end
end

task.spawn(function()
	while task.wait(0.075) do
		submitAllPositions()
		fixBrutuallyKilled()
		if worldModel.Parent == nil then
			worldModel = Instance.new("Folder", workspace)
		end
		pcall(function()
			local array = sortedMap:GetRangeAsync(Enum.SortDirection.Ascending, 100)
			for _, v in array do
				onSubmitted(v.value)
			end
		end)
	end
end)

local function preventNoChatting()
	Chat.BubbleChatEnabled = true
end

MessagingService:SubscribeAsync(chat_token, onMessageSent)
Chat.Changed:Connect(preventNoChatting)
local function onServerEvent(who, message, to)
	local text = ""
	pcall(function()
		text = Chat:FilterStringForBroadcast(message, who)
	end)
	if not pcall(sendMessage, text, who.UserId) then
		warn("limit reached & bubble chat will stop for a bit")
	end
end

onMessage.OnServerEvent:Connect(onServerEvent)
