package
{
	import com.plter.androidbridge.android.app.Activity;
	import com.plter.androidbridge.android.app.AlertDialogBuilder;
	import com.plter.androidbridge.dalvik.system.DexClassLoader;
	import com.plter.androidbridge.java.lang.ClassLoader;
	import com.plter.androidbridge.lang.JavaClass;
	import com.plter.androidbridge.lang.JavaIntefaceImplCallbackData;
	import com.plter.androidbridge.lang.JavaInterfaceImpl;
	import com.plter.androidbridge.lang.JavaObject;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
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
			var libBytes:ByteArray = new HelloLibBytes;
			var dir:File = Activity.getMainActivity().getDir("dex");
			
			var libFile:File = dir.resolvePath("lib.jar");
			var fs:FileStream = new FileStream;
			fs.open(libFile,FileMode.WRITE);
			fs.writeBytes(libBytes);
			fs.close();
			
			var loader:DexClassLoader = new DexClassLoader(libFile.nativePath,dir.nativePath,null,ClassLoader.getSystemClassLoader());
			var HelloClass:JavaClass = loader.loadClass("com.plter.jl.Hello");
			var h:JavaObject = HelloClass.newInstance();
			h.setRelatedObjectField("intVar",9);
			trace(h.getRelatedObjectField("intVar"));
			HelloClass.setRelatedObjectStaticField("strVar","Haha");
			trace(HelloClass.getRelatedObjectStaticField("strVar"));
		}
	}
}