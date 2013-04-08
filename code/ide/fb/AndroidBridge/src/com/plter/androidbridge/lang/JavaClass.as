/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */



package com.plter.androidbridge.lang
{
	import com.plter.androidbridge.AndroidBridge;

	public final class JavaClass extends JavaObject
	{
		public function JavaClass(id:int=0)
		{
			super(id, null);
		}
		
		
		public function newInstance():JavaObject{
			return AndroidBridge.androidBridge.newInstance(id);
		}
		
		
		public function newInstanceWithArgs(...args):JavaObject{
			args.splice(0,0,id);
			return AndroidBridge.androidBridge.newInstanceWithArgs.apply(AndroidBridge.androidBridge,args);
		}
		
		
		public function callRelatedObjectStaticMethod(methodName:String,...args):Object{
			args.splice(0,0,id,methodName);
			return AndroidBridge.androidBridge.callRelatedObjectStaticMethod.apply(AndroidBridge.androidBridge,args);
		}
		
		public function setRelatedObjectStaticField(fieldName:String,value:Object):void{
			AndroidBridge.androidBridge.setRelatedObjectStaticField(id,fieldName,value);
		}
		
		public function getRelatedObjectStaticField(fieldName:String):Object{
			return AndroidBridge.androidBridge.getRelatedObjectStaticField(id,fieldName);
		}
		
		
		public static function findClass(className:String):JavaClass{
			
			var clazz:JavaClass=null;
			clazz = javaClassMap[className];
			if (clazz!=null) 
			{
				return clazz;
			}
			
			clazz= AndroidBridge.androidBridge.findClass(className);
			if (clazz!=null) 
			{
				javaClassMap[className] = clazz;
				return clazz;
			}
			return null;
		}
		
		private static const javaClassMap:Object={};
	}
}