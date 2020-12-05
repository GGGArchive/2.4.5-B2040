package com.goodgamestudios.tracking
{
   import flash.net.URLVariables;
   
   public class ABTestTimeoutTrackingEvent extends BasicTrackingEvent
   {
      
      public static const EVENT_ID:int = 39;
       
      
      public var playerId:int = 0;
      
      public var testID:int;
      
      public var accountID:String;
      
      public function ABTestTimeoutTrackingEvent(param1:String)
      {
         super(param1);
      }
      
      override public function getVars() : URLVariables
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.playerId = this.playerId;
         _loc1_.var_2 = this.testID;
         _loc1_.var_4 = this.accountID;
         _loc1_.var_data = referrer;
         return _loc1_;
      }
   }
}
