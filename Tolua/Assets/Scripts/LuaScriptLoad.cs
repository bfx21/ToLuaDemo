using LuaInterface;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;

public class LuaScriptLoad : LuaFileUtils
{
    public override byte[] ReadFile(string fileName)
    {
        string path = Application.dataPath + "/Scripts/Lua/" + fileName + ".lua";
           
         if(File.Exists(path) == false)
         {
            Debug.Log("无法找到该路径" + path);
            return null;
         }
        
        return File.ReadAllBytes(path);
     }
}
