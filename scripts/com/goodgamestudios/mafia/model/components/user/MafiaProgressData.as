package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_Status;
   import com.goodgamestudios.mafia.constants.Constants_Work;
   import com.goodgamestudios.mafia.event.model.MafiaMissionEvent;
   import com.goodgamestudios.mafia.event.model.MafiaTravelEvent;
   import com.goodgamestudios.mafia.event.model.MafiaWorkEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getTimer;
   
   public class MafiaProgressData
   {
       
      
      public var progress:int;
      
      public var duration:Number;
      
      public var endTime:Number;
      
      private var _actionID:int;
      
      private var _missionGiverID:int;
      
      public function MafiaProgressData()
      {
         super();
      }
      
      public function parseData(param1:int, param2:int, param3:int, param4:int) : MafiaProgressData
      {
         this.progress = param1 * Constants_Basic.SEC2MILLISEC;
         this.duration = this.progress + param2 * Constants_Basic.SEC2MILLISEC;
         this.endTime = getTimer() + param2 * Constants_Basic.SEC2MILLISEC;
         this._missionGiverID = param3;
         this._actionID = param4;
         return this;
      }
      
      public function checkProgress(param1:Number, param2:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:Array = new Array();
         switch(param2)
         {
            case Constants_Status.STATUS_ON_A_MISSION:
               _loc4_ = this.endTime - param1;
               _loc3_.push(TimeStringHelper.getShortTimeString(_loc4_));
               _loc3_.push(100 - _loc4_ / this.duration * 100);
               BasicController.getInstance().dispatchEvent(new MafiaMissionEvent(MafiaMissionEvent.CHANGE_MISSION_TIMER,_loc3_));
               if(_loc4_ < 0)
               {
                  MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_PING,[]);
               }
               break;
            case Constants_Status.STATUS_WORKING:
               _loc5_ = MafiaModel.userData.workData.workDuration + (param1 - MafiaModel.userData.workData.getWorkDataTime);
               if(_loc5_ < 0)
               {
                  _loc5_ = _loc5_ * -1;
               }
               _loc3_.push(TimeStringHelper.getShortTimeString(_loc5_));
               _loc6_ = MafiaModel.userData.workData.workC1PerHour / 60 / 60;
               _loc3_.push(Math.floor(_loc6_ * (_loc5_ * Constants_Basic.MILLISEC2SEC - 1)));
               if(_loc3_[1] < 0)
               {
                  _loc3_[1] = 0;
               }
               _loc3_.push(Math.floor(_loc5_ * Constants_Basic.MILLISEC2SEC / 60 / 60));
               BasicController.getInstance().dispatchEvent(new MafiaWorkEvent(MafiaWorkEvent.CHANGE_WORK_TIMER,_loc3_));
               if(_loc5_ * Constants_Basic.MILLISEC2SEC > Constants_Work.MAX_WORKTIME_IN_SECONDS)
               {
                  MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_PING,[]);
               }
               break;
            case Constants_Status.STATUS_FLYING:
               _loc4_ = this.endTime - param1;
               _loc3_.push(TimeStringHelper.getShortTimeString(_loc4_));
               _loc3_.push(100 - _loc4_ / this.duration * 100);
               BasicController.getInstance().dispatchEvent(new MafiaTravelEvent(MafiaTravelEvent.CHANGE_FLIGHTTIMER,_loc3_));
               if(_loc4_ <= 0)
               {
                  MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_PING,[]);
               }
               break;
            default:
               return;
         }
      }
      
      public function get missionGiverID() : int
      {
         return this._missionGiverID;
      }
      
      public function get actionID() : int
      {
         return this._actionID;
      }
   }
}
