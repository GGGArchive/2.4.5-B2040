package com.goodgamestudios.mafia.view.screens.shops
{
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.event.model.MafiaShopEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import flash.display.DisplayObject;
   
   public class MafiaTournamentShopComponent extends MafiaShopComponent
   {
       
      
      public function MafiaTournamentShopComponent(param1:DisplayObject)
      {
         super(param1,false);
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaShopEvent.CHANGE_TOURNAMENT_SHOP_DATA,this.onChangeTournamentShopData);
         shop.txt_explanation.text = MafiaModel.languageData.getTextById("MafiaEventShopScreen_info");
         fillItemsInShop(MafiaModel.userData.tournamentShop.items,ItemLocation.ShopEvent);
      }
      
      private function onChangeTournamentShopData(param1:MafiaShopEvent) : void
      {
         fillItemsInShop(MafiaModel.userData.tournamentShop.items,ItemLocation.ShopEvent);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(MafiaShopEvent.CHANGE_TOURNAMENT_SHOP_DATA,this.onChangeTournamentShopData);
      }
   }
}
