/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package
{
	import com.plter.androidbridge.android.app.Activity;
	import com.plter.androidbridge.android.app.AlertDialogBuilder;
	import com.plter.androidbridge.lang.JavaIntefaceImplCallbackData;
	import com.plter.androidbridge.lang.JavaInterfaceImpl;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class E001HelloAB extends Sprite
	{
		public function E001HelloAB()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var ab:AlertDialogBuilder = new AlertDialogBuilder(Activity.getMainActivity()).setTitle("标题").setMessage("内容").setPositiveButton("OK",new JavaInterfaceImpl(function(data:JavaIntefaceImplCallbackData):void{
				trace("OK Button clicked ,and the dialog is closed,java callback name:"+data.methodName);
			}));
			ab.show();
			ab.dispose();
		}
	}
}