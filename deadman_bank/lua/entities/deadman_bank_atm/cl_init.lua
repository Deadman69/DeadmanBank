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

local function OpenATMMenu(playerCode)
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
	TextMain:SetText(DBankConfig.Language22)
	TextMain:SetColor(colorText)
	TextMain:SizeToContents()
	TextMain:CenterHorizontal()
	TextMain:CenterVertical(0.3)

	local TextEntryOne = vgui.Create( "DTextEntry", Main )
	TextEntryOne:SetPos( ScrW()/6, ScrH()/4 )
	TextEntryOne:SetSize( ScrW()/7, ScrH()/27 )
	TextEntryOne:SetPlaceholderText( "1234" )
	TextEntryOne:CenterHorizontal()
	TextEntryOne:CenterVertical(0.45)

	local Validate = vgui.Create("DButton", Main)
	Validate:SetText("")
	Validate:SetPos(ScrW()/1.88, ScrH()/100)
	Validate:SetSize(ScrW()/8, ScrH()/25)
	Validate:SetColor(Color(0,0,255))
	Validate.DoClick = function()
		if isnumber( TextEntryOne:GetValue() ) then
			local value1 = tonumber(TextEntryOne:GetValue())
			net.Start("DBank::CheckCode")
				net.WriteInt(value1, 32)
			net.SendToServer()
			Main:Remove()
			surface.PlaySound( "buttons/button15.wav" )
		end
	end
	Validate.Paint = function(self, w, h)
	    draw.RoundedBox(0, 0, 0, w, h, colorHeader)
	    draw.SimpleText(DBankConfig.Validate, "OpenSans_DBank_Big", w / 2, h / 2, colorText, 1, 1)
	end
	Validate:CenterHorizontal()
	Validate:CenterVertical(0.75)
end




local function OpenFirstMenu()
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
	TextMain:SetText(DBankConfig.Language4)
	TextMain:SetColor(colorText)
	TextMain:SizeToContents()
	TextMain:CenterHorizontal(0.5)
	TextMain:CenterVertical(0.3)

	local TextEntryOne = vgui.Create( "DTextEntry", Main )
	TextEntryOne:SetPos( 10,10 )
	TextEntryOne:SetSize( ScrW()/7, ScrH()/27 )
	TextEntryOne:SetPlaceholderText( "1234" )
	TextEntryOne:CenterHorizontal(0.5)
	TextEntryOne:CenterVertical(0.45)

	local TextEntryTwo = vgui.Create( "DTextEntry", Main )
	TextEntryTwo:SetPos( 10,10 )
	TextEntryTwo:SetSize( ScrW()/7, ScrH()/27 )
	TextEntryTwo:SetPlaceholderText( DBankConfig.Language5 )
	TextEntryTwo:CenterHorizontal(0.5)
	TextEntryTwo:CenterVertical(0.55)


	local Validate = vgui.Create("DButton", Main)
	Validate:SetText("")
	Validate:SetPos(ScrW()/1.88, ScrH()/100)
	Validate:SetSize(ScrW()/8, ScrH()/25)
	Validate:SetColor(Color(0,0,255))
	Validate.DoClick = function()
		if isnumber( TextEntryOne:GetValue() ) and isnumber(TextEntryTwo:GetValue()) then
			local value1, value2 = tonumber(TextEntryOne:GetValue()), tonumber(TextEntryTwo:GetValue())
			if value1 == value2 then
				net.Start("DBank::CreateCode")
					net.WriteInt(value1, 32)
				net.SendToServer()
				notification.AddLegacy( DBankConfig.Language2..value1, NOTIFY_UNDO, 4  )
				Main:Remove()
			else
				notification.AddLegacy( DBankConfig.Language3, NOTIFY_UNDO, 4  )
			end
			surface.PlaySound( "buttons/button15.wav" )
		end
	end
	Validate.Paint = function(self, w, h)
	    draw.RoundedBox(0, 0, 0, w, h, colorHeader)
	    draw.SimpleText(DBankConfig.Validate, "OpenSans_DBank_Big", w / 2, h / 2, colorText, 1, 1)
	end
	Validate:CenterHorizontal()
	Validate:CenterVertical(0.75)
end




