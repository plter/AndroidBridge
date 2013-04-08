/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */

package com.plter.androidbridge.lang;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.plter.androidbridge.AndroidBridgeArg;

public class JavaClass extends JavaObject {

	public JavaClass(Class<?> relatedObject) {
		super(relatedObject);
	}


	public AndroidBridgeArg newInstance(){
		try {
			return AndroidBridgeArg.encodeObject(getRelatedClass().newInstance());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		}
		return null;
	}


	public AndroidBridgeArg newInstanceWithArgs(AndroidBridgeArg[] args){
		
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
		for (Constructor<?> ct : getRelatedClassConstructors()) {
			paramTypes = ct.getParameterTypes();
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
						Object result = ct.newInstance(argsForSend);
						if (result!=null) {
							return AndroidBridgeArg.encodeObject(result);
						}
					} catch (IllegalArgumentException e) {
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					} catch (InvocationTargetException e) {
						e.printStackTrace();
					} catch (InstantiationException e) {
						e.printStackTrace();
					}

					break;
				}
			}
		}

		return null;
	}

	
	public void setRelatedObjectStaticField(String fieldName,AndroidBridgeArg arg){
		setFieldOfObject(getRelatedClass(), getRelatedClassFields(), fieldName, arg);
	}
	
	
	public AndroidBridgeArg getRelatedObjectStaticField(String fieldName){
		return getFieldOfObject(getRelatedClass(), getRelatedClassFields(), fieldName);
	}
	

	public Field[] getRelatedClassFields() {
		if (relatedClassFields==null) {
			relatedClassFields = getRelatedClass().getFields();
		}
		return relatedClassFields;
	}
	
	private Field[] relatedClassFields = null;
	
	public AndroidBridgeArg callRelatedObjectStaticMethod(String methodName,AndroidBridgeArg[] args){
		return callMethodOnObject(getRelatedClass(), methodName, getRelatedClassMethods(), args);
	}

	public Constructor<?>[] getRelatedClassConstructors() {
		if (relatedClassConstructors==null) {
			relatedClassConstructors = getRelatedClass().getConstructors();
		}
		return relatedClassConstructors;
	}
	private Constructor<?>[] relatedClassConstructors = null;


	public Method[] getRelatedClassMethods() {
		if (relatedClassMethods==null) {
			relatedClassMethods = getRelatedClass().getMethods();
		}
		return relatedClassMethods;
	}
	private Method[] relatedClassMethods = null;

	public Class<?> getRelatedClass(){
		return (Class<?>) getRelatedObject();
	}

	public static final AndroidBridgeArg findClass(String className){
		JavaClass jc = javaClasses.get(className);
		if (jc==null) {
			Class<?> c = null;
			try {
				c = Class.forName(className);
			} catch (ClassNotFoundException e) {
			}
			if(c!=null) {
				jc = new JavaClass(c);
				return AndroidBridgeArg.encodeObject(jc);
			}else{
				return null;
			}
		}

		return null;
	}

	private static final Map<String, JavaClass> javaClasses = new ConcurrentHashMap<String, JavaClass>();

}
