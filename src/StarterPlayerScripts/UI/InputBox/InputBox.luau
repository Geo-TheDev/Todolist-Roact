local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)

local Components = script.Parent.Parent.Components
local Button = require(Components.Button)

local e = Roact.createElement

local function Inputbox(props, hooks)
    local text, setText = hooks.useState("")

    return e("Frame", {
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.fromScale(0.5,0.5),
        Size = UDim2.fromScale(0.35,0.25),
        BackgroundColor3 = Color3.fromRGB(255,255,255),
    }, {
        inputBox = e("TextBox", {
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.fromScale(0.5,0.5),
            Size = UDim2.fromScale(0.9,0.4),
            BackgroundColor3 = Color3.fromRGB(222,222,222),
            BorderSizePixel = 0,

            Font = Enum.Font.FredokaOne,
            TextScaled = true,
            Text = "",
            PlaceholderText = "...",

            [Roact.Event.Changed] = function(_text)
                setText(_text.Text)
            end
        }, {
            UICorner = e("UICorner", {
                CornerRadius = UDim.new(0.2,0)
            })
        }),
        UICorner = e("UICorner", {
            CornerRadius = UDim.new(0.05,0)
        }),
        Title = e("TextLabel", {
            AnchorPoint = Vector2.new(0.5,0),
            Position = UDim2.fromScale(0.5,-0.225),
            Size = UDim2.fromScale(0.9,0.4),
            BackgroundTransparency = 1,
            Rotation = -5,

            TextScaled = true,
            TextColor3 = Color3.fromRGB(255,255,255),
            Text = props.TitleText or "Test",
            Font = Enum.Font.FredokaOne,
        }, {
            UIStroke = e("UIStroke", {
                Thickness = 4,
                Color = Color3.fromRGB(0,0,0)
            })
        }),
        Submit = e(Button, {
            Position = UDim2.fromScale(0.5,1),
            Size = UDim2.fromScale(0.5,0.35),
            BackgroundColor3 = Color3.fromRGB(126, 240, 103),
            Text = "Submit",
            Function = function()
                props.Callback(text)
            end
        })
    })
end

return Hooks.new(Roact)(Inputbox)