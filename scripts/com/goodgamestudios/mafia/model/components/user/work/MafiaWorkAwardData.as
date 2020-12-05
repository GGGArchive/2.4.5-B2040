package com.goodgamestudios.mafia.model.components.user.work
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.controller.protobuf.work.stopworking.PBWorkStopWorkingResponse;
   import com.goodgamestudios.mafia.event.model.MafiaWorkEvent;
   
   public class MafiaWorkAwardData
   {
       
      
      public var cashForWork:int;
      
      public var cashBonusForFamily:int;
      
      public var cashBonusForAchievement:int;
      
      public var workDuration:int;
      
      public var workAP:int;
      
      public function MafiaWorkAwardData()
      {
         super();
      }
      
      public function parseData(param1:PBWorkStopWorkingResponse) : void
      {
         this.cashForWork = param1.cashForWork;
         this.cashBonusForFamily = param1.cashBonusForFamily;
         this.cashBonusForAchievement = param1.cashBonusForAchievement;
         this.workDuration = param1.workDuration;
         this.workAP = Math.floor(this.workDuration / 60 / 60);
         BasicController.getInstance().dispatchEvent(new MafiaWorkEvent(MafiaWorkEvent.CHANGE_WORK_AWARD_DATA,[this]));
      }
   }
}
