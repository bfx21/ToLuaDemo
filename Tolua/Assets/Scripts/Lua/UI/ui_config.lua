UIStyle = {
   MAIN = 1,
   ROLE = 2, 

}

UIConfig = 
{
[UIStyle.MAIN] = {id = UIStyle.MAIN, ui_class = MainView, path = "UI/MainView", async = false , cache = false, layer = "Mid"},
[UIStyle.ROLE] = {id = UIStyle.ROLE, ui_class = RoleView, path = "UI/RoleView", async = false , cache = false, layer = "Top"},

}