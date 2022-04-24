MonoSingleton = Class(UnityBehaviour) or {}

function MonoSingleton:GetSingleton()
    if self.instance == nil then
        local go = GameObject("manager")
        --go.transform.parent = System.transform
        self.instance = self.New(go)
    end
    return  self.instance
end
