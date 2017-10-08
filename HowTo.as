package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.*;
	
	
	public class HowTo extends MovieClip {
		private var frame:Number = new Number;
		
		public function HowTo() {
			// constructor code
			x = 0;
			y = 0;
			alpha = 0;
			cacheAsBitmap = true;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		public function init(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			addEventListener(MouseEvent.CLICK,GoOn);
			frame = 1;
		}
		public function GoOn(e:MouseEvent):void{
			
			//gotoAndStop(frame);
			frame++;
			if (frame>4){
				gotoAndStop(1);
				TweenLite.to(this,.5,{alpha:0});
				(this.parent as MovieClip).removeChild(this);
				frame=1;
				}else{gotoAndStop(frame);}
		}
		
	}
	
}
