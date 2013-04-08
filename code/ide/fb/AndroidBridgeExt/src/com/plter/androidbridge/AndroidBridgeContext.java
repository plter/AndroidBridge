package com.plter.androidbridge;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.plter.androidbridge.funcs.callRelatedObjectMethod;
import com.plter.androidbridge.funcs.callRelatedObjectStaticMethod;
import com.plter.androidbridge.funcs.disposeRelatedObjectObject;
import com.plter.androidbridge.funcs.findClass;
import com.plter.androidbridge.funcs.getMainActivity;
import com.plter.androidbridge.funcs.getRelatedObjectField;
import com.plter.androidbridge.funcs.getRelatedObjectStaticField;
import com.plter.androidbridge.funcs.newInstance;
import com.plter.androidbridge.funcs.newInstanceWithArgs;
import com.plter.androidbridge.funcs.setRelatedObjectField;
import com.plter.androidbridge.funcs.setRelatedObjectStaticField;

public final class AndroidBridgeContext extends FREContext{

	@Override
	public void dispose() {
		
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		if (functions==null) {
			functions = new HashMap<String, FREFunction>();
			functions.put("callRelatedObjectMethod", new callRelatedObjectMethod());
			functions.put("callRelatedObjectStaticMethod", new callRelatedObjectStaticMethod());
			functions.put("setRelatedObjectField", new setRelatedObjectField());
			functions.put("setRelatedObjectStaticField", new setRelatedObjectStaticField());
			functions.put("getRelatedObjectField", new getRelatedObjectField());
			functions.put("getRelatedObjectStaticField", new getRelatedObjectStaticField());
			functions.put("disposeRelatedObjectObject", new disposeRelatedObjectObject());
			functions.put("findClass", new findClass());
			functions.put("newInstance", new newInstance());
			functions.put("newInstanceWithArgs", new newInstanceWithArgs());
			functions.put("getMainActivity", new getMainActivity());
		}
		return functions;
	}
	
	private Map<String, FREFunction> functions = null;
}