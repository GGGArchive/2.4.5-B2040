package com.goodgamestudios.mafia.model.components.user.booster
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.controller.protobuf.mission.booster.getplayerbooster.response.PBMissionBoosterGetPlayerBoosterBooster;
   import com.goodgamestudios.mafia.event.model.MafiaBoosterEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getTimer;
   
   public class MafiaBoosterData
   {
       
      
      public var boosterID:int;
      
      public var boosterPower:int;
      
      public var boosterEndTime:Number;
      
      public function MafiaBoosterData()
      {
         super();
      }
      
      public function parseData(param1:Array) : MafiaBoosterData
      {
         var _loc3_:PBMissionBoosterGetPlayerBoosterBooster = null;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = PBMissionBoosterGetPlayerBoosterBooster(param1[_loc2_]);
            this.boosterID = _loc3_.boosterID;
            this.boosterPower = _loc3_.boostPower;
            this.boosterEndTime = getTimer() + _loc3_.remainingDurationInSeconds * Constants_Basic.SEC2MILLISEC;
            _loc2_++;
         }
         return this;
      }
      
      public function checkBoosterTime(param1:Number) : void
      {
         var _loc2_:Array = new Array();
         if(this.boosterID > 0)
         {
            if(param1 > this.boosterEndTime)
            {
               this.boosterID = 0;
               this.boosterPower = 0;
               this.boosterEndTime = 0;
               BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_BOOSTER_DATA));
            }
            _loc2_.push(TimeStringHelper.getTimeToString((this.boosterEndTime - param1) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById));
            BasicController.getInstance().dispatchEvent(new MafiaBoosterEvent(MafiaBoosterEvent.CHANGE_BOOSTER_TIMER,_loc2_));
         }
      }
   }
}
