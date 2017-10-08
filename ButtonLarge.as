package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	
	public class ButtonLarge extends MovieClip {
		public var MainNumber:TextField;
		private var _X:Number;
		private var _Y:Number;
		//private var Titulo:Number;
		public function ButtonLarge(posX:Number,posY:Number,texto:String) {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE,init,false,0,true);
			x = posX;
			y = posY;
			cacheAsBitmap=true;
			MainNumber.text = texto;
		}
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			//codigo al añadir
			/*x = _X;
			y = _Y;*/
			//addEventListener(MouseEvent.CLICK,onPressHandler);
			//addEventListener(MouseEvent.MOUSE_UP,onReleaseHandler);
			
		}
		private function onPressHandler(e:MouseEvent):void
		{
			//codigo al presionar
			//x+=10;
			//MainNumber.text = String(x);
			//saveSharedObject();
		}
		private function onReleaseHandler(e:MouseEvent):void
		{
			//codigo al soltar
		}
		
	}
	
}
