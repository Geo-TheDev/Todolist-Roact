local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)

local e = Roact.createElement

local function Button(props, hooks)
	return e("TextButton", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = props.position, --UDim2.fromScale(0.5,1.1),
		Size = props.size, --UDim2.fromScale(0.5,0.15),
		Font = Enum.Font.FredokaOne,
		TextScaled = true,
		BackgroundColor3 = props.backgroundColor3,
		BorderSizePixel = 0,
		Text = props.text,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		[Roact.Event.Activated] = props.onActivated,
	}, {
		UICorner = e("UICorner", {
			CornerRadius = UDim.new(0.1, 0),
		}),
	})
end

return Hooks.new(Roact)(Button)
