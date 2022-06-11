-- TODO: add a display

local commandManager = {}
commandManager.commands = {}
type Callback<T> = (...any) -> T

type Exit = {
	exitCode: number,
	exitMessage: string,
}

type Command = {
	commandFunction: Callback<Exit>,
	commandName: string,
	commandDescription: string,
	commandAliases: Array<string>,
	commandArguments: Dictionary<string>,
	moduleName: string?,
}

function commandManager:addCommand(
	-- unpack type command
	commandFunction: Callback<Exit>,
	commandName: string,
	commandDescription: string,
	commandAliases: Array<string>,
	commandArguments: Dictionary<string>
)
	local cmd: Command = {
		commandFunction = commandFunction,
		commandName = commandName,
		commandDescription = commandDescription,
		commandAliases = commandAliases,
		commandArguments = commandArguments,
	}
	self.commands[#self.commands + 1] = cmd
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
		argv = function(_, x)
			return x
		end,
		raw = function(x)
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
