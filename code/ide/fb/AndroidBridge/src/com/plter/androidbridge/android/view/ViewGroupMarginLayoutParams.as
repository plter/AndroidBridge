/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge.android.view
{
	public class ViewGroupMarginLayoutParams extends ViewGroupLayoutParams
	{
		public function ViewGroupMarginLayoutParams(width:int, height:int, id:int=0, relatedJavaClassName:String="android.view.ViewGroup$MarginLayoutParams")
		{
			super(width, height, id, relatedJavaClassName);
		}
		

		public function get bottomMargin():int
		{
			return getRelatedObjectField("bottomMargin") as int;
		}

		public function set bottomMargin(value:int):void
		{
			setRelatedObjectField("bottomMargin",value);
		}


		public function get leftMargin():int
		{
			return getRelatedObjectField("leftMargin") as int;
		}

		public function set leftMargin(value:int):void
		{
			setRelatedObjectField("leftMargin",value);
		}


		public function get rightMargin():int
		{
			return getRelatedObjectField("rightMargin") as int;
		}

		public function set rightMargin(value:int):void
		{
			setRelatedObjectField("rightMargin",value);
		}


		public function get topMargin():int
		{
			return getRelatedObjectField("topMargin") as int;
		}

		public function set topMargin(value:int):void
		{
			setRelatedObjectField("topMargin",value);
		}

	}
}