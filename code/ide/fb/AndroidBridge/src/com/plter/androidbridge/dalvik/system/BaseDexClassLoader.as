/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge.dalvik.system
{
	import com.plter.androidbridge.java.lang.ClassLoader;
	
	public class BaseDexClassLoader extends ClassLoader
	{
		public function BaseDexClassLoader(id:int=0, relatedJavaClassName:String=null)
		{
			super(id, relatedJavaClassName);
		}
	}
}