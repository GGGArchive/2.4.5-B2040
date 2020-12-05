package com.goodgamestudios.mafia.controller.commands.work
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.work.stopworking.PBWorkStopWorkingRequest;
   import com.goodgamestudios.mafia.controller.protobuf.work.stopworking.PBWorkStopWorkingResponse;
   import com.goodgamestudios.mafia.controller.protobuf.work.stopworking.response.PBWorkStopWorkingResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class StopWorkingCommand extends BasicProtobufCommand
   {
       
      
      public function StopWorkingCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBWorkStopWorkingRequest = new PBWorkStopWorkingRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBWorkStopWorkingResponse = param1 as PBWorkStopWorkingResponse;
         switch(_loc2_.result)
         {
            case PBWorkStopWorkingResult.OK:
               MafiaModel.userData.workData.workAwardData.parseData(_loc2_);
               return true;
            case PBWorkStopWorkingResult.ERROR:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBWorkStopWorkingRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBWorkStopWorkingResponse;
      }
   }
}
