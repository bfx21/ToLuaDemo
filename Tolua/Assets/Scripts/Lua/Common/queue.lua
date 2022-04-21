--通过lua实现队列数据结构
Object:Sub("Queue")

function Queue:_init()
    self.list = {}
    self.count = 0
end

--入队
function Queue:EnQueue(item)
    self.count = self.count +1
    table.insert(self.list,item)
end

--出队
function Queue:DeQueue()
    if self.count <= 0 then
        return
    end

    self.count = self.count - 1
    local item = self.list[1]
    table.remove(self.list,1)

    return item
end

function Queue:GetCount()
    return self.count
end

function Queue:Contains(item)
    for i = 1 , self.count do
        if self.list[i] == item then
            return true
        end
    end
    return false
end

function Queue:Clear()
    self.list = {}
    self.count = 0
end

function Queue:IsEmpty()
    return self.count <= 0
end

