package com.goodgamestudios.basic.view.firstVisit
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFieldAutoSize;
   
   public class FirstVisitToolTipManager
   {
       
      
      public var disp:MovieClip;
      
      private var parent:MovieClip;
      
      private const SPACE:int = 10;
      
      protected const MAX_WIDTH:int = 200;
      
      public function FirstVisitToolTipManager(param1:MovieClip)
      {
         super();
         this.parent = param1;
         param1.disp.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         param1.disp.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         param1.disp.addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      public function set toolTip(param1:MovieClip) : void
      {
         this.disp = param1;
         this.parent.disp.stage.addChild(this.disp);
         this.disp.txt_text.autoSize = TextFieldAutoSize.CENTER;
         this.disp.visible = false;
      }
      
      public function get toolTip() : MovieClip
      {
         return this.disp;
      }
      
      protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc3_:Number = NaN;
         if(param1.target == this.disp || !(param1.target is MovieClip) || !param1.target.toolTipText)
         {
            return;
         }
         var _loc2_:Point = param1.target.localToGlobal(new Point(param1.target.stage.x,param1.target.stage.y));
         this.disp.x = _loc2_.x;
         this.disp.y = _loc2_.y + param1.target.height * 0.5;
         this.disp.txt_text.text = param1.target.toolTipText;
         this.disp.txt_text.width = this.MAX_WIDTH;
         if(this.disp.txt_text.textWidth + this.SPACE < this.MAX_WIDTH)
         {
            this.disp.txt_text.width = this.disp.txt_text.textWidth + this.SPACE;
         }
         this.disp.mc_arrow.y = this.disp.mc_bg.y + 2;
         this.disp.txt_text.x = -(this.disp.txt_text.width * 0.5);
         this.disp.mc_bg.width = this.disp.txt_text.textWidth + this.SPACE + 30;
         this.disp.mc_bg.height = this.disp.txt_text.height + this.disp.txt_text.numLines * 5;
         this.disp.txt_text.y = this.disp.mc_arrow.y + 4 + this.disp.txt_text.numLines * 1;
         this.disp.visible = true;
         this.disp.mc_bg.x = 0;
         if(this.disp.width * 0.5 + this.disp.x > this.disp.stage.stageWidth)
         {
            _loc3_ = this.disp.width * 0.5 + this.disp.x - this.disp.stage.stageWidth;
            this.disp.mc_bg.x = this.disp.mc_bg.x - _loc3_;
            this.disp.txt_text.x = this.disp.txt_text.x - _loc3_;
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         this.disp.visible = false;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         this.disp.visible = false;
      }
      
      public function destroy() : void
      {
         this.parent.disp.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.parent.disp.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.parent.disp.stage.removeChild(this.disp);
         MovieClipHelper.clearMovieClip(this.disp);
         this.parent = null;
      }
   }
}
