MonoSingleton = Class(UnityBehaviour) or {}

function MonoSingleton:__init()
    self.GetSingleton = function ()
        if self.instance == nil then
            self.instance = self.New()
            local go = GameObject("manager")
            --go.transform.parent = System.transform
            self.instance:InitBehaviour(go) 
        end
        return  self.instance
    end
end
