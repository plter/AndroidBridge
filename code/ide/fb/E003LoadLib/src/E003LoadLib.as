/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */


package
{
	import com.plter.androidbridge.android.app.Activity;
	import com.plter.androidbridge.dalvik.system.DexClassLoader;
	import com.plter.androidbridge.java.lang.ClassLoader;
	import com.plter.androidbridge.lang.JavaClass;
	import com.plter.androidbridge.lang.JavaObject;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	public class E003LoadLib extends Sprite
	{
		
		[Embed(source="../assets/DexHello.jar",mimeType="application/octet-stream")]
		private static var DexHelloBytes:Class;
		
		public function E003LoadLib()
		{
			super();
			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var dexHelloBytes:ByteArray = new DexHelloBytes;
			
			var aty:Activity = Activity.getMainActivity();
			var appDir:File = aty.getDir("dex");
			var dexFile:File = appDir.resolvePath("DexHello.jar");
			var fs:FileStream = new FileStream;
			fs.open(dexFile,FileMode.WRITE);
			fs.writeBytes(dexHelloBytes);
			fs.close();
			
			var dcl:DexClassLoader = new DexClassLoader(dexFile.nativePath,appDir.nativePath,null,ClassLoader.getSystemClassLoader());
			var HelloClass:JavaClass = dcl.loadClass("com.plter.javalib.Hello");
			trace(HelloClass.callRelatedObjectStaticMethod("sayHello"));
			HelloClass.setRelatedObjectStaticField("intVar",12);
			trace(HelloClass.getRelatedObjectStaticField("intVar"));
			
			var h:JavaObject = HelloClass.newInstance();
			trace(h.callRelatedObjectMethod("sayHi"));
			h.setRelatedObjectField("strVar","Haha");
			trace(h.getRelatedObjectField("strVar"));
		}
	}
}