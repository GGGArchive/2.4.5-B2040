package com.goodgamestudios.tracking
{
   import flash.net.URLVariables;
   
   public class ClientLoadTrackingEvent extends BasicTrackingEvent
   {
      
      public static const EVENT_ID:int = 30;
       
      
      public var gameId:int;
      
      public var networkId:int;
      
      public var distributorId:String;
      
      public var versionDate:String;
      
      public var cid:String;
      
      public var websiteId:String;
      
      public var accountId:String;
      
      public function ClientLoadTrackingEvent(param1:String)
      {
         super(param1);
      }
      
      override public function getVars() : URLVariables
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.var_1 = this.distributorId;
         _loc1_.var_2 = this.versionDate;
         _loc1_.var_3 = this.cid;
         _loc1_.var_4 = this.websiteId;
         _loc1_.var_5 = this.accountId;
         _loc1_.var_data = referrer;
         _loc1_.eventId = EVENT_ID;
         _loc1_.gameId = this.gameId;
         _loc1_.networkId = this.networkId;
         return _loc1_;
      }
   }
}
