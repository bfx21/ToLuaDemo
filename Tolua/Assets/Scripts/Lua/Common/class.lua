--面向对象实现
function Class(super)
    local class_type = {}
    class_type.__super = super
    class_type.__init = false

    class_type.New = function(...)
        local obj = {}

        --通过递归从子类到父类按顺序调用构造函数
        local create    
        create = function(class,obj,...)
            if class.__super then
                create(class.__super,obj,...)
            end

            if class.__init then
                class.__init(obj,...)
            end
        end
        
        setmetatable(obj,{__index = function(t,k)
            local result = class_type[k]
            obj[k] = result
            return result
        end})

        create(class_type,obj,...)
        return obj
    end
    
    if super then
        setmetatable(class_type,{__index = function(t,k)
            local result = super[k]
            class_type[k] = result
            return result
        end})
    end

    return class_type
end