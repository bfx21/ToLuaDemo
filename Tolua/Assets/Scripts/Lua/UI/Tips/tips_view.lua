--制作一个游戏的提示信息功能
BaseView:Sub("TipsView")

local _cacheType = 
{
   Txt_TIPS = "TxtTips"
}

function TipsView:InitPanel()
    self.tips_prefab = Resources.Load("UI/TipsItem")
    self.queue = Queue.New()
end

function TipsView:Update()
   if not self.queue:IsEmpty()then
      self:_createTips(self.queue:DeQueue())
   end
end

function TipsView:Show(txt)
   self.queue:EnQueue(txt) 
end

function TipsView:_createTips(txt)
    local prefab = GameObject.Instantiate(self.tips_prefab)
    local text = Tools.FindChildComponent(prefab.transform,_cacheType.Txt_TIPS,typeof(Text))
    text.text = txt

    local item_tran = prefab.transform
    item_tran:SetParent(self.transform,false)
    item_tran.localPosition = Vector3.zero
    item_tran.localScale = Vector3.one
    local animation = prefab:GetComponent(typeof(Animation))
    animation:Play()
    
    local delay_func = function(tips_prefab)  
        coroutine.wait(1)
        GameObject.Destroy(tips_prefab)
    end

    coroutine.start(delay_func,prefab)
end