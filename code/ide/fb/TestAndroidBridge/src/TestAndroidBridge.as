package
{
	import com.plter.androidbridge.android.app.Activity;
	import com.plter.androidbridge.android.app.AlertDialogBuilder;
	import com.plter.androidbridge.android.view.ViewGroupLayoutParams;
	import com.plter.androidbridge.android.widget.Button;
	import com.plter.androidbridge.android.widget.LinearLayout;
	import com.plter.androidbridge.lang.JavaIntefaceImplCallbackData;
	import com.plter.androidbridge.lang.JavaInterfaceImpl;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class TestAndroidBridge extends Sprite
	{
		
		[Embed(source="../assets/DexHello.jar",mimeType="application/octet-stream")]
		public static var HelloLibBytes:Class;
		
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
			
			
			//embed jar example
//			var libBytes:ByteArray = new HelloLibBytes;
//			var dir:File = Activity.getMainActivity().getDir("dex");
//			
//			var libFile:File = dir.resolvePath("lib.jar");
//			var fs:FileStream = new FileStream;
//			fs.open(libFile,FileMode.WRITE);
//			fs.writeBytes(libBytes);
//			fs.close();
//			
//			var loader:DexClassLoader = new DexClassLoader(libFile.nativePath,dir.nativePath,null,ClassLoader.getSystemClassLoader());
//			var HelloClass:JavaClass = loader.loadClass("com.plter.jl.Hello");
//			var h:JavaObject = HelloClass.newInstance();
//			h.setRelatedObjectField("intVar",9);
//			trace(h.getRelatedObjectField("intVar"));
//			HelloClass.setRelatedObjectStaticField("strVar","Haha");
//			trace(HelloClass.getRelatedObjectStaticField("strVar"));
			
			var aty:Activity = Activity.getMainActivity();
			var ll:LinearLayout = new LinearLayout(aty);
			ll.setOrientation(LinearLayout.VERTICAL);
			
			var lp:ViewGroupLayoutParams = new ViewGroupLayoutParams(-1,-1);
			aty.addContentView(ll,lp);
			
			var btn:Button = new Button(aty);
			btn.setText("Button 1");
			ll.addView(btn,-1,-2);
			btn = new Button(aty);
			ll.addView(btn,-1,-2);
			btn.setText("Button 2");
			btn.setOnClickListener(new JavaInterfaceImpl(function(data:JavaIntefaceImplCallbackData):void{
				new AlertDialogBuilder(Activity.getMainActivity()).setTitle("标题").setMessage("Haha").setPositiveButton("OK",null).show();
			}));
		}
	}
}