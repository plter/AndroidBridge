/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */

package com.plter.androidbridge.lang;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

import org.json.JSONArray;
import org.json.JSONObject;

import com.plter.androidbridge.AndroidBridge;
import com.plter.androidbridge.AndroidBridgeArg;
import com.plter.androidbridge.AndroidBridgeEvent;

public class JavaInterfaceImpl {

	public JavaInterfaceImpl(int javaInterfaceImplId,Class<?> interfaceDef) {
		
		this.javaInterfaceImplId= javaInterfaceImplId;
		proxyInstance = Proxy.newProxyInstance(interfaceDef.getClassLoader(), new Class<?>[]{interfaceDef}, new InvocationHandler() {
			
			@Override
			public Object invoke(Object proxy, Method method, Object[] args)
					throws Throwable {
				
				
				JSONObject jo = new JSONObject();
				jo.put("javaInterfaceImplId", getJavaInterfaceImplId());
				jo.put("methodName", method.getName());
				JSONArray ja = new JSONArray();
				for (Object object : args) {
					ja.put(AndroidBridgeArg.encodeObject(object).toJSON());
				}
				jo.put("args", ja);
				
				AndroidBridge.getContext().dispatchStatusEventAsync(AndroidBridgeEvent.JAVA_INTERFACE_IMPL_CALLBACK, jo.toString());
				return null;
			}
		});
	}
	
	
	public Object getProxyInstance() {
		return proxyInstance;
	}
	
	public int getJavaInterfaceImplId() {
		return javaInterfaceImplId;
	}
	
	
	private int javaInterfaceImplId = 0;
	private Object proxyInstance=null;
	
}
