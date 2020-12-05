package com.goodgamestudios.mafia.controller.commands.specialevent.tournament
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.PBSpecialeventTournamentShowTournamentFinalsRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.PBSpecialeventTournamentShowTournamentFinalsResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.response.PBSpecialeventTournamentShowTournamentFinalsResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ShowTournamentFinalsCommand extends BasicProtobufCommand
   {
       
      
      public function ShowTournamentFinalsCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventTournamentShowTournamentFinalsRequest = new PBSpecialeventTournamentShowTournamentFinalsRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventTournamentShowTournamentFinalsResponse = param1 as PBSpecialeventTournamentShowTournamentFinalsResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventTournamentShowTournamentFinalsResult.OK:
               MafiaModel.specialEvent.tournamentEvent.parseTournamentFinalsOverview(_loc2_.duels);
               return true;
            case PBSpecialeventTournamentShowTournamentFinalsResult.NO_ACTIVE_TOURNAMENT:
               break;
            case PBSpecialeventTournamentShowTournamentFinalsResult.CORRUPT_INFO:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventTournamentShowTournamentFinalsRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventTournamentShowTournamentFinalsResponse;
      }
   }
}
