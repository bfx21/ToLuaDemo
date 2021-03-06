//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class ResourcesManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ResourcesManager), typeof(MonoSingle<ResourcesManager>));
		L.RegFunction("Load", Load);
		L.RegFunction("LoadAsync", LoadAsync);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Load(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			ResourcesManager obj = (ResourcesManager)ToLua.CheckObject<ResourcesManager>(L, 1);
			string arg0 = ToLua.CheckString(L, 2);
			System.Type arg1 = ToLua.CheckMonoType(L, 3);
			UnityEngine.Object o = obj.Load(arg0, arg1);
			ToLua.Push(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int LoadAsync(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 3)
			{
				ResourcesManager obj = (ResourcesManager)ToLua.CheckObject<ResourcesManager>(L, 1);
				string arg0 = ToLua.CheckString(L, 2);
				System.Type arg1 = ToLua.CheckMonoType(L, 3);
				obj.LoadAsync(arg0, arg1);
				return 0;
			}
			else if (count == 4)
			{
				ResourcesManager obj = (ResourcesManager)ToLua.CheckObject<ResourcesManager>(L, 1);
				string arg0 = ToLua.CheckString(L, 2);
				System.Type arg1 = ToLua.CheckMonoType(L, 3);
				LoadResComplete arg2 = (LoadResComplete)ToLua.CheckDelegate<LoadResComplete>(L, 4);
				obj.LoadAsync(arg0, arg1, arg2);
				return 0;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ResourcesManager.LoadAsync");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object arg0 = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object arg1 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool o = arg0 == arg1;
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

