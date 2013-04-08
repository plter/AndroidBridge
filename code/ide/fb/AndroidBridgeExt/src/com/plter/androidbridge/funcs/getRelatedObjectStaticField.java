package com.plter.androidbridge.funcs;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.plter.androidbridge.AndroidBridgeArg;
import com.plter.androidbridge.lang.JavaClass;
import com.plter.androidbridge.lang.JavaObject;

public class getRelatedObjectStaticField implements FREFunction{
	
	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		try {
			int joId = arg1[0].getAsInt();
			String fieldName = arg1[1].getAsString();
			
			JavaObject jo = JavaObject.getJavaObject(joId);
			if (jo!=null&&jo instanceof JavaClass) {
				AndroidBridgeArg result = ((JavaClass)jo).getRelatedObjectStaticField(fieldName);
				if (result!=null) {
					return FREObject.newObject(result.toJSONString());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}