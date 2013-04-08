/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */

package com.plter.androidbridge;

import org.json.JSONException;
import org.json.JSONObject;

import com.plter.androidbridge.lang.JavaClass;
import com.plter.androidbridge.lang.JavaObject;

public class AndroidBridgeArg {

	public AndroidBridgeArg(int type,Object value) {
		this.type=type;
		this.value = value;

		if(type==TYPE_JAVA_OBJECT){
			javaObjectId = (Integer) value;
		}else if (type==TYPE_JAVA_INTERFACE_IMPL) {
			javaInterfaceImplId = (Integer) value;
		}
	}
	
	public AndroidBridgeArg(JavaObject jo) {
		type= TYPE_JAVA_OBJECT;
		value = jo.getId();
		
		javaObject = jo;
		javaObjectId = jo.getId();
	}

	public final int getType() {
		return type;
	}
	
	public JSONObject toJSON() throws JSONException{
		JSONObject jo = new JSONObject();
		jo.put("type", getType());
		jo.put("value", getValue());
		return jo;
	}
	
	public String toJSONString() throws JSONException{
		return toJSON().toString();
	}
	
	
	public Object getRelatedValue() {
		if (relatedValue==null) {
			if (type==TYPE_JAVA_OBJECT) {
				relatedValue = getJavaObject().getRelatedObject();
			}else{
				relatedValue = value;
			}
		}
		return relatedValue;
	}
	
	private Object relatedValue = null;
	

	public Object getValue() {
		return value;
	}

	public int getJavaObjectId() {
		return javaObjectId;
	}

	public int getJavaInterfaceImplId() {
		return javaInterfaceImplId;
	}

	public Class<?> getValueType(){
		if (valueType==null) {
			switch (getType()) {
			case TYPE_BOOLEAN:
			case TYPE_INT:
			case TYPE_NUMBER:
			case TYPE_STRING:
				valueType = getValue().getClass();
				break;
			case TYPE_JAVA_OBJECT:
				valueType = getJavaObject().getClass();
				break;
			}
		}
		return valueType;
	}

	private Class<?> valueType=null;

	public JavaObject getJavaObject() {
		if (type==TYPE_JAVA_OBJECT&&javaObject==null) {
			javaObject = JavaObject.getJavaObject(javaObjectId);
		}
		return javaObject;
	}

	private JavaObject javaObject=null;

	private int type = 0;
	private Object value = null;
	private int javaObjectId = 0;
	private int javaInterfaceImplId = 0;


	public static final int TYPE_INT=1;
	public static final int TYPE_STRING=2;
	public static final int TYPE_NUMBER=3;
	public static final int TYPE_BOOLEAN=4;
	public static final int TYPE_JAVA_OBJECT=5;
	public static final int TYPE_JAVA_INTERFACE_IMPL=6;
	public static final int TYPE_NULL=7;
	public static final int TYPE_UNKNOW=8;
	public static final int TYPE_ARG_ARRAY=9;


	public final static AndroidBridgeArg encodeObject(Object obj){
		if (obj==null) {
			return new AndroidBridgeArg(TYPE_NULL, null);
		}
		
		if (obj instanceof String) {
			return new AndroidBridgeArg(TYPE_STRING, obj);
		}else if (obj instanceof Integer) {
			return new AndroidBridgeArg(TYPE_INT, obj);
		}else if (obj instanceof Number) {
			return new AndroidBridgeArg(TYPE_NUMBER, obj);
		}else if (obj instanceof Boolean) {
			return new AndroidBridgeArg(TYPE_BOOLEAN, obj);
		}else if (obj instanceof JavaObject) {
			return new AndroidBridgeArg((JavaObject) obj);
		}else if (obj instanceof Class<?>) {
			return new AndroidBridgeArg(new JavaClass((Class<?>) obj));
		}else{
			return new AndroidBridgeArg(new JavaObject(obj));
		}
	}

	public final static AndroidBridgeArg encodeJSON(JSONObject jo) throws JSONException{
		int type = jo.getInt("type");
		if (type!=TYPE_ARG_ARRAY) {
			return new AndroidBridgeArg(type, jo.get("value"));
		}else{
			return new AndroidBridgeArgArray(type, jo.getJSONArray("value"));
		}
	}

	public final static AndroidBridgeArg encodeJSONString(String jsonStr) throws JSONException{
		return encodeJSON(new JSONObject(jsonStr));
	}
}
