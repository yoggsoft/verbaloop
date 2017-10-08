package  {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.display.MovieClip;
	
	public class Bonus3Option extends MovieClip {
		public var optionText:TextField = new TextField;
		
		public function Bonus3Option(Texto:String,Xpos:Number) {
			// constructor code
			cacheAsBitmap = true;
			alpha = 0;
			x = Xpos;
			y= 250;
			optionText.text =  Texto;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void{
			
		}

	}
	
}
