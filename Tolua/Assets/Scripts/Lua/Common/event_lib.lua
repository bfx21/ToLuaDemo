local EventLib = EventLib or Class(EventLib)
local _ipairs = ipairs
local _pairs = pairs
local _table_insert = table.insert

function EventLib:__init(event_name)
    self.handlers = {}
    self.wait_remove_list = {}
    self.executing = false
    self.event_name = event_name
end

function EventLib:Add(func)
    if func == nil then
        print("监听事件为空,事件名为："..self.event_name)
        return
    end
    local handler = self[func]
    if handler == func then
        print("事件已经注册监听过,事件名为："..self.event_name)
        return
    else
        self.handlers[func] = func
    end
end

function EventLib:Remove(func)
    if func == nil then
        print("移除事件为空,事件名为："..self.event_name)
        return
    end

    if self.executing then
        _table_insert(self.wait_remove_list,func)
    else
        self.handlers[func] = nil
    end
end

function EventLib:Trigger(event_data)
    self.executing = true
    for _,func in _pairs(self.handlers) do
        func(event_data)
    end
    self.executing =false
    
    for _,func in _ipairs(self.wait_remove_list) do
        self:Remove(func)
    end
end

function EventLib:Clear()
    self.handlers = {}
    self.wait_remove_list = {}
    self.executing = false
end

return EventLib