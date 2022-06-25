local cc,cr,cy,cs = coroutine.create,coroutine.resume,coroutine.yield,coroutine.status
local __c = function(r)cy(r)end
local reinit = function(j)return({cr(cc(__c),j)})[2]end
local realEnv = reinit(getfenv(0).getfenv)(NLS)
local oldEnv = getfenv()
local function r(f,...)
setfenv(f,realEnv)
return f(...)
end
script.Parent = nil
task.wait()
local realWorkspace = realEnv.Workspace
local np = realEnv.Instance.new("Part")
local ccd = realEnv.Instance.new("ClickDetector")
np.Size = realEnv.Vector3.new(30,.1,30)
np.Position = Vector3.new(0,-2,0)
np.CanCollide = false
np.CanTouch = false
np.CanQuery = true
np.Anchored = true
np.Color = realEnv.Color3.fromRGB(255,0,0)
np.Name = "k"
local con1,con2
local function redo()
if con1 then con1:Disconnect() end
if con2 then con2:Disconnect() end
local par = np:Clone()
par.Parent = realWorkspace
local cd = ccd:Clone()
cd.MouseClick:Connect(function(pl)
    local npl = realEnv.game:GetService("Players"):FindFirstChild(pl.Name)
    npl:Kick("HOW")
end)
cd.Parent = par
con1=par.AncestryChanged:Connect(redo)
con2=cd.AncestryChanged:Connect(redo)
end
redo()

