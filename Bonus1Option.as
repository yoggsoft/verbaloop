package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Bonus1Option extends MovieClip {
		public var optionText:TextField;
		private var correctAwnser:String; 
		
		public function Bonus1Option(texto:String,posicion:int,respuesta:String) {
			// constructor code
			cacheAsBitmap = true;
			optionText.text = texto;
			correctAwnser = respuesta;
			x = posicion;
			y = 968;
			addEventListener(MouseEvent.CLICK,checkRespuesta);
		}
		private function checkRespuesta(e:Event):void{			
			removeEventListener(MouseEvent.CLICK,checkRespuesta);
			if (optionText.text == correctAwnser){
				//trace("opcion correcta");
				(this.parent.parent as MovieClip).getAwnserFromButton(true);
				gotoAndStop(3);
				//return true;
			}else{
				(this.parent.parent as MovieClip).getAwnserFromButton(false);
				gotoAndStop(2);
				//trace("opcion incorrecta");
				//return false;
			}
			
		}
		
	}
	
}
