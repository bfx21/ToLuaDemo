--主入口函数。从这里开始lua逻辑
local Ue = UnityEngine.GameObject

function Main()					
	print("logic start")
		 		
end

--场景切换通知
function OnLevelWasLoaded(level)
	collectgarbage("collect")
	Time.timeSinceLevelLoad = 0
end

function OnApplicationQuit()
end