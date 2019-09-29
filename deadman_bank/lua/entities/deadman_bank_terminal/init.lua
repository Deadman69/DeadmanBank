AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("deadman_bank_config.lua")

include("deadman_bank_config.lua")
include("shared.lua")


util.AddNetworkString("DBank::Terminal")
util.AddNetworkString("DBank::TerminalDefine")

function ENT:Initialize()

	self:SetModel(DBankConfig.TerminalModel)
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
		if self:GetNWEntity("DBank:Owner", NULL) ~= NULL then
			local userType
		    if self:GetNWEntity("DBank:Owner") == activator then
		        userType = "isOwner"
		    else
		    	userType = "isClient"
		    end
		    net.Start("DBank::Terminal")
		        net.WriteString(userType)
		        net.WriteEntity(self)
		    net.Send(activator)
		else
			self:SetNWEntity("DBank:Owner", activator)
			net.Start("DBank::Notification")
		   	    net.WriteString(DBankConfig.Language18)
			net.Send(activator)
		end
	end

end




net.Receive("DBank::TerminalDefine", function(len, ply)
	local priceToDefine = net.ReadInt(32)
	local terminal = net.ReadEntity()
	terminal:SetNWInt("DBank:Terminal:Amount", priceToDefine)
end)



net.Receive("DBank::Terminal", function(len, ply)
	local _ent = net.ReadEntity()
	if _ent:GetNWEntity("DBank:Owner") ~= ply then
		if _ent:GetNWInt("DBank:Terminal:Amount") ~= 0 then
			local buyerAmount = tonumber(file.Read("dbank/"..ply:SteamID64().."/balance.txt"))
			local vendorAmount = tonumber(file.Read("dbank/".._ent:GetNWEntity("DBank:Owner"):SteamID64().."/balance.txt"))

			if buyerAmount >= _ent:GetNWInt("DBank:Terminal:Amount") then
				file.Write("dbank/"..ply:SteamID64().."/balance.txt", buyerAmount - _ent:GetNWInt("DBank:Terminal:Amount"))
				file.Write("dbank/".._ent:GetNWEntity("DBank:Owner"):SteamID64().."/balance.txt", vendorAmount + _ent:GetNWInt("DBank:Terminal:Amount"))
				net.Start("DBank::Notification")
				    net.WriteString(DBankConfig.Language19.._ent:GetNWInt("DBank:Terminal:Amount")..DBankConfig.Currency)
				net.Send(ply)

				net.Start("DBank::Notification")
				    net.WriteString(DBankConfig.Language20.._ent:GetNWInt("DBank:Terminal:Amount")..DBankConfig.Currency)
				net.Send(_ent:GetNWEntity("DBank:Owner"))	
			else
				net.Start("DBank::Notification")
				    net.WriteString(DBankConfig.Language21)
				net.Send(ply)
			end

		end
	end

end)