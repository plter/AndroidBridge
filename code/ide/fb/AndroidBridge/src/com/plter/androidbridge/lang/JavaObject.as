/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */



package com.plter.androidbridge.lang
{
	import com.plter.androidbridge.AndroidBridge;
	

	public class JavaObject
	{
		public function JavaObject(id:int=0,relatedJavaClassName:String=null)
		{
			_id = id;
			_relatedJavaClassName = relatedJavaClassName;
			
			var jo:JavaObject = onCreateJavaObject();
			if (jo!=null) 
			{
				_id = jo.id;
			}
		}
		
		
		public function callRelatedObjectMethod(methodName:String,...args):Object{
			args.splice(0,0,id,methodName);
			return AndroidBridge.androidBridge.callRelatedObjectMethod.apply(AndroidBridge.androidBridge,args);
		}
		
		public function setRelatedObjectField(fieldName:String,value:Object):void{
			AndroidBridge.androidBridge.setRelatedObjectField(id,fieldName,value);
		}
		
		public function getRelatedObjectField(fieldName:String):Object{
			return AndroidBridge.androidBridge.getRelatedObjectField(id,fieldName);
		}
		
		public function dispose():void{
			AndroidBridge.androidBridge.disposeRelatedObjectObject(id);
		}
		
		
		/**
		 * 子类重写此方法用于不同的创建操作
		 */
		protected function onCreateJavaObject():JavaObject{
			return null;
		}
		
		
		private var _id:int=0;

		public function get id():int
		{
			return _id;
		}
		
		private var _relatedJavaClassName:String=null;

		public function get relatedJavaClassName():String
		{
			return _relatedJavaClassName;
		}

		
		public function getJavaClass():JavaClass{
			if (relatedJavaClassName==null) 
			{
				return null;
			}
			
			return JavaClass.findClass(relatedJavaClassName);
		}
	}
}