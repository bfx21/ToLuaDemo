--lua脚本入口

function main()
    print("执行Lua函数入口")
    require("Include")
    Test()

    UIManager.GetSingleton():InitManager()
    UIManager.GetSingleton():OpenView(UIStyle.MAIN)
end

function Test()

end

main()

