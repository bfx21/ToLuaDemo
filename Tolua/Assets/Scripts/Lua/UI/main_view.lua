BaseView:Sub("MainView")

local _cacheType =
{
   BtnRole = "BtnRole" ,
   TxtName = "TxtName",
   TxtLev = "TxtLev",
   TxtDiamond = "TxtDiamond",
   TxtGold = "TxtGold",
   TxtPower = "TxtPower",
}

function MainView:InitPanel()
    self:AddBtnEvent(_cacheType.BtnRole,function() self:ClickRoleBtn() end)
end

function MainView:Start()
    print("MainView Start")
end

function MainView:Open()
    self.refresh_ui = function(data) self:refreshUI(data) end
    EventCenter.AddListener(EventType.ROLE_UP_LEVEL,self.refresh_ui)

    PlayerData.RefreshData()
end

function MainView:Close()
    EventCenter.RemoveListener(EventType.ROLE_UP_LEVEL,self.refresh_ui)
end

function MainView:refreshUI(data)
    self:SetText(_cacheType.TxtDiamond,data.diamond)
    self:SetText(_cacheType.TxtGold,data.gold)
    self:SetText(_cacheType.TxtName,data.name)
    self:SetText(_cacheType.TxtPower,data.power)
end


function MainView:ClickRoleBtn()
    UIManager.GetSingleton():OpenView(UIStyle.Role)
end


