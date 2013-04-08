/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */



package com.plter.androidbridge.android.app
{
	import com.plter.androidbridge.AndroidBridge;
	import com.plter.androidbridge.android.view.ContextThemeWrapper;
	import com.plter.androidbridge.lang.JavaObject;
	
	import flash.filesystem.File;
	
	public class Activity extends ContextThemeWrapper
	{
		public function Activity(id:int=0, relatedJavaClassName:String=null)
		{
			super(id, relatedJavaClassName);
		}
		
		
		public function getDir(name:String):File{
			return new File(JavaObject(callRelatedObjectMethod("getDir",name,0)).callRelatedObjectMethod("getAbsolutePath") as String);
		}
		
		
		public static function getMainActivity():Activity{
			if (_mainAty==null) 
			{
				_mainAty = new Activity(AndroidBridge.androidBridge.getMainActivity().id);
			}
			return _mainAty;
		}
		
		private static var _mainAty:Activity=null;
	}
}