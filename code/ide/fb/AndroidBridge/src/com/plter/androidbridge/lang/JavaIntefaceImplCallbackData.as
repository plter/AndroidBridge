/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */



package com.plter.androidbridge.lang
{
	import com.plter.androidbridge.AndroidBridgeArg;

	public class JavaIntefaceImplCallbackData
	{
		public function JavaIntefaceImplCallbackData(javaInterfaceImplId:int,methodName:String,args:Array)
		{
			_javaInterfaceImplId = javaInterfaceImplId;
			_methodName = methodName;
			_args = args;
		}
		
		private var _args:Array=null;

		public function get args():Array
		{
			return _args;
		}

		private var _methodName:String=null;

		public function get methodName():String
		{
			return _methodName;
		}

		private var _javaInterfaceImplId:int = 0;

		public function get javaInterfaceImplId():int
		{
			return _javaInterfaceImplId;
		}

		
		public static function parseJSON(json:Object):JavaIntefaceImplCallbackData{
			var args:Array = json.args;
			for (var i:int = 0; i < args.length; i++) 
			{
				args[i]=AndroidBridgeArg.decodeJSON(args[i]);
			}
			
			return new JavaIntefaceImplCallbackData(json.javaInterfaceImplId,json.methodName,args);
		}
		
		public static function parseJSONString(json:String):JavaIntefaceImplCallbackData{
			if (json==null) 
			{
				return null;
			}
			
			return parseJSON(JSON.parse(json));
		}
	}
}