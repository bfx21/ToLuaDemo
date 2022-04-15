Object ={}

function Object:new()
    local obj = {}
    obj._index = self
    setmetatable(obj, self)
    return obj
end

function Object:sub(className)
    _G[className] = {}
    local obj = _G[className]
    obj.base = self
    obj._index = self
    setmetatable(obj,self)
end
