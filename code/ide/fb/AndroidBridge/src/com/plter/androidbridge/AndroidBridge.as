package com.plter.androidbridge
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class AndroidBridge extends EventDispatcher
	{
		public function AndroidBridge(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}