package com.goodgamestudios.mafia.event
{
   import flash.events.Event;
   
   public class MafiaSliderEvent extends Event
   {
      
      public static const ON_SLIDING:String = "onsliding";
      
      public static const ARROW_UP:String = "slideUp";
      
      public static const ARROW_DOWN:String = "slideDown";
       
      
      public var slidePos:int;
      
      public var buttonDown:Boolean;
      
      public function MafiaSliderEvent(param1:String, param2:int, param3:Boolean, param4:Boolean = false, param5:Boolean = false)
      {
         this.slidePos = param2;
         this.buttonDown = param3;
         super(param1,param4,param5);
      }
   }
}
