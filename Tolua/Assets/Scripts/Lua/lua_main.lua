--lua脚本入口

function main()
    print("执行Lua函数入口")
    require("Include")
    Test()

    --UIManager.GetSingleton():InitManager()
    --UIManager.GetSingleton():OpenView(UIStyle.MAIN)
    local main_controller = MainController:GetInstance()
    local role_controller = RoleController:GetInstance()
    PlayerModule:GetInstance():Fire(PlayerModule.EventType.OPEN_MAIN_VIEW)
end

function Test()

end

main()

