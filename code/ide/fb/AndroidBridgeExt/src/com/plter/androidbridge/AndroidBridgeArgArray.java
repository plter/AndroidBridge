/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */

package com.plter.androidbridge;

import java.lang.reflect.Array;

import org.json.JSONArray;
import org.json.JSONException;

public class AndroidBridgeArgArray extends AndroidBridgeArg {

	public AndroidBridgeArgArray(int type, JSONArray value) throws JSONException {
		super(type, value);
		
		args = new AndroidBridgeArg[value.length()];
		for (int i = 0; i < args.length; i++) {
			args[i] = AndroidBridgeArg.encodeJSON(value.getJSONObject(i));
		}
		
		if (args.length>0) {
			componentType = args[0].getValueType();
		}
		
		components = Array.newInstance(componentType, args.length);
		for (int i = 0; i < args.length; i++) {
			Array.set(components, i, args[i].getRelatedValue());
		}
	}
	
	
	public Object getComponents(){
		return components;
	}
	
	private Object components = null;
	
	
	public Class<?> getComponentType() {
		return componentType;
	}
	
	private Class<?> componentType = null;
	
	public AndroidBridgeArg[] getArgs() {
		return args;
	}
	
	private AndroidBridgeArg[] args=null;

	
}
