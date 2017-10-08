package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.display.Stage;
	
	public class Button extends MovieClip {
		private var _X:Number;
		private var _Y:Number;

		public function Button() {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE,init,false,0,true);
		}
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
		}

	}
	
}
