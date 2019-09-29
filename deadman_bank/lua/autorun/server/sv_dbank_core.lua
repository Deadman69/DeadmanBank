if not file.Exists("dbank", "DATA") then
	file.CreateDir("dbank")
end

hook.Add("PlayerInitialSpawn", "DBank:PlayerFirstSpawn", function( ply )
	if not file.Exists("dbank/"..ply:SteamID64(), "DATA") then
		file.CreateDir("dbank/"..ply:SteamID64())
		file.Write("dbank/"..ply:SteamID64().."/code.txt", 0)
		file.Write("dbank/"..ply:SteamID64().."/balance.txt", DBankConfig.DefaultAmount)
	end
end)


hook.Add( "PlayerSay", "DBank:PlayerSay", function( ply, text )
	local playerInput = string.Explode( " ", text )

	if ( playerInput[1] == DBankConfig.CommandAdmin ) then
		if not DBankConfig.AllowedUsergroups[ply:GetUserGroup()] then return end
			if not playerInput[2] or not playerInput[3] then return end
			for k, v in pairs(player.GetAll()) do
				if playerInput[2] == v:SteamID() or playerInput[2] == v:SteamID64() then
					if playerInput[3] == "reset" then
						file.Write("dbank/"..ply:SteamID64().."/code.txt", 0)
						ply:ChatPrint("You have reset "..v:Nick().."'s code")
					else
						file.Write("dbank/"..ply:SteamID64().."/code.txt", playerInput[3])
						ply:ChatPrint("You have define "..v:Nick().."'s code for "..playerInput[3])
					end
				end
			end

		return ""
	end
end )

local shouldAdvert = DBankConfig.AdvertPlayers
local VIPInterest = tonumber(DBankConfig.VIPInterest)
local ClassicInterest = tonumber(DBankConfig.Interest)
if DBankConfig.InterestTime ~= nil then
	timer.Create("DBank:Interest", DBankConfig.InterestTime, 0, function()
		for k, v in pairs(player.GetAll()) do
			local vBalance = file.Read("dbank/"..v:SteamID64().."/balance.txt")
			local interest
			if DBankConfig.VIPUsergroups[v:GetUserGroup()] then
				interest = math.Round((vBalance*VIPInterest))
			else
				interest = math.Round((vBalance*ClassicInterest))
			end

			file.Write("dbank/"..v:SteamID64().."/balance.txt", vBalance + interest)

			if shouldAdvert then
				net.Start("DBank::Notification")
					net.WriteString(DBankConfig.Language1..interest..DBankConfig.Currency)
				net.Send(v)
			end
		end

	end)
end