/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package
{
	import com.plter.androidbridge.android.app.Activity;
	import com.plter.androidbridge.android.view.ViewGroupLayoutParams;
	import com.plter.androidbridge.android.widget.Button;
	import com.plter.androidbridge.android.widget.LinearLayout;
	import com.plter.androidbridge.lang.JavaIntefaceImplCallbackData;
	import com.plter.androidbridge.lang.JavaInterfaceImpl;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class E002UsingAndroidUI extends Sprite
	{
		public function E002UsingAndroidUI()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var aty:Activity = Activity.getMainActivity();
			var ll:LinearLayout = new LinearLayout(aty);
			ll.setOrientation(LinearLayout.VERTICAL);
			var lp:ViewGroupLayoutParams = new ViewGroupLayoutParams(-1,-1);
			aty.addContentView(ll,lp);
			
			var btn:Button = new Button(aty);
			btn.setText("Click me 1");
			ll.addView(btn,-1,-2);
			
			btn = new Button(aty);
			btn.setText("Click me 2");
			ll.addView(btn,-1,-2);
			btn.setOnClickListener(new JavaInterfaceImpl(function(data:JavaIntefaceImplCallbackData):void{
				trace("Button Clicked");
			}));
		}
	}
}