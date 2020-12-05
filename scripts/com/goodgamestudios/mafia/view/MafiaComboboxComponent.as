package com.goodgamestudios.mafia.view
{
   import com.goodgamestudios.basic.event.BasicComboboxEvent;
   import com.goodgamestudios.basic.view.BasicComboboxComponent;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   
   public class MafiaComboboxComponent extends BasicComboboxComponent
   {
       
      
      private var dropShadowFilter:DropShadowFilter;
      
      public function MafiaComboboxComponent(param1:MovieClip, param2:String = "", param3:int = -1, param4:int = 14, param5:int = 18, param6:int = 0, param7:Boolean = false)
      {
         this.dropShadowFilter = new DropShadowFilter(3,45,0,0.3);
         super(param1,BasicComboboxItem,param2,param3,param4,param5,param6,param7);
         _disp.bg.visible = false;
         if(_disp.lines)
         {
            _disp.lines.gotoAndStop(1);
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         BasicLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         if(param1.target is itemClass)
         {
            param1.target.bg.gotoAndStop(2);
            param1.target.txt_item.textColor = 16777215;
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         BasicLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         if(param1.target is itemClass)
         {
            param1.target.bg.gotoAndStop(1);
            param1.target.txt_item.textColor = 5196099;
         }
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         super.onMouseUp(param1);
         if(param1.target == _disp.bg2)
         {
            onClickArrow();
         }
      }
      
      override protected function showItems() : void
      {
         _disp.btn_arrow.gotoAndStop(1);
         _disp.bg.scaleY = _scaleOpen;
         if(_itemDir == -1)
         {
            _disp.item_Holder.y = -CLOSED_HEIGHT;
         }
         _disp.item_Holder.visible = true;
         _disp.dispatchEvent(new BasicComboboxEvent(BasicComboboxEvent.COMBOBOXSELECT,1));
         _disp.bg.visible = true;
         _disp.bg2.visible = false;
         _disp.lines.gotoAndStop(2);
         _disp.filters = [this.dropShadowFilter];
      }
      
      override public function hideItems() : void
      {
         _disp.btn_arrow.gotoAndStop(2);
         _disp.item_Holder.visible = false;
         _disp.dispatchEvent(new BasicComboboxEvent(BasicComboboxEvent.COMBOBOXSELECT,0));
         _disp.bg.scaleY = 1;
         _disp.bg2.visible = true;
         _disp.bg.visible = false;
         _disp.lines.gotoAndStop(1);
         _disp.filters = [];
      }
   }
}
