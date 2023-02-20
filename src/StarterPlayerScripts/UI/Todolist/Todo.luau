local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)

local e = Roact.createElement

local function Todo(props, hooks)
    local checked, setChecked = hooks.useState(props.Checked)
    local text, setText = hooks.useState("")

    return e("Frame", {
        AnchorPoint = Vector2.new(0.5,0),
        Position = UDim2.fromScale(0.5,0),
        Size = UDim2.fromScale(0.9,0.15),
        BackgroundColor3 = Color3.fromRGB(222, 222, 222),
    }, {
        UICorner = e("UICorner", {
            CornerRadius = UDim.new(0.1,0)
        }),
        Text = e("TextLabel", {
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.fromScale(0.6,0.5),
            Size = UDim2.fromScale(0.65,0.75),
            BorderSizePixel = 0,
            TextScaled = true,
            Text = props.Text,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Font = Enum.Font.FredokaOne,
            TextWrapped = true
        }),
        Checkbox = e("TextButton", {
            AnchorPoint = Vector2.new(0,0.5),
            Position = UDim2.fromScale(0.05,0.5),
            Size = UDim2.fromScale(0.15,0.75),
            BorderSizePixel = 0,
            TextScaled = true,
            Text = text,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextXAlignment = Enum.TextXAlignment.Center,
            Font = Enum.Font.FredokaOne,
    
            [Roact.Event.Activated] = function()
                setChecked(not checked)
    
                if checked then
                    setText("")
                else
                    setText("X")
                end

                props.checkboxFunc(not checked)
            end,
        }, {
            UICorner = e("UICorner", {
                CornerRadius = UDim.new(0.1,0)
            }),
        })
    })
end

return Hooks.new(Roact)(Todo)
