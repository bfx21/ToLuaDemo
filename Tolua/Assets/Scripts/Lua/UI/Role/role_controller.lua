RoleController = Class(Singleton) or {}

function RoleController:__init()
    self.module = PlayerModule:GetInstance()
    self:initEvent()
end

function RoleController:initEvent()
    local function opRoleView()
        UIManager.GetInstance():OpenView(UIStyle.ROLE)
        self.module:RefreshView()
    end
    
    self.module:Bind(PlayerModule.EventType.OPEN_ROLE_VIEW,opRoleView)

    local function closeRoleView()
        UIManager.GetInstance():CloseView(UIStyle.ROLE)
    end

    self.module:Bind(PlayerModule.EventType.CLOSE_ROLE_VIEW,closeRoleView)
end