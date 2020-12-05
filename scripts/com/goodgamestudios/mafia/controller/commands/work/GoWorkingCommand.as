package com.goodgamestudios.mafia.controller.commands.work
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.work.goworking.PBWorkGoWorkingRequest;
   import com.goodgamestudios.mafia.controller.protobuf.work.goworking.PBWorkGoWorkingResponse;
   import com.goodgamestudios.mafia.controller.protobuf.work.goworking.response.PBWorkGoWorkingResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class GoWorkingCommand extends BasicProtobufCommand
   {
       
      
      public function GoWorkingCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBWorkGoWorkingRequest = new PBWorkGoWorkingRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBWorkGoWorkingResponse = param1 as PBWorkGoWorkingResponse;
         switch(_loc2_.result)
         {
            case PBWorkGoWorkingResult.OK:
               MafiaModel.userData.workData.parseStartWorkData(_loc2_);
               return true;
            case PBWorkGoWorkingResult.ERROR:
               trace("go working failed");
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBWorkGoWorkingRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBWorkGoWorkingResponse;
      }
   }
}
