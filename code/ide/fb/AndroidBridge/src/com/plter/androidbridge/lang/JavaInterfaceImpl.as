/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */



package com.plter.androidbridge.lang
{
	public class JavaInterfaceImpl
	{
		public function JavaInterfaceImpl(callback:Function)
		{
			__id++;
			_id = __id;
			javaInterfaceImplMap[_id] = this;
			
			_callback = callback;
		}
		
		
		private var _id:int=0;

		public function get id():int
		{
			return _id;
		}
		
		
		private var _callback:Function=null;

		public function get callback():Function
		{
			return _callback;
		}
		
		private static var __id:int=0;
		
		public static function getJavaInterfaceImpl(javaInterfaceImplId:int):JavaInterfaceImpl{
			return javaInterfaceImplMap[javaInterfaceImplId];
		}
		
		private static const javaInterfaceImplMap:Object={};

	}
}