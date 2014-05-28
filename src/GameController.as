package  
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	public class GameController extends Engine
	{
		
		public function GameController() 
		{
			super(800, 600, 30,true);
			
		}
		override public function init():void 
		{
			FP.world = new GameWorld();
			
		}
		
	}

}