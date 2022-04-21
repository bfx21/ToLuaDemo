--处理并发性的事件系统
Object:Sub("EventSystem")

function EventSystem:_init()
    self.listener_list ={}
    self.cache_event ={} --定义用来存储缓存的事件
    self.executing_dic = {} --定义该事件类型是否正在执行
end

function EventSystem:AddListener(event_type,func)
    local event_list = self.listener_list[event_type]
    if event_list == nil then 
        event_list = {}
        self.listener_list[event_type] = event_list
    end
    
    table.insert(event_list,func)    
end

function EventSystem:RemoveListener(event_type,func)
    local event_list = self.listener_list[event_type]
    if event_list == nil then
        return
    end

    --执行移除事件时如果正在执行触发事件，则停止移除操作，将移除事件加入缓存
    if self.executing_dic[event_type] then
        if not self.cache_event[event_type] then
            self.cache_event[event_type] = {}
        end
        table.insert(self.cache_event[event_type],func)
        return
    end

    for index, value in pairs(event_list) do
        if value == func then
            table.remove(event_list,index)
            return
        end
    end
end

function EventSystem:Trigger(event_type,data)
    local event_list = self.listener_list[event_type]
    if event_list == nil then
        return
    end
    
    self.executing_dic[event_type] = true
    for _,func in ipairs(event_list) do
        func(data)
    end
    self.executing_dic[event_type] = false

    --处理缓存的移除操作
     local cache_list = self.cache_event[event_type]   
     if cache_list then
        for _,remove_event in ipairs(cache_list) do
            for index,func in ipairs(event_list) do
                if remove_event == func then
                    table.remove(event_list,index)
                    break
                end 
            end 
        end 
     end
end