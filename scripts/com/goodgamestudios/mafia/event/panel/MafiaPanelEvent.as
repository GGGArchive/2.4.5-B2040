package com.goodgamestudios.mafia.event.panel
{
   import flash.events.Event;
   
   public class MafiaPanelEvent extends Event
   {
      
      public static const MOUSE_ON_PANEL:String = "mouseonpanel";
      
      public static const CHAT_INPUT:String = "chatinput";
      
      public static const MOUSE_OVER:String = "mouseover";
      
      public static const MOUSE_OUT:String = "mouseout";
       
      
      public var params:Array = null;
      
      public function MafiaPanelEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         this.params = param2;
         super(param1,param3,param4);
      }
   }
}
