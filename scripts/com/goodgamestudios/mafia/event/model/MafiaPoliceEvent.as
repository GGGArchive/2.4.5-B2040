package com.goodgamestudios.mafia.event.model
{
   public class MafiaPoliceEvent extends MafiaEvent
   {
      
      public static const POLICE_OCCURS:String = "policeOccurs";
      
      public static const POLICE_SHOW_FIGHT:String = "policeShowFight";
      
      public static const CHANGE_POLICE_STATUS:String = "policeChangeStatus";
      
      public static const CHANGE_POLICE_EFFECT_TIMER:String = "policeChangeEffectTimer";
      
      public static const POLICE_RETREAT:String = "policeFlee";
       
      
      public function MafiaPoliceEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
