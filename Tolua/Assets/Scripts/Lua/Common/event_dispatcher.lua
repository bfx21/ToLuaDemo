Object:Sub("EventDispatcher")

function EventDispatcher:_init()
    self.event_system = EventSystem:New()
end

function EventDispatcher:Bind(event_type,func)
    self.event_system:AddListener(event_type,func)
end

function EventDispatcher:UnBind(event_type,func)
    self.event_system:RemoveListener(event_type,func)
end

function EventDispatcher:Fire(event_type,data)
    self.event_system:Trigger(event_type,data)
end