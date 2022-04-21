--lua脚本入口

function main()
    print("执行Lua函数入口")
    require("Include")
    Test()

    UIManager.GetSingleton():InitManager()
    UIManager.GetSingleton():OpenView(UIStyle.MAIN)
end

function Test()
    local func = function() 
        coroutine.wait(5)
        print("测试lua协程")
    end
    
    coroutine.start(func)
end

main()

