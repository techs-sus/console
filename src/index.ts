declare const owner: Player;
declare const NLS: (code: string, parent: Instance) => LocalScript;
const part = new Instance("SpawnLocation");
const gui = new Instance("SurfaceGui");
const frame = new Instance("ScrollingFrame");
const list = new Instance("UIListLayout");
const worldModel = new Instance("WorldModel");
const remote = new Instance("RemoteEvent", owner.FindFirstChildOfClass("PlayerGui")!);
const TweenService = game.GetService("TweenService");
const RunService = game.GetService("RunService");
const TextService = game.GetService("TextService");
const Players = game.GetService("Players");
const insults = [
	"you really suck",
	"i can't believe you failed one of the simplest tasks",
	"even dino knows how to do this better",
	"god you really need some sleeping pills that last forever",
	"your oxygen should be transferred to someone else who needs it more",
	"how stupid are you to forget that coroutines existed",
	"god you are so useless i cant believe your parents didn't leave you",
	"i thought trash belonged outside, not in void",
	"even tusk knows how to write better sandboxes than you",
	"rookie experience ~= good scripter",
	"don't even try getting scripter; the tables don't want you",
	"gosh i thought i was a loser now, then i remembered you exist",
	"not even the vim community wants you in it",
	"comradio3 was better than whatever trash you made",
	"you still use wait() in 2022, how useless can people like you get",
	"im literally gonna turn you into a metatable",
	"get ready to be obfuscated, no one wants the original you",
	"microsoft doesn't approve of your actions",
	"god why am i wasting time roasting you, i should roast someone else more useful",
	"the grass moves away from you, and it literally disappears when you touch it",
	"obesity is an epidemic for a reason",
];
gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
gui.PixelsPerStud = 125;
gui.Face = Enum.NormalId.Back;
gui.Adornee = part;
frame.AutomaticCanvasSize = Enum.AutomaticSize.XY;
frame.BackgroundColor3 = new Color3(0.15, 0.15, 0.15);
frame.CanvasSize = UDim2.fromScale(0, 0);
frame.BorderSizePixel = 0;
frame.ScrollBarImageTransparency = 1;
frame.Size = UDim2.fromScale(1, 1);
list.FillDirection = Enum.FillDirection.Vertical;
list.HorizontalAlignment = Enum.HorizontalAlignment.Left;
list.VerticalAlignment = Enum.VerticalAlignment.Top;
list.SortOrder = Enum.SortOrder.LayoutOrder;
list.Parent = frame;
frame.Parent = gui;
part.Enabled = false;
part.Locked = true;
part.CanTouch = false;
part.CanCollide = false;
part.CanQuery = false;
part.Material = Enum.Material.Glass;
part.Color = new Color3(0, 1, 1);
part.Anchored = true;
part.Size = new Vector3(12, 8, 0.01);
part.Position = new Vector3(0, 10, 0);
part.Transparency = 0.5;
gui.Parent = script;
part.Parent = worldModel;
worldModel.Parent = script;
interface box {
	created: number;
	box: TextBox;
}
const boxes: box[] = [];

const scroll = () => {
	const tween = TweenService.Create(frame, new TweenInfo(0.25), {
		CanvasPosition: new Vector2(0, list.AbsoluteContentSize.Y - 125),
	});
	tween.Play();
};

const createText = (text: string) => {
	let box: TextBox = new Instance("TextBox");
	box.Text = text;
	box.BackgroundTransparency = 1;
	box.TextColor3 = new Color3(1, 1, 1);
	box.RichText = true;
	box.Font = Enum.Font.Code;
	box.BorderSizePixel = 0;
	box.AutomaticSize = Enum.AutomaticSize.XY;
	box.TextSize = 35;
	box.TextWrapped = true;
	box.LayoutOrder = 1;
	box.TextXAlignment = Enum.TextXAlignment.Left;
	box.TextYAlignment = Enum.TextYAlignment.Top;
	box.Parent = frame;
	boxes.push({
		created: os.clock(),
		box: box,
	});
	if (boxes.size() > 30) {
		let oldest: box;
		boxes.forEach((ins) => {
			if (!oldest) {
				oldest = ins;
			} else if (oldest.created > ins.created!) {
				oldest = ins;
			}
		});
		oldest!.box.Destroy();
		boxes.remove(boxes.indexOf(oldest!));
	}
	scroll();
	return box;
};
interface Command {
	name: string;
	description: string;
	aliases: string[];
	func: Callback;
	arguments: string[];
}
const commands: Command[] = [];
const prompt = createText("");
boxes.pop();
const cursor = new Instance("Frame");
cursor.BorderSizePixel = 0;
cursor.Size = UDim2.fromScale(0, 1).add(UDim2.fromOffset(20, 0));
cursor.BackgroundColor3 = new Color3(1, 1, 1);
cursor.Position = UDim2.fromScale(1, 0);
cursor.Parent = prompt;

task.spawn(() => {
	while (!0) {
		if (cursor.BackgroundColor3 === new Color3(1, 1, 1)) {
			cursor.BackgroundColor3 = frame.BackgroundColor3;
		} else {
			cursor.BackgroundColor3 = new Color3(1, 1, 1);
		}
		task.wait(0.5);
	}
});

