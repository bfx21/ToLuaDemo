BasePanel:sub("UIMainPanel")

CacheType =
{
   RoleBtn = "RoteBtn" ,
}

function UIMainPanel:OnEnable()
    self:AddBtnEvent(CacheType.RoleBtn,function() self:ClickRoleBtn() end)
end

function UIMainPanel:Open()
end

function UIMainPanel:RefreshUI(data)
    
end

function UIMainPanel:ClickRoleBtn()

end


