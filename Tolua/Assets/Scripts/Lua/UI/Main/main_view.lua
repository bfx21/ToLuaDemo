BaseView:Sub("MainView")

local _cacheType =
{
   btn_test = "BtnTest",
   btn_role = "BtnRole" ,
   txt_name = "TxtName",
   txt_lev = "TxtLev",
   txt_diamond = "TxtDiamond",
   txt_gold = "TxtGold",
   txt_power = "TxtPower",
}

function MainView:InitPanel()
    self:AddBtnEvent(_cacheType.btn_role,function() self:ClickRoleBtn() end)
    self:AddBtnEvent(_cacheType.btn_test,function() self:ClickTestBtn() end)
end

function MainView:Start()
    print("MainView Start")
end

function MainView:Open()
    self.refresh_ui = function(data) self:refreshUI(data) end
    EventManager:GetInstance():AddListener(EventType.ROLE_UP_LEVEL,self.refresh_ui)

    PlayerModule:GetInstance():RefreshData()
end

function MainView:Close()
    EventManager:GetInstance():RemoveListener(EventType.ROLE_UP_LEVEL,self.refresh_ui)
end

function MainView:refreshUI(data)
    self:SetText(_cacheType.txt_diamond,data.diamond)
    self:SetText(_cacheType.txt_gold,data.gold)
    self:SetText(_cacheType.txt_name,data.name)
    self:SetText(_cacheType.txt_power,data.power)
end

function MainView:ClickRoleBtn()
    UIManager.GetSingleton():OpenView(UIStyle.ROLE)
end

--测试Tips功能
function MainView:ClickTestBtn()
    UIManager.GetSingleton():OpenView(UIStyle.TIPS,function(view) 
       view:Show("测试游戏提示信息功能")
    end)
end

