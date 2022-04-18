using UnityEngine;

public class MonoSingle<T> : MonoBehaviour where T : MonoSingle<T>
{
    private static T instance;

    public static T Instance
    { 
        get
        {
            if (instance == null)
            {
                instance = FindObjectOfType<T>();
                if(instance == null)
                {
                    GameObject go = new GameObject(typeof(T).Name);
                    instance = go.AddComponent<T>();
                }
                instance.Init();
            }
            return instance;
        }  
    }

    protected virtual void Init() { }


}
