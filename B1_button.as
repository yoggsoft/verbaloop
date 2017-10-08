package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;

	
	public class B1_button extends MovieClip {
		

		
		public function B1_button() {
			// constructor code
			cacheAsBitmap=true;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			gotoAndStop(1);
			y=0;
			x=0;
		}
	}
	
}
