BasePanel:Sub("UIRolePanel")

local _cacheType = 
{
   BtnClose = "BtnClose",
   BtnUpLevel = "BtnUpLevel",
}

function UIRolePanel:InitPanel()
    self:AddBtnEvent(_cacheType.BtnClose,function() self:ClickCloseBtn() end)
    self:AddBtnEvent(_cacheType.BtnUpLevel,function() self:ClickUpLevelBtn() end)
end

function UIRolePanel:Start()
    print("UIRolePanel OnEnable")
end

function UIRolePanel:OnDisable()
    print("UIRolePanel OnDisable")
end

function UIRolePanel:ClickUpLevelBtn()
end

function UIRolePanel:refreshUI(data)

end

function UIRolePanel:ClickCloseBtn()
    UIManager.GetSingleton():ClosePanel(UIStyle.Role)
end