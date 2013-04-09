/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge.android.view
{
	import com.plter.androidbridge.lang.JavaObject;
	
	public class ViewGroupLayoutParams extends JavaObject
	{
		public function ViewGroupLayoutParams(width:int,height:int,id:int=0, relatedJavaClassName:String="android.view.ViewGroup$LayoutParams")
		{
			_width=width;
			_height=height;
			
			super(id, relatedJavaClassName);
		}
		
		private var _width:int=-1;
		private var _height:int=-2;
		
		override protected function onCreateJavaObject():JavaObject{
			return getRelatedJavaClass().newInstanceWithArgs(_width,_height);
		}
		

		public function get height():int
		{
			return getRelatedObjectField("height") as int;
		}

		public function set height(value:int):void
		{
			setRelatedObjectField("height",value);
		}

		public function get width():int
		{
			return getRelatedObjectField("width") as int;
		}

		public function set width(value:int):void
		{
			setRelatedObjectField("width",value);
		}

	}
}