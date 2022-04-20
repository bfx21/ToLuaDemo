--处理并发性的事件系统
EventCenter = {}
EventCenter.listener_list = {}

EventType = 
{
   ROLE_UP_LEVEL = 1,
}

function EventCenter.Trigger(event_type,data)
    local event_list = EventCenter.listener_list[event_type]
    if event_list == nil then
        return
    end
    
    event_list.executing = true
    for _,func in ipairs(event_list.handler_list) do
        func(data)
    end
    event_list.executing = false

    --处理缓存的添加和移除操作
    if #event_list.add_list > 0 then
        for _,func in ipairs(event_list.add_list) do
            table.insert(event_list.handler_list,func)
        end
    end
    if #event_list.remove_list > 0 then
        for _, remove_event in ipairs(event_list.remove_list) do
            for index, event in ipairs(event_list.handler_list) do
                if remove_event == event then
                    table.remove(event_list.handler_list,index)
                    break
                end 
            end
        end
    end

    event_list.add_list = {}
    event_list.remove_list = {}
end

function EventCenter.AddListener(event_type,func)
    local event_list = EventCenter.listener_list[event_type]
    if event_list == nil then 
        event_list = {handler_list = {},add_list = {}, remove_list = {}, executing = false}
        EventCenter.listener_list[event_type] = event_list
    end

    --执行添加事件时如果正在执行触发事件，则停止添加操作，将添加事件加入缓存
    if event_list.executing then
       table.insert(event_list.add_list,func)
    else
       table.insert(event_list.handler_list,func)
    end   
end

function EventCenter.RemoveListener(event_type,func)
    local event_list = EventCenter.listener_list[event_type]
    if event_list == nil then
        return
    end

    --执行移除事件时如果正在执行触发事件，则停止移除操作，将移除事件加入缓存
    if event_list.executing then
        table.insert(event_list.remove_list,func)
        return
    end

    for index, value in pairs(EventCenter.listener_list[event_type]) do
        if value == func then
            table.remove(EventCenter.listener_list,index)
            return
        end
    end
end
