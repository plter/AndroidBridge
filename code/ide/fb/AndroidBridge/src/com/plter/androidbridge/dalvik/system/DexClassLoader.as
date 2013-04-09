/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge.dalvik.system
{
	import com.plter.androidbridge.java.lang.ClassLoader;
	import com.plter.androidbridge.lang.JavaObject;

	public class DexClassLoader extends BaseDexClassLoader
	{
		public function DexClassLoader(dexPath:String, optimizedDirectory:String, libraryPath:String, parent:ClassLoader,id:int=0, relatedJavaClassName:String="dalvik.system.DexClassLoader")
		{
			_dexPath = dexPath;
			_optimizedDirectory = optimizedDirectory;
			_libraryPath = libraryPath;
			_parent = parent;
			
			super(id, relatedJavaClassName);
		}
		
		override protected function onCreateJavaObject():JavaObject{
			return getRelatedJavaClass().newInstanceWithArgs(_dexPath,_optimizedDirectory,_libraryPath,_parent);
		}
		
		private var _dexPath:String=null;
		private var _optimizedDirectory:String=null;
		private var _libraryPath:String=null;
		private var _parent:ClassLoader=null;
	}
}