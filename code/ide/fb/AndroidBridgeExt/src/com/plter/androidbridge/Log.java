package com.plter.androidbridge;

public class Log {

	public static final String TAG="AndroidBridge";
	
	public static void i(String msg){
		android.util.Log.i(TAG, msg);
	}
	
	public static void e(String msg){
		android.util.Log.e(TAG, msg);
	}
	
}
