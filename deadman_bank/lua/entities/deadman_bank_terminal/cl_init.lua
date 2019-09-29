AddCSLuaFile("deadman_bank_config.lua")
include("deadman_bank_config.lua")

include("shared.lua")

function ENT:Draw()

	self:DrawModel()

end 

local colorText = DBankConfig.ColorText
local colorMain = DBankConfig.ColorMainBackground
local colorHeader = DBankConfig.ColorMainHeader
local colorButtonInfo = DBankConfig.ColorInfoButton
local colorHeaderBar = DBankConfig.ColorHeaderBar

surface.CreateFont("OpenSans_DBank", {
	    font = "TargetID",
	    size = ScrH()*0.025,
	    weight = 1000
})

surface.CreateFont("OpenSans_DBank_Big", {
	    font = "TargetID",
	    size = ScrH()*0.035,
	    weight = 1000
})

local function OpenPanelOwner(terminalEntity)
	local Main = vgui.Create("DFrame")
	Main:SetSize(ScrW()/1.8, ScrH()/2)
	Main:Center()
	Main:SetTitle("")
	Main:MakePopup()
	Main:ShowCloseButton(false)
	Main:SetDraggable(false)
	Main.Paint = function(self, w, h)
	    draw.RoundedBox(6, 0, 0, w, h, colorMain) -- Main panel
	    draw.RoundedBox(6, 0, 0, w, h/8, colorHeader) -- Main panel color
	    draw.RoundedBox(0, w/10000, h/8, w, h/530, colorHeaderBar) -- red bar header

	    draw.RoundedBox(0, w/2.57, h/3, w/4.4, h/180, colorText) -- Underline How it works
	end

	local CloseButton = vgui.Create("DButton", Main)
	CloseButton:SetText("")
	CloseButton:SetPos(ScrW()/1.88, ScrH()/100)
	CloseButton:SetSize(ScrW()/40, ScrH()/25)
	CloseButton:SetColor(Color(0,0,255))
	CloseButton.DoClick = function()
		Main:Remove()
		surface.PlaySound( "buttons/button15.wav" )
	end
	CloseButton.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	    draw.SimpleText("X", "OpenSans_DBank_Big", w / 2, h / 2, colorText, 1, 1)
	end
	CloseButton:CenterHorizontal(0.98)
	CloseButton:CenterVertical(0.08)

	local TextHeader = vgui.Create("DLabel", Main)
	TextHeader:SetPos(10,10)
	TextHeader:SetFont("OpenSans_DBank_Big")
	TextHeader:SetText(DBankConfig.Company)
	TextHeader:SetColor(colorText)
	TextHeader:SizeToContents()
	TextHeader:CenterHorizontal(0.22)
	TextHeader:CenterVertical(0.08)

	local TextMain = vgui.Create("DLabel", Main)
	TextMain:SetPos(10,10)
	TextMain:SetFont("OpenSans_DBank")
	TextMain:SetText(DBankConfig.Language16)
	TextMain:SetColor(colorText)
	TextMain:SizeToContents()
	TextMain:CenterHorizontal()
	TextMain:CenterVertical(0.3)

	local TextEntryOne = vgui.Create( "DTextEntry", Main )
	TextEntryOne:SetPos( ScrW()/6, ScrH()/4 )
	TextEntryOne:SetSize( ScrW()/7, ScrH()/27 )
	TextEntryOne:SetPlaceholderText( "6000$" )
	TextEntryOne:CenterHorizontal()
	TextEntryOne:CenterVertical(0.45)

	local Validate = vgui.Create("DButton", Main)
	Validate:SetText("")
	Validate:SetPos(ScrW()/1.88, ScrH()/100)
	Validate:SetSize(ScrW()/8, ScrH()/25)
	Validate:SetColor(Color(0,0,255))
	Validate.DoClick = function()
		local value1 = tonumber(TextEntryOne:GetValue())
		if value1 == nil or value1 == 0 then return end
		net.Start("DBank::TerminalDefine")
			net.WriteInt(value1, 32)
			net.WriteEntity(terminalEntity)
		net.SendToServer()
		Main:Remove()
		surface.PlaySound( "buttons/button15.wav" )
	end
	Validate.Paint = function(self, w, h)
	    draw.RoundedBox(0, 0, 0, w, h, colorHeader)
	    draw.SimpleText(DBankConfig.Validate, "OpenSans_DBank_Big", w / 2, h / 2, colorText, 1, 1)
	end
	Validate:CenterHorizontal()
	Validate:CenterVertical(0.75)
