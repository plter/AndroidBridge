/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */



package com.plter.androidbridge
{
	import com.plter.androidbridge.errors.ErrorUnsupportedOpration;
	import com.plter.androidbridge.lang.JavaInterfaceImpl;
	import com.plter.androidbridge.lang.JavaObject;

	public class AndroidBridgeArg
	{
		public function AndroidBridgeArg(type:int,value:Object)
		{
			_type=type;
			_value =value;
		}
		
		private var _type:int=0;

		public function get type():int
		{
			return _type;
		}

		private var _value:Object=null;

		public function get value():Object
		{
			return _value;
		}
		
		
		public function toJSONString():String{
			return JSON.stringify({type:type,value:value});
		}
		
		public function get javaObjectId():int{
			if (type==TYPE_JAVA_OBJECT) 
			{
				if (_javaObjectId==0) 
				{
					_javaObjectId = value as int;
				}
				
				return _javaObjectId;
			}
			
			return 0;
		}
		
		private var _javaObjectId:int=0;
		
		public function get javaObject():JavaObject{
			if (type==TYPE_JAVA_OBJECT) 
			{
				if (_javaObject==null&&javaObjectId>0) 
				{
					_javaObject = new JavaObject(javaObjectId);
				}
				return _javaObject;
			}
			
			return null;
		}
		
		private var _javaObject:JavaObject=null;
		
		
		
		public static function encodeJSONStringToArg(json:String):AndroidBridgeArg{
			if (json==null) 
			{
				return null;
			}
			
			return encodeJSONObjectToArg(JSON.parse(json));
		}
		
		public static function encodeJSONObjectToArg(json:Object):AndroidBridgeArg{
			return new AndroidBridgeArg(json.type,json.value);
		}
		
		
		public static function decodeJSONString(json:String):Object{
			if (json==null) 
			{
				return null;
			}
			return decodeJSON(JSON.parse(json));
		}
		
		
		public static function encodeObjectToArgJSONString(obj:Object):String{
			return JSON.stringify(encodeObjectToArgJSON(obj));
		}
		
		
		public static function encodeObjectToArgJSON(obj:Object):Object{
			if (obj==null) 
			{
				return {type:TYPE_NULL,value:null};
			}
			
			if (obj is String) 
			{
				return {type:TYPE_STRING,value:obj};
			}else if (obj is int) 
			{
				return {type:TYPE_INT,value:obj};
			}else if(obj is Boolean){
				return {type:TYPE_BOOLEAN,value:obj};
			}else if (obj is Number) 
			{
				return {type:TYPE_NUMBER,value:obj};
			}else if (obj is JavaObject) 
			{
				return {type:TYPE_JAVA_OBJECT,value:obj.id};
			}else if (obj is JavaInterfaceImpl) 
			{
				return {type:TYPE_JAVA_INTERFACE_IMPL,value:obj.id};
			}else if (obj is Array||obj is Vector) 
			{
				var target:Array = [];
				for (var i:int = 0; i < obj.length; i++) 
				{
					target[i] = encodeObjectToArgJSON(obj[i]);
				}
				return {type:TYPE_ARG_ARRAY,value:target};
			}else{
				throw new ErrorUnsupportedOpration("不支持直接将非原生的ActionScript对象传给Java");
			}
		}
		
		
		public static function decodeJSON(json:Object):Object{
			var arg:AndroidBridgeArg = encodeJSONObjectToArg(json);
			if (arg.type==TYPE_JAVA_OBJECT) 
			{
				return arg.javaObject;
			}else{
				return arg.value;
			}
		}
		
		public static const TYPE_INT:int=1;
		public static const TYPE_STRING:int=2;
		public static const TYPE_NUMBER:int=3;
		public static const TYPE_BOOLEAN:int=4;
		public static const TYPE_JAVA_OBJECT:int=5;
		public static const TYPE_JAVA_INTERFACE_IMPL:int=6;
		public static const TYPE_NULL:int=7;
		public static const TYPE_UNKNOW:int=8;
		public static const TYPE_ARG_ARRAY:int=9;
	}
	
}