package com.goodgamestudios.mafia.view.screens.ranking
{
   import com.goodgamestudios.basic.event.BasicComboboxEvent;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.mafia.view.MafiaComboboxComponent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MafiaRankingComboboxComponent extends MafiaComboboxComponent
   {
       
      
      private var _mainItemName:String;
      
      public function MafiaRankingComboboxComponent(param1:MovieClip, param2:String = "", param3:int = 1, param4:int = 32, param5:int = 18, param6:int = 0, param7:Boolean = false)
      {
         super(param1,param2,param3,param4,param5,param6,param7);
         _disp.bg.visible = true;
      }
      
      override public function addItem(param1:Object) : void
      {
         _itemData.push(param1);
         var _loc2_:int = CLOSED_HEIGHT + _itemData.length * (ITEM_HEIGHT + ITEM_SPACE);
         if(_itemDir == 1)
         {
            _loc2_ = _loc2_ + (_disp.item_Holder.y - (_disp.txt_selected.y + _disp.txt_selected.height));
         }
         _scaleOpen = _loc2_ / CLOSED_HEIGHT;
         var _loc3_:MovieClip = new this.itemClass();
         _loc3_.txt_item.text = param1.label;
         this._mainItemName = param1.data.mainName;
         if(ITEM_WIDTH > 0)
         {
            _loc3_.bg.width = ITEM_WIDTH;
         }
         _loc3_.gotoAndStop(1);
         _loc3_.id = _itemData.length - 1;
         _loc3_.y = (_itemData.length - 1) * (ITEM_HEIGHT + ITEM_SPACE) * _itemDir;
         _disp.item_Holder.addChild(_loc3_);
         _disp.showLine.visible = false;
      }
      
      override public function selectItemIndex(param1:int) : void
      {
         if(_itemData.length < 1)
         {
            return;
         }
         if(param1 > _itemData.length || param1 < 0)
         {
            _selectedItem = -1;
            _disp.txt_selected.text = _defaultString;
         }
         else
         {
            _selectedItem = param1;
            _disp.txt_selected.text = this._mainItemName + _itemData[_selectedItem].label;
         }
         _disp.dispatchEvent(new BasicComboboxEvent(BasicComboboxEvent.COMBOBOXCHANGE));
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
         _disp.showLine.visible = true;
      }
      
      override public function hideItems() : void
      {
         _disp.btn_arrow.gotoAndStop(2);
         _disp.item_Holder.visible = false;
         _disp.dispatchEvent(new BasicComboboxEvent(BasicComboboxEvent.COMBOBOXSELECT,0));
         _disp.bg.scaleY = 1;
         _disp.showLine.visible = false;
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(param1.target is this.itemClass)
         {
            BasicLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            param1.target.gotoAndStop(1);
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(param1.target is this.itemClass)
         {
            BasicLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            param1.target.gotoAndStop(2);
         }
      }
      
      override protected function get itemClass() : Class
      {
         return RankingComboboxItem;
      }
   }
}
