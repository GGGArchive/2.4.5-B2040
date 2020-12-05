package com.goodgamestudios.mafia.controller.commands.mission
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.mission.view.PBMissionViewRequest;
   import com.goodgamestudios.mafia.controller.protobuf.mission.view.PBMissionViewResponse;
   import com.goodgamestudios.mafia.controller.protobuf.mission.view.response.PBMissionViewResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ViewMissionCommand extends BasicProtobufCommand
   {
       
      
      public function ViewMissionCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBMissionViewRequest = new PBMissionViewRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMissionViewResponse = param1 as PBMissionViewResponse;
         switch(_loc2_.result)
         {
            case PBMissionViewResult.OK:
               MafiaModel.userData.missionData.parseMissionData(_loc2_);
               return true;
            case PBMissionViewResult.NOT_ENOUGH_ENERGY:
            case PBMissionViewResult.PLAYER_BUSY:
            case PBMissionViewResult.MISSION_NOT_AVAILABLE:
               return false;
            default:
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBMissionViewRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMissionViewResponse;
      }
   }
}
