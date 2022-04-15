using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ResourcesManager 
{
    public static Object Load(string path,System.Type type)
    {
        Object obj =  Resources.Load(path,type);
        
        if(obj is GameObject)
        {
            obj = GameObject.Instantiate(obj);
        }

        return obj;
    } 
}
