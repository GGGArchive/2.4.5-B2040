package com.goodgamestudios.mafia.model.components.user.work
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.controller.protobuf.work.goworking.PBWorkGoWorkingResponse;
   import com.goodgamestudios.mafia.controller.protobuf.work.viewwork.PBWorkViewWorkResponse;
   import com.goodgamestudios.mafia.event.model.MafiaWorkEvent;
   import flash.utils.getTimer;
   
   public class MafiaWorkData
   {
       
      
      public var getWorkDataTime:Number;
      
      public var workC1PerHour:Number;
      
      public var workDuration:Number;
      
      public var workAwardData:MafiaWorkAwardData;
      
      public function MafiaWorkData()
      {
         super();
         this.workAwardData = new MafiaWorkAwardData();
      }
      
      public function parseData(param1:PBWorkViewWorkResponse) : void
      {
         this.getWorkDataTime = getTimer();
         this.workC1PerHour = param1.moneyPerHour;
         this.workDuration = param1.currentWorkDuration * Constants_Basic.SEC2MILLISEC;
         BasicController.getInstance().dispatchEvent(new MafiaWorkEvent(MafiaWorkEvent.CHANGE_WORK_DATA));
      }
      
      public function parseStartWorkData(param1:PBWorkGoWorkingResponse) : void
      {
         this.getWorkDataTime = getTimer();
         this.workDuration = param1.currentWorkDuration * Constants_Basic.SEC2MILLISEC;
      }
   }
}
