package com.goodgamestudios.mafia.view.screens.shops
{
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.event.model.MafiaShopEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaKioskShopComponent extends MafiaShopComponent
   {
       
      
      public function MafiaKioskShopComponent(param1:DisplayObject)
      {
         super(param1,false);
      }
      
      override protected function fillBasicShopInfo() : void
      {
         super.fillBasicShopInfo();
         fillNewItemInfo();
      }
      
      private function onChangeKioskShopData(param1:MafiaShopEvent) : void
      {
         fillItemsInShop(MafiaModel.userData.kioskShop.items,ItemLocation.ShopKiosk);
      }
      
      override public function show() : void
      {
         super.show();
         shop.btn_newItems.properties = ItemLocation.ShopKiosk;
         fillItemsInShop(MafiaModel.userData.kioskShop.items,ItemLocation.ShopKiosk);
         controller.addEventListener(MafiaShopEvent.CHANGE_KIOSK_SHOP_DATA,this.onChangeKioskShopData);
         controller.addEventListener(MafiaShopEvent.CHANGE_NEW_ITEMS_IN_KIOSK_SHOP_TIME,onShopTimer);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(MafiaShopEvent.CHANGE_KIOSK_SHOP_DATA,this.onChangeKioskShopData);
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaShopEvent.CHANGE_NEW_ITEMS_IN_KIOSK_SHOP_TIME,onShopTimer);
         super.removeEvents();
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         super.onMouseDown(param1);
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         super.onMouseUp(param1);
      }
   }
}
