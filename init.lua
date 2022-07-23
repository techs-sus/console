local part = Instance.new("SpawnLocation")
local gui = Instance.new("SurfaceGui")
local frame = Instance.new("ScrollingFrame")
local list = Instance.new("UIListLayout")
local worldModel = Instance.new("WorldModel")
gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
gui.PixelsPerStud = 150
gui.Adornee = part
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
gui.Parent = script
part.Parent = worldModel
local prompt = "<font color='#00A0FF'>[tech@artixbox {directory}]$</font> {filtered_text}"

local function filterRichText(text: string)
	return string.gsub(
		string.gsub(
			string.gsub(string.gsub(string.gsub(text, "&", "&amp;"), "<", "&lt;"), '"', "&quot;"),
			"'",
			"&apos;"
		),
		">",
		"&gt;"
	)
end

local function fillInVariables(text: string, table: Dictionary<any>)
	local s = text
	for i, v in pairs(table) do
		s = string.gsub(s, "{" .. i .. "}", v)
	end
	return s
end

local function createText(text: string)
	local box = Instance.new("TextBox")
	box.Text = text
	box.RichText = true
	box.TextSize = 40
	box.TextWrapped = true
	box.Font = Enum.Font.Code
	box.AutomaticSize = Enum.AutomaticSize.XY
	box.Name = os.time()
	box.TextColor3 = Color3.new(1, 1, 1)
	box.BackgroundTransparency = 1
	box.Parent = frame
end

createText(fillInVariables(prompt, {
	directory = "~",
	filtered_text = filterRichText("hello"),
}))
