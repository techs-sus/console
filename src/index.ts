declare const owner: Player;
const part = new Instance("SpawnLocation");
const gui = new Instance("SurfaceGui");
const frame = new Instance("ScrollingFrame");
const list = new Instance("UIListLayout");
const worldModel = new Instance("WorldModel");
const TweenService = game.GetService("TweenService");
const Players = game.GetService("Players");
const insults = [
	"you really suck",
	"i can't believe you failed one of the simplest tasks",
	"even dino knows how to do this better",
	"god you really need some sleeping pills",
	"you're oxygen should be transferred to someone else who needs it more",
	"how stupid are you to forget that coroutines existed",
	"god you are so useless i cant believe your parents didn't leave you",
	"i thought trash belonged outside, not in void",
	"even tusk knows how to write better sandboxes than you",
	"rookie experience ~= good scripter",
	"don't even try getting scripter; the tables don't want you",
];
gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
gui.PixelsPerStud = 100;
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
		return error("Failed finding command!");
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

executeCommand("cool", ["tabe"]);

export {};
