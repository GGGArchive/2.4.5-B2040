package com.goodgamestudios.mafia.controller.commands.specialevent.tournament
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.remainingtournamentplayer.PBSpecialeventTournamentRemainingtournamentplayerRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.remainingtournamentplayer.PBSpecialeventTournamentRemainingtournamentplayerResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.remainingtournamentplayer.response.PBSpecialeventTournamentRemainingtournamentplayerResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ShowRemainingTournamentPlayersCommand extends BasicProtobufCommand
   {
       
      
      public function ShowRemainingTournamentPlayersCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBSpecialeventTournamentRemainingtournamentplayerRequest = new PBSpecialeventTournamentRemainingtournamentplayerRequest();
         _loc2_.scrollPosition = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventTournamentRemainingtournamentplayerResponse = param1 as PBSpecialeventTournamentRemainingtournamentplayerResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventTournamentRemainingtournamentplayerResult.OK:
               MafiaModel.specialEvent.tournamentEvent.parseRemainingPlayersData(_loc2_.players);
               return true;
            case PBSpecialeventTournamentRemainingtournamentplayerResult.APPLICATION_STILL_IN_PROGRESS:
               break;
            case PBSpecialeventTournamentRemainingtournamentplayerResult.NO_ACTIVE_TOURNAMENT:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventTournamentRemainingtournamentplayerRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventTournamentRemainingtournamentplayerResponse;
      }
   }
}
