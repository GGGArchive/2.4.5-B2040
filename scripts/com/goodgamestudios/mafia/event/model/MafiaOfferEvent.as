package com.goodgamestudios.mafia.event.model
{
   public class MafiaOfferEvent extends MafiaEvent
   {
      
      public static const CHANGE_OFFER:String = "changeOffer";
      
      public static const CHANGE_OFFERENDTIME:String = "changeOfferEndTime";
      
      public static const CHANGE_GOLDSHINE:String = "changeGoldShine";
       
      
      public function MafiaOfferEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
