UIManager = Class() or {}
local _UIConfig = require("UI/Common/ui_config")

function UIManager.GetInstance()
    if UIManager.instance == nil then
        UIManager.instance = UIManager.New()
    end
    return UIManager.instance
end

function UIManager:__init()
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
        view.gameObject:SetActive(true)
        view:Open()
        if complete then
            complete(view)
        end
    else
        local view_config = _UIConfig[style]
        local view_go = nil
        if view_config.async then
            local load_complete_handler = function (asset)
                self:_loadView(view_config,asset)
                if complete then
                    complete(self:GetView(view_config.id))
                end
            end   

            ResourcesManager.Instance:LoadAsync(view_config.path,typeof(GameObject),load_complete_handler)
        else
            view_go = ResourcesManager.Instance:Load(view_config.path,typeof(GameObject))
            self:_loadView(view_config,view_go)

            if complete then
                complete(self:GetView(view_config.id))
            end
        end
        
    end
end

function UIManager:CloseView(style)
    local view = self:GetView(style)
    view:Close()

    if view ~= nil then
        if _UIConfig[style].cache then
            view.gameObject:SetActive(false)
        else
            self:_unloadView(style)
        end
    end
end

function UIManager:GetView(style)
    return self.views[style]
end

function UIManager:_getLayer(layer_id)
    return self.layers[layer_id]
end

function UIManager:_loadView(view_config,view_go)
    local view = view_config.ui_class.New(view_go)
    view:Open()
    self.views[view_config.id] =view
    
    local view_tran = view.transform
    view_tran:SetParent(self:_getLayer(view_config.layer),false)
    view_tran.localPosition = Vector3.zero
    view_tran.localScale = Vector3.one

end

function UIManager:_unloadView(style)
    local view = self:GetView(style)
    GameObject.Destroy(view.gameObject)
    self.views[style] = nil
end

return UIManager