using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public delegate void LuaBehaviourAction();

public class LuaBehaviour : MonoBehaviour
{
    public LuaBehaviourAction AwakeAction;
    public LuaBehaviourAction StartAction;
    public LuaBehaviourAction OnEnableAction;
    public LuaBehaviourAction OnDisableAction;
    public LuaBehaviourAction UpdateAction;

    private void Start()
    {
        AwakeAction?.Invoke();
        StartAction?.Invoke();
    }

    private void OnEnable()
    {
        OnEnableAction?.Invoke();
    }

    private void Update()
    {
        UpdateAction?.Invoke();
    }

    private void OnDisable()
    {
        OnDisableAction?.Invoke();
    }
}
