UIStyle = {
   Main = 1,
   Role = 2, 

}

UIConfig = 
{
[UIStyle.Main] = {id = UIStyle.Main, ui_class = MainView, path = "UI/MainView", async = false , cache = false, layer = "Mid"},
[UIStyle.Role] = {id = UIStyle.Role, ui_class = RoleView, path = "UI/RoleView", async = false , cache = false, layer = "Top"},

}