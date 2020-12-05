package com.goodgamestudios.mafia.controller.commands.avatar
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.mission.booster.getplayerbooster.PBMissionBoosterGetPlayerBoosterRequest;
   import com.goodgamestudios.mafia.controller.protobuf.mission.booster.getplayerbooster.PBMissionBoosterGetPlayerBoosterResponse;
   import com.goodgamestudios.mafia.controller.protobuf.mission.booster.getplayerbooster.response.PBMissionBoosterGetPlayerBoosterResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class GetPlayerBoosterCommand extends BasicProtobufCommand
   {
       
      
      public function GetPlayerBoosterCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBMissionBoosterGetPlayerBoosterRequest = new PBMissionBoosterGetPlayerBoosterRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMissionBoosterGetPlayerBoosterResponse = param1 as PBMissionBoosterGetPlayerBoosterResponse;
         switch(_loc2_.result)
         {
            case PBMissionBoosterGetPlayerBoosterResult.OK:
               if(_loc2_.playerID == MafiaModel.userData.playerID)
               {
                  MafiaModel.userData.parseBoosterData(_loc2_.boosters);
                  return true;
               }
               if(_loc2_.playerID != MafiaModel.userData.playerID)
               {
                  MafiaModel.otherUserData.parseBoosterData(_loc2_.boosters);
                  return true;
               }
               break;
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMissionBoosterGetPlayerBoosterRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMissionBoosterGetPlayerBoosterResponse;
      }
   }
}
