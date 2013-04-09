/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge.android.view
{
	import com.plter.androidbridge.android.content.Context;
	
	public class ViewGroup extends View
	{
		public function ViewGroup(context:Context, id:int=0, relatedJavaClassName:String="android.view.ViewGroup")
		{
			super(context, id, relatedJavaClassName);
		}
		
		
		public function addView(child:View, width:int, height:int):void{
			callRelatedObjectMethod("addView",child,width,height);
		}
		
		public function addView1(child:View):void{
			callRelatedObjectMethod("addView",child);
		}
		
		public function addView2(child:View,index:int):void{
			callRelatedObjectMethod("addView",child,index);
		}
		
		public function removeView(child:View):void{
			callRelatedObjectMethod("removeView",child);
		}
		
		public function removeAllViews():void{
			callRelatedObjectMethod("removeAllViews");
		}
		
		public function removeViewAt(index:int):void{
			callRelatedObjectMethod("removeViewAt",index);
		}
		
	}
}