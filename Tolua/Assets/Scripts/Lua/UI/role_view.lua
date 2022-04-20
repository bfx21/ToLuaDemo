BaseView:Sub("RoleView")

local _cacheType = 
{
   btn_close = "btnClose",
   btn_up_level = "btnUpLevel",
   txt_level = "txtLev",
   txt_hp = "txtHp",
   txt_attack = "txtAtk",
   txt_defence = "txtDef",
   txt_crit = "txtCrit",
   txt_miss = "txtMiss",
   txt_luck = "txtLuck",
}

function RoleView:InitPanel()
    self:AddBtnEvent(_cacheType.btn_close,function() self:ClickCloseBtn() end)
    self:AddBtnEvent(_cacheType.btn_up_level,function() self:ClickUpLevelBtn() end)
end

function RoleView:Start()
    print("RoleView Start")
end

function RoleView:OnEnable()
    print("RoleView OnEnable")
end

function RoleView:OnDisable()
    print("RoleView OnDisable")
end

function RoleView:Open()
    self.refresh_ui = function(data) self:refreshUI(data) end
    EventCenter.AddListener(EventType.ROLE_UP_LEVEL,self.refresh_ui)

    PlayerData.RefreshData()
end

function RoleView:Close()
    EventCenter.RemoveListener(EventType.ROLE_UP_LEVEL,self.refresh_ui)
end

function RoleView:ClickUpLevelBtn()
    PlayerData.LevelUp()
end

function RoleView:refreshUI(data)
    self:SetText(_cacheType.txt_attack,data.attack)
    self:SetText(_cacheType.txt_hp,data.hp)
    self:SetText(_cacheType.txt_defence,data.defence)
    self:SetText(_cacheType.txt_crit,data.crit)
    self:SetText(_cacheType.txt_miss,data.miss)
    self:SetText(_cacheType.txt_luck,data.luck)

    local level_str = table.concat({[1] = "Lv.",[2] = data.level})
    self:SetText(_cacheType.txt_level,level_str)
end

function RoleView:ClickCloseBtn()
    UIManager.GetSingleton():CloseView(UIStyle.ROLE)
end