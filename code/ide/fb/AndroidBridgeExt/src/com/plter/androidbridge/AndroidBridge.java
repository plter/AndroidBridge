package com.plter.androidbridge;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONException;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.plter.androidbridge.lang.JavaClass;
import com.plter.androidbridge.lang.JavaObject;

public class AndroidBridge implements FREExtension {

	@Override
	public FREContext createContext(String arg0) {
		if (context==null) {
			context = new Context();
			
		}
		return context;
	}
	
	public static Context getContext() {
		return context;
	}
	
	private static Context context=null;

	@Override
	public void dispose() {
	}

	@Override
	public void initialize() {
	}

	public static final class Context extends FREContext{

		@Override
		public void dispose() {
			
		}

		@Override
		public Map<String, FREFunction> getFunctions() {
			if (functions==null) {
				functions = new HashMap<String, FREFunction>();
				functions.put("callRelatedObjectMethod", new Functions.callRelatedObjectMethod());
				functions.put("callRelatedObjectStaticMethod", new Functions.callRelatedObjectStaticMethod());
				functions.put("setRelatedObjectField", new Functions.setRelatedObjectField());
				functions.put("setRelatedObjectStaticField", new Functions.setRelatedObjectStaticField());
				functions.put("getRelatedObjectField", new Functions.getRelatedObjectField());
				functions.put("getRelatedObjectStaticField", new Functions.getRelatedObjectStaticField());
				functions.put("disposeRelatedObjectObject", new Functions.disposeRelatedObjectObject());
				functions.put("findClass", new Functions.findClass());
				functions.put("newInstance", new Functions.newInstance());
				functions.put("newInstanceWithArgs", new Functions.newInstanceWithArgs());
				functions.put("getMainActivity", new Functions.getMainActivity());
			}
			return functions;
		}
		
		private Map<String, FREFunction> functions = null;
	}
	
	public static interface Functions{
		
		class callRelatedObjectMethod implements FREFunction{

			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				
				try {
					int joId = arg1[0].getAsInt();
					String methodName = arg1[1].getAsString();
					
					AndroidBridgeArg[] argsForSend = new AndroidBridgeArg[arg1.length-2];
					for (int i = 0; i < argsForSend.length; i++) {
						argsForSend[i] = AndroidBridgeArg.encodeJSONString(arg1[i+2].getAsString());
					}
					
					JavaObject jo = JavaObject.getJavaObject(joId);
					if (jo!=null) {
						AndroidBridgeArg result = jo.callRelatedObjectMethod(methodName, argsForSend);
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
		class callRelatedObjectStaticMethod implements FREFunction{
			
			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				try {
					int joId = arg1[0].getAsInt();
					String methodName = arg1[1].getAsString();
					
					AndroidBridgeArg[] argsForSend = new AndroidBridgeArg[arg1.length-2];
					for (int i = 0; i < argsForSend.length; i++) {
						argsForSend[i] = AndroidBridgeArg.encodeJSONString(arg1[i+2].getAsString());
					}
					
					JavaObject jo = JavaObject.getJavaObject(joId);
					if (jo!=null&&jo instanceof JavaClass) {
						AndroidBridgeArg result = ((JavaClass)jo).callRelatedObjectStaticMethod(methodName, argsForSend);
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
		class setRelatedObjectField implements FREFunction{
			
			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				
				try {
					int joId = arg1[0].getAsInt();
					String fieldName = arg1[1].getAsString();
					AndroidBridgeArg arg = AndroidBridgeArg.encodeJSONString(arg1[2].getAsString());
					
					JavaObject jo = JavaObject.getJavaObject(joId);
					if (jo!=null) {
						jo.setRelatedObjectField(fieldName, arg);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				
				return null;
			}
		}
		class getRelatedObjectField implements FREFunction{
			
			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				try {
					int joId = arg1[0].getAsInt();
					String fieldName = arg1[1].getAsString();
					
					JavaObject jo = JavaObject.getJavaObject(joId);
					if (jo!=null) {
						AndroidBridgeArg result = jo.getRelatedObjectField(fieldName);
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
		class setRelatedObjectStaticField implements FREFunction{
			
			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				try {
					int joId = arg1[0].getAsInt();
					String fieldName = arg1[1].getAsString();
					AndroidBridgeArg arg = AndroidBridgeArg.encodeJSONString(arg1[2].getAsString());
					
					JavaObject jo = JavaObject.getJavaObject(joId);
					if (jo!=null&&jo instanceof JavaClass) {
						((JavaClass)jo).setRelatedObjectStaticField(fieldName, arg);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				return null;
			}
		}
		class getRelatedObjectStaticField implements FREFunction{
			
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
		class disposeRelatedObjectObject implements FREFunction{

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
		class findClass implements FREFunction{
			
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
		class newInstance implements FREFunction{
			
			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				
				try {
					int joId = arg1[0].getAsInt();
					JavaObject jo = JavaObject.getJavaObject(joId);
					if (jo!=null&&jo instanceof JavaClass) {
						AndroidBridgeArg result = ((JavaClass)jo).newInstance();
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
		class newInstanceWithArgs implements FREFunction{
			
			@Override
			public FREObject call(FREContext arg0, FREObject[] arg1) {
				
				try {
					int joId = arg1[0].getAsInt();
					
					AndroidBridgeArg[] argsForSend = new AndroidBridgeArg[arg1.length-1];
					for (int i = 0; i < argsForSend.length; i++) {
						argsForSend[i] = AndroidBridgeArg.encodeJSONString(arg1[i+1].getAsString());
					}
					
					JavaObject jo = JavaObject.getJavaObject(joId);
					if (jo!=null&&jo instanceof JavaClass) {
						AndroidBridgeArg result = ((JavaClass)jo).newInstanceWithArgs(argsForSend);
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
		
		class getMainActivity implements FREFunction{
			
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
	}
	
}
