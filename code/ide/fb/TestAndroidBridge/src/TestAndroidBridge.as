package
{
	import com.plter.androidbridge.android.app.Activity;
	import com.plter.androidbridge.android.app.AlertDialogBuilder;
	import com.plter.androidbridge.java.lang.ClassLoader;
	import com.plter.androidbridge.lang.JavaIntefaceImplCallbackData;
	import com.plter.androidbridge.lang.JavaInterfaceImpl;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class TestAndroidBridge extends Sprite
	{
		public function TestAndroidBridge()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
//			new AlertDialogBuilder(Activity.getMainActivity()).setMessage("Haha").setPositiveButton("OK",new JavaInterfaceImpl(function(data:JavaIntefaceImplCallbackData):void{
//			
//				trace(JSON.stringify(data));
//			})).show();
			
//			trace(ClassLoader.getSystemClassLoader().id);
			
//			trace(Activity.getMainActivity().getDir("my").nativePath);
		}
	}
}