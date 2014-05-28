package  
{
	import flash.geom.Point;
	import net.flashpunk.World;
	import net.flashpunk.Entity;

	public class GameWorld extends World
	{
		private var blocks:BlocksModel;
		private var blockStore:Vector.<Block>;
		private var scoreLabel:Label;
		private var shapesLabel:Label;
		private var points:int;

		public function GameWorld() 
		{
			
		}
		override public function begin():void 
		{			
			 super.begin();
			 setup();
		}
		
		private function setup():void
		{

			blocks = new BlocksModel();
			//blocks.handlePoint(0, 0);
			buildGrid();
			scoreLabel = new Label().setup("score:", G.blockSize * G.gridWidth, 0, 150, 50);
			shapesLabel = new Label().setup("shapes left:"+String(blocks.amountOfShapesLeft), G.blockSize * G.gridWidth, 60, 150, 50);
			add(scoreLabel);
			add(shapesLabel);			
		}
		private function buildGrid():void
		{
			blockStore = new Vector.<Block>();
			for (var i:int = 0; i < blocks.grid.w; i++) 
			{
				for (var j:int = 0; j < blocks.grid.h; j++) 
				{
					//blockStore.push(Block(create(Block)).setup(i, j, blocks.grid.Get(i, j)));
					if(blocks.grid.Get(i, j)!=-1)
						Block(add(new Block())).setup(i, j, blocks.grid.Get(i, j));
				}
			}

		}
		public function handlePoint(x:int, y:int):void
		{
			var score:int = blocks.handlePoint(x, y);
			var col:uint = 0xff0000;
			if(blocks.wasChanged)
			{
				score-= 3;
				blocks.wasChanged = false;
				col = 0xffffff;
				var list:Vector.<Entity> = new Vector.<Entity>();
				getType("block", list);
				removeList(list);
				
				buildGrid();
			}	

			TextSpark(create(TextSpark)).setup(mouseX, mouseY, String(score), col, 30, 3);
			points += score;
			scoreLabel.text = "score:" + String(points);
			shapesLabel.text = "shapes left:" + blocks.amountOfShapesLeft;
		}
	}

}