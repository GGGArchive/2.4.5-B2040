package com.goodgamestudios.mafia.event.model
{
   import flash.events.Event;
   
   public class MafiaEvent extends Event
   {
       
      
      public var params:Array;
      
      public function MafiaEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         this.params = param2;
         super(param1,param3,param4);
      }
   }
}
