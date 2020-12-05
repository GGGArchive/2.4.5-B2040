package com.goodgamestudios.basic.tracking
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.constants.BasicTrackingConstants;
   import com.goodgamestudios.marketing.google.CampaignVars;
   
   public class BasicTrackingStringComposer
   {
       
      
      public function BasicTrackingStringComposer()
      {
         super();
      }
      
      public static function composeVarDataForRegistration(param1:String, param2:String) : String
      {
         var _loc3_:CampaignVars = env.campainVars;
         var _loc4_:Array = [];
         _loc4_[0] = param1;
         _loc4_[1] = param2;
         _loc4_[2] = _loc3_.placement;
         _loc4_[3] = _loc3_.keyword;
         _loc4_[4] = _loc3_.network;
         _loc4_[5] = _loc3_.channelId;
         _loc4_[6] = _loc3_.trafficSource;
         _loc4_[7] = _loc3_.camp;
         _loc4_[8] = _loc3_.adgr;
         _loc4_[9] = _loc3_.matchtype;
         _loc4_[10] = env.jsVariables.journeyHash;
         _loc4_[11] = env.urlVariables.websiteId;
         return _loc4_.join(BasicTrackingConstants.DEFAULT_DELIMITER);
      }
      
      private static function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
