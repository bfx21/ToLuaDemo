--处理并发性的事件系统
EventManager = EventManager or Class(EventManager)

function EventManager:__init()
    self.event_list ={}
end

function EventManager.GetInstance()
    if EventManager.instance == nil then
        EventManager.instance = EventManager.New()
    end
    return EventManager.instance
end

function EventManager:AddListener(event_type,func)
    local event = self.event_list[event_type]
    if event == nil then 
        event = EventLib.New(event_type)
        self.event_list[event_type] = event
    end
    
    event:Add(func)  
end

function EventManager:RemoveListener(event_type,func)
    local event = self.event_list[event_type]
    if event == nil then
        return
    end
    event:Remove(func)
end

function EventManager:Trigger(event_type,data)
    local event = self.event_list[event_type]
    if event == nil then
        return
    end
    event:Trigger(data)
end

function EventManager:RemoveAllListener(event_type)
    local event = self.event_list[event_type]
    if event == nil then
        return
    end
    event:Clear()
end