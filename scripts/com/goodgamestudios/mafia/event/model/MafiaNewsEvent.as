package com.goodgamestudios.mafia.event.model
{
   public class MafiaNewsEvent extends MafiaEvent
   {
      
      public static const CHANGE_NEWNEWSDATA:String = "changeNewNewsData";
      
      public static const CHANGE_NEWSDATA:String = "changeNewsData";
      
      public static const CHANGE_READMSGDATA:String = "changeReadMsgData";
      
      public static const CHANGE_SENDMSG:String = "changeSendMsg";
      
      public static const CHANGE_MAILREFRESHTIME:String = "changemailrefresh";
      
      public static const SWITCH_WRITEMAIL:String = "switchwritemail";
      
      public static const SET_VARS:String = "setvars";
      
      public static const DESELECT:String = "deselect";
       
      
      public function MafiaNewsEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
