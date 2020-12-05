package com.goodgamestudios.mafia.controller.protobuf.shop.buyitem.response
{
   public final class PBShopBuyItemResult
   {
      
      public static const OK:int = 1;
      
      public static const WRONG_SOURCE:int = 2;
      
      public static const WRONG_TARGET:int = 3;
      
      public static const SOURCE_EMPTY:int = 4;
      
      public static const INVENTORY_SLOT_OCCUPIED:int = 5;
      
      public static const ITEM_AMOUNT_LIMIT_REACHED:int = 6;
      
      public static const CANNOT_AFFORD:int = 7;
      
      public static const FEATURE_INACTIVE:int = 8;
       
      
      public function PBShopBuyItemResult()
      {
         super();
      }
   }
}
