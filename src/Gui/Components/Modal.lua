local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Roact = require(ReplicatedStorage.Packages.Roact)

local e = Roact.createElement

local function Modal(props)
	return e(Roact.Portal, {
		target = props.target or Players.LocalPlayer.PlayerGui,
	}, {
		[props.name or "ScreenGui"] = e("ScreenGui", {
			DisplayOrder = props.displayOrder,
			IgnoreGuiInset = true,
			ResetOnSpawn = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		}, props[Roact.Children]),
	})
end

return Modal
