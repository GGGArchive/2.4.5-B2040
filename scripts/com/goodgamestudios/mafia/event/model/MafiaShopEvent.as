package com.goodgamestudios.mafia.event.model
{
   public class MafiaShopEvent extends MafiaEvent
   {
      
      public static const CHANGE_WEAPON_SHOP_DATA:String = "changeWeaponShopData";
      
      public static const CHANGE_KIOSK_SHOP_DATA:String = "changeKioskShopData";
      
      public static const CHANGE_CONSUMABLE_SHOP_DATA:String = "changeConsumableShopData";
      
      public static const CHANGE_TOURNAMENT_SHOP_DATA:String = "changeTournamentShopData";
      
      public static const CHANGE_EXTRAS_SHOP_DATA:String = "changeExtrasShopData";
      
      public static const CHANGE_NEW_SHOP_ITEMS_FAILED:String = "changeNewShopItemsFailed";
      
      public static const CHANGE_NEW_ITEMS_IN_WEAPON_SHOP_TIME:String = "changeNewItemsInWeaponShopTime";
      
      public static const CHANGE_NEW_ITEMS_IN_KIOSK_SHOP_TIME:String = "changeNewItemsInKioskShopTime";
      
      public static const CHANGE_NEW_ITEMS_IN_CONSUMABLES_SHOP_TIME:String = "changenewitemsinconsumablesshoptime";
      
      public static const CHANGE_SHOP_BUY_HELP:String = "changeShopBuyHelp";
      
      public static const CHANGE_BREAKING_THE_LAW_SHOP_DATA:String = "changeBreakingtheLawShopData";
      
      public static const CHANGE_SHOP_STATE:String = "changeShopState";
       
      
      public function MafiaShopEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
