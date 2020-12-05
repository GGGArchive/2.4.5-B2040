package com.goodgamestudios.mafia.event.model
{
   public class MafiaFeatureEvent extends MafiaEvent
   {
      
      public static const CHANGE_ITEMS_IN_EXTRAS_SHOP_TIME:String = "changeItemsInExtrasShopTime";
       
      
      public function MafiaFeatureEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
