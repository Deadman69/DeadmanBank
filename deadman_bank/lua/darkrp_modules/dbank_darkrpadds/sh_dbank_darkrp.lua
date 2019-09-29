DarkRP.createCategory{
    name = "Bank",
    categorises = "entities",
    startExpanded = true,
    color = Color(255, 150, 150, 255),
    canSee = function(ply) return true end,
    sortOrder = 100
}

DarkRP.createEntity("Terminal", {
    ent = "deadman_bank_terminal",
    model = "models/props_c17/consolebox03a.mdl",
    price = 250,
    max = 1,
    cmd = "buydbankterminal",
    category = "Bank"
})