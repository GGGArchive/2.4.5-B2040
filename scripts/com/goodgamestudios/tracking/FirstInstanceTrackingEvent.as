package com.goodgamestudios.tracking
{
   import com.goodgamestudios.marketing.google.CampaignVars;
   import flash.net.URLVariables;
   
   public class FirstInstanceTrackingEvent extends BasicTrackingEvent
   {
      
      public static const EVENT_ID:int = 4;
       
      
      public var tutorialLength:String;
      
      public var sessionLength:String;
      
      public var registered:int = 0;
      
      public var gameState:String;
      
      public var testID:int;
      
      public var caseID:int;
      
      public var accountID:String;
      
      public var isFirstInstanceUser:Boolean;
      
      public var version:int;
      
      public var clp:int;
      
      public var cv:CampaignVars;
      
      public var sessionId:String;
      
      public function FirstInstanceTrackingEvent(param1:String)
      {
         super(param1);
      }
      
      override public function getVars() : URLVariables
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.var_1 = this.tutorialLength;
         _loc1_.var_2 = this.sessionLength;
         _loc1_.var_3 = this.encodeRegisteredVar();
         _loc1_.var_4 = this.testID;
         _loc1_.var_5 = this.accountID;
         _loc1_.var_6 = this.caseID;
         _loc1_.var_7 = int(!this.isFirstInstanceUser);
         _loc1_.var_data = this.composeCampaignVarsStringForUsertunnelTracking(this.gameState,referrer);
         return _loc1_;
      }
      
      private function encodeRegisteredVar() : int
      {
         return (this.version << 2) + (this.clp << 1) + this.registered;
      }
      
      private function composeCampaignVarsStringForUsertunnelTracking(param1:String, param2:String) : String
      {
         var _loc3_:Array = [];
         _loc3_[0] = param1;
         _loc3_[1] = param2;
         if(this.cv && this.cv.isValid())
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
         _loc3_[14] = this.sessionId;
         return _loc3_.join(";");
      }
   }
}
