package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;

	
	public class B2_button extends MovieClip {
		

		
		public function B2_button() {
			// constructor code
			cacheAsBitmap=true;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			gotoAndStop(1);
			y=-1;
			x=339,25;
		}
	}
	
}