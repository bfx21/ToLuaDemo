-- 处理并发事件
local events = {}
local eventHandleId = 0
local eventHandles = {}

local function AddListener(name, listener)
    local listeners = events[name]
    if not listeners then
        --listeners不再是一个简单的table，通过多个标识符来标识
        listeners = { insert = {}, dirty = false, executing = false, destroyed = false }
        events[name] = listeners
    end

    local handleId = listeners[listener] or listeners.insert[listener]
    if not handleId then
        handleId = eventHandleId + 1
        eventHandleId = handleId
        --如果在塞入的时候，该listeners正在被触发，则不执行立即塞入的操作，等下一个触发到来的时候执行
        if listeners.executing then
            listeners.insert[listener] = handleId
            listeners.dirty = true
        else
            listeners[listener] = handleId
        end
        eventHandles[handleId] = { name, listener }
    end

    return handleId
end

local function RemoveListener(name, listener, handles)
    local listeners = events[name]
    if listeners then
        if not listener then
            for _, handleId in pairs(listeners) do
                eventHandles[handleId] = nil
                if handles then
                    handles[handleId] = nil
                end
            end
            --标记其已经destroyed
            listeners.destroyed = true
            events[name] = nil
        else
            local handleId = listeners[listener] or listeners.insert[listener]
            if handleId then
                listeners[listener] = nil
                listeners.insert[listener] = nil
                eventHandles[handleId] = nil
                if handles then
                    handles[handleId] = nil
                end
            end
        end
    end
end

local function RemoveHandle(handleId)
    local entry = eventHandles[handleId]
    if entry then
        RemoveListener(entry[1], entry[2])
    end
end

local EventManager = {}

function EventManager.Add(name, listener)
    AddListener(name, listener)
end

function EventManager.Remove(name, listener)
    RemoveListener(name, listener)
end

function EventManager.Clear()
    events = {}
    eventHandles = {}
end

function EventManager.Dispatch(name, ...)
    local listeners = events[name]
    if listeners then
        listeners.executing = true
        for listener, _ in pairs(listeners) do
            if type(listener) == "function" then
                listener(name, ...)
            end
            --可能在执行listener的过程中回调执行了remove，所以需要检测一次是否退出
            if listeners.destroyed then
                return
            end
        end
        --触发完后，再执行缓存的塞入检测
        if listeners.dirty then
            for listener, handleId in pairs(listeners.insert) do
                listeners[listener] = handleId
                listeners.insert[listener] = nil
            end
            listeners.dirty = false
        end
        listeners.executing = false
    end
end