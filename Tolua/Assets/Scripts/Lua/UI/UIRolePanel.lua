BasePanel:Sub("UIRolePanel")

local _cacheType = 
{
   BtnClose = "BtnClose",
}

function UIRolePanel:InitPanel()
    self:AddBtnEvent(_cacheType.BtnClose,function() self:ClickCloseBtn() end)
end

function UIRolePanel:ClickCloseBtn()
    UIManager.GetSingleton():ClosePanel(UIStyle.Role)
end