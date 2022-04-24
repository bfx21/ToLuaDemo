Singleton = Class() or {}

function Singleton:GetInstance()
    if self.instance == nil then
        self.instance = self.New()
    end

    return self.instance
end