package com.goodgamestudios.mafia.event.model
{
   public class MafiaGangEvent extends MafiaEvent
   {
      
      public static const CHANGE_OWN_USER_GANG_DATA:String = "changeSelfUserGangData";
      
      public static const CHANGE_OTHER_USER_GANG_DATA:String = "changeOtherUserGangData";
      
      public static const CHANGE_OWN_USER_GANG_TIME:String = "changeSelfUserGangTime";
       
      
      public function MafiaGangEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
