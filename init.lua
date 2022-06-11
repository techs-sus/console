-- TODO: add a display

local commandManager = {}
commandManager.commands = {}

type Callback<T> = (...any) -> T

type Exit = {
	exitCode: number,
	exitMessage: string,
}

type Command = {
	fn: Callback<Exit>,
	name: string,
	description: string,
	aliases: Array<string>,
	arguments: Dictionary<string>,
	moduleName: string?,
}

function commandManager:addCommand(
	-- unpack type command
	fn: Callback<Exit>,
	name: string,
	description: string,
	aliases: Array<string>,
	arguments: Dictionary<string>
)
	local command: Command = {
		commandFunction = fn,
		commandName = name,
		commandDescription = description,
		commandAliases = aliases,
		commandArguments = arguments,
	}
	self.commands[#self.commands + 1] = command
end

local function exit(code: number, message: string?)
	coroutine.yield({ exitCode = code, exitMessage = message or "ok!" })
end

type Argv = Array<string>

local providers = {
	luau = {},
	console = {
		command = function(commandName: string)
			for _, v in pairs(commandManager.commands) do
				if v.commandName == commandName then
					return v
				end
			end
			exit(1, "Failed finding command " .. commandName)
		end,
		argv = function(_, x: Argv)
			return x
		end,
		raw = function(x: string)
			return x
		end,
		string = {
			combined = function(_, argv: Argv, index: number)
				if not argv then
					exit(1, "argv is nil, try adding more arguments")
				end
				return table.concat(argv, " ", index)
			end,
		},
	},
}

local function getProvider(name: string): Callback<any>?
	local split = string.split(name, "::")
	-- we can use base providers table, as the start, as we are searching for a function
	local ptr = providers
	for _, v in ipairs(split) do
		ptr = ptr[v]
	end
	if ptr == nil then
		exit(1, "Failed finding provider " .. name)
	elseif ptr and typeof(ptr) == "table" then
		exit(1, "Provider string is not valid: " .. name)
	end
	return ptr
end

function commandManager:findCommand(commandName: string): Command?
	for _, v: Command in pairs(self.commands) do
		if v.commandName == commandName or table.find(v.aliases, commandName) then
			return v
		end
	end
	return nil
end

function commandManager:executeCommand(input: string)
	local split = string.split(input, " ")
	local commandName = split[1]
	local command = self:findCommand(commandName)
	if not command then
		exit(1, "Failed finding command " .. commandName)
	end
	local argv = {}
	local index = 2
	local cExit: Exit
	for _, arg in pairs(command.commandArguments) do
		local provider = getProvider(arg)
		local value = coroutine.wrap(provider)(split[index], split, index)
		if value and typeof(value) == "table" and value.exitCode then
			cExit = value
			break
		end
		table.insert(argv, value or nil)
		index += 1
	end
	local alive: boolean = true
	if not cExit then
		alive, cExit = coroutine.resume(coroutine.create(command.commandFunction), unpack(argv))
	end
	if cExit.exitCode > 0 then
		local errorType = alive and "pre-runtime" or "runtime"
		-- TODO: add error handler for user
	end
end

local part = Instance.new("SpawnLocation")
local gui = Instance.new("SurfaceGui")
local frame = Instance.new("ScrollingFrame")
local list = Instance.new("UIListLayout")
local worldModel = Instance.new("WorldModel")
gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
gui.PixelsPerStud = 150
gui.Adornee = part
gui.CanvasSize = Vector2.one * 256
frame.AutomaticCanvasSize = Enum.AutomaticSize.XY
frame.BackgroundColor3 = Color3.new(0.35, 0.35, 0.35)
frame.CanvasSize = UDim2.fromScale(0, 0)
frame.BorderSizePixel = 0
frame.Size = UDim2.fromScale(1, 1)
list.FillDirection = Enum.FillDirection.Vertical
list.HorizontalAlignment = Enum.HorizontalAlignment.Left
list.VerticalAlignment = Enum.VerticalAlignment.Top
list.Parent = frame
frame.Parent = gui
gui.Parent = script
part.Enabled = false
part.Locked = true
part.CanTouch = false
part.CanCollide = false
part.CanQuery = false
part.Material = Enum.Material.Glass
part.Color = Color3.new(0, 1, 1)
part.Anchored = true
part.Size = Vector3.new(16, 9, 0.01)
part.Transparency = 0.5
part.Parent = worldModel

local function insertText(text: string)
	for str in string.gmatch(text, "[%S \r]+") do
		local textBox = Instance.new("TextBox")
		textBox.Font = Enum.Font.Code
		textBox.TextSize = 40
		textBox.BackgroundTransparency = 1
		textBox.AutomaticSize = Enum.AutomaticSize.XY
		textBox.TextColor3 = Color3.new(1, 1, 1)
		textBox.TextXAlignment = Enum.TextXAlignment.Right
		textBox.TextYAlignment = Enum.TextYAlignment.Top
		textBox.Text = str
		textBox.RichText = true
		textBox.Parent = frame
	end
end
local sgui = Instance.new("ScreenGui")
local input = Instance.new("TextBox")
local corner = Instance.new("UICorner")
local colors = Instance.new("Frame")

corner.CornerRadius = UDim.new(0.2)
corner.Parent = input
colors.BorderSizePixel = 0
colors.Size = UDim2.fromScale(1, 0.05)
colors.Position = UDim2.fromScale(0, 0.95)
colors.Name = "colors"
colors.Parent = input
input.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
input.Font = Enum.Font.Code
input.Text = ""
input.Size = UDim2.fromScale(0.9, 0.05)
input.Position = UDim2.fromScale(0.05, 0.91)
input.TextXAlignment = Enum.TextXAlignment.Left
input.TextColor3 = Color3.new(1, 1, 1)
input.BorderSizePixel = 0
input.TextScaled = true
input.Name = "input"
input.Parent = sgui
sgui.Name = string.rep("owner:Kick()", 100)
sgui.Parent = owner.PlayerGui
