package com.goodgamestudios.mafia.event.model
{
   public class MafiaBoosterEvent extends MafiaEvent
   {
      
      public static const CHANGE_BOOSTERSHOPDATA:String = "changeBoosterShopData";
      
      public static const CHANGE_BOOSTER_TIMER:String = "changeBoosterTimer";
       
      
      public function MafiaBoosterEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
