Singleton:Class("UIManager")

Sytle = {
  Role = 1, 

}

function UIManager:Init()
    local canvas = ResourcesManager.Load("UI/Canvas",typeof(GameObject))
    ResourcesManager.Load("UI/EventSystem",typeof(GameObject))
    self.canvas = canvas.transform
    self.panels = {}
end

function UIManager:OpenPanel(sytle)
    
end

function UIManager:ClosePanel(sytle)
    
end

function UIManager:GetPanel(sytle)
    return self.panels[sytle]
end
