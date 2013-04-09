/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge.android.widget
{
	import com.plter.androidbridge.android.content.Context;
	import com.plter.androidbridge.android.view.ViewGroup;
	
	public class LinearLayout extends ViewGroup
	{
		public function LinearLayout(context:Context, id:int=0, relatedJavaClassName:String="android.widget.LinearLayout")
		{
			super(context, id, relatedJavaClassName);
		}
		
		public function setOrientation(o:int):void{
			callRelatedObjectMethod("setOrientation",o);
		}
		
		public static const HORIZONTAL:int=0;
		public static const VERTICAL:int=1;
	}
}