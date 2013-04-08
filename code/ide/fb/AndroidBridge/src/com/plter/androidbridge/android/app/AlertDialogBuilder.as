package com.plter.androidbridge.android.app
{
	import com.plter.androidbridge.android.content.Context;
	import com.plter.androidbridge.lang.JavaInterfaceImpl;
	import com.plter.androidbridge.lang.JavaObject;
	
	public class AlertDialogBuilder extends JavaObject
	{
		public function AlertDialogBuilder(context:Context,id:int=0, relatedJavaClassName:String="android.app.AlertDialog$Builder")
		{
			_context = context;
			
			super(id, relatedJavaClassName);
		}
		
		
		public function setMessage(msg:String):AlertDialogBuilder{
			callRelatedObjectMethod("setMessage",msg);
			return this;
		}
		
		public function show():void{
			callRelatedObjectMethod("show");
		}
		
		public function setTitle(title:String):AlertDialogBuilder{
			callRelatedObjectMethod("setTitle",title);
			return this;
		}
		
		public function setPositiveButton(text:String,clickHandler:JavaInterfaceImpl=null):AlertDialogBuilder{
			callRelatedObjectMethod("setPositiveButton",text,clickHandler);
			return this;
		}
		
		
		public function get context():Context
		{
			return _context;
		}

		override protected function onCreateJavaObject():JavaObject{
			return getJavaClass().newInstanceWithArgs(context);
		}
		
		private var _context:Context=null;
	}
}