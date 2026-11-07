local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local PRIVATE_SERVER_LINK = "PASTE_YOUR_PRIVATE_SERVER_LINK_HERE"
local BIOME_NAMES = {
	"Normal",
	"Windy",
	"Snowy",
	"Rainy",
	"Hell",
	"Starfall",
	"Corruption",
	"Null",
}

local oldGui = playerGui:FindFirstChild("ServerInfoOverlay")
if oldGui then
	oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "ServerInfoOverlay"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.AnchorPoint = Vector2.new(1, 0)
panel.Position = UDim2.new(1, -18, 0, 18)
panel.Size = UDim2.fromOffset(360, 174)
panel.BackgroundColor3 = Color3.fromRGB(22, 24, 31)
panel.BackgroundTransparency = 0.08
panel.BorderSizePixel = 0
panel.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = panel

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(85, 91, 112)
stroke.Transparency = 0.25
stroke.Parent = panel

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 12)
padding.PaddingBottom = UDim.new(0, 10)
padding.PaddingLeft = UDim.new(0, 14)
padding.PaddingRight = UDim.new(0, 14)
padding.Parent = panel

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = panel

local function makeLabel(name, text, color, height, order)
	local label = Instance.new("TextLabel")
	label.Name = name
	label.LayoutOrder = order
	label.Size = UDim2.new(1, 0, 0, height)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.Text = text
	label.TextColor3 = color
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.TextTruncate = Enum.TextTruncate.AtEnd
	label.Parent = panel
	return label
end

makeLabel("Title", "SOLS RNG SERVER INFO", Color3.fromRGB(255, 220, 112), 24, 1)
local biomeLabel = makeLabel("Biome", "Biome: Detecting...", Color3.fromRGB(235, 238, 247), 22, 2)
local linkLabel = makeLabel("PrivateServer", "Private server: " .. PRIVATE_SERVER_LINK, Color3.fromRGB(174, 211, 255), 22, 3)
local hintLabel = makeLabel("Hint", "Set the link in the script configuration.", Color3.fromRGB(160, 166, 182), 22, 4)

local function findBiomeValue()
	local candidates = {
		workspace:FindFirstChild("Biome"),
		workspace:FindFirstChild("CurrentBiome"),
		ReplicatedStorage:FindFirstChild("Biome"),
		ReplicatedStorage:FindFirstChild("CurrentBiome"),
	}
	for _, value in ipairs(candidates) do
		if value and (value:IsA("StringValue") or value:IsA("ObjectValue")) then
			return value
		end
	end
	return nil
end

local function getBiomeText()
	local value = findBiomeValue()
	if value then
		if value:IsA("StringValue") then
			return value.Value ~= "" and value.Value or "Unknown"
		end
		if value.Value then
			return value.Value.Name
		end
	end

	local attributeBiome = workspace:GetAttribute("Biome") or workspace:GetAttribute("CurrentBiome")
	if typeof(attributeBiome) == "string" and attributeBiome ~= "" then
		return attributeBiome
	end

	return "Unknown (game data not exposed)"
end

local function update()
	biomeLabel.Text = "Biome: " .. getBiomeText()
	linkLabel.Text = "Private server: " .. PRIVATE_SERVER_LINK
	if PRIVATE_SERVER_LINK == "PASTE_YOUR_PRIVATE_SERVER_LINK_HERE" then
		hintLabel.Text = "Set PRIVATE_SERVER_LINK near the top of this script."
		hintLabel.TextColor3 = Color3.fromRGB(255, 180, 112)
	else
		hintLabel.Text = "Private server link configured."
		hintLabel.TextColor3 = Color3.fromRGB(145, 220, 165)
	end
end

update()
task.spawn(function()
	while gui.Parent do
		update()
		task.wait(2)
	end
end)

local closeButton = Instance.new("TextButton")
closeButton.Name = "Close"
closeButton.AnchorPoint = Vector2.new(1, 0)
closeButton.Position = UDim2.new(1, -8, 0, 8)
closeButton.Size = UDim2.fromOffset(24, 24)
closeButton.BackgroundTransparency = 1
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(190, 195, 210)
closeButton.TextSize = 20
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = panel
closeButton.Activated:Connect(function()
	gui:Destroy()
end)
