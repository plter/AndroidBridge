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
import com.plter.androidbridge.lang.JavaObject;

public class disposeRelatedObjectObject implements FREFunction{

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		try {
			int joid = arg1[0].getAsInt();
			JavaObject.removeJavaObject(joid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
}