local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)

local Components = script.Parent.Parent.Components
local Todo = require(script.Parent.Todo)
local Button = require(Components.Button)
local InputBox = require(script.Parent.Parent.InputBox.InputBox)

local e = Roact.createElement

local function Todolist(props, hooks)
    local todos, setTodos = hooks.useState({})
    local visible, setVisible = hooks.useState(true)

    local function addTodos()
        local _todos = {}
    
        for i, v in pairs(todos) do
            _todos[i] = e(Todo, {
                checkboxFunc = function(checked)
                    todos[i].Checked = checked
                end,
                Checked = v.Checked,
                Text = v.Text,
            })
        end
    
        return Roact.createFragment(_todos)
    end
    
    local function clearFinished()
        local unchecked = {}

        for _, v in ipairs(todos) do
            if v.Checked == false then
                table.insert(unchecked, v)
            end
        end

        setTodos({})
        setTodos(unchecked)
    end

    return e("Frame", {
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.fromScale(0.5,0.45),
        Size = UDim2.fromScale(0.3,0.6),
        BackgroundColor3 = Color3.fromRGB(255,255,255),
        Visible = visible,
    }, {
        UICorner = e("UICorner", {
            CornerRadius = UDim.new(0.025,0)
        }),
        List = e("ScrollingFrame", {
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.fromScale(0.5,0.5),
            Size = UDim2.fromScale(0.95,0.95),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AutomaticCanvasSize = Enum.AutomaticSize.XY,
            ScrollBarImageColor3 = Color3.fromRGB(0,0,0),
            ScrollBarThickness = 8
        }, {
            Layout = e("UIListLayout", {
                Padding = UDim.new(0,5),
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
            }),
            addTodos(),
        }),

        Clear = e(Button, {
            Position = UDim2.fromScale(0.225,1.1),
            BackgroundColor3 = Color3.fromRGB(240, 103, 103),
            Size = UDim2.fromScale(0.45,0.15),
            Text = "Clear Finished",
            Function = function()
                clearFinished()
            end
        }),
        
        ClearAll = e(Button, {
            Position = UDim2.fromScale(0.775,1.1),
            BackgroundColor3 = Color3.fromRGB(240, 103, 103),
            Size = UDim2.fromScale(0.45,0.15),
            Text = "Clear All",
            Function = function()
                setTodos({})
            end
        }),
        
        Add = e(Button, {
            Position = UDim2.fromScale(0.5,1.275),
            Size = UDim2.fromScale(1,0.15),
            Text = "Add",
            BackgroundColor3 = Color3.fromRGB(126, 240, 103),
            Function = function()
                setVisible(false)
                
                local app
                local UI = e("ScreenGui", { ResetOnSpawn = false }, {
                    UI = e(InputBox, {
                        TitleText = "Create!",
                        Callback = function(text)
                            local newTodos = todos
                            newTodos[#newTodos+1] = {Text = text, Checked = false}
    
                            setTodos(newTodos)
                            setVisible(true)

                            if app == nil then return end
                            Roact.unmount(app)
                        end
                    })
                })

                app = Roact.mount(UI, game.Players.LocalPlayer.PlayerGui, "InputBox")
            end
        }),

        AspectRatio = e("UIAspectRatioConstraint", {
            AspectRatio = 0.8,
            AspectType = Enum.AspectType.FitWithinMaxSize,
            DominantAxis = Enum.DominantAxis.Width,
        }),
    })
end

return Hooks.new(Roact)(Todolist)