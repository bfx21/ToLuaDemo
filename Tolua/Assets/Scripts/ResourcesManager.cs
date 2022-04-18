using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public delegate void LoadResComplete(Object asset);

public class ResourcesManager :MonoSingle<ResourcesManager>
{
    public Object Load(string path,System.Type type)
    {
        Object obj =  Resources.Load(path,type);
        
        if(obj is GameObject)
        {
            obj = GameObject.Instantiate(obj);
        }

        return obj;
    }

    public void LoadAsync(string path,System.Type type,LoadResComplete complete = null)
    {
        StartCoroutine(LoadAsyncHandler(path,type,complete));
    }

    private IEnumerator LoadAsyncHandler(string path,System.Type type,LoadResComplete complete)
    {
        ResourceRequest request =  Resources.LoadAsync(path,type);
        
        yield return request;

        complete?.Invoke(request.asset);
    }
}
