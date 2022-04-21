Singleton:Sub("MainController")

function MainController:_init()
    self.module = PlayerModule:GetInstance()
    
    local function opMainView()
        UIManager.GetSingleton():OpenView(UIStyle.MAIN)
        self.module:RefreshView()
    end
    
    self.module:Bind(PlayerModule.EventType.OPEN_MAIN_VIEW,opMainView)
end