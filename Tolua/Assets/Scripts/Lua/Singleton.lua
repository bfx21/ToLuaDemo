UnityBehaviour:sub("Singleton")

function Singleton:Class(name)
    self:sub(name)
    _G[name].GetSingleton = function ()
        if _G[name].instance == nil then
            _G[name].instance = _G[name]:new()
            local go = GameObject(name)
            --go.transform.parent = System.transform
            _G[name].instance:InitBehaviour(go) 
        end
        return  _G[name].instance
    end
end