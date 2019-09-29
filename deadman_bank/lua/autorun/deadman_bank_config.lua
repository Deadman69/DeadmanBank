DBankConfig = {}

DBankConfig.ATMModel = "models/props/cs_assault/ticketmachine.mdl" -- Model of the ATM
DBankConfig.TerminalModel = "models/props_c17/consolebox03a.mdl" -- Model of the Terminal

DBankConfig.CommandAdmin = "!adminbank" -- Command to use:   "!adminbank <STEAMID/STEAMID64> reset" --> Will reset the player's bank code
														  -- "!adminbank <STEAMID/STEAMID64> 2563" --> Will set a new code for the player
DBankConfig.AllowedUsergroups = { -- ULX Groups allowed to use the Admin command
	["superadmin"] = true,
	["admin"] = true,
	["moderator"] = true,
}


DBankConfig.VIPUsergroups = { -- ULX Groups that is considered as VIP
	["superadmin"] = true,
	["admin"] = true,
	["moderator"] = true,
	["donator"] = true,
	["vip"] = true,
}


DBankConfig.MustHaveCC = true -- The player must have the credit card in hands when using the ATM ?
DBankConfig.DefaultAmount = 500 -- The money player will have on his account when first connecting

DBankConfig.InterestTime = 600 -- The time (in seconds) when Interest come in your account, set to "nil" if you don't want to use it
	DBankConfig.Interest = 0.005 -- Amount player will earn every Interest Time (based on player Balance)
	DBankConfig.VIPInterest = 0.008 -- Same but for VIP players (you can set the same amount as normal players)
		-- Formule is:   playerBalance + (playerBalance * DBankConfig.Interest)
	DBankConfig.AdvertPlayers = true -- Should we advert player the have got interest ?




-- Dark Theme

DBankConfig.ColorText = Color(209, 216, 224) -- Color for all the texts
DBankConfig.ColorMainBackground = Color(30, 55, 153) -- Color for the background
DBankConfig.ColorMainHeader = Color(12, 36, 97) -- Color for the header background
DBankConfig.ColorInfoButton = Color(135,206,250) -- Color for the Info Button
DBankConfig.ColorHeaderBar = Color(235, 47, 6) -- Color for the litle line in the header

--[[  Light Theme
DDirtyMoney.ColorJobText = Color(0, 0, 0) -- Color for all the texts
DDirtyMoney.ColorJobMainBackground = Color(255, 255, 240) -- Color for the background
DDirtyMoney.ColorJobMainHeader = Color(245, 245, 220) -- Color for the header background
DDirtyMoney.ColorJobInfoButton = Color(135,206,250) -- Color for the Info Button
DDirtyMoney.ColorJobHeaderBar = Color(255, 0, 0) -- Color for the litle line in the header
--]]







DBankConfig.Currency =   "$"
DBankConfig.Validate =   "Validate"
DBankConfig.Decline =    "Decline"
DBankConfig.Withdrawal = "Withdrawal"
DBankConfig.Deposit =    "Deposit"
DBankConfig.Return =	 "Return"
DBankConfig.Logout =     "Logout"
DBankConfig.Company =    "Bahamas Worldwide Company"
DBankConfig.Language1 =  "You have received your interest: "
DBankConfig.Language2 =  "You have succesfully create your code for: "
DBankConfig.Language3 =  "The code don't match !"
DBankConfig.Language4 =  "Please create below your personnal Code"
DBankConfig.Language5 =  "Validate your code"
DBankConfig.Language6 =  "Balance account: "
DBankConfig.Language7 =  "Please enter an amount to "
DBankConfig.Language8 =  "Please choose an operation"
DBankConfig.Language9 =  "You must have your credit card !"
DBankConfig.Language10 = "Your code is wrong !"
DBankConfig.Language11 = "You don't have enough money on you !"
DBankConfig.Language12 = "You have succesfully deposit "
DBankConfig.Language13 = " to your account !"
DBankConfig.Language14 = "You don't have enough money on your account !"
DBankConfig.Language15 = "You have succesfully withdraw "
DBankConfig.Language16 = "Please enter the amount you want the buyer pay"
DBankConfig.Language17 = "Do you want to pay"
DBankConfig.Language18 = "You are now the owner of this terminal !"
DBankConfig.Language19 = "You have send "
DBankConfig.Language20 = "You have received "
DBankConfig.Language21 = "You don't have enough money to pay !"
DBankConfig.Language22 = "Please enter your personnal code"



--[[  FRENCH VERSION

DBankConfig.Currency =   "€"
DBankConfig.Validate =   "Valider"
DBankConfig.Decline =    "Decliner"
DBankConfig.Withdrawal = "Retirer"
DBankConfig.Deposit =    "Déposer"
DBankConfig.Return =	 "Retour"
DBankConfig.Logout = 	 "Déconnexion"
DBankConfig.Company =    "Bahamas Worldwide Company"
DBankConfig.Language1 =  "Vous avez reçu vos intérêts: "
DBankConfig.Language2 =  "Votre code est: "
DBankConfig.Language3 =  "Le code ne correspond pas !"
DBankConfig.Language4 =  "Créer ci-dessous votre code personnel"
DBankConfig.Language5 =  "Valider votre code"
DBankConfig.Language6 =  "Solde: "
DBankConfig.Language7 =  "Entrez un montant à "
DBankConfig.Language8 =  "Choissisez une opération"
DBankConfig.Language9 =  "Vous devez avoir votre carte de crédit en main !"
DBankConfig.Language10 = "Votre code est faux !"
DBankConfig.Language11 = "Vous n'avez pas assez d'argent sur vous !"
DBankConfig.Language12 = "Vous avez déposer "
DBankConfig.Language13 = " sur votre compte !"
DBankConfig.Language14 = "You n'avez pas assez d'argent sur votre compte !"
DBankConfig.Language15 = "Vous avez retirer "
DBankConfig.Language16 = "Entrer un montant que l'acheteur payera"
DBankConfig.Language17 = "Voulez vous payer "
DBankConfig.Language18 = "Vous êtes désormais le propriétaire de ce terminal !"
DBankConfig.Language19 = "Vous avez envoyer "
DBankConfig.Language20 = "Vous avez reçu "
DBankConfig.Language21 = "Vous n'avez pas assez d'argent pour payer !"
DBankConfig.Language22 = "Entrez votre code personnel"
--]]