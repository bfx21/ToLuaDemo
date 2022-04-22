Object:Sub("UnityBehaviour")

function UnityBehaviour:InitBehaviour(go)
    self.gameObject = go
    self.transform = go.transform
    local behaviour = self.gameObject:AddComponent(typeof(LuaBehaviour))

    if self.Init ~= nil then
        self:Init()
    end

    if self.Awake ~= nil then
        behaviour.AwakeAction = function() self:Awake() end
    end

    if self.Start ~= nil then
        behaviour.StartAction = function() self:Start() end
    end

    if self.OnEnable ~= nil then
        behaviour.OnEnableAction = function() self:OnEnable() end
    end

    if self.Update ~= nil then
        behaviour.UpdateAction = function() self:Update() end
    end

end

function UnityBehaviour:GetTag()
    return self.gameObject.tag
end

function UnityBehaviour:SetTag(tag)
    self.gameObject.tag = tag
end

function UnityBehaviour:GetName()
    return self.gameObject.name
end

function UnityBehaviour:SetName(name)
     self.gameObject.name = name
end

function UnityBehaviour:GetComponent(type)
    return self.gameObject:GetComponent(type)
end

function UnityBehaviour:GetComponentInChildren(type)
    return self.gameObject:GetComponentInChildren(type)
end

function UnityBehaviour:GetComponentsInChildren(type)
    return self.gameObject:GetComponentsInChildren(type)
end

function UnityBehaviour:FindChild(childName)
    local child =  Tools.FindChildObject(self.transform,childName)   
    if child == nil then
        print("找不到该子物体："..childName)
    end

    return child
end

function UnityBehaviour:FindChildComponent(childName,type)
    local child = self:FindChild(childName)
    return child:GetComponent(type)
 end

function UnityBehaviour:Destroy()
    GameObject.Destroy(self.gameObject)
end