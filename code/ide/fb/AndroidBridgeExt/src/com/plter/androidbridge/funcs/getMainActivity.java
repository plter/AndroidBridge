/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge.funcs;

import org.json.JSONException;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.plter.androidbridge.AndroidBridgeArg;

public class getMainActivity implements FREFunction{
	
	private static AndroidBridgeArg mainActivity = null;
	
	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		
		
		if (mainActivity==null) {
			mainActivity = AndroidBridgeArg.encodeObject(arg0.getActivity());
		}
		
		
		try {
			return FREObject.newObject(mainActivity.toJSONString());
		} catch (FREWrongThreadException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return null;
	}
}