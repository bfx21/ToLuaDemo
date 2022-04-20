Singleton:Class("UIManager")

function UIManager:InitManager()
    local canvas = ResourcesManager.Instance:Load("UI/Canvas",typeof(GameObject))
    ResourcesManager.Instance:Load("UI/EventSystem",typeof(GameObject))
    self.canvas = canvas.transform

    local bot = Tools.FindChildObject(self.canvas,"Bot")
    local mid = Tools.FindChildObject(self.canvas,"Mid")
    local top = Tools.FindChildObject(self.canvas,"Top")
    
    self.layers = 
    {
        ["Bot"] = bot,
        ["Mid"] = mid,
        ["Top"] = top,
    }

    self.views = {}
end

function UIManager:OpenView(style,complete)
    local view = self:GetView(style)
    if view ~= nil then
        view.gameobject:SetActive(true)
        view:Open()
        if complete then
            complete(view)
        end
    else
        local view_config = UIConfig[style]
        local view_go = nil
        if view_config.async then
            local load_complete_handler = function (asset)
                self:loadView(view_config,asset)
                if complete then
                    complete(self:GetView(view_config.id))
                end
            end   

            ResourcesManager.Instance:LoadAsync(view_config.path,typeof(GameObject),load_complete_handler)
        else
            view_go = ResourcesManager.Instance:Load(view_config.path,typeof(GameObject))
            self:loadView(view_config,view_go)

            if complete then
                complete(self:Getview(view_config.id))
            end
        end
        
    end
end

function UIManager:CloseView(style)
    local view = self:GetView(style)
    view:Close()

    if view ~= nil then
        if UIConfig[style].cache then
            view.gameObject:SetActive(false)
        else
            self:unloadView(style)
        end
    end
end

function UIManager:GetView(style)
    return self.views[style]
end

function UIManager:getLayer(layer_id)
    return self.layers[layer_id]
end

function UIManager:loadView(view_config,view_go)
    local view = view_config.ui_class:New()
    view:InitBehaviour(view_go)
    view:Open()
    self.views[view_config.id] =view
    
    local view_tran = view.transform
    view_tran:SetParent(self:getLayer(view_config.layer),false)
    view_tran.localPosition = Vector3.zero
    view_tran.localScale = Vector3.one

end

function UIManager:unloadView(style)
    local view = self:GetView(style)
    GameObject.Destroy(view.gameObject)
    self.views[style] = nil
    Resources.UnloadUnusedAssets()
end
