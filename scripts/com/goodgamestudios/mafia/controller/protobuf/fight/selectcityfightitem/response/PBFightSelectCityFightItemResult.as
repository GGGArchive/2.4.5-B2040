package com.goodgamestudios.mafia.controller.protobuf.fight.selectcityfightitem.response
{
   public final class PBFightSelectCityFightItemResult
   {
      
      public static const OK:int = 1;
      
      public static const ITEM_NOT_FOUND:int = 2;
      
      public static const INVALID_CITY_FIGHT_STATE:int = 3;
      
      public static const ITEM_AMOUNT_LIMIT_REACHED:int = 4;
       
      
      public function PBFightSelectCityFightItemResult()
      {
         super();
      }
   }
}
