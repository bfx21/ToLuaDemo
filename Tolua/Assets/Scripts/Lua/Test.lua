local __class = {}

function Class(super)
    local classType = {}
    classType.__super = super
    classType.ctor  = false
    
    function classType:New(...)
        local obj = {}
        do
            local create
            create = function(c,...)
            if c.__super then
            end


            end
        end
    end
end