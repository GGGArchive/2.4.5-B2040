package com.goodgamestudios.mafia.controller.commands.specialevent.tournament
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.searchtournamentplayer.PBSpecialeventTournamentSearchtournamentplayerRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.searchtournamentplayer.PBSpecialeventTournamentSearchtournamentplayerResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.searchtournamentplayer.response.PBSpecialeventTournamentSearchtournamentplayerResult;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class SearchTournamentPlayerCommand extends BasicProtobufCommand
   {
       
      
      public function SearchTournamentPlayerCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:String) : void
      {
         var _loc2_:PBSpecialeventTournamentSearchtournamentplayerRequest = new PBSpecialeventTournamentSearchtournamentplayerRequest();
         _loc2_.name = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventTournamentSearchtournamentplayerResponse = param1 as PBSpecialeventTournamentSearchtournamentplayerResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventTournamentSearchtournamentplayerResult.OK:
               MafiaModel.specialEvent.tournamentEvent.parseSearchTournamentPlayer(_loc2_);
               break;
            case PBSpecialeventTournamentSearchtournamentplayerResult.PLAYER_NOT_FOUND:
               controller.dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_PLAYER_NOTFOUND,[]));
               break;
            case PBSpecialeventTournamentSearchtournamentplayerResult.NO_ACTIVE_TOURNAMENT:
               break;
            default:
               trace("ViewTournamentFightCommand error " + _loc2_.result);
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventTournamentSearchtournamentplayerRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventTournamentSearchtournamentplayerResponse;
      }
   }
}
