package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.mafia.event.model.MafiaTipEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.vo.TipVO;
   import com.gskinner.motion.GTween;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   
   public class MafiaTipPanel extends MafiaPanel
   {
      
      private static const MAXMCSIZE:int = 45;
      
      public static const INDEX:int = 1;
       
      
      public function MafiaTipPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_TIP;
         param1.visible = false;
         param1.y = -100 * layoutManager.scaleFactor;
         controller.addEventListener(MafiaTipEvent.HIDE_TIP,this.onHideTip);
         controller.addEventListener(MafiaTipEvent.SHOW_TIP,this.onShowTip);
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(MafiaTipEvent.HIDE_TIP,this.onHideTip);
         controller.removeEventListener(MafiaTipEvent.SHOW_TIP,this.onShowTip);
         super.destroy();
      }
      
      override protected function init() : void
      {
         super.updateAllTextFields();
      }
      
      private function onHideTip(param1:MafiaTipEvent) : void
      {
         this.hideTip();
      }
      
      private function hideTip() : void
      {
         var _loc1_:GTween = null;
         disp.cacheAsBitmap = true;
         _loc1_ = new GTween(disp,0.5,{"y":-100 * layoutManager.scaleFactor});
      }
      
      private function onShowTip(param1:MafiaTipEvent) : void
      {
         var _loc3_:GTween = null;
         var _loc4_:Number = NaN;
         var _loc2_:TipVO = param1.params[0] as TipVO;
         if(!_loc2_)
         {
            return;
         }
         disp.visible = true;
         this.tipPanel.holder.properties = null;
         this.tipPanel.txt_copy.mouseEnabled = false;
         while(this.tipPanel.holder.numChildren > 0)
         {
            this.tipPanel.holder.removeChildAt(0);
         }
         if(_loc2_.mc)
         {
            _loc2_.mc.mouseEnabled = false;
            _loc4_ = MAXMCSIZE / _loc2_.mc.height;
            _loc2_.mc.height = MAXMCSIZE;
            _loc2_.mc.width = _loc2_.mc.width * _loc4_;
            _loc2_.mc.filters = [new DropShadowFilter(2,45,3355443,0.7,2,2,3,1)];
            this.tipPanel.holder.addChild(_loc2_.mc);
            this.tipPanel.holder.functionClick = _loc2_.functionClick;
         }
         disp.cacheAsBitmap = true;
         _loc3_ = new GTween(disp,0.5,{"y":0});
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         MafiaModel.tipData.stopTip = true;
         if(0)
         {
         }
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         MafiaModel.tipData.stopTip = false;
         if(0)
         {
         }
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         super.onClick(param1);
         MafiaModel.tipData.stopTip = false;
         switch(param1.target)
         {
            case this.tipPanel.holder:
               if(this.tipPanel.holder.functionClick)
               {
                  this.tipPanel.holder.functionClick();
               }
               this.hideTip();
               break;
            case this.tipPanel.bg:
               this.hideTip();
         }
      }
      
      private function get tipPanel() : TipPanel
      {
         return disp as TipPanel;
      }
   }
}
