BaseView = Class(UnityBehaviour) or {}
local table_concat = table.concat

function BaseView:__init()
     self.control_cache ={}
end

function BaseView:Open()
    
end

function BaseView:Close()
    
end

function BaseView:GetControl(name,type)
    local str = {}
    str[1] = name
    str[2] = type:ToString()
    local control_name = table_concat( str, "_")

    if self.control_cache[control_name] == nil then
       local control = self:FindChildComponent(name,type)
       self.control_cache[control_name] = control
    end

    return self.control_cache[control_name]
end

function BaseView:SetActive(name,active)
   local transform = self:GetControl(name,typeof(Transform))
   transform.gameObject:SetActive(active)
end

function BaseView:SetImage(name,sprite)
    local image = self:GetControl(name,typeof(Image))
    image.sprite =sprite
end

function BaseView:SetText(name,content)
   local text = self:GetControl(name,typeof(Text))
   text.text = content
end

function BaseView:GetText(name)
    local text = self:GetControl(name,typeof(Text))
    return text.text
end

function BaseView:AddBtnEvent(name,event)
    local button = self:GetControl(name,typeof(Button))
    button.onClick:AddListener(event)
end

return BaseView