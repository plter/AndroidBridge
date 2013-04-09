/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */



package com.plter.androidbridge
{
	import com.plter.androidbridge.lang.JavaClass;
	import com.plter.androidbridge.lang.JavaIntefaceImplCallbackData;
	import com.plter.androidbridge.lang.JavaInterfaceImpl;
	import com.plter.androidbridge.lang.JavaObject;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	[Event(name="javaInterfaceImplCallback", type="com.plter.androidbridge.AndroidBridgeEvent")]
	public class AndroidBridge extends EventDispatcher
	{
	
		
		private static var __ins:AndroidBridge=null;
		private static var __locked:Boolean=true;
		
		public static function get androidBridge():AndroidBridge{
			if (__ins==null) 
			{
				__locked=false;
				__ins = new AndroidBridge;
				__locked=true;
			}
			
			return __ins;
		}
		
		
		
		
		private var _ec:ExtensionContext=null;
		
		public function AndroidBridge()
		{
			
			if (__locked) 
			{
				throw new Error("该类不允许实例化");
			}
			
			_ec = ExtensionContext.createExtensionContext(EXT_ID,null);
			_ec.addEventListener(StatusEvent.STATUS,_ec_statusHandler);
		}
		
		protected function _ec_statusHandler(event:StatusEvent):void
		{
			if (event.code==AndroidBridgeEvent.JAVA_INTERFACE_IMPL_CALLBACK)  
			{
				var data:JavaIntefaceImplCallbackData = JavaIntefaceImplCallbackData.parseJSONString(event.level);
				if (data!=null) 
				{
					dispatchEvent(new AndroidBridgeEvent(AndroidBridgeEvent.JAVA_INTERFACE_IMPL_CALLBACK,data));
					
					var javaInterfaceImpl:JavaInterfaceImpl = JavaInterfaceImpl.getJavaInterfaceImpl(data.javaInterfaceImplId);
					if (javaInterfaceImpl!=null) 
					{
						if (javaInterfaceImpl.callback!=null) 
						{
							javaInterfaceImpl.callback(data);
						}
					}
				}
			}
		}
		
		
		public function callRelatedObjectMethod(id:int,methodName:String,... args):Object{
			
//			trace("call method "+methodName,"arg len "+args.length);
			
			var argsForSend:Array=[];
			argsForSend.push("callRelatedObjectMethod",id,methodName);
			
			for (var i:int = 0; i < args.length; i++) 
			{
				argsForSend.push(AndroidBridgeArg.encodeObjectToArgJSONString(args[i]));
			}
			
			return AndroidBridgeArg.decodeJSONString(_ec.call.apply(_ec,argsForSend));
		}
		
		public function newInstance(id:int):JavaObject{
			return AndroidBridgeArg.decodeJSONString(_ec.call("newInstance",id) as String) as JavaObject;
		}
		
		public function newInstanceWithArgs(id:int,... args):JavaObject{
			var argsForSend:Array=[];
			argsForSend.push("newInstanceWithArgs",id);
			
			for (var i:int = 0; i < args.length; i++) 
			{
				argsForSend.push(AndroidBridgeArg.encodeObjectToArgJSONString(args[i]));
			}
			
			return AndroidBridgeArg.decodeJSONString(_ec.call.apply(_ec,argsForSend) as String) as JavaObject;
		}
		
		public function callRelatedObjectStaticMethod(id:int,methodName:String,... args):Object{
			
			var argsForSend:Array=[];
			argsForSend.push("callRelatedObjectStaticMethod",id,methodName);
			
			for (var i:int = 0; i < args.length; i++) 
			{
				argsForSend.push(AndroidBridgeArg.encodeObjectToArgJSONString(args[i]));
			}
			
			return AndroidBridgeArg.decodeJSONString(_ec.call.apply(_ec,argsForSend));
		}
		
		public function setRelatedObjectField(id:int,fieldName:String,value:Object):void{
			_ec.call("setRelatedObjectField",id,fieldName,AndroidBridgeArg.encodeObjectToArgJSONString(value));
		}
		
		public function setRelatedObjectStaticField(id:int,fieldName:String,value:Object):void{
			_ec.call("setRelatedObjectStaticField",id,fieldName,AndroidBridgeArg.encodeObjectToArgJSONString(value));
		}
		
		public function getRelatedObjectField(id:int,fieldName:String):Object{
			return AndroidBridgeArg.decodeJSONString(_ec.call("getRelatedObjectField",id,fieldName) as String);
		}
		
		public function getRelatedObjectStaticField(id:int,fieldName:String):Object{
			return AndroidBridgeArg.decodeJSONString(_ec.call("getRelatedObjectStaticField",id,fieldName) as String);
		}
		
		public function disposeRelatedObjectObject(id:int):void{
			_ec.call("disposeRelatedObjectObject",id);
		}
		
		public function findClass(className:String):JavaClass{
			var resultJson:String = _ec.call("findClass",className) as String;
			
			if (resultJson!=null) 
			{
				var obj:Object = JSON.parse(resultJson);
				return new JavaClass(obj.value);
			}
			return null;
		}
		
		public function getMainActivity():JavaObject{
			return AndroidBridgeArg.decodeJSONString(_ec.call("getMainActivity") as String) as JavaObject;
		}
		
		
		private static const EXT_ID:String="com.plter.AndroidBridge";
	}
}