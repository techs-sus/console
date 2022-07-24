-- Compiled with roblox-ts v1.3.3
-- Made by tech
local part = Instance.new("SpawnLocation")
local gui = Instance.new("SurfaceGui")
local frame = Instance.new("ScrollingFrame")
local list = Instance.new("UIListLayout")
local worldModel = Instance.new("WorldModel")
local remote = Instance.new("RemoteEvent", owner:FindFirstChildOfClass("PlayerGui"))
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local insults = { "you really suck", "i can't believe you failed one of the simplest tasks", "even dino knows how to do this better", "god you really need some sleeping pills that last forever", "your oxygen should be transferred to someone else who needs it more", "how stupid are you to forget that coroutines existed", "god you are so useless i cant believe your parents didn't leave you", "i thought trash belonged outside, not in void", "even tusk knows how to write better sandboxes than you", "rookie experience ~= good scripter", "don't even try getting scripter role; the tables don't want you", "gosh i thought i was a loser now, then i remembered you exist", "comradio3 was better than all of the trash you made", "you still use wait() in 2022, how useless can people like you get", "im literally gonna turn you into a metatable", "get ready to be obfuscated, no one wants the original you", "microsoft doesn't approve of your actions", "god why am i wasting time roasting you, i should roast someone more useful", "the grass moves away from you, and it literally disappears when you touch it", "obesity is an epidemic for a reason", "don't try and install linux, grub wont mkconfig", "openrc doesn't approve of your iq levels", "you thought that compiling lua was legal", "you thought that luau was built in lua" }
gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
gui.PixelsPerStud = 125
gui.Face = Enum.NormalId.Back
gui.Adornee = part
frame.AutomaticCanvasSize = Enum.AutomaticSize.XY
frame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
frame.CanvasSize = UDim2.fromScale(0, 0)
frame.BorderSizePixel = 0
frame.ScrollBarImageTransparency = 1
frame.Size = UDim2.fromScale(1, 1)
list.FillDirection = Enum.FillDirection.Vertical
list.HorizontalAlignment = Enum.HorizontalAlignment.Left
list.VerticalAlignment = Enum.VerticalAlignment.Top
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent = frame
frame.Parent = gui
part.Enabled = false
part.Locked = true
part.CanTouch = false
part.CanCollide = false
part.CanQuery = false
part.Material = Enum.Material.Glass
part.Color = Color3.new(0, 1, 1)
part.Anchored = true
part.Size = Vector3.new(12, 8, 0.01)
part.Position = Vector3.new(0, 10, 0)
part.Transparency = 0.5
gui.Parent = script
part.Parent = worldModel
worldModel.Parent = script
local boxes = {}
local scroll = function()
	local tween = TweenService:Create(frame, TweenInfo.new(0.25), {
		CanvasPosition = Vector2.new(0, list.AbsoluteContentSize.Y - 125),
	})
	tween:Play()
end
local createText = function(text, noPush)
	local box = Instance.new("TextBox")
	box.Text = text
	box.BackgroundTransparency = 1
	box.TextColor3 = Color3.new(1, 1, 1)
	box.RichText = true
	box.Font = Enum.Font.Code
	box.BorderSizePixel = 0
	box.AutomaticSize = Enum.AutomaticSize.XY
	box.TextSize = 35
	box.TextWrapped = true
	box.LayoutOrder = 9
	box.TextXAlignment = Enum.TextXAlignment.Left
	box.TextYAlignment = Enum.TextYAlignment.Top
	box.Parent = frame
	local _condition = not noPush
	if _condition then
		local _arg0 = {
			created = os.clock(),
			box = box,
		}
		table.insert(boxes, _arg0)
		_condition = #boxes
	end
	if #boxes > 30 then
		local oldest
		local _arg0 = function(ins)
			if not oldest then
				oldest = ins
			elseif oldest.created > ins.created then
				oldest = ins
			end
		end
		for _k, _v in ipairs(boxes) do
			_arg0(_v, _k - 1, boxes)
		end
		oldest.box:Destroy()
		local _oldest = oldest
		local _arg0_1 = (table.find(boxes, _oldest) or 0) - 1
		table.remove(boxes, _arg0_1 + 1)
	end
	scroll()
	return box
