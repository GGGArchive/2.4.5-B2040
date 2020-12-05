package com.goodgamestudios.mafia.controller.commands.specialevent.city
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.showcityeventopponents.PBSpecialeventCityShowCityEventOpponentsRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.showcityeventopponents.PBSpecialeventCityShowCityEventOpponentsResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.showcityeventopponents.response.PBSpecialeventCityShowCityEventOpponentsResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ShowCityEventOpponentCommand extends BasicProtobufCommand
   {
       
      
      public function ShowCityEventOpponentCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventCityShowCityEventOpponentsRequest = new PBSpecialeventCityShowCityEventOpponentsRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventCityShowCityEventOpponentsResponse = param1 as PBSpecialeventCityShowCityEventOpponentsResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventCityShowCityEventOpponentsResult.OK:
               MafiaModel.specialEvent.sicilianEvent.parseGangwarData(_loc2_.opponents,_loc2_.gangwarProgress,_loc2_.nextFreeTime);
               return true;
            case PBSpecialeventCityShowCityEventOpponentsResult.INVALID_EVENT_STATE:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventCityShowCityEventOpponentsRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventCityShowCityEventOpponentsResponse;
      }
   }
}
