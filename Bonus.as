package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import XMLList;
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.ui.Mouse;
	import flash.events.TimerEvent;
	
	public class Bonus extends MovieClip {
		//VARIABLES DE XML, PARSING Y VARIABLES QUE GUARDAN CANTIDAD DE OCURRENCIAS
		private var urlLoader:URLLoader = new URLLoader();
		private var xmlData:XML = new XML();
		private var numOraciones:int;
		private var numQuestions:int;
		private var numMatches:int;
		
		//variables de puntuación
		private var aciertos:int;
		private var intentos:int;
		//CONTENEDORES DE INFORMACIÓN
		private var MainMenuHolder:MovieClip = new MovieClip();
		
		//variables de numeros aleatorios
		private var rp:RandomPlus = new RandomPlus(5,0);
		private var guia:int;
		private var valoresTextoPregunta:Array = new Array;
		private var valoresPalabrasMatches:Array = new Array;
		private var valoresOraciones:Array = new Array;
		
		//VARIABLES DE POSICIONES ALEATORIAS
		private var PosOp1:Array = new Array();
		private var PosOpB1:Number = new Number();
		private var posOpB2:Number = new Number();
		private var XposOp2:Array = new Array();
		private var YposOp2:Array = new Array();
		private var PosOp3_4:Array = new Array();
		private var PosOp3_5:Array = new Array();
		
		//ALEATORIOS PARA CONTROLAR REPETICION DE PREGUNTAS
		private var OpB1Alt:Number = new Number();
		private var OpB2Alt:Number = new Number();
		private var opcionBonus3Alterna:Number = new Number();
		private var usados:Array = new Array();
		private var seRepite:Boolean = false;
		private var DelaySeguir:Timer = new Timer(2000,1);
		
		//CONTENEDORES DE CLASES
		private var bonus1Bg:Loader = new Loader();//CONTENEDOR DE FONDO DE BONUS 1
		private var bonusOptionHolder:MovieClip = new MovieClip(); //CONTENEDOR DE INFORMACION Y OPCIONES DE BONOS
		
		private var BonusEnUso:Number = new Number; //VARIABLE QUE INDICA QUE BONO VOY A CARGAR
				
		public function Bonus(cualBonus:Number) {
			// constructor code
			BonusEnUso = cualBonus;
			addEventListener(Event.ADDED_TO_STAGE,init);
			DelaySeguir.addEventListener(TimerEvent.TIMER_COMPLETE,doNewQuestion);
		}
		private function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			loadXML();
			
		}
		private function loadXML():void{
			urlLoader.load(new URLRequest("BonusInfo.xml"));
			urlLoader.addEventListener(Event.COMPLETE,parseXML);
		}
		private function parseXML(e:Event):void{
			xmlData = new XML(e.target.data);
			numOraciones = (xmlData.oraciones.oracion as XMLList).length();
			numQuestions = (xmlData.questions.question as XMLList).length()-1;
			numMatches = (xmlData.matches.matchItem as XMLList).length();
			
			//FUNCION QUE MANDE A CARGAR LA OPCION CORRECTA DE BONUS
			drawBonus();
		}
		public function drawBonus():void{
			switch (BonusEnUso){
				case 1: drawBonus1(); break;
				case 2: drawBonus2(); break;
				case 3: drawBonus3(); break;
			}
		}
		public function drawBonus1():void{
			addChild(bonusOptionHolder);
			DelaySeguir.start();
			//doNewQuestion();
		}
		public function drawBonus2():void{
			addChild(bonusOptionHolder);
			DelaySeguir.start();
		}
		public function drawBonus3():void{
			addChild(bonusOptionHolder);
			DelaySeguir.start();
		}
		//VACIAR UNA PELICULA
		private function removeChildren (container:MovieClip):void{
			while (container.numChildren > 0){container.removeChildAt(0);}
		}
		//////////////////////////////////////////HACER PREGUNTA///////////////////////////////////////////
		public function DoBonus3Question():void{
			removeChildren(bonusOptionHolder);
			TweenLite.to(bonusOptionHolder.addChild(new Atril),.5,{alpha:1});
			//CARGO VARIABLES BONUS3
			for(var t=0;t<numOraciones;t++){
				valoresOraciones[t] = xmlData.oraciones.oracion[t].palabra;
			}
			PosOp3_4.push(124,323,520,719);
			PosOp3_5.push(104,263,421,580,738);
			//comienza ubicacion y aleatorizado
			guia= rp.getNum();
			trace("------------------------------------------------------------------------");
			trace("oracion seleccionada: "+guia);
			var numPalabrasOracion:Number = (xmlData.oraciones.oracion[guia].palabra as XMLList).length();
			trace("Cantidad de Palabras en Oracion: "+numPalabrasOracion);
			
			for (var g:int=0;g<numPalabrasOracion;g++){
				if(numPalabrasOracion == 4){
					TweenLite.to(bonusOptionHolder.addChild(new Bonus3Option(xmlData.oraciones.oracion[guia].palabra[g],PosOp3_4[g])),.5,{alpha:1});
				}else{
					TweenLite.to(bonusOptionHolder.addChild(new Bonus3Option(xmlData.oraciones.oracion[guia].palabra[g],PosOp3_5[g])),.5,{alpha:1});
				}
			}
			addEventListener(MouseEvent.CLICK,newOne);
		}
		public function newOne(e:MouseEvent):void{
			DelaySeguir.start();//DoBonus3Question();
		}
		public function DoBonus2Question():void{
			removeChildren(bonusOptionHolder);
			for (var u=0;u<numMatches;u++){
				valoresPalabrasMatches[u] = xmlData.matches.matchItem[u].objeto;
			}
			//reinicio el vector de posiciones
			XposOp2.push(0,512,0,512);
			YposOp2.push(120,120,420,420);
			//AQUI HAGO LA MECANICA DE CARGAR 4 FOTOS, DUPLICARLOS Y organizarlos donde van
			
			//trace(valoresPalabrasMatches);
			guia = Math.floor(Math.random() * valoresPalabrasMatches.length);
			posOpB2 = Math.floor(Math.random() * 4);
			TweenLite.to(bonusOptionHolder.addChild(new Dialogo(xmlData.matches.matchItem[guia].objeto,-100)),.5,{y:0});
			TweenLite.to(bonusOptionHolder.addChild(new Bonus2Option(XposOp2[posOpB2],YposOp2[posOpB2],xmlData.matches.matchItem[guia].bg,xmlData.matches.matchItem[guia].objeto,xmlData.matches.matchItem[guia].objeto)),.5,{alpha:1});
			XposOp2.splice(posOpB2,1);
			YposOp2.splice(posOpB2,1);
			valoresPalabrasMatches.splice(guia,1);
			//CARGAR RESTO DE IMAGENES
			var randomOptions:RandomPlus = new RandomPlus(valoresPalabrasMatches.length,0);
			for (var i=0;i<3;i++){
				OpB2Alt = randomOptions.getNum(); //Math.floor(Math.random() * valoresPalabrasMatches.length);
				posOpB2 = Math.floor(Math.random() * XposOp2.length);
				TweenLite.to(bonusOptionHolder.addChild(new Bonus2Option(XposOp2[posOpB2],YposOp2[posOpB2],xmlData.matches.matchItem[OpB2Alt].bg,xmlData.matches.matchItem[guia].objeto,xmlData.matches.matchItem[OpB2Alt].objeto)),.5,{alpha:1});
				XposOp2.splice(posOpB2,1);
				YposOp2.splice(posOpB2,1);
			}
		}
		public function DoBonus1Question():void{
			//trace("-------------------------------------------------------")
			removeChildren(bonusOptionHolder);
			bonus1Bg.unload();
			bonusOptionHolder.addChild(bonus1Bg);
			//reinicio el vector de posiciones
			PosOp1.push(170, 512, 853);
			//CARGO VARIABLES BONUS1
			for(var t=0;t<numQuestions;t++){
				valoresTextoPregunta[t] = xmlData.questions.question[t].texto;
			}
			//cuadro el valor correcto de la opcion correcta e imagen correcta
			guia = rp.getNum();
			//trace("OPCION SELECCIONADA CORRECTA: "+guia);
			//var opcionCorrecta = guia;
			bonus1Bg.load(new URLRequest(xmlData.questions.question[guia].bg));
			//trace("Fondo: "+xmlData.questions.question[guia].bg);
			//cargo el dialogo correcto
			TweenLite.to(bonusOptionHolder.addChild(new Dialogo(xmlData.questions.question[guia].frase,-100)),.5,{y:0});
			//cargo la opcion correcta y la ubico en una posicion aleatoria
			PosOpB1 = Math.floor(Math.random() * PosOp1.length);
			//trace("Posicion de opcion correcta: "+PosOp1[PosOpB1]);
			TweenLite.to(bonusOptionHolder.addChild(new Bonus1Option(valoresTextoPregunta[guia],PosOp1[PosOpB1],valoresTextoPregunta[guia])),.5,{y:768});
			//trace("Texto de opcion correcta: "+valoresTextoPregunta[guia]);
			//elimino de las opciones disponibles la opciones con ocurrencia para no repetir posicion ni texto de opcion
			valoresTextoPregunta.splice(guia,1);
			PosOp1.splice(PosOpB1,1);
			//completo el resto de las opciones con opciones aleatorias que no se repitan
			for(var j=0;j<2;j++){
				PosOpB1 = Math.floor(Math.random() * PosOp1.length);
				OpB1Alt = Math.floor(Math.random() * valoresTextoPregunta.length);
				TweenLite.to(bonusOptionHolder.addChild(new Bonus1Option(valoresTextoPregunta[OpB1Alt],PosOp1[PosOpB1],valoresTextoPregunta[guia])),.5,{y:768});
				valoresTextoPregunta.splice(OpB1Alt,1);
				PosOp1.splice(PosOpB1,1);
			}
		}
		
		public function getAwnserFromButton(veredicto:Boolean):void{
			//reviso la respuesta del boton
			if (veredicto){//SI LA RESPUESTA ES CORRECTA
				aciertos++;
				trace("CORRECTAS: "+aciertos);
				//animacion de monedas
				DelaySeguir.start();//doNewQuestion();//O BONUS 1 O BONUS 3
				if(aciertos >= 5){//SI COMPLETA 5 PREGUNTAS BIEN
					//bono 2 desbloqueado
					//animacion bonita
					removeChildren(bonusOptionHolder);
					trace("TERMINASTE EL BONUS "+BonusEnUso);
					guia=0;//vacio todas las selecciones
					aciertos = 0;
					intentos = 0;
					DelaySeguir.stop();
				}
				intentos = 0;
			}else{//SI LA RESPUESTA ES INCORRECTA
				intentos++;
				trace("Intentos: "+intentos);
				trace("INCORRECTO, INTENTA UNA VEZ MAS");
				if(intentos >= 2){//SI SE EQUIVOCA UNA SEGUNDA VEZ
					trace("MEJOR SUERTE LA PROXIMA VEZ");
					DelaySeguir.start();//doNewQuestion();
					intentos = 0;
				}
				
			}
			
		}
		//CARGAR UNA PREGUNTA NUEVA EN CUALQUIER BONUS QUE ESTE EN USO
		private function doNewQuestion(e:TimerEvent):void{
			DelaySeguir.stop();
			switch(BonusEnUso){
				case 1: DoBonus1Question(); break;
				case 2: DoBonus2Question(); break;
				case 3: DoBonus3Question(); break;
			}
		}
		
	}
	
}
