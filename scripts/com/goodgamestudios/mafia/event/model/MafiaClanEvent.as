package com.goodgamestudios.mafia.event.model
{
   public class MafiaClanEvent extends MafiaEvent
   {
      
      public static const CHANGE_USERCLAN:String = "changeUserClan";
      
      public static const CHANGE_OTHERCLAN:String = "changeOtherClan";
      
      public static const CHANGE_CLANMEMBER:String = "changeClanMember";
      
      public static const CHANGE_ATTACKCLANWARTIME:String = "changeAttackClanWarTime";
      
      public static const CHANGE_DEFENDCLANWARTIME:String = "changeDefendClanWarTime";
      
      public static const CHANGE_TEMPBOOSTERXPTIME:String = "changeTempBoosterXPTime";
      
      public static const CHANGE_TEMPBOOSTERC1TIME:String = "changeTempBoosterC1Time";
      
      public static const CHANGE_CLANCHAT:String = "changeClanChat";
      
      public static const CHANGE_CLANSTATUS:String = "changeClanStatus";
      
      public static const CHANGE_CLANWARDATA:String = "changeClanWar";
      
      public static const CHANGE_PINBOARDDATA:String = "changePinboard";
      
      public static const CHANGE_FAMILY_MESSAGE:String = "changeFamilyMessage";
      
      public static const CHANGE_FAMILY_ACCOUNT:String = "changeFamilyAccount";
      
      public static const CHANGE_FAMILY_NOTIFICATION:String = "changeFamilyNotification";
       
      
      public function MafiaClanEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
