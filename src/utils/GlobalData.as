package utils 
{
	import flash.display.Stage;
	import starling.core.Starling;
	import starling.events.Event;
	/**
	 * ...
	 * @author Javier
	 */
	public class GlobalData 
	{
		private static var mInstance:GlobalData;
		private var mCreationCallback:Function;
		public var pPlayerProfile:PlayerProfile;
		
		public var pStage:Stage;
		
		public static function GetInstance():GlobalData
		{
			if (!mInstance)
			{
				mInstance = new GlobalData();
				mInstance.Init();
			}
			
			return mInstance;
		}
		
		private function Init():void		
		{
			pPlayerProfile = new PlayerProfile();
		}
		
		public function PostInit(starling:Starling, creationCallback:Function):void
		{
			mCreationCallback = creationCallback;
			starling.addEventListener(Event.ROOT_CREATED, HandleRootCreated);
		}
		
		public function HandleRootCreated(e:Event):void
		{
			/*RegisterFont(EmbeddedUI.komikaFont, EmbeddedUI.komikaFontXML);
			RegisterFont(EmbeddedUI.whiteKomikaFont, EmbeddedUI.whiteKomikaFontXML);
			RegisterFont(EmbeddedUI.avengeanceFont, EmbeddedUI.avengeanceXML);
			RegisterFont(EmbeddedUI.avengeanceShadowFont, EmbeddedUI.avengeanceShadowXML);*/
			
			Starling.current.removeEventListener(Event.CONTEXT3D_CREATE, HandleRootCreated);
			
			mCreationCallback();
			mCreationCallback = null;
		}
		
		
		
	}

}