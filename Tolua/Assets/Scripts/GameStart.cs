using LuaInterface;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameStart : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        LuaState luaState = new LuaState();
        DelegateFactory.Init();

        luaState.Start();
        LuaBinder.Bind(luaState);
        LuaLooper luaLooper = gameObject.AddComponent<LuaLooper>();
        luaLooper.luaState = luaState;

        LuaScriptLoad luaLoad = new LuaScriptLoad();
        luaState.DoFile("lua_main");
    }

    // Update is called once per frame
    void Update()
    {
   
    }
}
