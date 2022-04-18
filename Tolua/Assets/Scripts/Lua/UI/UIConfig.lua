UIStyle = {
   Main = 1,
   Role = 2, 

}

UIConfig = 
{
[UIStyle.Main] = {id = UIStyle.Main, uiClass = UIMainPanel, path = "UI/MainPanel", async = false , cache = false, layer = "Mid"},
[UIStyle.Role] = {id = UIStyle.Role, uiClass = UIRolePanel, path = "UI/RolePanel", async = false , cache = false, layer = "Top"},

}