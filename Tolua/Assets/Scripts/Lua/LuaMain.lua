--lua脚本入口

function main()
    print("执行Lua函数入口")
    require("Include")
    
    UIManager.GetSingleton():Init()
end

main()