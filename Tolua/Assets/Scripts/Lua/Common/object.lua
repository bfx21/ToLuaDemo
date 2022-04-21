Object ={}

function Object:New()
    local obj = {}
    self.__index = self
    setmetatable(obj, self)
    
    if obj._init then
        obj:_init()
    end

    return obj
end

function Object:Sub(className)
    _G[className] = {}
    local obj = _G[className]

    obj._init = false
    obj.base = self
    self.__index = self
    setmetatable(obj,self)
end
