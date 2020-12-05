package com.goodgamestudios.mafia.controller.protobuf.shop.saveitem.response
{
   public final class PBShopSaveItemResult
   {
      
      public static const OK:int = 1;
      
      public static const WRONG_SOURCE:int = 2;
      
      public static const SOURCE_EMPTY:int = 3;
      
      public static const SAFE_NOT_EMPTY:int = 4;
       
      
      public function PBShopSaveItemResult()
      {
         super();
      }
   }
}
