/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge;




import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class AndroidBridge implements FREExtension {

	@Override
	public FREContext createContext(String arg0) {
		if (context==null) {
			context = new AndroidBridgeContext();
		}
		return context;
	}
	
	public static AndroidBridgeContext getContext() {
		return context;
	}
	
	private static AndroidBridgeContext context=null;

	@Override
	public void dispose() {
	}

	@Override
	public void initialize() {
	}
}
