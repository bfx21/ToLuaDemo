EventCenter = {}
EventCenter.listener_list ={}

EventType = 
{
   ROLE_UP_LEVEL = 1,
}


function EventCenter.Trigger(event_type,data)
    local func_list = nil
    for key,value in ipairs(EventCenter.listener_list) do
        if key == event_type then
            func_list = value
        end
    end

    if func_list == nil then
        return
    end

    for _,func in ipairs(func_list) do
        func(data)
    end
end

function EventCenter.AddListener(event_type,func)
    if EventCenter.listener_list[event_type] == nil then 
        EventCenter.listener_list[event_type] = {}
    end

    table.insert(EventCenter.listener_list[event_type],func)   
end

function EventCenter.RemoveListener(event_type,func)
    if EventCenter.listener_list[event_type] == nil then
        return
    end

    for index, value in pairs(EventCenter.listener_list[event_type]) do
        if value == func then
            table.remove(EventCenter.listener_list,index)
            return
        end
    end
end
