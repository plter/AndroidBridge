/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */

package com.plter.androidbridge.lang;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.plter.androidbridge.AndroidBridgeArg;

public class JavaObject {


	public JavaObject(Object relatedObject) {
		__id++;
		id=__id;
		this.relatedObject=relatedObject;

		javaObjects.put(getId(), this);
	}

	
	public AndroidBridgeArg getRelatedObjectField(String fieldName){
		return getFieldOfObject(getRelatedObject(),getRelatedObjectFields(), fieldName);
	}
	
	
	public void setRelatedObjectField(String fieldName,AndroidBridgeArg arg){
		setFieldOfObject(getRelatedObject(),getRelatedObjectFields(), fieldName, arg);
	}
	

	void setFieldOfObject(Object obj,Field[] fieldsForSearch,String fieldName,AndroidBridgeArg arg){
		for (Field f : fieldsForSearch) {
			if (f.getName().equals(fieldName)) {

				try {
					if (arg.getType()!=AndroidBridgeArg.TYPE_JAVA_INTERFACE_IMPL) {
						f.set(obj, arg.getRelatedValue());
					}else{
						if (f.getType().isInterface()) {
							f.set(obj, new JavaInterfaceImpl(arg.getJavaInterfaceImplId(), f.getType()));
						}
					}
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				}
				break;
			}
		}
	}


	AndroidBridgeArg getFieldOfObject(Object obj,Field[] fieldsForSearch,String fieldName){
		for (Field f : fieldsForSearch) {
			if (f.getName().equals(fieldName)) {

				try {
					return AndroidBridgeArg.encodeObject(f.get(obj));
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				}

				break;
			}
		}

		return null;
	}

	AndroidBridgeArg callMethodOnObject(Object obj,String methodName,Method[] methodsForSearch,AndroidBridgeArg[] args){

		Object[] argsForSend = new Object[args.length];
		for (int i = 0; i < argsForSend.length; i++) {
			if (args[i].getType()!=AndroidBridgeArg.TYPE_JAVA_INTERFACE_IMPL&&args[i].getType()!=AndroidBridgeArg.TYPE_ARG_ARRAY) {
				argsForSend[i]=args[i].getRelatedValue();
			}
		}

		Class<?>[] paramTypes = null;
		Class<?> paramType =null;
		boolean methodMatch = true;
		int argType = 0;
		for (Method method : methodsForSearch) {
			if (method.getName().equals(methodName)) {
				paramTypes = method.getParameterTypes();
				if (paramTypes.length==args.length) {
					
					methodMatch = true;
					for (int i = 0; i < paramTypes.length; i++) {
						paramType = paramTypes[i];
						argType = args[i].getType();

						if (argType==AndroidBridgeArg.TYPE_INT) {
							if (paramType==int.class||paramType==Integer.class) {
								continue;
							}else{
								methodMatch=false;
								break;
							}
						}else if (argType==AndroidBridgeArg.TYPE_NUMBER) {
							if (paramType==double.class||paramType==Double.class) {
								continue;
							}else if (paramType==float.class||paramType==Float.class) {
								argsForSend[i] = ((Double)argsForSend[i]).floatValue();
								continue;
							}else{
								methodMatch=false;
								break;
							}
						}else if(argType==AndroidBridgeArg.TYPE_BOOLEAN){
							if (paramType==boolean.class||paramType==Boolean.class) {
								continue;
							}else{
								methodMatch=false;
								break;
							}
						}else if (argType==AndroidBridgeArg.TYPE_JAVA_INTERFACE_IMPL) {
							if (paramType.isInterface()) {
								argsForSend[i] = new JavaInterfaceImpl(args[i].getJavaInterfaceImplId(), paramType).getProxyInstance();
								continue;
							}else{
								methodMatch=false;
								break;
							}
						}else if (argType==AndroidBridgeArg.TYPE_ARG_ARRAY) {
							if (paramType.isArray()) {
								continue;
							}else{
								methodMatch=false;
								break;
							}
						}else if(argType == AndroidBridgeArg.TYPE_NULL){
							argsForSend[i]=null;
							continue;
						}else{
							if (paramType.isAssignableFrom(argsForSend[i].getClass())) {
								continue;
							}else{
								methodMatch=false;
								break;
							}
						}
					}

					if (methodMatch) {
						try {
							Object result = method.invoke(obj, argsForSend);
							if (result!=null) {
								return AndroidBridgeArg.encodeObject(result);
							}
						} catch (IllegalArgumentException e) {
							e.printStackTrace();
						} catch (IllegalAccessException e) {
							e.printStackTrace();
						} catch (InvocationTargetException e) {
							e.printStackTrace();
						}

						break;
					}
				}
			}
		}

		return null;
	}


	public final AndroidBridgeArg callRelatedObjectMethod(String methodName,AndroidBridgeArg[] args){
		return callMethodOnObject(getRelatedObject(), methodName, getRelatedObjectMethods(), args);
	}


	public final Field[] getRelatedObjectFields() {
		if (relatedObjectFields==null) {
			relatedObjectFields = getRelatedObjectType().getFields();
		}
		return relatedObjectFields;
	}

	private Field[] relatedObjectFields = null;

	public final Method[] getRelatedObjectMethods() {
		if (relatedObjectMethods==null) {
			relatedObjectMethods = getRelatedObjectType().getMethods();
		}
		return relatedObjectMethods;
	}

	private Method[] relatedObjectMethods = null;

	public final Class<?> getRelatedObjectType() {
		if (relatedObjectType==null) {
			relatedObjectType = getRelatedObject().getClass();
		}
		return relatedObjectType;
	}

	private Class<?> relatedObjectType=null;

	public final Object getRelatedObject() {
		return relatedObject;
	}

	private Object relatedObject=null;

	private int id=0;
	private static int __id = 0;
	public final int getId() {
		return id;
	}






	public static final JavaObject getJavaObject(int id){
		return javaObjects.get(id);
	}

	public static final void removeJavaObject(int id){
		javaObjects.remove(id);
	}

	public static final void putJavaObject(JavaObject jo){
		javaObjects.put(jo.getId(), jo);
	}
	private static final Map<Integer, JavaObject> javaObjects = new ConcurrentHashMap<Integer, JavaObject>();
}
