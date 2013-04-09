/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package com.plter.androidbridge.android.widget
{
	import com.plter.androidbridge.android.view.ViewGroupMarginLayoutParams;
	
	public class RelativeLayoutLayoutParams extends ViewGroupMarginLayoutParams
	{
		public function RelativeLayoutLayoutParams(width:int, height:int, id:int=0, relatedJavaClassName:String="android.view.RelativeLayout$LayoutParams")
		{
			super(width, height, id, relatedJavaClassName);
		}
		
		
		public function addRule(verb:int):void{
			callRelatedObjectMethod("addRule",verb);
			_rules.push(verb);
		}
		
		public function removeRule(verb:int):void{
			callRelatedObjectMethod("removeRule",verb);
			
			for (var i:int = 0; i < _rules.length; i++) 
			{
				if (_rules[i]==verb) 
				{
					_rules.splice(i,1);
					break;
				}
			}
			
		}
		
		public function getRules():Array{
			return _rules;
		}
		
		private var _rules:Array=[];
	}
}