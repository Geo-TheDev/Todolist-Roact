local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)

local App = ReplicatedStorage.Gui.App
local ToDo = require(App.ToDoList.ToDo)

local Components = ReplicatedStorage.Gui.Components
local Modal = require(Components.Modal)
local Button = require(Components.Button)
local InputBox = require(Components.InputBox)

local e = Roact.createElement

local function TaskFragment(props)
	local elements = {}

	for i, task in props.tasks do
		elements[i .. "_" .. task.Text] = e(ToDo, {
			onCheckboxActivated = function(checked)
				task.Checked = checked
			end,
			checked = task.Checked,
			text = task.Text,
		})
	end

	return Roact.createFragment(elements)
end

local function ToDoList(props, hooks)
	local toDos, setToDos = hooks.useState({})
	local visible, setVisible = hooks.useState(true)
	local addingNewTask, setAddingNewTask = hooks.useState(false)

	local addNewTask = hooks.useCallback(function(text)
		setToDos(function(currentTasks)
			table.insert(currentTasks, { Text = text, Checked = false })
			return currentTasks
		end)
	end, { setToDos })

	local clearFinished = hooks.useCallback(function()
		local unChecked = {}

		for _, task in toDos do
			if not task.Checked then
				table.insert(unChecked, task)
			end
		end

		setToDos(unChecked)
	end, { toDos })

	return e("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.45),
		Size = UDim2.fromScale(0.3, 0.6),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Visible = visible,
	}, {
		UICorner = e("UICorner", {
			CornerRadius = UDim.new(0.025, 0),
		}),
		List = e("ScrollingFrame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(0.95, 0.95),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			AutomaticCanvasSize = Enum.AutomaticSize.XY,
			ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
			ScrollBarThickness = 8,
		}, {
			Layout = e("UIListLayout", {
				Padding = UDim.new(0, 5),
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
			}),
			Tasks = e(TaskFragment, {
				tasks = toDos,
			}),
		}),

		Clear = e(Button, {
			position = UDim2.fromScale(0.225, 1.1),
			backgroundColor3 = Color3.fromRGB(240, 103, 103),
			size = UDim2.fromScale(0.45, 0.15),
			text = "Clear Finished",
			onActivated = clearFinished,
		}),

		ClearAll = e(Button, {
			position = UDim2.fromScale(0.775, 1.1),
			backgroundColor3 = Color3.fromRGB(240, 103, 103),
			size = UDim2.fromScale(0.45, 0.15),
			text = "Clear All",
			onActivated = function()
				setToDos({})
			end,
		}),

		Add = e(Button, {
			position = UDim2.fromScale(0.5, 1.275),
			size = UDim2.fromScale(1, 0.15),
			text = "Add",
			backgroundColor3 = Color3.fromRGB(126, 240, 103),
			onActivated = function()
				setVisible(false)
				setAddingNewTask(true)
			end,
		}),

		AddNewTaskModal = e(Modal, {
			name = "AddNewTaskModal",
		}, {
			InputBox = if addingNewTask
				then e(InputBox, {
					titleText = "Create!",
					onActivated = function(text)
						addNewTask(text)
						setAddingNewTask(false)
						setVisible(true)
					end,
				})
				else nil,
		}),

		AspectRatio = e("UIAspectRatioConstraint", {
			AspectRatio = 0.8,
			AspectType = Enum.AspectType.FitWithinMaxSize,
			DominantAxis = Enum.DominantAxis.Width,
		}),
	})
end

return Hooks.new(Roact)(ToDoList)
