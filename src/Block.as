package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.*;
	import net.flashpunk.graphics.Image;

	public class Block extends Entity
	{
		public var grX:int;
		public var grY:int;
		private var img1:Image;
		private var img2:Image;
		private var outLine:int = 1;
		//private var colorTween:ColorTween;
		private var blockType:int;
		private var tweenTimer:Number;
		public function Block() 
		{
			type = "block";
		}
		public function setup(px:int,py:int,blockType:int):void
		{
			
			this.blockType = blockType;
			//colorTween = new ColorTween();
			//setTween(G.colors[blockType]);
			
			img1 = Image.createRect(G.blockSize, G.blockSize, 0,0.8);
			img2 = Image.createRect(G.blockSize-(outLine * 2), G.blockSize-(outLine * 2), G.colors[blockType]);
			//img2.x = img2.y = outLine;
			grX = px;
			grY = py;
			x = G.blockSize * px;			
			y = G.blockSize * py;
			setHitbox(G.blockSize, G.blockSize);
			addGraphic(img1);
			addGraphic(img2);
			//centerOrigin();
			//img2.centerOrigin();
			//img2.angle = 35;
			//img2.x += G.blockSize / 2;
			//img2.y += G.blockSize / 2;
			
		}
		//private function setTween(startColor:uint):void
		//{
			//trace("resetting colortween");
			//tweenTimer = (150);
			//colorTween.tween(tweenTimer, startColor,0xffffff *FP.random);
		//}
		
		override public function update():void 
		{
			super.update();
			//img2.angle += -2+(FP.random*4);
			//colorTween.update();
			//if(colorTween.percent>=1)
				//setTween(G.colors[blockType]);
			//img2.color = colorTween.color;
			if (Input.mousePressed && collidePoint(x, y, world.mouseX, world.mouseY))
			{				
				GameWorld(world).handlePoint(grX, grY);
			}
		}
		
		
	}

}