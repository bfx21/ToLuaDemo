BasePanel:Sub("UIMainPanel")

local _cacheType =
{
   BtnRole = "BtnRole" ,
   TxtName = "TxtName",
   TxtLev = "TxtLev",
   TxtDiamond = "TxtDiamond",
   TxtGold = "TxtGold",
   TxtPower = "TxtPower",
}

function UIMainPanel:InitPanel()
    self:AddBtnEvent(_cacheType.BtnRole,function() self:ClickRoleBtn() end)
end

function UIMainPanel:Start()
    print("UIMainPanel Start")
end

function UIMainPanel:Open()
    self:refreshUI(PlayerData)
end

function UIMainPanel:refreshUI(data)
    self:SetText(_cacheType.TxtDiamond,data.diamond)
    self:SetText(_cacheType.TxtGold,data.gold)
    self:SetText(_cacheType.TxtName,data.name)
    self:SetText(_cacheType.TxtPower,data.power)
end


function UIMainPanel:ClickRoleBtn()
    UIManager.GetSingleton():OpenPanel(UIStyle.Role)
end


