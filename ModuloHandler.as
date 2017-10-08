package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import XMLList;
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class ModuloHandler extends MovieClip {
		//variables de prueba lectura xml
		private var xmlLoader:URLLoader = new URLLoader();
		private var xmlData:XML = new XML();
		public var indice:int;
		private var numLevels:Number;
		private var currentActivity:Number;
		private var cantidadAudios:Number;
		private var cantidadTextos:Number;
		private var sonido:Sound = new Sound();
		private var canalSonido:SoundChannel = new SoundChannel();
		public var control:Number=1;
		private var hay:Boolean;
		private var isShown:Boolean = false;
		//resto de variables normales de siempre
		private var clips:Number;
		private var delayClickeable:Timer = new Timer(10000,1);
		private var isclickeable:Boolean = true;
		private var cargador:Loader = new Loader();
		private var touchControl:TapAlert = new TapAlert();
		private var userProgress:usuario = new usuario();
		private var ModuloDialogHolder:MovieClip = new MovieClip();
		public var canSound:Boolean=true;//me indica el main si puedo sonar
		public var pauseDisableHandler:Boolean = false;
		private var pauseBg:pauseBG = new pauseBG();

		//DELAYS
		private var delay:Timer = new Timer(3000,1);
		
		
		public function ModuloHandler() {
			// constructor code
			x = 0;
			y = 0;
			alpha = 0;
			cacheAsBitmap = true;
			addEventListener(Event.ADDED_TO_STAGE,init);
			setupEvents();
		}
		function loadAnImage( event:Event = null ):void 
		{    
          var image:Bitmap = Bitmap(cargador.content);
          image.smoothing=true;
          this.addChild(image);  
		}
		private function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			delay.addEventListener(TimerEvent.TIMER_COMPLETE,esClickeable);
		}
		//FUNCIONES PUBLICAS QUE EJECUTAN LOS BOTONES RESET, ANTERIOR Y SIGUIENTE DEL PARENT
		/****************************************************************************/
		/**/public function fadeNextActiv():void{
		/**/	
		/**/	removeEventListener(MouseEvent.CLICK,WaitForCheck);
		/**/	gotoPage(indice+1);
		/**/	control=1;
		/**/	touchControl.alpha = 0;
		/**/	
		/**/}
		/**/public function fadePastActiv():void{
		/**/	
		/**/	removeEventListener(MouseEvent.CLICK,WaitForCheck);
		/**/	if(indice == 0){
		/**/		gotoPage(0);
		/**/	}
		/**/	else{
		/**/		gotoPage(indice-1);
		/**/	}
		/**/	control=1;
		/**/	touchControl.alpha = 0;
		/**/}
		
		private function setupEvents():void{
			xmlLoader.load(new URLRequest("Actividades.xml"));
			xmlLoader.addEventListener(Event.COMPLETE,loadXML);
			addChild(cargador);
			addChild(touchControl);
			addChild(ModuloDialogHolder);
			cargador.addEventListener(Event.COMPLETE,loadAnImage);
		}
		private function loadXML(e:Event):void{
			xmlData = new XML(e.target.data);
			numLevels = (xmlData.actividad as XMLList).length();
		}
		private function removeChildren (container:MovieClip):void
		{
			while (container.numChildren > 0){container.removeChildAt(0);}
		}
		public function gotoPage(numActiv:Number):void{
			removeEventListener(MouseEvent.CLICK,WaitForCheck);
			delay.start();
			removeChildren(ModuloDialogHolder);
			touchControl.alpha = 0;
			indice = numActiv;
			//trace("Numero de Actividad: "+(indice+1));
			userProgress.progreso = indice;
			if (indice<numLevels){
			delay.start();
			cantidadTextos = ((xmlData.actividad[indice].textos.texto as XMLList).length());
			TweenLite.to(ModuloDialogHolder.addChild(new Dialogo(xmlData.actividad[indice].textos.texto[0],-100)),1,{y:0});
			if(canSound){sonido = new Sound(new URLRequest(xmlData.actividad[indice].audios.audio[0]));
			sonido.play(0,1);}
			cargador.load(new URLRequest(xmlData.actividad[indice].fondo));
			}else{
				delay.start();
				gotoPage(0);
			}
		}
		public function playAgain():void{
			removeEventListener(MouseEvent.CLICK,WaitForCheck);
			control=1;
			gotoPage(indice);
		}
		public function disableWhilePaused():void{
			
			if (!pauseDisableHandler){
				TweenLite.to(addChild(pauseBg),.5,{alpha:.5});
				removeEventListener(MouseEvent.CLICK,WaitForCheck);
				delay.stop();
				pauseDisableHandler = true;
			}else{
				pauseBg.alpha = 0;
				//removeChild(pauseBg);
				delay.start();
				addEventListener(MouseEvent.CLICK,WaitForCheck);
				removeChild(pauseBg);
				pauseDisableHandler=false;
			}
		}
		
		private function WaitForCheck(e:MouseEvent):void{
			removeEventListener(MouseEvent.CLICK,WaitForCheck);
			TweenLite.to(touchControl,.2,{alpha:0});
			if(control<(cantidadTextos)){
				TweenLite.to(ModuloDialogHolder.addChild(new Dialogo(xmlData.actividad[indice].textos.texto[control],-100)),1,{y:0});
				if (canSound){sonido = new Sound(new URLRequest(xmlData.actividad[indice].audios.audio[control]));
				sonido.play(0,1);}
				delay.start();
				control++;
			}else{
				indice++;
				gotoPage(indice);
				control=1;
				}
		}
		private function esClickeable(e:Event):void{
			TweenLite.to(touchControl,.2,{alpha:.5});
			addEventListener(MouseEvent.CLICK,WaitForCheck);
		}
	}
}
