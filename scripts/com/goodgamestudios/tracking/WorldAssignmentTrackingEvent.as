package com.goodgamestudios.tracking
{
   import com.goodgamestudios.language.countries.AbstractGGSCountry;
   import com.goodgamestudios.marketing.google.CampaignVars;
   import com.goodgamestudios.utils.BrowserUtil;
   import com.goodgamestudios.utils.TimezoneUtil;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   
   public final class WorldAssignmentTrackingEvent extends BasicTrackingEvent
   {
      
      public static const EVENT_ID:int = 41;
       
      
      public var currCountry:AbstractGGSCountry;
      
      public var accountID:String;
      
      public var cv:CampaignVars;
      
      public function WorldAssignmentTrackingEvent(param1:String)
      {
         super(param1);
      }
      
      override public function getVars() : URLVariables
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.lang = Capabilities.language;
         _loc1_.var_1 = this.accountID;
         _loc1_.var_2 = TimezoneUtil.getTrackingTimezone();
         if(this.currCountry)
         {
            _loc1_.var_data = this.composeCampaignVarsStringForWorldAssignmentTracking(this.currCountry.ggsCountryCode,BrowserUtil.getBrowserLanguage());
         }
         return _loc1_;
      }
      
      private function composeCampaignVarsStringForWorldAssignmentTracking(param1:String, param2:String) : String
      {
         var _loc3_:Array = [];
         _loc3_[0] = param1;
         _loc3_[1] = param2;
         if(this.cv.isValid())
         {
            _loc3_[2] = this.cv.partnerId;
            _loc3_[3] = this.cv.creative;
            _loc3_[4] = this.cv.placement;
            _loc3_[5] = this.cv.keyword;
            _loc3_[6] = this.cv.network;
            _loc3_[7] = this.cv.lp;
            _loc3_[8] = this.cv.channelId;
            _loc3_[9] = this.cv.trafficSource;
            _loc3_[10] = this.cv.aid;
            _loc3_[11] = this.cv.camp;
            _loc3_[12] = this.cv.adgr;
            _loc3_[13] = this.cv.matchtype;
         }
         return _loc3_.join(";");
      }
   }
}
