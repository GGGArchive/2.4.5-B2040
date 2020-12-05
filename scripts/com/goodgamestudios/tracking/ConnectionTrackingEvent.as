package com.goodgamestudios.tracking
{
   import com.goodgamestudios.utils.TimezoneUtil;
   import flash.net.URLVariables;
   
   public class ConnectionTrackingEvent extends BasicTrackingEvent
   {
      
      public static const EVENT_ID:int = 2;
       
      
      public var connectionTime:String;
      
      public var roundTrip:String;
      
      public var downloadRate:String;
      
      public var accountId:String;
      
      public var delay:int;
      
      public var bluebox:int;
      
      public function ConnectionTrackingEvent(param1:String)
      {
         super(param1);
      }
      
      override public function getVars() : URLVariables
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.var_1 = this.connectionTime;
         _loc1_.var_2 = this.roundTrip;
         _loc1_.var_3 = this.downloadRate;
         _loc1_.var_4 = this.bluebox;
         _loc1_.var_5 = this.delay;
         _loc1_.var_6 = TimezoneUtil.getTrackingTimezone();
         _loc1_.var_7 = this.accountId;
         _loc1_.var_data = referrer;
         return _loc1_;
      }
   }
}
