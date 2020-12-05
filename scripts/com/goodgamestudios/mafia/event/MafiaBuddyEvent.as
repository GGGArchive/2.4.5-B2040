package com.goodgamestudios.mafia.event
{
   import flash.events.Event;
   
   public class MafiaBuddyEvent extends Event
   {
      
      public static const CHANGE_BUDDYDATA:String = "changebuddydata";
      
      public static const CHANGE_BUDDYAVATARDATA:String = "changebuddyavatardata";
       
      
      public var params:Array;
      
      public function MafiaBuddyEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         this.params = param2;
         super(param1,param3,param4);
      }
   }
}
