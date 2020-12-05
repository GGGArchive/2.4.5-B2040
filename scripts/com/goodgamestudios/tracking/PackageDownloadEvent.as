package com.goodgamestudios.tracking
{
   import flash.net.URLVariables;
   
   public class PackageDownloadEvent extends BasicTrackingEvent
   {
      
      public static const EVENT_ID:int = 56;
       
      
      public var gameId:int;
      
      public var networkId:int;
      
      public var instanceID:int;
      
      public var playerID:int;
      
      public var accountID:String;
      
      public var countryCode:String;
      
      public var downloadSize:Number;
      
      public var downloadDuration:Number;
      
      public var downloadURL:String;
      
      public function PackageDownloadEvent(param1:String)
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
         _loc1_.var_1 = this.downloadSize;
         _loc1_.var_2 = this.downloadDuration;
         _loc1_.var_3 = this.accountID;
         _loc1_.var_data = this.downloadURL + ";" + this.countryCode;
         return _loc1_;
      }
   }
}
