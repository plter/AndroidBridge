/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge.java.lang
{
	import com.plter.androidbridge.lang.JavaClass;
	import com.plter.androidbridge.lang.JavaObject;
	
	public class ClassLoader extends JavaObject
	{
		public function ClassLoader(id:int=0, relatedJavaClassName:String=null)
		{
			super(id, relatedJavaClassName);
		}
		
		
		public static function getSystemClassLoader():ClassLoader{
			return new ClassLoader(JavaObject(getRelatedJavaClass().callRelatedObjectStaticMethod("getSystemClassLoader")).id);
		}
		
		
		public function loadClass(className:String):JavaClass{
			var c:JavaClass = classDefMap[className];
			
			if (c!=null) 
			{
				return c;
			}
			
			var jo:JavaObject = callRelatedObjectMethod("loadClass",className) as JavaObject;
			if (jo!=null) 
			{
				c = new JavaClass(jo.id);
				classDefMap[className]=c;
				return c;
			}
			
			return null;
		}
		
		private const classDefMap:Object = {};
		
		
		public static function getRelatedJavaClass():JavaClass{
			if (_javaClass==null) 
			{
				_javaClass = JavaClass.findClass("java.lang.ClassLoader");
			}
			return _javaClass;
		}
		
		private static var _javaClass:JavaClass=null;
	}
}