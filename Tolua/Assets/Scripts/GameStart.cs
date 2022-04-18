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

        LuaScriptLoad luaLoad = new LuaScriptLoad();
        luaState.DoFile("LuaMain");
    }

    // Update is called once per frame
    void Update()
    {
   
    }
}
