/**
 * 
 * @author plter 
 * website http://plter.com http://plter.sinaapp.com
 * email xtiqin@163.com
 */



package com.plter.androidbridge.lang
{
	import com.plter.androidbridge.AndroidBridge;
	import com.plter.androidbridge.errors.ErrorCannotCreateInstance;
	

	public class JavaObject
	{
		public function JavaObject(id:int=0,relatedJavaClassName:String=null)
		{
			if (id>0) 
			{
				_id = id;
			}else if (relatedJavaClassName!=null) 
			{
				_relatedJavaClassName = relatedJavaClassName;
				
				var jo:JavaObject = onCreateJavaObject();
				if (jo!=null) 
				{
					_id = jo.id;
				}else{
					throw new ErrorCannotCreateInstance("无法创建该实例");
				}
			}else{
				throw new ErrorCannotCreateInstance("既没有指定id，又没有指定类名，所以无法创建该实例");
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

		
		public function getRelatedJavaClass():JavaClass{
			if (relatedJavaClassName==null) 
			{
				return null;
			}
			
			return JavaClass.findClass(relatedJavaClassName);
		}
	}
}