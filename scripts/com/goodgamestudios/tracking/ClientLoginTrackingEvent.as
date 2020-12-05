package com.goodgamestudios.tracking
{
   import flash.net.URLVariables;
   
   public class ClientLoginTrackingEvent extends BasicTrackingEvent
   {
      
      public static const EVENT_ID:int = 54;
       
      
      public var gameId:int;
      
      public var networkId:int;
      
      public var instanceID:int;
      
      public var playerID:int;
      
      public var lang:String;
      
      public function ClientLoginTrackingEvent(param1:String)
      {
         super(param1);
      }
      
      override public function getVars() : URLVariables
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.gameId = this.gameId;
         _loc1_.networkId = this.networkId;
         _loc1_.instanceId = this.instanceID;
         _loc1_.playerId = this.playerID;
         _loc1_.lang = this.lang;
         return _loc1_;
      }
   }
}
