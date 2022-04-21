Singleton:Sub("RoleController")

function RoleController:_init()
    self.module = PlayerModule:GetInstance()
    self:initEvent()
end

function RoleController:initEvent()
    local function opRoleView()
        UIManager.GetSingleton():OpenView(UIStyle.ROLE)
        self.module:RefreshView()
    end
    
    self.module:Bind(PlayerModule.EventType.OPEN_ROLE_VIEW,opRoleView)

    local function closeRoleView()
        UIManager.GetSingleton():CloseView(UIStyle.ROLE)
    end

    self.module:Bind(PlayerModule.EventType.CLOSE_ROLE_VIEW,closeRoleView)
end