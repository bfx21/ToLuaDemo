UnityBehaviour:Sub("BasePanel")

function BasePanel:Init()
     self.controlCache ={}

     if self.InitPanel ~= nil then
         self:InitPanel()
     end
end

function BasePanel:Open()
    
end

function BasePanel:Close()
    
end

function BasePanel:GetControl(name,type)
    local str = {}
    str[1] = name
    str[2] = type:ToString()
    local controlName = table.concat( str, "_")

    if self.controlCache[controlName] == nil then
       local control = self:FindChildComponent(name,type)
       self.controlCache[controlName] = control
    end

    return self.controlCache[controlName]
end

function BasePanel:SetActive(name,active)
   local transform = self:GetControl(name,typeof(Transform))
   transform.gameObject:SetActive(active)
end

function BasePanel:SetImage(name,sprite)
    local image = self:GetControl(name,typeof(Image))
    image.sprite =sprite
end

function BasePanel:SetText(name,content)
   local text = self:GetControl(name,typeof(Text))
   text.text = content
end

function BasePanel:GetText(name)
    local text = self:GetControl(name,typeof(Text))
    return text.text
end

function BasePanel:AddBtnEvent(name,event)
    local button = self:GetControl(name,typeof(Button))
    button.onClick:AddListener(event)
end