prompt.LayoutOrder = 10;
const addCommand = (command: Command) => {
	commands.push(command);
};

let providers = new Map<string, Callback>();
const addProvider = (provider: string, callback: Callback) => {
	providers.set(provider, callback);
};

const getProviderFromName = (provider: string) => {
	return providers.get(provider);
};

addProvider("Player", (s: string) => {
	return Players.GetPlayers().find((v) => {
		let name = string.lower(v.Name);
		return string.sub(name, 1, s.size()) === string.lower(s);
	});
});

const executeCommand = (name: string, args: string[]) => {
	let command: Command;
	for (let cmd of commands) {
		if (cmd.name === name) {
			command = cmd;
			break;
		} else if (cmd.aliases.indexOf(name) !== -1) {
			command = cmd;
			break;
		}
	}
	if (!command!) {
		return `Failed finding command "${name}"!`;
	}

	let coro = coroutine.create(command.func);
	let constructed: string[] = [];
	args.forEach((arg: string, index: number) => {
		let provider = getProviderFromName(command.arguments[index]);
		const insult = insults[math.random(1, insults.size())];
		if (provider) {
			let result: string = provider(arg, args);
			if (!result) {
				return createText(
					`[pre-runtime] "${insult}" - Literally everybody\nDid you type the command correctly?`,
				);
			}
			return constructed.push(result);
		} else {
			return createText(`[pre-runtime] "${insult}" - Everybody but you\nDid you forget to pass in an argument?`);
		}
	});
	coroutine.resume(coro, ...constructed);
	return command;
};

addCommand({
	name: "coolness",
	description: "its cool",
	aliases: ["cool"],
	func: (player: Player) => {
		createText(player.Name);
	},
	arguments: ["Player"],
});

const filterRichText = (text: string) => {
	return string.gsub(
		string.gsub(
			string.gsub(string.gsub(string.gsub(text, "&", "&amp;")[0], "'", "&apos;")[0], '"', "&quot;")[0],
			"<",
			"&lt;",
		)[0],
		">",
		"&gt;",
	)[0];
};

const getPromptText = (input: string) => {
	const split = string.split(input, " ");
	const commandName = split.shift();
	const command =
		commandName && commands.filter((v) => v.name === commandName || v.aliases.indexOf(commandName) !== -1)[0];

	return `<font color="#00AAFF">[tech@vsb ~]$ </font>${
		commandName &&
		`<font color='${(command && typeOf(command) === "table" && "#FFBB00") || "#FF0000"}'>${filterRichText(
			commandName,
		)}</font>`
	}${filterRichText((split.size() > 0 && " " + split.join(" ")) || "")}`;
};

const runCommand = (message: string) => {
	const split = string.split(message, " ");
	if (split.size() <= 0) {
		return;
	}
	const commandName = split.shift()!;

	let cmd: Command | string | undefined = executeCommand(commandName, split);
	createText(getPromptText(message));
	if (typeOf(cmd) === "string") {
		createText(`<font color='#FF0000'>Error: ${filterRichText(cmd as string)}</font>`);
	}
};

const screenGui = new Instance("ScreenGui");
const textbox = new Instance("TextBox");
const corner = new Instance("UICorner");
textbox.BackgroundColor3 = new Color3(0.25, 0.25, 0.25);
textbox.BorderSizePixel = 0;
textbox.Position = UDim2.fromScale(0.025, 0.9);
textbox.Size = UDim2.fromScale(0.95, 0.05);
textbox.Font = Enum.Font.Code;
textbox.TextScaled = true;
textbox.TextXAlignment = Enum.TextXAlignment.Left;
textbox.TextYAlignment = Enum.TextYAlignment.Top;
textbox.TextColor3 = new Color3(1, 1, 1);
textbox.Text = "";
textbox.Visible = false;
textbox.ClearTextOnFocus = false;
corner.CornerRadius = new UDim(0.025, 0);
corner.Parent = textbox;
textbox.Parent = screenGui;
screenGui.Parent = remote;
remote.OnServerEvent.Connect((player: Player, requestType, text) => {
	if (owner !== player) return;
	if (!typeIs(requestType, "string")) return;
	if (!typeIs(text, "string")) return;
	switch (requestType as string) {
		case "enter":
			runCommand(text as string);
			break;
		case "typing":
			prompt.Text = getPromptText(text);
			break;
		default:
			break;
	}
});

NLS(
	`
local remote = script.Parent
local gui = remote:FindFirstChildOfClass("ScreenGui")
local textbox = gui:FindFirstChildOfClass("TextBox")
local UserInputService = game:GetService("UserInputService")
textbox.Visible = false
local function toggle()
  textbox.Visible = not textbox.Visible
  if textbox.Visible then
    textbox.Transparency = 1
    for i = 1, 10 do
      textbox.Transparency = (10 - i) / 10
      task.wait()
    end
    textbox:CaptureFocus()
  else
    textbox.Visible = true
    textbox.Transparency = 0
    for i = 1, 10 do
      textbox.Transparency = i / 10
      task.wait()
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
`,
	remote,
);

export {};
