package com.goodgamestudios.mafia.event.model
{
   public class MafiaTipEvent extends MafiaEvent
   {
      
      public static const SHOW_TIP:String = "showtip";
      
      public static const HIDE_TIP:String = "hidetip";
      
      public static const UPDATE_TIP:String = "updatetip";
       
      
      public function MafiaTipEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
