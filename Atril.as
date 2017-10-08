package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class Atril extends MovieClip {
		
		
		public function Atril() {
			// constructor code
			cacheAsBitmap = true;
			x = 512;y = 384;
			alpha = 0;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		public function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,init);
		}
		
	}
	
}
