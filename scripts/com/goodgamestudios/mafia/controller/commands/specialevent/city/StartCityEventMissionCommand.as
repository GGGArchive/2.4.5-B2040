package com.goodgamestudios.mafia.controller.commands.specialevent.city
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventmission.PBSpecialeventCityStartCityEventMissionRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventmission.PBSpecialeventCityStartCityEventMissionResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventmission.response.PBSpecialeventCityStartCityEventMissionResult;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class StartCityEventMissionCommand extends BasicProtobufCommand
   {
       
      
      public function StartCityEventMissionCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventCityStartCityEventMissionRequest = new PBSpecialeventCityStartCityEventMissionRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventCityStartCityEventMissionResponse = param1 as PBSpecialeventCityStartCityEventMissionResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventCityStartCityEventMissionResult.OK:
               MafiaModel.userData.status = _loc2_.playerStatus;
               MafiaModel.userData.progressData.parseData(_loc2_.progressTime,_loc2_.remainingTime,_loc2_.missionGiver,_loc2_.missionId);
               controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_PING_DATA));
               return true;
            case PBSpecialeventCityStartCityEventMissionResult.PLAYER_BUSY:
               trace("player is busy");
               break;
            case PBSpecialeventCityStartCityEventMissionResult.NOT_ENOUGH_ENERGY:
               trace("not enough energy");
               break;
            case PBSpecialeventCityStartCityEventMissionResult.NOT_ENOUGH_GOLD:
               break;
            case PBSpecialeventCityStartCityEventMissionResult.INVALID_EVENT_STATE:
         }
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventCityStartCityEventMissionRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventCityStartCityEventMissionResponse;
      }
   }
}
