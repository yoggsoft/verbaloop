package  {
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;


	
	public class Bonus2Option extends MovieClip {
		private var optionLoader:Loader = new Loader();
		private var photoToLoad:String = new String;
		private var correctAwnser:String = new String;
		private var myAwnser:String = new String;
		
		public function Bonus2Option(posX:Number,posY:Number,photo:String,respuesta:String,respuestaPropia:String) {
			// constructor code
			alpha=0;
			cacheAsBitmap = true;
			addEventListener(Event.ADDED_TO_STAGE,init);
			//asigno parametros a travez de argumentos
			x = posX;
			y = posY;
			photoToLoad = photo;
			correctAwnser = respuesta;
			myAwnser = respuestaPropia;
			addEventListener(MouseEvent.CLICK,checkRespuesta);
		}
		public function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			//DECIRLE QUE CARGUE EL TERCER ARGUMENTO QUE ES UN STRING DE IMAGEN
			optionLoader.load(new URLRequest(photoToLoad));
			optionLoader.x = 158;
			optionLoader.y = 52;
			addChildAt(optionLoader,2);
		}
		private function checkRespuesta(e:MouseEvent):void{
			if (myAwnser == correctAwnser){
				trace("opcion correcta");
				(this.parent.parent as MovieClip).getAwnserFromButton(true);
				gotoAndStop(3);
				//return true;
			}else{
				(this.parent.parent as MovieClip).getAwnserFromButton(false);
				gotoAndStop(2);
				trace("opcion incorrecta");
				//return false;
			}
		}
	}
	
}
