UIStyle = {
   MAIN = 1,
   ROLE = 2, 
   TIPS = 3,
}

local UIConfig = 
{
[UIStyle.MAIN] = {id = UIStyle.MAIN, ui_class = require("UI/Main/main_view"), path = "UI/MainView", async = false , cache = false, layer = "Mid"},
[UIStyle.ROLE] = {id = UIStyle.ROLE, ui_class = require("UI/Role/role_view"), path = "UI/RoleView", async = false , cache = false, layer = "Top"},
[UIStyle.TIPS] = {id = UIStyle.TIPS, ui_class = require("UI/Tips/tips_view"), path = "UI/TipsView", async = false , cache = false, layer = "Top"},
}

return UIConfig