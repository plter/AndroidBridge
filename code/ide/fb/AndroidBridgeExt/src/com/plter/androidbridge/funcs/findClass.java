/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge.funcs;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.plter.androidbridge.AndroidBridgeArg;
import com.plter.androidbridge.lang.JavaClass;

public class findClass implements FREFunction{
	
	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		try {
			String className = arg1[0].getAsString();
			AndroidBridgeArg result = JavaClass.findClass(className);
			if (result!=null) {
				return FREObject.newObject(result.toJSONString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
}