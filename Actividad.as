package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.greensock.*;
	import usuario;
	import flash.sampler.NewObjectSample;
	
	public class Actividad extends MovieClip {
		private var botonGigante:MovieClip;
		private var terminado:Boolean = new Boolean;
		private var jugador:usuario;
		private var referencia:Stage;
		private var clickeable:Boolean;
		private var delayCantidad:int = 300;
		private var delayContinuar:Timer= new Timer();
		private var bg:MovieClip = new MovieClip();

		public function Actividad(user:usuario)  {
			// constructor code
			// asigno variables de parametros
			
			jugador = user;
			
			//referencia tiempo para que sea clickeable
			
			
			
		}

	}
	
}
