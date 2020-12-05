package com.goodgamestudios.mafia.view.screens.shops
{
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.event.model.MafiaShopEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MafiaConsumablesShopComponent extends MafiaShopComponent
   {
       
      
      private var maxPage:int = 0;
      
      private var currentPage:int = 0;
      
      private const ITEMS_PER_PAGE:int = 8;
      
      public function MafiaConsumablesShopComponent(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,false);
      }
      
      override public function show() : void
      {
         super.show();
         this.currentPage = 0;
         fillItemsInShop(Vector.<ItemVO>(MafiaModel.userData.consumablesShop.items),ItemLocation.ShopConsumables);
         controller.addEventListener(MafiaShopEvent.CHANGE_CONSUMABLE_SHOP_DATA,this.onChangeConsumableShopData);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         super.onClick(param1);
      }
      
      private function filteredItems() : Vector.<ItemVO>
      {
         var _loc1_:int = this.currentPage * this.ITEMS_PER_PAGE;
         var _loc2_:Vector.<ItemVO> = MafiaModel.userData.consumablesShop.items;
         var _loc3_:Vector.<ItemVO> = new Vector.<ItemVO>();
         var _loc4_:int = 0;
         while(_loc4_ < this.ITEMS_PER_PAGE)
         {
            if(_loc1_ < _loc2_.length)
            {
               _loc3_[_loc4_] = _loc2_[_loc1_];
            }
            _loc1_++;
            _loc4_++;
         }
         return _loc3_;
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         controller.removeEventListener(MafiaShopEvent.CHANGE_CONSUMABLE_SHOP_DATA,this.onChangeConsumableShopData);
      }
      
      private function onChangeConsumableShopData(param1:MafiaShopEvent) : void
      {
         fillItemsInShop(Vector.<ItemVO>(MafiaModel.userData.consumablesShop.items),ItemLocation.ShopConsumables);
      }
      
      override protected function onTutorialEvent(param1:MafiaTutorialEvent) : void
      {
         super.onTutorialEvent(param1);
         switch(MafiaTutorialController.getInstance().tutorialState)
         {
            case MafiaTutorialController.TUT_STATE_SELECT_DYNAMITE:
               shop.tutpoint_17.addChild(MafiaTutorialController.getInstance().tutorialArrow);
         }
      }
   }
}
