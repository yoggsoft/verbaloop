package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class LvlThumb extends MovieClip {
		public var LevelNumber:TextField;
		
		public function LvlThumb(enX:Number,enY:Number,whichOne:Number) {
			// constructor code
			x = enX;
			y = enY;
			LevelNumber.text = String(whichOne);
			cacheAsBitmap = true;
		}
	}
	
}
