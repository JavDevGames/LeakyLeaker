package utils 
{
	import flash.display.Stage;
	import game.definitions.Releases;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Javier
	 */
	public class GlobalData 
	{
		private static var mInstance:GlobalData;
		private var mCreationCallback:Function;
		public var pPlayerProfile:PlayerProfile;
		public var pPopUpManager:PopUpManager;
		
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
			pPopUpManager = new PopUpManager();
			Releases.Init();
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
		
		
		public function RegisterFont(fontSheet:Class, fontXML:Class, name:String):void
		{
			var fontTexture:Texture = Texture.fromEmbeddedAsset(fontSheet);
			var xml:XML = XML(new fontXML());
			TextField.registerBitmapFont(new BitmapFont(fontTexture, xml), name);
		}
	}

}