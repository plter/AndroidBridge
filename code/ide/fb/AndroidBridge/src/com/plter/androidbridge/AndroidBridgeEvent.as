/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */




package com.plter.androidbridge
{
	import com.plter.androidbridge.lang.JavaIntefaceImplCallbackData;
	
	import flash.events.Event;
	
	
	
	
	public class AndroidBridgeEvent extends Event
	{
		public static const JAVA_INTERFACE_IMPL_CALLBACK:String="javaInterfaceImplCallback";
		
		
		
		public function AndroidBridgeEvent(type:String, data:JavaIntefaceImplCallbackData)
		{
			super(type, false, false);
			
			_data=data;
		}
		
		private var _data:JavaIntefaceImplCallbackData=null;
		
		public function get data():JavaIntefaceImplCallbackData
		{
			return _data;
		}
		
		
		override public function clone():Event{
			return new AndroidBridgeEvent(type,data);
		}
		
	}
}