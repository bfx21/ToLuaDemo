PlayerData = {}

PlayerData.name = "bfx"
PlayerData.gold = 500
PlayerData.diamond = 1000
--
PlayerData.level = 1
PlayerData.hp = 30
PlayerData.attack = 10
PlayerData.defence = 10
PlayerData.crit = 2
PlayerData.miss = 5
PlayerData.luck = 3

function PlayerData.LevelUp()
     if PlayerData.diamond < 15 then
        return
     end

     PlayerData.hp =  PlayerData.hp + 1
     PlayerData.attack =  PlayerData.attack + 1
     PlayerData.defence =  PlayerData.defence + 1
     PlayerData.crit =  PlayerData.crit + 1
     PlayerData.miss =  PlayerData.miss + 1
     PlayerData.luck =  PlayerData.luck + 1
     PlayerData.level = PlayerData.level + 1
     PlayerData.diamond = PlayerData.diamond - 15

     EventCenter.Trigger(EventType.ROLE_UP_LEVEL,PlayerData)
end

function PlayerData.RefreshData()
    EventCenter.Trigger(EventType.ROLE_UP_LEVEL,PlayerData)
end