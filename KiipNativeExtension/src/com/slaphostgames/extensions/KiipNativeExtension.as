package com.slaphostgames.extensions
{
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;
	
	public class KiipNativeExtension extends EventDispatcher
	{
		
		private var extContext:ExtensionContext;
		
		public function KiipNativeExtension()
		{
			super();
			
			extContext = ExtensionContext.createExtensionContext("com.slaphostgames.extensions.KiipNativeExtension", "" );
			
			if ( !extContext ) {
				throw new Error( "Kiip native extension is not supported on this platform." );
			}
		}
		
		public function setLocation():void {
			
			extContext.call("setLocation");
		}
		
		
		public function unlockAchievement():void {
			
			extContext.call("unlockAchievement");
		}
	}
}