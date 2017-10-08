package {
	//IMPORTS RELACIONADOS A APLICACION
	//import flash.desktop.NativeApplication;
	//import flash.desktop.SystemIdleMode;
	//import flash.net.SharedObject;
	//imports relacionados a funcionalidad
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.greensock.*;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class VerbaLoop extends MovieClip {
		
		//variables de aplicacion
		/*private var application:NativeApplication;*/
		/*private var so:SharedObject;*/
		/**/private var pantalla:Stage;
		/**/private var modulo1:ModuloHandler = new ModuloHandler();
		/**/private var progreso:int;
		//variables de instancia y configuracion
		private var configuracion:gameSetup=new gameSetup();
		private var user:usuario;		
		//botones de menu principal
		private var viewOptions:Boolean = false;
		//botones de menu pausa
		private var pausado:Boolean = false;
		private var pausaBtn:PauseBtn = new PauseBtn();
		private var reiniciar:ResetBtn = new ResetBtn();
		private var volumen:VolBtn = new VolBtn();
		private var inicio:HomeBtn = new HomeBtn();
		private var pausaShadow:shadowMC = new shadowMC(-44);
		//botones de interfaz
		private var Toque:TapAlert = new TapAlert();
		private var jugar,opciones:ButtonLarge;
		private var creditos:ButtonSmall;
		private var instrucciones:Tutorial;
		private var comenzarModulo:ArrowBtn;
		private var nextActiv:ArrowBtn = new ArrowBtn(1224,383,-1);
		private var prevActiv:ArrowBtn = new ArrowBtn(-200,383,1);
		private var bonusLink:BonusItem = new BonusItem();
		//variables de audio
		private var VolumeControl:Boolean = false;
		private var hayAudio:Boolean = true;
		private var miVolume:Number = .5;
		private var audio:Sound = new Sound();
		private var audioCanal:SoundChannel = new SoundChannel();
		private var AudioVolumen:SoundTransform = new SoundTransform(1);
		
		//variables de tiempo
		private var tiempo:Timer = new Timer(2000);		
		
		//contenedores de menues
		private var MainMenuHolder:MovieClip = new MovieClip();
		private var MainOptionsHolder:MovieClip = new MovieClip();
		private var PauseMenuHolder:MovieClip = new MovieClip();
		private var BonusMenuHolder:MovieClip = new MovieClip();
		private var BonusHolder:MovieClip = new MovieClip();
		private var MainMenuOptions:MovieClip = new MovieClip();
		private var ModuloHolder:MovieClip = new MovieClip();
		private var isShowInfo:Boolean = false;
		private var isDrawUI:Boolean = false;
		private var isShowCredits:Boolean = false;
		private var isShowTutorial:Boolean = false;
		private var MainBonusHolder:MovieClip = new MovieClip();
		private var LogoPrincipal:largeSplash = new largeSplash();
		//bonos
		//private var BonoHandler:Bonus = new Bonus();
		
		private var bono1Button:B1_button = new B1_button();
		private var bono2Button:B2_button = new B2_button();
		private var bono3Button:B3_button = new B3_button();
		//booleans de bonos
		private var b1IsDone:Boolean = false;
		private var b2IsDone:Boolean = false;
		private var b3IsDone:Boolean = false;
		
		public function VerbaLoop():void{
			// constructor code
			/*CONTENIDO DE APLICACION, MULTITASK, MINIMIZAR APP*/
			/*application = NativeApplication.nativeApplication;
			/*application.addEventListener(Event.ACTIVATE,activate);
			/*application.addEventListener(Event.DEACTIVATE,deactivate);
			/*application.addEventListener(Event.EXITING,exiting);
			//initSharedObject();
			/*CONTENIDO DE EVENTOS*/
			addEventListener(Event.ENTER_FRAME,init);
			audio = new Sound(new URLRequest("res/WeHeart.mp3"));
			MainMenuHolder.x = -100;
			
		}
		//FUNCIONES DE AUDIO
		/**/function loopAudio(e:Event):void
		/**/{
		/**/	AudioVolumen.volume = miVolume;
		/**/	audioCanal = audio.play();
		/**/	audioCanal.soundTransform = AudioVolumen;
		/**/	audioCanal.addEventListener(Event.SOUND_COMPLETE,loopAudio);
		/**/}
import flash.events.MouseEvent;

		/**/function raiseVolume():void
		/**/{
		/**/	if (hayAudio)
		/**/	{
		/**/		TweenMax.to(audioCanal,1,{volume:.5});
		/**/		miVolume = .5;
		/**/		AudioVolumen.volume = miVolume;
		/**/		audioCanal.soundTransform = AudioVolumen;
		/**/	}
		/**/}
		/**/function startSound():void
		/**/{
		/**/	if (hayAudio)
		/**/	{
		/**/		audioCanal = audio.play();
		/**/		audioCanal.addEventListener(Event.SOUND_COMPLETE,loopAudio);
		/**/	}
		/**/}
		/**/function lowerVolume():void
		/**/{
		/**/	if(hayAudio)
		/**/	{
		/**/		TweenMax.to(audioCanal,3,{volume:.2});
		/**/		miVolume = 0;
		/**/		AudioVolumen.volume = miVolume;
		/**/	}
		/**/}
		/**/function checkAudioStatus():void
		/**/{
		/**/	if (hayAudio)
		/**/	{
		/**/		miVolume = 0;
		/**/		AudioVolumen.volume = miVolume;
		/**/		audioCanal.soundTransform = AudioVolumen;
		/**/		hayAudio=false;
		/**/	}else
		/**/	{
		/**/		miVolume = .5;
		/**/		AudioVolumen.volume = miVolume;
		/**/		audioCanal.soundTransform = AudioVolumen;
		/**/		hayAudio = true;
		/**/	}
		/**/}
		//FUNCIONES DE VOLUMEN
		private function init(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME,init);
			tiempo.addEventListener(TimerEvent.TIMER,comenzar);
			TweenLite.to(addChild(LogoPrincipal),3,{alpha:1,onComplete:tiempo.start});
		}
		private function comenzar(e:TimerEvent):void
		{
			addEventListener(MouseEvent.CLICK,drawMainMenu);
			TweenMax.to(addChild(Toque),1,{alpha:1,repeat:-1,yoyo:true,repeatDelay:0});
			tiempo.stop();
			startSound();
		}
		private function drawMenu():void{
			addChild(MainMenuOptions);
			addChild(MainMenuHolder);
		}
		private function drawMainMenu(e:MouseEvent):void
		{
			removeEventListener(MouseEvent.CLICK,drawMainMenu);
			removeChild(LogoPrincipal);
			removeChild(Toque);
			jugar = new ButtonLarge(215,296,"Jugar");
			opciones = new ButtonLarge(215,416,"Tutorial");
			creditos = new ButtonSmall(305,562,"Créditos");
			instrucciones = new Tutorial(100);
			MainMenuHolder.addChild(new shadowMC(417));
			MainMenuHolder.addChild(jugar);
			MainMenuHolder.addChild(opciones);
			MainMenuHolder.addChild(creditos);
			MainMenuHolder.addChild(instrucciones);
			MainMenuHolder.addChild(new SplashLogo());
			addChild(MainMenuOptions);//CONTENEDOR DE OPCIONES DEL MENU PRINCIPAL
			TweenLite.to(addChild(MainMenuHolder),.3,{x:0});//CONTENEDOR DEL MENU PRINCIPAL
			//acciones del menu principal
			jugar.addEventListener(MouseEvent.CLICK,drawUI);
			opciones.addEventListener(MouseEvent.CLICK,showTutorial);
			instrucciones.addEventListener(MouseEvent.CLICK,showInfo);
			creditos.addEventListener(MouseEvent.CLICK,showCredits);
		}
		//FUNCIONES QUE MUESTRAN INTERFACES EN EL MENÚ PRINCIPAL
		private function drawUI(e:MouseEvent):void{
			//negamos el resto de items del menu
			isShowInfo = false;
			isShowCredits = false;
			isShowTutorial = false;
			//si no está agregado, se muestra
			if(!isDrawUI){
				removeChildren(MainMenuOptions);
				comenzarModulo = new ArrowBtn(300,250,-1);
				TweenLite.to(MainMenuOptions.addChildAt(new bg1,0),.2,{alpha:1});
				TweenLite.to(MainMenuOptions.addChildAt(comenzarModulo,1),.2,{x:695});
				isDrawUI = true;
			}
			comenzarModulo.addEventListener(MouseEvent.CLICK,startGame);
		}
		private function hideUIMenu():void
		{
			TweenLite.to(jugar,.2,{x:-330});
			TweenLite.to(opciones,.2,{x:-330});
			TweenLite.to(creditos,.2,{x:-330});
			TweenLite.to(instrucciones,.2,{x:-100});
			removeChildren(MainMenuHolder);
			removeChild(MainMenuHolder);
		}
		private function showInfo(e:MouseEvent):void{
			//negamos el resto de items del menu
			isDrawUI = false;
			isShowCredits = false;
			isShowTutorial = false;
			//si no está agregado, se muestra
			if (!isShowInfo){
				removeChildren(MainMenuOptions);
				TweenLite.to(MainMenuOptions.addChildAt(new ModuloInfo,0),.2,{x:475});
				isShowInfo = true;
			}
		}
		private function showTutorial(e:MouseEvent):void{
			isDrawUI = false;
			isShowCredits = false;
			isShowInfo = false;
			//if (!isShowTutorial){
				removeChildren(MainMenuOptions);
				TweenLite.to(MainMenuHolder.addChildAt(new HowTo(),6),.5,{alpha:1});
				MainOptionsHolder.addChild(volumen);
				volumen.x = 620;
				//isShowTutorial = true;
			//}
		}
		private function showCredits(e:MouseEvent):void{
			isDrawUI = false;
			isShowInfo = false;
			isShowTutorial = false;
			if (!isShowCredits){
				removeChildren(MainMenuOptions);
				TweenLite.to(MainMenuOptions.addChildAt(new CreditosInfo,0),.2,{x:410});
				isShowCredits = true;
			}
		}
		/*private function initSharedObject():void{
			so = SharedObject.getLocal("savedData");
			if(so.data.counter == null)
			{
				so.data.counter = counter;
			}else
			{
				counter = so.data.counter;
			}
		}
		private function saveSharedObject():void
		{
			so.data.counter = counter;
			so.flush();
		}//sharedobject*/
		
		private function removeChildren (container:MovieClip):void
		{
			while (container.numChildren > 0){container.removeChildAt(0);}
		}
		private function drawPauseMenu():void
		{
			PauseMenuHolder.addChild(pausaShadow);
			PauseMenuHolder.addChild(reiniciar);
			PauseMenuHolder.addChild(volumen);
			PauseMenuHolder.addChild(inicio);
			PauseMenuHolder.addChild(pausaBtn);
			PauseMenuHolder.addChild(nextActiv);
			PauseMenuHolder.addChild(prevActiv);
			//PauseMenuHolder.addChild(bonusLink);
			pausaBtn.x = -147;
			pausaShadow.x = -44;
			inicio.x = -154;
			volumen.x = -154;
			reiniciar.x = -154;
			bonusLink.y = -69;
			pausaBtn.addEventListener(MouseEvent.CLICK,hideShowPause);
			reiniciar.addEventListener(MouseEvent.CLICK,function (e:MouseEvent):void{if(modulo1.pauseDisableHandler){removeFromPause();modulo1.playAgain();}});
			volumen.addEventListener(MouseEvent.CLICK,pauseVolumeHandler);
			inicio.addEventListener(MouseEvent.CLICK,irAlInicio);
			nextActiv.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void{if(modulo1.pauseDisableHandler){removeFromPause();modulo1.fadeNextActiv();}});
			prevActiv.addEventListener(MouseEvent.CLICK,function (e:MouseEvent):void{if(modulo1.pauseDisableHandler){removeFromPause();modulo1.fadePastActiv();}});
			bonusLink.addEventListener(MouseEvent.CLICK,drawBonusMenu);
			addChildAt(PauseMenuHolder,1);
		}
		private function drawBonusMenu(e:MouseEvent):void{
			removeFromPause();
			checkAudioStatus();
			drawBonusHolder();
			addChildAt(MainBonusHolder,0);
			removeChild(ModuloHolder);//NO VACIO EL mODULOhOLDER
			removeChildren(ModuloHolder);
			removeChild(PauseMenuHolder);//ELIMINO EL MENU PAUSA PERO SIGUE ESTANDO CARGADA LA INFORMACION EN EL MOVIECLIP
			removeChildren(PauseMenuHolder);
			drawPauseMenu();
		}
		private function checkBonusProgress():void{
			
			if (!b1IsDone){
				bono1Button.gotoAndStop(1);
				}else{
					bono1Button.gotoAndStop(2);
				}
			if (!b2IsDone){
				bono2Button.gotoAndStop(1);
				}else{
					bono2Button.gotoAndStop(2);
				}
			if (!b3IsDone){
				bono3Button.gotoAndStop(1);
				}else{
					bono3Button.gotoAndStop(2);
				}
		}
		private function drawBonusHolder():void{
			MainBonusHolder.addChild(bono1Button);
			MainBonusHolder.addChild(bono2Button);
			MainBonusHolder.addChild(bono3Button);
			checkBonusProgress();
			bono1Button.addEventListener(MouseEvent.CLICK,loadBonus1);
			bono2Button.addEventListener(MouseEvent.CLICK,loadBonus2);
			bono3Button.addEventListener(MouseEvent.CLICK,loadBonus3);
		}
		
		private function loadBonus1(e:MouseEvent):void{
			bono1Button.removeEventListener(MouseEvent.CLICK,loadBonus1);
			var BonoHandler:Bonus = new Bonus(1);
			BonusHolder.addChild(BonoHandler);
			addChild(BonusHolder);
			removeChildren(MainBonusHolder);//VACIO EL CONTENEDOR DE MENU DE BONOS
			trace("Modulo 1 Cargado");
		}
		private function loadBonus2(e:MouseEvent):void{
			bono2Button.removeEventListener(MouseEvent.CLICK,loadBonus2);
			var BonoHandler:Bonus = new Bonus(2);
			BonusHolder.addChild(BonoHandler);
			addChild(BonusHolder);
			removeChildren(MainBonusHolder);//VACIO EL CONTENEDOR DE MENU DE BONOS
			trace("Modulo 2 Cargado");
		}
		private function loadBonus3(e:MouseEvent):void{
			//b1IsDone=true;
			//b2IsDone=true;
			//checkBonusProgress();
			var BonoHandler:Bonus = new Bonus(3);
			BonusHolder.addChild(BonoHandler);
			addChild(BonusHolder);
			removeChildren(MainBonusHolder);
			bono3Button.removeEventListener(MouseEvent.CLICK,loadBonus3);
			bono3Button.gotoAndStop(2);
			trace("Modulo 3 Cargado");
		}
		private function irAlInicio(e:MouseEvent):void{
			progreso = modulo1.indice;
			removeFromPause();
			checkAudioStatus();
			removeChildren(ModuloHolder);
			removeChildren(PauseMenuHolder);
			removeChild(ModuloHolder);
			removeChild(PauseMenuHolder);
			drawMenu();
			modulo1.control=1;
		}
		private function pauseVolumeHandler(e:MouseEvent):void{
			if(!VolumeControl){
				modulo1.canSound = false;
				VolumeControl = true;
				volumen.gotoAndStop(2);
			}else{
				modulo1.canSound = true;
				VolumeControl = false;
				volumen.gotoAndStop(1);
			}
		}
		private function removeFromPause():void{
			//si el juego no está pausado
				modulo1.disableWhilePaused();
				TweenLite.to(pausaBtn,.5,{x:-147});
				TweenLite.to(reiniciar,.5,{x:-154});
				TweenLite.to(volumen,.5,{x:-154});
				TweenLite.to(inicio,.5,{x:-154});
				TweenLite.to(pausaShadow,.5,{x:-44});
				TweenLite.to(prevActiv,.5,{x:-200});
				TweenLite.to(nextActiv,.5,{x:1224});
				TweenLite.to(bonusLink,.5,{y:-69});
				pausado=false;
				checkAudioStatus();
		}
		private function hideShowPause(e:MouseEvent):void{
			if (!pausado){
				//si el juego está pausado
				TweenLite.to(pausaBtn,.5,{x:0});
				modulo1.disableWhilePaused();
				TweenLite.to(reiniciar,.5,{x:20});
				TweenLite.to(volumen,.5,{x:20});
				TweenLite.to(inicio,.5,{x:20});
				TweenLite.to(pausaShadow,.5,{x:130});
				TweenLite.to(prevActiv,.5,{x:319});
				TweenLite.to(nextActiv,.5,{x:698});
				TweenLite.to(bonusLink,.5,{y:51});
				pausado=true;
				checkAudioStatus();
			}else{
				//si el juego no está pausado
				modulo1.disableWhilePaused();
				TweenLite.to(pausaBtn,.5,{x:-147});
				TweenLite.to(reiniciar,.5,{x:-154});
				TweenLite.to(volumen,.5,{x:-154});
				TweenLite.to(inicio,.5,{x:-154});
				TweenLite.to(pausaShadow,.5,{x:-44});
				TweenLite.to(prevActiv,.5,{x:-200});
				TweenLite.to(nextActiv,.5,{x:1224});
				TweenLite.to(bonusLink,.5,{y:-69});
				pausado=false;
				checkAudioStatus();
			}
		}
		private function startGame(e:MouseEvent):void
		{
			comenzarModulo.removeEventListener(MouseEvent.CLICK,startGame);
			addChild(ModuloHolder);
			//removeChildren(MainMenuHolder);
			removeChild(MainMenuHolder);
			removeChildren(MainMenuOptions);
			isDrawUI = false;
			removeChild(MainMenuOptions);
			TweenLite.killTweensOf(comenzarModulo,true);
			TweenLite.to(comenzarModulo,.2,{alpha:0});
			TweenLite.to(ModuloHolder.addChild(modulo1),1,{alpha:1});
			drawPauseMenu();
			checkAudioStatus();
			modulo1.control = 1;
			if (progreso!=0){
				modulo1.gotoPage(progreso);
			}else{
				modulo1.gotoPage(0);
			}
		}
		/****************************************************/
		/****************************************************/
		/****************************************************/
		/*FUNCIONES QUE MANEJAN EVENTOS RELACIONADOS AL iPAD*/
		/****************************************************/
		/****************************************************/
		/****************************************************/
		/**/
		/*	private function activate(e:Event):void{
		/*		application.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		/*	}
		/*	private function deactivate(e:Event):void{
		/*		application.systemIdleMode = SystemIdleMode.NORMAL;
		/*	}
		/*	private function exiting(e:Event):void
		/*	{
		/*		application.removeEventListener(Event.ACTIVATE,activate);
		/*		application.removeEventListener(Event.DEACTIVATE,deactivate);
		/*		application.removeEventListener(Event.EXITING,exiting);
		/*		application.systemIdleMode = SystemIdleMode.NORMAL;
		/*	}
		/**/
		/****************************************************/
		/****************************************************/
		/****************************************************/
		/*FUNCIONES QUE MANEJAN EVENTOS RELACIONADOS AL iPAD*/
		/****************************************************/
		/****************************************************/
		/****************************************************/
	}
}