end


local function OpenPanelClient(amountToPay, terminalEntity)
	local Main = vgui.Create("DFrame")
	Main:SetSize(ScrW()/1.8, ScrH()/2)
	Main:Center()
	Main:SetTitle("")
	Main:MakePopup()
	Main:ShowCloseButton(false)
	Main:SetDraggable(false)
	Main.Paint = function(self, w, h)
	    draw.RoundedBox(6, 0, 0, w, h, colorMain) -- Main panel
	    draw.RoundedBox(6, 0, 0, w, h/8, colorHeader) -- Main panel color
	    draw.RoundedBox(0, w/10000, h/8, w, h/530, colorHeaderBar) -- red bar header

	    draw.RoundedBox(0, w/2.57, h/3, w/4.4, h/180, colorText) -- Underline How it works
	end

	local CloseButton = vgui.Create("DButton", Main)
	CloseButton:SetText("")
	CloseButton:SetPos(ScrW()/1.88, ScrH()/100)
	CloseButton:SetSize(ScrW()/40, ScrH()/25)
	CloseButton:SetColor(Color(0,0,255))
	CloseButton.DoClick = function()
		Main:Remove()
		surface.PlaySound( "buttons/button15.wav" )
	end
	CloseButton.Paint = function(self, w, h)
	    draw.RoundedBox(26, 0, 0, w, h, colorHeader)
	    draw.SimpleText("X", "OpenSans_DBank_Big", w / 2, h / 2, colorText, 1, 1)
	end
	CloseButton:CenterHorizontal(0.98)
	CloseButton:CenterVertical(0.08)

	local TextHeader = vgui.Create("DLabel", Main)
	TextHeader:SetPos(10,10)
	TextHeader:SetFont("OpenSans_DBank_Big")
	TextHeader:SetText(DBankConfig.Company)
	TextHeader:SetColor(colorText)
	TextHeader:SizeToContents()
	TextHeader:CenterHorizontal(0.22)
	TextHeader:CenterVertical(0.08)

	local TextMain = vgui.Create("DLabel", Main)
	TextMain:SetPos(10,10)
	TextMain:SetFont("OpenSans_DBank")
	TextMain:SetText(DBankConfig.Language17..terminalEntity:GetNWInt("DBank:Terminal:Amount")..DBankConfig.Currency)
	TextMain:SetColor(colorText)
	TextMain:SizeToContents()
	TextMain:CenterHorizontal()
	TextMain:CenterVertical(0.3)

	local Validate = vgui.Create("DButton", Main)
	Validate:SetText("")
	Validate:SetPos(ScrW()/1.88, ScrH()/100)
	Validate:SetSize(ScrW()/8, ScrH()/25)
	Validate:SetColor(Color(0,0,255))
	Validate.DoClick = function()
		net.Start("DBank::Terminal")
			net.WriteEntity(terminalEntity)
		net.SendToServer()
		Main:Remove()
		surface.PlaySound( "buttons/button15.wav" )
	end
	Validate.Paint = function(self, w, h)
	    draw.RoundedBox(0, 0, 0, w, h, colorHeader)
	    draw.SimpleText(DBankConfig.Validate, "OpenSans_DBank_Big", w / 2, h / 2, colorText, 1, 1)
	end
	Validate:CenterHorizontal(0.35)
	Validate:CenterVertical(0.75)

	local Decline = vgui.Create("DButton", Main)
	Decline:SetText("")
	Decline:SetPos(ScrW()/1.88, ScrH()/100)
	Decline:SetSize(ScrW()/8, ScrH()/25)
	Decline:SetColor(Color(0,0,255))
	Decline.DoClick = function()
		Main:Remove()
		surface.PlaySound( "buttons/button15.wav" )
	end
	Decline.Paint = function(self, w, h)
	    draw.RoundedBox(0, 0, 0, w, h, colorHeader)
	    draw.SimpleText(DBankConfig.Decline, "OpenSans_DBank_Big", w / 2, h / 2, colorText, 1, 1)
	end
	Decline:CenterHorizontal(0.65)
	Decline:CenterVertical(0.75)
end





net.Receive("DBank::Terminal", function()
	local _string = net.ReadString()
	local termEntity = net.ReadEntity()
	if _string == "isOwner" then
		OpenPanelOwner(termEntity)
	elseif _string == "isClient" then
		OpenPanelClient(net.ReadInt(32), termEntity)
	end
end)