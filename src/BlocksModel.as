package  
{
	import flash.geom.Point;
	import net.flashpunk.FP;

	public class BlocksModel 
	{
		public var grid:IntGrid;
		private var currentShape:Vector.<Point>=new Vector.<Point>();
		private var allShapes:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
		private var w:int;
		private var h:int;
		public var wasChanged:Boolean;
		public var amountOfShapesLeft:int;
		public function BlocksModel() 
		{
			this.w = G.gridWidth;
			this.h = G.gridHeight;
			init();
		}
		private function init():void
		{
			wasChanged = true;
			makeRandomGrid();		
			findShapes();
			trace("shapes",allShapes);
		}
		private function shapeContains(p:Point, shape:Vector.<Point>):int
		{
			for (var i:int = 0; i < shape.length; i++) 
			{
				if (p.equals(shape[i]))
					return i;
			}
			return -1;
		}
		
		private function dropBlocks():void
		{
			//trace("dropping blocks");
			//go through all the blocks
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					//if the gridpoint is empty
					if (grid.Get(i,j)==-1)
					{
						//store the point 
						var p:Point = new Point(i, j);
						//while the point is not on the top row
						while (p.y >= 0)
						{	
							//fill point with value of point above it, or a random one if it is on the top row
							grid.Set(p.x, p.y, (p.y == 0)?-1:grid.Get(p.x, p.y - 1));
							//grid.Set(p.x, p.y, (p.y == 0)?int(FP.random * G.amountOfTypes):grid.Get(p.x, p.y - 1));
							
							//set temp point to one row higher
							p.y -= 1;
						}
					}					
				}
			}			
		}
		
		private function collectShape(p:Point):void
		{
			currentShape.push(p);
			var nb:Vector.<*>=grid.getNeighboursOfType(p.x,p.y,grid.Get(p.x,p.y));
			for (var i:int = 0; i < nb.length; i++) 
			{
				var nbp:Point = new Point(nb[i].x, nb[i].y);
				if (shapeContains(nbp, currentShape) == -1)
				{
					collectShape(nbp);
				}
			}
		}
		private function findShapes():void
		{
			//empty shapes
			allShapes = new Vector.<Vector.<Point>>();

			//walk through all blocks
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					if (grid.Get(i, j) != -1)
					{
					var isPresent:Boolean = false;
					//check if current point is in one of the stored shapes
					for (var m:int = 0; m < allShapes.length; m++) 
					{
						if (shapeContains(new Point(i, j), allShapes[m]) != -1)
						{
							isPresent = true;							
							break;
						}
					}	
					//if not present in shapes so far
					if (!isPresent)
					{
						//store the shape in shapevect
						collectShape(new Point(i, j));	
						//put it in the list of found shapes if the shape has at least the minimum size (4)
						if (currentShape.length >= G.shapeMinimum )
						{
							allShapes.push(currentShape);
						}
						//'recycle' shapevect
						currentShape = new Vector.<Point>();
					}
					}
				}				
			}
			amountOfShapesLeft = allShapes.length;
			trace("amount of shapes", allShapes.length);
		}
		
		public function handlePoint(px:int,py:int):int
		{
			var score:int = 0;
			var p:Point = new Point(px, py);
			if (p.x >= 0 && p.x < w && p.y >= 0 && p.y < h)			
			{
				//find which of the shapes the point is in
				var shapeNr:int = -1;
				for (var i:int = 0; i < allShapes.length; i++) 
				{
					if (shapeContains(p, allShapes[i]) != -1)
					{
						shapeNr = i;
						break;						
					}
				}
				//if point is in one of the shapes
				if (shapeNr >= 0)
				{
					//set the shape to zero on the grid
					for (var j:int = 0; j < allShapes[shapeNr].length; j++) 
					{
						grid.Set(allShapes[shapeNr][j].x, allShapes[shapeNr][j].y, -1);
					}	
					//add the size of the shape to the score
					score = allShapes[shapeNr].length;
					//let others know that a shape was removed
					//dispatchEvent(new Event("ShapeRemoved"));

					//make all the blocks above the removed ones drop down
					dropBlocks();
					wasChanged = true;
					findShapes();
					if (allShapes.length == 0)
					{
						//if there are no more shapes, reset the grid, and send an event
						init();				
						//dispatchEvent(new Event("LastShapeRemoved"));				
					}					
				}	
				else
				{
					//else punish the player with a sound and a score-deduction
					wasChanged = false;
					score = -5;
					//dispatchEvent(new Event("WrongClick"));
				}
			}	
			return score;
		}
		private function makeRandomGrid():void
		{
			grid = new IntGrid(w, h);
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					grid.Set(i, j, int(FP.random * G.amountOfTypes));
				}
			}
		}
		
		
	}

}