package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	

	
	public class B3_button extends MovieClip {
		

		
		public function B3_button() {
			// constructor code
			cacheAsBitmap=true;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			gotoAndStop(1);
			y=0;
			x=723,85;
		}
	}
	
}