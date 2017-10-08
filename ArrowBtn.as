package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Stage;	

	
	public class ArrowBtn extends MovieClip {
		
		public function ArrowBtn(posX:Number,posY:Number,sentido:Number) {
			// constructor code
			x = posX;
			y = posY;
			scaleX = sentido;
			cacheAsBitmap=true;

		}
		
	}
	
}
