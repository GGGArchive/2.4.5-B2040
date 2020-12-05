package com.goodgamestudios.mafia.view.screens.shops
{
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.event.model.MafiaShopEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import flash.display.DisplayObject;
   
   public class MafiaBlackMarketShopComponent extends MafiaShopComponent
   {
       
      
      public function MafiaBlackMarketShopComponent(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,false);
      }
      
      override public function show() : void
      {
         super.show();
         shop.btn_newItems.properties = ItemLocation.ShopBlackMarket;
         fillItemsInShop(MafiaModel.userData.weaponShop.items,ItemLocation.ShopBlackMarket);
         controller.addEventListener(MafiaShopEvent.CHANGE_WEAPON_SHOP_DATA,this.onChangeBlackMarketShopData);
         controller.addEventListener(MafiaShopEvent.CHANGE_NEW_ITEMS_IN_WEAPON_SHOP_TIME,onShopTimer);
      }
      
      override protected function fillBasicShopInfo() : void
      {
         super.fillBasicShopInfo();
         fillNewItemInfo();
      }
      
      private function onChangeBlackMarketShopData(param1:MafiaShopEvent) : void
      {
         fillItemsInShop(MafiaModel.userData.weaponShop.items,ItemLocation.ShopBlackMarket);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaShopEvent.CHANGE_NEW_ITEMS_IN_WEAPON_SHOP_TIME,onShopTimer);
         controller.removeEventListener(MafiaShopEvent.CHANGE_WEAPON_SHOP_DATA,this.onChangeBlackMarketShopData);
         super.removeEvents();
      }
   }
}
