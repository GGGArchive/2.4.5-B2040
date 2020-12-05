package com.goodgamestudios.mafia.event.model
{
   public class MafiaSlotEvent extends MafiaEvent
   {
      
      public static const START_STLOTMACHINE:String = "startSlotmachine";
       
      
      public function MafiaSlotEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
