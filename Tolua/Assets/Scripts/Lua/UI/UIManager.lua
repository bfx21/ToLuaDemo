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

    self.panels = {}
end

function UIManager:OpenPanel(style,complete)
  local panel = self:GetPanel(style)
  if panel ~= nil then
      panel.gameobject:SetActive(true)
      panel:Open()
      if complete then
         complete(panel)
      end
  else
       local panelConfig = UIConfig[style]
       local panelGo = nil
       if panelConfig.async then
          local loadCompleteHandler = function (asset)
              self:createPanel(panelConfig,asset)
              if complete then
                  complete(self:GetPanel(panelConfig.id))
              end
          end   

          ResourcesManager.Instance:LoadAsync(panelConfig.path,typeof(GameObject),loadCompleteHandler)
       else
          panelGo = ResourcesManager.Instance:Load(panelConfig.path,typeof(GameObject))
          self:createPanel(panelConfig,panelGo)

          if complete then
              complete(self:GetPanel(panelConfig.id))
          end
       end
      
   end
end

function UIManager:ClosePanel(style)
    local panel = self:GetPanel(style)
    panel:Close()

    if panel ~= nil then
        if UIConfig[style].cache then
            panel.gameObject:SetActive(false)
        else
            GameObject.Destroy(panel.gameObject)
            self.panels[style] = nil
        end
    end
end

function UIManager:GetPanel(sytle)
    return self.panels[sytle]
end

function UIManager:getLayer(layerId)
    return self.layers[layerId]
end

function  UIManager:createPanel(panelConfig,panelGo)
    local panel = panelConfig.uiClass:New()
    panel:InitBehaviour(panelGo)
    panel:Open()
    self.panels[panelConfig.id] =panel
    
    local panelTran = panel.transform
    panelTran:SetParent(self:getLayer(panelConfig.layer),false)
    panelTran.localPosition = Vector3.zero
    panelTran.localScale = Vector3.one

end