end
local commands = {}
local cursor = Instance.new("Frame")
local prompt = createText("", true)
prompt.LayoutOrder = 100
cursor.BorderSizePixel = 0
local _exp = UDim2.fromScale(0, 1)
local _arg0 = UDim2.fromOffset(20, 0)
cursor.Size = _exp + _arg0
cursor.BackgroundColor3 = Color3.new(1, 1, 1)
cursor.Position = UDim2.fromScale(1, 0)
cursor.Parent = prompt
-- blinking cursor loop
task.spawn(function()
	while true do
		if cursor.BackgroundColor3 == Color3.new(1, 1, 1) then
			cursor.BackgroundColor3 = frame.BackgroundColor3
		else
			cursor.BackgroundColor3 = Color3.new(1, 1, 1)
		end
		task.wait(0.5)
	end
end)
local addCommand = function(command)
	table.insert(commands, command)
end
local providers = {}
local addProvider = function(provider, callback)
	providers[provider] = callback
end
local getProviderFromName = function(provider)
	return providers[provider]
end
addProvider("Player", function(s)
	local _exp_1 = Players:GetPlayers()
	local _arg0_1 = function(v)
		local name = string.lower(v.Name)
		return string.sub(name, 1, #s) == string.lower(s)
	end
	-- ▼ ReadonlyArray.find ▼
	local _result
	for _i, _v in ipairs(_exp_1) do
		if _arg0_1(_v, _i - 1, _exp_1) == true then
			_result = _v
			break
		end
	end
	-- ▲ ReadonlyArray.find ▲
	return _result
end)
addProvider("Players", function(s)
	repeat
		if s == "all" then
			return Players:GetPlayers()
		end
		if s == "friends" then
			local _exp_1 = Players:GetPlayers()
			local _arg0_1 = function(v)
				return v:IsFriendsWith(owner.UserId)
			end
			-- ▼ ReadonlyArray.filter ▼
			local _newValue = {}
			local _length = 0
			for _k, _v in ipairs(_exp_1) do
				if _arg0_1(_v, _k - 1, _exp_1) == true then
					_length += 1
					_newValue[_length] = _v
				end
			end
			-- ▲ ReadonlyArray.filter ▲
			return _newValue
		end
		if s == "others" then
			local _exp_1 = Players:GetPlayers()
			local _arg0_1 = function(v)
				return v ~= owner
			end
			-- ▼ ReadonlyArray.filter ▼
			local _newValue = {}
			local _length = 0
			for _k, _v in ipairs(_exp_1) do
				if _arg0_1(_v, _k - 1, _exp_1) == true then
					_length += 1
					_newValue[_length] = _v
				end
			end
			-- ▲ ReadonlyArray.filter ▲
			return _newValue
		end
		if s == "random" then
			local players = Players:GetPlayers()
			return { players[math.random(1, #players) + 1] }
		end
		if s == "me" then
			return { owner }
		end
		if { string.find(s, ",") } then
			local split = string.split(s, ",")
			local constructed = {}
			local players = Players:GetPlayers()
			local _arg0_1 = function(v2)
				local _arg0_2 = function(v)
					local name = string.lower(v.Name)
					return string.sub(name, 1, #s) == string.lower(v2)
				end
				-- ▼ ReadonlyArray.find ▼
				local _result
				for _i, _v in ipairs(players) do
					if _arg0_2(_v, _i - 1, players) == true then
						_result = _v
						break
					end
				end
				-- ▲ ReadonlyArray.find ▲
				local player = _result
				if player then
					table.insert(constructed, player)
				end
			end
			for _k, _v in ipairs(split) do
				_arg0_1(_v, _k - 1, split)
			end
			return constructed
		end
		break
	until true
end)
addProvider("Raw", function(s)
	return s
end)
local executeCommand = function(name, args)
	local command
	for _, cmd in ipairs(commands) do
		if cmd.name == name then
			command = cmd
			break
		elseif (table.find(cmd.aliases, name) or 0) - 1 ~= -1 then
			command = cmd
			break
		end
	end
	if not command then
		return 'Failed finding command "' .. (name .. '"!')
	end
	local coro = coroutine.create(command.func)
	local constructed = {}
	local _arg0_1 = function(arg, index)
		local provider = getProviderFromName(command.arguments[index + 1])
		local insult = insults[math.random(1, #insults) + 1]
		if provider then
			local result = provider(arg, args)
			if not (result ~= "" and result) then
				return createText('[pre-runtime] <font color="#AAAAAA">' .. (insult .. " - Literally everybody</font>\nDid you type the command correctly?"), false)
			end
			local _constructed = constructed
			local _result = result
			table.insert(_constructed, _result)
			return #_constructed
		else
			return createText('[pre-runtime] <font color="#AAAAAA">' .. (insult .. " - Literally everybody</font>\nDid you forget to pass in an argument?"), false)
		end
	end
	for _k, _v in ipairs(args) do
		_arg0_1(_v, _k - 1, args)
	end
	coroutine.resume(coro, unpack(constructed))
	return command
end
local filterRichText = function(text)
	return (string.gsub((string.gsub((string.gsub((string.gsub((string.gsub(text, "&", "&amp;")), "'", "&apos;")), '"', "&quot;")), "<", "&lt;")), ">", "&gt;"))
end
local getPromptText = function(input)
	local split = string.split(input, " ")
	local commandName = table.remove(split, 1)
	local _condition = commandName
	if _condition ~= "" and _condition then
		local _arg0_1 = function(v)
			return v.name == commandName or (table.find(v.aliases, commandName) or 0) - 1 ~= -1
		end
		-- ▼ ReadonlyArray.filter ▼
		local _newValue = {}
		local _length = 0
		for _k, _v in ipairs(commands) do
			if _arg0_1(_v, _k - 1, commands) == true then
				_length += 1
				_newValue[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		_condition = _newValue[1]
	end
	local command = _condition
	local _condition_1 = commandName
	if _condition_1 ~= "" and _condition_1 then
		local _condition_2 = command
		if _condition_2 ~= "" and _condition_2 then
			_condition_2 = typeof(command) == "table" and "#FFBB00"
		end
		local _condition_3 = _condition_2
		if not (_condition_3 ~= "" and _condition_3) then
			_condition_3 = "#FF0000"
		end
		_condition_1 = "<font color='" .. (_condition_3 .. ("'>" .. (filterRichText(commandName) .. "</font>")))
	end
	local _condition_2 = (#split > 0 and " " .. table.concat(split, " "))
	if not (_condition_2 ~= "" and _condition_2) then
		_condition_2 = ""
	end
	return '<font color="#00AAFF">[tech@vsb ~]$ </font>' .. (tostring(_condition_1) .. filterRichText(_condition_2))
end
local runCommand = function(message)
	local split = string.split(message, " ")
	if #split <= 0 then
		return nil
	end
	local commandName = table.remove(split, 1)
	createText(getPromptText(message), false)
	if commandName == "" then
		return nil
	end
	local cmd = executeCommand(commandName, split)
	local _condition = cmd
	if _condition ~= "" and _condition then
		local _cmd = cmd
		_condition = typeof(_cmd) == "string"
	end
	if _condition ~= "" and _condition then
		createText("<font color='#FF0000'>Error: " .. (filterRichText(cmd) .. "</font>"), false)
	end
end
-- create ui on the server (executing code on the client is slow)
-- the only issue would be if the player's internet is slow, but if they are playing roblox
-- ... they have enough internet speed
prompt.Text = getPromptText("")
local screenGui = Instance.new("ScreenGui")
local textbox = Instance.new("TextBox")
local corner = Instance.new("UICorner")
textbox.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
textbox.BorderSizePixel = 0
textbox.Position = UDim2.fromScale(0.025, 0.9)
textbox.Size = UDim2.fromScale(0.95, 0.05)
textbox.Font = Enum.Font.Code
textbox.TextScaled = true
textbox.TextXAlignment = Enum.TextXAlignment.Left
textbox.TextYAlignment = Enum.TextYAlignment.Top
textbox.TextColor3 = Color3.new(1, 1, 1)
textbox.Text = ""
textbox.Visible = false
textbox.ClearTextOnFocus = false
corner.CornerRadius = UDim.new(0.025, 0)
corner.Parent = textbox
textbox.Parent = screenGui
screenGui.Parent = remote
remote.OnServerEvent:Connect(function(player, requestType, text)
	if owner ~= player then
		return nil
	end
	if not (type(requestType) == "string") then
		return nil
	end
	if not (type(text) == "string") then
		return nil
	end
	repeat
		if requestType == "enter" then
			runCommand(text)
			break
		end
		if requestType == "typing" then
			prompt.Text = getPromptText(text)
			break
		end
		break
	until true
end)
local recursiveGet
recursiveGet = function(stuff, out)
	local matches = (string.match(stuff, 'TS.import%(script, script, (["%a%s, ]+)%)'))
	if not (matches ~= 0 and (matches == matches and (matches ~= "" and matches))) then
		return stuff
	end
	local _matches = matches
	if type(_matches) == "string" then
		local _exp_1 = string.split(matches, ",")
		local _arg0_1 = function(v)
			return string.match(v, "%a+")
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_exp_1)
		for _k, _v in ipairs(_exp_1) do
			_newValue[_k] = _arg0_1(_v, _k - 1, _exp_1)
		end
		-- ▲ ReadonlyArray.map ▲
		local split = _newValue
		if #split == 1 then
			-- its a local import
			local _fn = HttpService
			-- ▼ ReadonlyArray.join ▼
			local _result = table.create(#split)
			for _k, _v in ipairs(split) do
				_result[_k] = tostring(_v)
			end
			-- ▲ ReadonlyArray.join ▲
			local _arg1 = "(function() " .. (tostring((recursiveGet(_fn:GetAsync(out .. ("/" .. (table.concat(_result, "") .. ".lua")), true), out))) .. " end)()")
			stuff = (string.gsub(stuff, 'TS.import%(script, script, (["%a%s, ]+)%)', _arg1))
			return stuff
		else
			return stuff
		end
	end
end
local compileModule = function(github)
	-- github as in person/repo
	-- TS.import(script, script, "test").default
	local base = "https://raw.githubusercontent.com/" .. (github .. "/master")
	local out = base .. "/out"
	local init = out .. "/init.lua"
	local stuff = HttpService:GetAsync(init, true)
	local final = recursiveGet(stuff, out)
	local func = loadstring(final)
	if func then
		createText("Finished compiling " .. (github .. " (github repository)"), false)
		loadstring("local table = {...}; local v1 = table[2]; setfenv(table[1], setmetatable(v1, {__index = getfenv(0)}))")(func, {
			addCommand = addCommand,
			createText = createText,
			addProvider = addProvider,
			boxes = boxes,
			_G = {
				[script] = {},
			},
		})
		local sizeBefore = #commands
		func()
		if #commands - sizeBefore <= 0 then
			return nil
		end
		createText("Module " .. (github .. " added new commands."), false)
		do
			local i = sizeBefore
			local _shouldIncrement = false
			while true do
				if _shouldIncrement then
					i += 1
				else
					_shouldIncrement = true
				end
				if not (i < #commands) then
					break
				end
				local command = commands[i + 1]
				createText("command " .. (command.name .. (", shorthands [" .. (table.concat(command.aliases, ",") .. ("] description: " .. (command.description .. ("\narguments: [" .. (table.concat(command.arguments, ", ") .. "]"))))))), false)
			end
		end
	end
end
addCommand({
	name = "clear",
	description = "Clear the screen",
	aliases = { "cls" },
	func = function()
		local _arg0_1 = function(v)
			return v.box:Destroy()
		end
		for _k, _v in ipairs(boxes) do
			_arg0_1(_v, _k - 1, boxes)
		end
		table.clear(boxes)
	end,
	arguments = {},
})
addCommand({
	name = "pkg",
	description = "Package manager",
	aliases = { "yay" },
	func = function(raw, raw2)
		if raw == "--compile" then
			createText("calling compileModule with raw2 (" .. raw2 .. ")", false)
			compileModule(raw2)
		end
		if raw == "--list" then
			createText("Listing all commands:", false)
			do
				local i = 0
				local _shouldIncrement = false
				while true do
					if _shouldIncrement then
						i += 1
					else
						_shouldIncrement = true
					end
					if not (i < #commands) then
						break
					end
					local command = commands[i + 1]
					createText(command.name .. (", aliases [" .. (table.concat(command.aliases, ",") .. ('] description: "' .. (command.description .. ('" args: [' .. (table.concat(command.arguments, ", ") .. "]")))))), false)
				end
			end
		end
	end,
	arguments = { "Raw", "Raw" },
})
local tpPart = function()
	local character = owner.Character
	if character and character:IsA("Model") then
		local hrp = character:FindFirstChild("HumanoidRootPart")
		if hrp then
			local _cFrame = hrp.CFrame
			local _cFrame_1 = CFrame.new(0, 3, -3)
			part.CFrame = _cFrame * _cFrame_1
		end
	end
end
addCommand({
	name = "bring_part",
	description = "Bring the console to you.",
	aliases = { "parttp" },
	func = tpPart,
	arguments = {},
})
local canMove = true
RunService.Stepped:Connect(function()
	if canMove then
		tpPart()
	end
end)
addCommand({
	name = "toggle_move",
	description = "Bring the console to you.",
	aliases = { "canMove" },
	func = function()
		canMove = not canMove
		return canMove
	end,
	arguments = {},
})
createText("Welcome to console v7! (typescript edition)", false)
createText("This console is licensed under the GNU GPL v3 license. (techs-sus/console)", false)
createText('You can compile modules with "pkg --compile {module}".', false)
createText("All modules are created in typescript. If you would like to create a module, please do the following:\n1. Create a new rbxts package\n2. Remove out from .gitignore\n3. Import the index.d.ts from console\n4. Publish on github\n5. Use your package with pkg --compile <your github username>/<your github repository>", false)
NLS([[
local remote = script.Parent
local gui = remote:FindFirstChildOfClass("ScreenGui")
local textbox = gui:FindFirstChildOfClass("TextBox")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local RenderStepped = RunService.RenderStepped
textbox.Visible = false
local function toggle()
  textbox.Visible = not textbox.Visible
  if textbox.Visible then
    textbox:CaptureFocus()
    textbox.Transparency = 1
    for i = 1, 10 do
      textbox.Transparency = (10 - i) / 10
      RenderStepped:Wait()
    end
  else
    textbox.Visible = true
    textbox.Transparency = 0
    for i = 1, 10 do
      textbox.Transparency = i / 10
      RenderStepped:Wait()
    end
    textbox.Visible = false
  end
end
textbox.FocusLost:Connect(function(enter)
  if enter then
    remote:FireServer("enter", textbox.Text)
    remote:FireServer("typing", "")
    textbox.Text = ""
    toggle()
  end
end)
textbox:GetPropertyChangedSignal("Text"):Connect(function()
  local text = textbox.Text
  remote:FireServer("typing", text)
end)
UserInputService.InputEnded:Connect(function(obj, gpe)
  if not gpe and obj.KeyCode == Enum.KeyCode.Semicolon then
   toggle()
  end
end)
print("[ts-client] Initialized!")
]], remote)
return {
	boxes = boxes,
	createText = createText,
	addCommand = addCommand,
	addProvider = addProvider,
	filterRichText = filterRichText,
}
