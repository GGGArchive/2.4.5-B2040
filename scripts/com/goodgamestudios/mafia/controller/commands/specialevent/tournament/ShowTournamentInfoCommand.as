package com.goodgamestudios.mafia.controller.commands.specialevent.tournament
{
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.PBSpecialeventTournamentShowTournamentInfosRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.PBSpecialeventTournamentShowTournamentInfosResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.response.PBSpecialeventTournamentShowTournamentInfosResult;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ShowTournamentInfoCommand extends BasicProtobufCommand
   {
       
      
      public function ShowTournamentInfoCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventTournamentShowTournamentInfosRequest = new PBSpecialeventTournamentShowTournamentInfosRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventTournamentShowTournamentInfosResponse = param1 as PBSpecialeventTournamentShowTournamentInfosResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventTournamentShowTournamentInfosResult.OK:
               MafiaModel.specialEvent.tournamentEvent.parseTournamentInfo(_loc2_);
               if(MafiaModel.specialEvent.tournamentEvent.canPlayerViewTournamentScreen && MafiaModel.specialEvent.tournamentEvent.playerRequestedTournamentInfo)
               {
                  MafiaModel.specialEvent.tournamentEvent.playerRequestedTournamentInfo = false;
                  layoutManager.state = Constants_LayoutStates.STATE_TOURNAMENT;
               }
               controller.dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_EVENT_DATA_UPDATED,[]));
               return true;
            case PBSpecialeventTournamentShowTournamentInfosResult.NO_ACTIVE_TOURNAMENT:
               break;
            default:
               trace("ViewTournamentFightCommand error " + _loc2_.result);
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventTournamentShowTournamentInfosRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventTournamentShowTournamentInfosResponse;
      }
   }
}
