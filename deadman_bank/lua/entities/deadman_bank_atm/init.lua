AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("deadman_bank_config.lua")

include("deadman_bank_config.lua")
include("shared.lua")

util.AddNetworkString("DBank::OpenATMMenu")
util.AddNetworkString("DBank::CreateCode")
util.AddNetworkString("DBank::CheckCode")
util.AddNetworkString("DBank::Transaction")
util.AddNetworkString("DBank::Notification")

function ENT:Initialize()

	self:SetModel(DBankConfig.ATMModel)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then

		phys:Wake()
	
	end

end




function ENT:Use(activator, caller)

	if activator:IsValid() and activator:IsPlayer() and activator:Alive() then
		local canOpen = true
		if DBankConfig.MustHaveCC then
			if activator:GetActiveWeapon():GetClass() == "deadman_bank_card" then
				canOpen = true
			else
				canOpen = false
			end
		end

		if canOpen then
			local playerCode
			if file.Exists( "dbank/"..activator:SteamID64().."/code.txt", "DATA" ) then
				if tonumber(file.Read("dbank/"..activator:SteamID64().."/code.txt")) == 0 then -- The player code is 0 (default)
					playerCode = "888888"
				else
					playerCode = tonumber(file.Read("dbank/"..activator:SteamID64().."/code.txt"))
				end
			else
				playerCode = "888888"
			end
			net.Start("DBank::OpenATMMenu")
				net.WriteInt(playerCode, 32)
			net.Send(activator)
		else
			net.Start("DBank::Notification")
				net.WriteString(DBankConfig.Language9)
			net.Send(activator)
		end
	end

end




net.Receive("DBank::CreateCode", function(len, ply)
	local playerCode = net.ReadInt(32)
	file.Write("dbank/"..ply:SteamID64().."/code.txt", playerCode)
end)


net.Receive("DBank::CheckCode", function(len, ply)
	local playerCode = net.ReadInt(32)
	local realPlayerCode = tonumber(file.Read("dbank/"..ply:SteamID64().."/code.txt"))

	if playerCode == realPlayerCode then
		local playerBalance = tonumber(file.Read("dbank/"..ply:SteamID64().."/balance.txt"))
		net.Start("DBank::Transaction")
			net.WriteInt(playerBalance , 32)
		net.Send(ply)
	else
		net.Start("DBank::Notification")
			net.WriteString(DBankConfig.Language10)
		net.Send(ply)
	end
end)

net.Receive("DBank::Transaction", function(len, ply)
	local _string = net.ReadString()
	local _value = net.ReadInt(32)
	local playerBalance = tonumber(file.Read("dbank/"..ply:SteamID64().."/balance.txt"))

	if _string == "deposit" then
		local stringToSend = DBankConfig.Language11

		if ply:getDarkRPVar("money") >= _value then -- Si il a assez d'argent pour déposer
			stringToSend = DBankConfig.Language12.._value..DBankConfig.Currency..DBankConfig.Language13
			ply:addMoney(-_value)
			file.Write("dbank/"..ply:SteamID64().."/balance.txt", playerBalance + _value)
		end

		net.Start("DBank::Notification")
			net.WriteString(stringToSend)
		net.Send(ply)
	elseif _string == "withdraw" then
		local stringToSend = DBankConfig.Language14

		if playerBalance >= _value then -- Si il a assez d'argent pour déposer
			stringToSend = DBankConfig.Language15.._value..DBankConfig.Currency..DBankConfig.Language13
			ply:addMoney(_value)
			file.Write("dbank/"..ply:SteamID64().."/balance.txt", playerBalance-_value)
		end

		net.Start("DBank::Notification")
			net.WriteString(stringToSend)
		net.Send(ply)
	end
end)