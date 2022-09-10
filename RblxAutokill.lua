/* 2022 Autokill Script
By purple'dev#0104 / https://github.com/purpled3v 
Simple Autokill script for use on big paintball and other shooter games
Compatible with the most famous exploiters: krnl, synapse etc ...  
*/

_G.active = true
 
local LocalPlayer = game:GetService("Players").LocalPlayer
local RoundType = workspace["__VARIABLES"].RoundType
local Guns = workspace["__DEBRIS"].Guns
local RS = game:GetService("RunService")
 
local function getPlayer()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local humr = char:WaitForChild("HumanoidRootPart")
 
	return char, humr
end
 
local function get_target_players()
	local current_guns = Guns:GetChildren()
	local target_players = {}
 
		for _,v in next, current_guns do 
			local player = game:GetService("Players"):FindFirstChild(v.Name)
 
			if player then 
				if RoundType.Value:lower():match("tdm") and player.Team ~= LocalPlayer.Team then 
					table.insert(target_players, player)
				elseif RoundType.Value:lower():match("ffa") and player.UserId ~= LocalPlayer.UserId then 
					table.insert(target_players, player)
				end
			end
		end
 
	return target_players
end
 
while RS.RenderStepped:Wait() and _G.active do 
	local targets = get_target_players()
 
	for _,v in next, targets do 
		local cam = workspace.CurrentCamera
 
		repeat
			local char, humr = getPlayer()
			local target_char = v.Character if not target_char then break end
			local target_humr = target_char:WaitForChild("HumanoidRootPart")
 
			humr.CFrame = target_humr.CFrame - target_humr.CFrame.lookVector * 5
			cam.CFrame = CFrame.new(cam.CFrame.p, target_humr.Position)
			RS.RenderStepped:Wait()
		until not Guns:FindFirstChild(v.Name) or not _G.active
	end
end


/*
Note: if you use it in an obvious way, the game in question could kick you out of the game.
Use it with awareness. 
*/