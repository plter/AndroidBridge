/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge.android.view
{
	import com.plter.androidbridge.android.content.Context;
	import com.plter.androidbridge.lang.JavaInterfaceImpl;
	import com.plter.androidbridge.lang.JavaObject;
	
	public class View extends JavaObject
	{
		public function View(context:Context,id:int=0, relatedJavaClassName:String="android.view.View")
		{
			_context = context;
			super(id, relatedJavaClassName);
		}
		
		override protected function onCreateJavaObject():JavaObject{
			return getRelatedJavaClass().newInstanceWithArgs(context);
		}
		
		
		public function setBackgroundColor(color:int):void{
			callRelatedObjectMethod("setBackgroundColor",color);
		}
		
		public function setOnClickListener(listener:JavaInterfaceImpl):void{
			callRelatedObjectMethod("setOnClickListener",listener);
		}
		
		public function getLayoutParams():ViewGroupLayoutParams{
			return new ViewGroupLayoutParams(0,0,JavaObject(callRelatedObjectMethod("getLayoutParams")).id,null);
		}
		
		public function setLayoutParams(lp:ViewGroupLayoutParams):void{
			callRelatedObjectMethod("setLayoutParams",lp);
		}
		
		private var _context:Context=null;
		
		public function get context():Context
		{
			return _context;
		}

	}
}