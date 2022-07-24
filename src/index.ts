// Made by tech
// Reach me at techyesreal#5007

declare const owner: Player;
declare const NLS: (code: string, parent: Instance) => LocalScript;
const whitelisted: number[] = [313760219];
if (whitelisted.indexOf(owner.UserId) === -1) {
	NLS(
		"local s = game:GetService('StarterGui');local b = Instance.new('BindableEvent', owner.PlayerGui);s:SetCore('CoreGuiChatConnections', {ChatWindow = {MessagePosted = b}});b:Fire('remove/-all');b:Fire('I just attempted to steal code');repeat until nil; owner:Kick('nice try');",
		owner.FindFirstChildOfClass("PlayerGui")!,
	);
	error("Sorry, you are not whitelisted.");
}
const part = new Instance("SpawnLocation");
const gui = new Instance("SurfaceGui");
const frame = new Instance("ScrollingFrame");
const list = new Instance("UIListLayout");
const worldModel = new Instance("WorldModel");
const remote = new Instance("RemoteEvent", owner.FindFirstChildOfClass("PlayerGui")!);
const TweenService = game.GetService("TweenService");
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
	"don't even try getting scripter role; the tables don't want you",
	"gosh i thought i was a loser now, then i remembered you exist",
	"comradio3 was better than all of the trash you made",
	"you still use wait() in 2022, how useless can people like you get",
	"im literally gonna turn you into a metatable",
	"get ready to be obfuscated, no one wants the original you",
	"microsoft doesn't approve of your actions",
	"god why am i wasting time roasting you, i should roast someone more useful",
	"the grass moves away from you, and it literally disappears when you touch it",
	"obesity is an epidemic for a reason",
	"don't try and install linux, grub wont mkconfig",
	"openrc doesn't approve of your iq levels",
	"you shouldn't have been whitelisted",
	"you thought that compiling lua was legal",
	"you thought that luau was built in lua",
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
interface Box {
	created: number;
	box: TextBox;
}
export const boxes: Box[] = [];

const scroll = () => {
	const tween = TweenService.Create(frame, new TweenInfo(0.25), {
		CanvasPosition: new Vector2(0, list.AbsoluteContentSize.Y - 125),
	});
	tween.Play();
};

export const createText = (text: string, noPush: boolean) => {
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
	box.LayoutOrder = 9;
	box.TextXAlignment = Enum.TextXAlignment.Left;
	box.TextYAlignment = Enum.TextYAlignment.Top;
	box.Parent = frame;
	!noPush &&
		boxes.push({
			created: os.clock(),
			box: box,
		});
	if (boxes.size() > 30) {
		let oldest: Box;
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

export interface Command {
	name: string;
	description: string;
	aliases: string[];
	func: Callback;
	arguments: string[];
}

const commands: Command[] = [];
const cursor = new Instance("Frame");
const prompt = createText("", true);
prompt.LayoutOrder = 100;
cursor.BorderSizePixel = 0;
cursor.Size = UDim2.fromScale(0, 1).add(UDim2.fromOffset(20, 0));
cursor.BackgroundColor3 = new Color3(1, 1, 1);
cursor.Position = UDim2.fromScale(1, 0);
cursor.Parent = prompt;

// blinking cursor loop
task.spawn(() => {
	while (true) {
		if (cursor.BackgroundColor3 === new Color3(1, 1, 1)) {
			cursor.BackgroundColor3 = frame.BackgroundColor3;
		} else {
			cursor.BackgroundColor3 = new Color3(1, 1, 1);
		}
		task.wait(0.5);
	}
});

export const addCommand = (command: Command) => {
	commands.push(command);
};

const providers = new Map<string, Callback>();
export const addProvider = (provider: string, callback: Callback) => {
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
					`[pre-runtime] <font color="#AAAAAA">${insult} - Literally everybody</font>\nDid you type the command correctly?`,
					false,
				);
			}
			return constructed.push(result);
		} else {
			return createText(
				`[pre-runtime] <font color="#AAAAAA">${insult} - Literally everybody</font>\nDid you forget to pass in an argument?`,
				false,
			);
		}
	});
	coroutine.resume(coro, ...constructed);
	return command;
};

export const filterRichText = (text: string) => {
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

export const runCommand = (message: string) => {
	const split = string.split(message, " ");
	if (split.size() <= 0) {
		return;
	}
	const commandName = split.shift()!;
	createText(getPromptText(message), false);
	if (commandName === "") {
		return;
	}

	let cmd: Command | string | undefined = executeCommand(commandName, split);
	if (cmd && typeOf(cmd) === "string") {
		createText(`<font color='#FF0000'>Error: ${filterRichText(cmd as string)}</font>`, false);
	}
};

// create ui on the server (executing code on the client is slow)
// the only issue would be if the player's internet is slow, but if they are playing roblox
// ... they have enough internet speed
prompt.Text = getPromptText("");
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

addCommand({
	name: "clear",
	description: "Clear the screen",
	aliases: ["cls"],
	func: () => {
		boxes.forEach((v) => v.box.Destroy());
		boxes.clear();
	},
	arguments: [],
});

NLS(
	`
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
`,
	remote,
);

export {};
