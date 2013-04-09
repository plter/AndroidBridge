/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge.android.widget
{
	import com.plter.androidbridge.android.content.Context;
	import com.plter.androidbridge.android.view.View;
	
	public class TextView extends View
	{
		public function TextView(context:Context, id:int=0, relatedJavaClassName:String="android.widget.TextView")
		{
			super(context, id, relatedJavaClassName);
		}
		
		private var _text:String=null;
		
		public function setText(text:String):void{
			callRelatedObjectMethod("setText",text);
			_text = text;
		}
		
		public function getText():String{
			return _text;
		}
	}
}