local function OperationMenu(playerBalanceHUD, operationType)
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

	local TextHeaderBalance = vgui.Create("DLabel", Main)
	TextHeaderBalance:SetPos(10,10)
	TextHeaderBalance:SetFont("OpenSans_DBank")
	TextHeaderBalance:SetText(DBankConfig.Language6..tonumber(playerBalanceHUD)..DBankConfig.Currency)
	TextHeaderBalance:SetColor(colorText)
	TextHeaderBalance:SizeToContents()
	TextHeaderBalance:CenterHorizontal(0.8)
	TextHeaderBalance:CenterVertical(0.08)

	local _operationString
	if operationType == "withdraw" then
		_operationString = DBankConfig.Withdrawal
	else
		_operationString = DBankConfig.Deposit
	end


	local TextMain = vgui.Create("DLabel", Main)
	TextMain:SetPos(10,10)
	TextMain:SetFont("OpenSans_DBank")
	TextMain:SetText(DBankConfig.Language7.._operationString)
	TextMain:SetColor(colorText)
	TextMain:SizeToContents()
	TextMain:CenterHorizontal()
	TextMain:CenterVertical(0.3)

	local TextEntryOne = vgui.Create( "DTextEntry", Main )
	TextEntryOne:SetPos( 10,10 )
	TextEntryOne:SetSize( ScrW()/7, ScrH()/27 )
	TextEntryOne:SetPlaceholderText( "5000" )
	TextEntryOne:CenterHorizontal(0.5)
	TextEntryOne:CenterVertical(0.45)

	local Validate = vgui.Create("DButton", Main)
	Validate:SetText("")
	Validate:SetPos(ScrW()/1.88, ScrH()/100)
	Validate:SetSize(ScrW()/8, ScrH()/25)
	Validate:SetColor(Color(0,0,255))
	Validate.DoClick = function()
		if isnumber( TextEntryOne:GetValue() ) then
			local value1 = tonumber(TextEntryOne:GetValue())
			net.Start("DBank::Transaction")
				net.WriteString(operationType)
				net.WriteInt(value1, 32)
			net.SendToServer()

			Main:Remove()
			surface.PlaySound( "buttons/button15.wav" )
		end
	end
	Validate.Paint = function(self, w, h)
	    draw.RoundedBox(0, 0, 0, w, h, colorHeader)
	    draw.SimpleText(DBankConfig.Validate, "OpenSans_DBank_Big", w / 2, h / 2, colorText, 1, 1)
	end
	Validate:CenterHorizontal()
	Validate:CenterVertical(0.75)


	local Return = vgui.Create("DButton", Main)
	Return:SetText("")
	Return:SetPos(ScrW()/1.88, ScrH()/100)
	Return:SetSize(ScrW()/10, ScrH()/25)
	Return:SetColor(Color(0,0,255))
	Return.DoClick = function()
		Main:Remove()
		OpenMainMenu(playerBalanceHUD)
		surface.PlaySound( "buttons/button15.wav" )
	end
	Return.Paint = function(self, w, h)
	    draw.RoundedBox(0, 0, 0, w, h, colorHeader)
	    draw.SimpleText(DBankConfig.Return, "OpenSans_DBank", w / 2, h / 2, colorText, 1, 1)
	end
	Return:CenterHorizontal(0.1)
	Return:CenterVertical(0.95)
end





function OpenMainMenu(playerBalance)
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

	local TextHeaderBalance = vgui.Create("DLabel", Main)
	TextHeaderBalance:SetPos(10,10)
	TextHeaderBalance:SetFont("OpenSans_DBank")
	TextHeaderBalance:SetText(DBankConfig.Language6..playerBalance..DBankConfig.Currency)
	TextHeaderBalance:SetColor(colorText)
	TextHeaderBalance:SizeToContents()
	TextHeaderBalance:CenterHorizontal(0.8)
	TextHeaderBalance:CenterVertical(0.08)

	local TextMain = vgui.Create("DLabel", Main)
	TextMain:SetPos(10,10)
	TextMain:SetFont("OpenSans_DBank")
	TextMain:SetText(DBankConfig.Language8)
	TextMain:SetColor(colorText)
	TextMain:SizeToContents()
	TextMain:CenterHorizontal()
	TextMain:CenterVertical(0.3)

	local Withdrawal = vgui.Create("DButton", Main)
	Withdrawal:SetText("")
	Withdrawal:SetPos(ScrW()/1.88, ScrH()/100)
	Withdrawal:SetSize(ScrW()/8, ScrH()/25)
	Withdrawal:SetColor(Color(0,0,255))
	Withdrawal.DoClick = function()
		OperationMenu(playerBalance, "withdraw")

		Main:Remove()
		surface.PlaySound( "buttons/button15.wav" )
	end
	Withdrawal.Paint = function(self, w, h)
	    draw.RoundedBox(0, 0, 0, w, h, colorHeader)
	    draw.SimpleText(DBankConfig.Withdrawal, "OpenSans_DBank", w / 2, h / 2, colorText, 1, 1)
	end
	Withdrawal:CenterHorizontal()
	Withdrawal:CenterVertical(0.55)

	local Deposit = vgui.Create("DButton", Main)
	Deposit:SetText("")
	Deposit:SetPos(ScrW()/1.88, ScrH()/100)
	Deposit:SetSize(ScrW()/8, ScrH()/25)
	Deposit:SetColor(Color(0,0,255))
	Deposit.DoClick = function()
		OperationMenu(playerBalance, "deposit")

		Main:Remove()
		surface.PlaySound( "buttons/button15.wav" )
	end
	Deposit.Paint = function(self, w, h)
	    draw.RoundedBox(0, 0, 0, w, h, colorHeader)
	    draw.SimpleText(DBankConfig.Deposit, "OpenSans_DBank", w / 2, h / 2, colorText, 1, 1)
	end
	Deposit:CenterHorizontal()
	Deposit:CenterVertical(0.75)

	local Logout = vgui.Create("DButton", Main)
	Logout:SetText("")
	Logout:SetPos(ScrW()/1.88, ScrH()/100)
	Logout:SetSize(ScrW()/10, ScrH()/25)
	Logout:SetColor(Color(0,0,255))
	Logout.DoClick = function()
		Main:Remove()
		surface.PlaySound( "buttons/button15.wav" )
	end
	Logout.Paint = function(self, w, h)
	    draw.RoundedBox(0, 0, 0, w, h, colorHeader)
	    draw.SimpleText(DBankConfig.Logout, "OpenSans_DBank", w / 2, h / 2, colorText, 1, 1)
	end
	Logout:CenterHorizontal(0.1)
	Logout:CenterVertical(0.95)
end









net.Receive("DBank::OpenATMMenu", function()
	local playerCode = net.ReadInt(32)
	if playerCode == 888888 then
		OpenFirstMenu()
	else
		OpenATMMenu(playerCode)	
	end
end)


net.Receive("DBank::Transaction", function()
	local playerBalance = net.ReadInt(32)
	OpenMainMenu(playerBalance)
end)


net.Receive("DBank::Notification", function()
	local _string = net.ReadString()
	notification.AddLegacy( _string, NOTIFY_UNDO, 4  )
	surface.PlaySound( "buttons/button15.wav" )
end)