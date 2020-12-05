package com.goodgamestudios.tracking
{
   import flash.net.URLVariables;
   
   public class ImpressionTrackingEvent extends BasicTrackingEvent
   {
      
      public static const EVENT_ID:int = 8;
       
      
      public var partnerId:String;
      
      public var creative:String;
      
      public var lp:String;
      
      public var placement:String;
      
      public var keyword:String;
      
      public var network:String;
      
      public var channelId:String;
      
      public var trafficSourceId:String;
      
      public var aid:String;
      
      public var camp:String;
      
      public var adgr:String;
      
      public var matchtype:String;
      
      public var journeyHash:String = "";
      
      public function ImpressionTrackingEvent(param1:String)
      {
         super(param1);
      }
      
      override public function getVars() : URLVariables
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.var_data = referrer;
         if(this.partnerId)
         {
            _loc1_.var_1 = this.partnerId;
            _loc1_.var_2 = this.creative;
            _loc1_.var_3 = this.lp;
            _loc1_.var_4 = this.aid;
            _loc1_.var_7 = this.journeyHash;
            _loc1_.var_data = _loc1_.var_data + (";" + this.placement + ";" + this.keyword + ";" + this.network + ";" + this.channelId + ";" + this.trafficSourceId + ";" + this.camp + ";" + this.adgr + ";" + this.matchtype);
         }
         return _loc1_;
      }
   }
}
