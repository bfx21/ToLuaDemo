MainController = Class(Singleton) or {}

function MainController:__init()
    self.module = PlayerModule:GetInstance()
    
    local function opMainView()
        UIManager.GetInstance():OpenView(UIStyle.MAIN)
        self.module:RefreshView()
    end
    
    self.module:Bind(PlayerModule.EventType.OPEN_MAIN_VIEW,opMainView)
end