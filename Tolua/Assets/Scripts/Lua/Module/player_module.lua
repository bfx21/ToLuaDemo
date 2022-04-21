EventDispatcher:Sub("PlayerModule")

PlayerModule.EventType = 
{
     OPEN_MAIN_VIEW = "ROLE_UP_LEVEL",
     OPEN_ROLE_VIEW = "OPEN_ROLE_VIEW",
     CLOSE_ROLE_VIEW = "CLOSE_ROLE_VIEW",
     REFRESH_VIEW = "REFRESH_VIEW",
}

function PlayerModule:GetInstance()
     if self.instance == nil then
          self.instance = PlayerModule:New()
     end

     return self.instance
end

function PlayerModule:_init()
    self.base:_init()

    self.name = "bfx"
    self.gold = 500
    self.diamond = 1000
    --
    self.level = 1
    self.hp = 30
    self.attack = 10
    self.defence = 10
    self.crit = 2
    self.miss = 5
    self.luck = 3
end

function PlayerModule:LevelUp()
     if self.diamond < 15 then
        return
     end

     self.hp =  self.hp + 1
     self.attack =  self.attack + 1
     self.defence =  self.defence + 1
     self.crit =  self.crit + 1
     self.miss =  self.miss + 1
     self.luck =  self.luck + 1
     self.level = self.level + 1
     self.diamond = self.diamond - 15

     self:Fire(PlayerModule.EventType.REFRESH_VIEW,self)
end

function PlayerModule:RefreshView()
     self:Fire(PlayerModule.EventType.REFRESH_VIEW,self)
end