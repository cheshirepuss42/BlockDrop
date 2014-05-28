package  Puzzle
{
	//import Box2D.Collision.b2ContactPoint;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	public class Blocks extends EventDispatcher
	{
		private var grid:Vector.<Vector.<int>>;
		private var searchGrid:Vector.<Vector.<int>>;
		private var w:int;
		private var h:int;
		private var amTypes:int = 5;
		private var neighbours:Vector.<Point> = Vector.<Point>([new Point(0, 1), new Point(1, 0), new Point(0, -1), new Point( -1, 0)]);
		private var colors:Vector.<uint> = Vector.<uint>([0,0xcccccc, 0xff0000 ,0x0000ff,0x00ff00, 0xffff00,0xeeee00, 0x00eeee]);
		private var shapeVect:Vector.<Point> = new Vector.<Point>();
		private var shapes:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
		//private var shapePoints:Vector.<Point> = new Vector.<Point>();
		private var size:int; 
		private var score:int = 0;
		private var minShapeSize:int = 4;
		private var newScore:Boolean = false;
		
		public function Blocks(_w:int,_h:int,_s:int) 
		{
			size = _s;
			w = _w;
			h = _h;
			//setupGrid();
			//setupSearchGrid();
			//findShapes();
			init();
		}
		public function hasNewScore():Boolean
		{
			return newScore;
		}
		public function getScore():int
		{
			newScore = false;
			return score;
		}
		public function getSize():int
		{
			return size;
		}		
		private function setupGrid():void
		{			
			//make a new grid and fill it with random types of blocks
			grid = new Vector.<Vector.<int>>();
			for (var i:int = 0; i < w; i++) 
			{
				grid[i] = new Vector.<int>();
				for (var j:int = 0; j < h; j++) 
				{
					grid[i][j] = int(Math.random() * amTypes)+1;
				}				
			}			
		}
		private function setupSearchGrid():void
		{
			//make a grid filled with 0
			searchGrid = new Vector.<Vector.<int>>();
			for (var i:int = 0; i < w; i++) 
			{
				searchGrid[i] = new Vector.<int>();
				for (var j:int = 0; j < h; j++) 
				{
					searchGrid[i][j] = 0;
				}				
			}			
		}		
		//public function handlePoint(p:Point):void
		//{
			//
			//if (pointIsOnGrid(p))
			//{
				//find which of the shapes the point is in
				//var shapenr:int = -1;
				//for (var m:int = 0; m < shapes.length; m++) 
				//{
					//if (searchPoints(p, shapes[m]) != -1)
					//{
						//shapenr = m;
						//m = shapes.length;
					//}
				//}
				//if point is in one of the shapes
				//if (shapenr >= 0)
				//{
					//set the shape to zero on the grid
					//for (var i:int = 0; i < shapes[shapenr].length; i++) 
					//{
						//grid[shapes[shapenr][i].x][shapes[shapenr][i].y] = 0;
					//}	
					//add the size of the shape to the score
					//score = (shapes[shapenr].length - (minShapeSize-1)) * 2;
					//let others know that a shape was removed
					//dispatchEvent(new Event("ShapeRemoved"));
					//remove the shape from the found shapes list (is this necessary?)
					//shapes.splice(shapenr, 1);
					//make all the blocks above the removed ones drop down
					//dropAboveEmpty();
					//the score has changed
					//newScore = true;
					//
				//}	
				//else
				//{
					//else punish the player with a sound and a score-deduction
					//score = -5;
					//dispatchEvent(new Event("WrongClick"));
					//newScore = true;
				//}
			//}
			//look for the shapes on the newly changed grid (only when grid was changed)
			//findShapes();
			//if (shapes.length == 0)
			//{
				//if there are no more shapes, reset the grid, and send an event
				//init();				
				//dispatchEvent(new Event("LastShapeRemoved"));				
			//}			
		//}
		//public function init():void
		//{
			//score = 20;			
			//newScore = true;
			//setupGrid();
			//setupSearchGrid();
			//findShapes();			
		//}
		//private function dropAboveEmpty():void
		//{
			//go through all the blocks
			//for (var i:int = 0; i < w; i++) 
			//{
				//for (var j:int = 0; j < h; j++) 
				//{
					//if the gridpoint is empty
					//if (grid[i][j] == 0)
					//{
						//store the point 
						//var p:Point = new Point(i, j);
						//while the point is not on the top row
						//while (p.y >= 0)
						//{	
							//fill point with value of point above it, or a random one if it is on the top row
							//grid[p.x][p.y] = (p.y == 0)?int(Math.random() * amTypes) + 1:grid[p.x][p.y - 1];
							//set temp point to one row higher
							//p.y -= 1;
						//}
					//}					
				//}
			//}
		//}
		
		//private function findShapes():void
		//{	
			//empty shapes
			//shapes.splice(0, shapes.length);
			//prepare searchgrid
			//setupSearchGrid();
			//walk through all blocks
			//for (var i:int = 0; i < w; i++) 
			//{
				//for (var j:int = 0; j < h; j++) 
				//{
					//var isPresent:Boolean = false;
					//check if current point is in one of the stored shapes
					//for (var m:int = 0; m < shapes.length; m++) 
					//{
						//if (searchPoints(new Point(i, j), shapes[m]) != -1)
						//{
							//isPresent = true;							
							//break;
						//}
					//}	
					//if not present in shapes so far
					//if (!isPresent)
					//{
						//store the shape in shapevect
						//findNextPointInShape(new Point(i, j));	
						//put it in the list of found shapes if the shape has at least the minimum size (4)
						//if (shapeVect.length >= minShapeSize )
						//{
							//shapes.push(shapeVect);
						//}
						//'recycle' shapevect
						//shapeVect = new Vector.<Point>();
					//}
				//}				
			//}
			//clone grid to searchgrid
			//for (var k:int = 0; k < shapes.length; k++) 
			//{
				//for (var l:int = 0; l <shapes[k].length ; l++) 
				//{
					//searchGrid[shapes[k][l].x][shapes[k][l].y] = grid[shapes[k][l].x][shapes[k][l].y];
				//}
			//}
//
		//}
		//private function findNextPointInShape(p:Point):void
		//{
			//recursive function that builds a shape from adjoining points
			//
			//put point in the shape that we're building
			//shapeVect.push(p);
			//collect neighbours with the same type
			//var nb:Vector.<Point> = getNeighbours(p);
			//for (var i:int = 0; i < nb.length; i++) 
			//{
				//if the neighbour is not yet in the shape
				//if (searchPoints(nb[i],shapeVect)==-1)
				//{
					//run this again with the same-types neighbour as input
					//findNextPointInShape(nb[i]);
				//}
			//}			
		//}
//
		//private function getNeighbours(p:Point):Vector.<Point>		
		//{
			//setup an array to store the neighbours in
			//var points:Vector.<Point> = new Vector.<Point>();
			//for (var i:int = 0; i < neighbours.length; i++) 
			//{
				//set the location of the next possible neighbour
				//var neighbour:Point = new Point(p.x + neighbours[i].x, p.y + neighbours[i].y);
				//if (pointIsOnGrid(neighbour))
				//{
					//if the point and the nieghbour are of the same type, add it to the list
					//if (grid[neighbour.x][neighbour.y] == grid[p.x][p.y])
					//{
						//points.push(neighbour);
					//}
				//}								
			//}		
			//return points;
		//}
		//private function pointIsOnGrid(p:Point):Boolean
		//{
			//return p.x >= 0 && p.x < w && p.y >= 0 && p.y < h;
		//}	
		//public function getView():Sprite
		//{
			//var spr:Sprite = new Sprite();
			//var gr:Sprite = gridView(grid);
			//var sgr:Sprite = gridView(searchGrid);
			//spr.addChild(gr);			
			//sgr.x += gr.width + 10;
			//return spr;
		//}
		//public function doFallingAnimation(shapenr:int,duration:int):void
		//{
			//make seperate sprite
			//paint shape black
			//
			//for (var k:int = 0; k < shapes[shapenr].length; k++) 
			//{
				//grid[shapes[shapenr][k].x][shapes[shapenr][k].y] = 0;
			//}
			//var droppingPoints:Vector.<Point> = new Vector.<Point>();
			//var dropping:Sprite = new Sprite();
			//for (var i:int = 0; i < w; i++) 
			//{
				//for (var j:int = 0; j < h; j++) 
				//{
					//if (grid[i][j] == 0)
					//{
						//var p:Point = new Point(i, j);
						//while (p.y >= 0)
						//{							
							//grid[p.x][p.y] = (p.y == 0)?int(Math.random() * amTypes)+1:grid[p.x][p.y - 1];
							//p.y -= 1;
							//dropping.graphics
							//dropping.graphics.beginFill(colors[grid[p.x][p.y]],0.35);					
							//dropping.graphics.drawRect(p.x * size, p.y * size, size, size);
							//dropping.graphics.endFill();	
							//dropping.graphics.lineStyle(1, 0);
							//dropping.graphics.beginFill(colors[grid[p.x][p.y]]);
							//dropping.graphics.drawRect(p.x * size + 2, p.y * size + 2, size-3, size-3);
							//view.graphics.drawCircle((i * size)+(size/2), (j * size)+(size/2), (size/2)-2);
							//dropping.graphics.endFill();	
							//dropping.graphics.lineStyle(0, 0);								
							//droppingPoints.push(p.clone());
						//}
					//}
					//
				//}
			//}
			//var dropping:Sprite = new Sprite();
			//
			//trace(droppingPoints);
			//make new shape from blocks above black
		//}
		//private function gridView(gr:Vector.<Vector.<int>>):Sprite
		//{
			//var view:Sprite = new Sprite();
			//var size:int = 30;
			//for (var i:int = 0; i < w; i++) 
			//{
				//for (var j:int = 0; j < h; j++) 
				//{
					//
					//view.graphics.beginFill(colors[gr[i][j]],0.35);					
					//view.graphics.drawRect(i * size, j * size, size, size);
					//view.graphics.endFill();	
					//view.graphics.lineStyle(1, 0);
					//view.graphics.beginFill(colors[gr[i][j]]);
					//view.graphics.drawRect(i * size + 2, j * size + 2, size-3, size-3);
					//view.graphics.drawCircle((i * size)+(size/2), (j * size)+(size/2), (size/2)-2);
					//view.graphics.endFill();	
					//view.graphics.lineStyle(0, 0);				
				//}				
			//}
			//trace(gr);
			//return view;
			//
		//}
		//private function searchPoints(p:Point,pts:Vector.<Point>):int
		//{
			//check if Point is in list of points
			//for (var i:int = 0; i < pts.length; i++) 
			//{
				//if (p.equals(pts[i]))
					//return i;
			//}
			//return -1;
		//}
	}

}