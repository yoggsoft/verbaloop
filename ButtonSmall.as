package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	
	
	public class ButtonSmall extends MovieClip {
		public var MainNumber: TextField;
		public var DoneNumber:TextField;
		public var Total:TextField;
		private var _X:Number;
		private var _Y:Number;
		
		public function ButtonSmall(posX:Number,posY:Number,texto:String) {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE,init,false,0,true);
			x = posX;
			y = posY;
			MainNumber.text = texto;
			//DoneNumber.text = String(hechos);
			//Total.text = String(quedan);
		}
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
		}
	}
	
}
