package com.goodgamestudios.mafia.controller.commands.mission
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.mission.start.PBMissionStartRequest;
   import com.goodgamestudios.mafia.controller.protobuf.mission.start.PBMissionStartResponse;
   import com.goodgamestudios.mafia.controller.protobuf.mission.start.response.PBMissionStartResult;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class StartMissionCommand extends BasicProtobufCommand
   {
       
      
      public function StartMissionCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBMissionStartRequest = new PBMissionStartRequest();
         _loc2_.missionNumber = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMissionStartResponse = param1 as PBMissionStartResponse;
         switch(_loc2_.result)
         {
            case PBMissionStartResult.OK:
               MafiaModel.userData.status = _loc2_.playerStatus;
               MafiaModel.userData.progressData.parseData(_loc2_.progressTime,_loc2_.remainingTime,_loc2_.missionGiver,_loc2_.missionId);
               controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_PING_DATA));
               return true;
            case PBMissionStartResult.PLAYER_BUSY:
               trace("player is busy");
               break;
            case PBMissionStartResult.NOT_ENOUGH_ENERGY:
               trace("not enough energy");
               break;
            case PBMissionStartResult.MISSION_NOT_AVAILABLE:
               trace("mission not available");
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMissionStartRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMissionStartResponse;
      }
   }
}
