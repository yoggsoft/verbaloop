package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;
	
	public class Dialogo extends MovieClip {
		public var dialogoTexto:TextField;
		private var format:TextFormat = new TextFormat();
		public function Dialogo(texto:String,posY:int) {
			// constructor code
			x=0;
			y=posY;
			cacheAsBitmap = true;
			dialogoTexto.text = texto;
			addEventListener(Event.ADDED_TO_STAGE,setFormat);
		}
		private function setFormat(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,setFormat);
			format.align = "center";
			dialogoTexto.setTextFormat(format);
		}
	}
	
}