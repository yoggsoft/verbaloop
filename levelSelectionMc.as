package LevelSelectionMc {
	import flash.display.Sprite;
	public class levelSelectionMc extends Sprite {
		public function levelSelectionMc(beaten:int):void {
			var setup:setupClass = new setupClass();
			var levelSelect:levelSelectMc;
			for (var i:int=0; i<setup.totalLevels; i++) {
				levelSelect=new levelSelectMc(i,i<=beaten);
				addChild(levelSelect);
			}
			var homeButton:homeButtonMc=new homeButtonMc();
			addChild(homeButton);
		}
	}
}