package com.goodgamestudios.mafia.controller.commands.specialevent.tournament
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.tournamentroundreport.PBSpecialeventTournamentTournamentroundreportRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.tournamentroundreport.PBSpecialeventTournamentTournamentroundreportResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.tournamentroundreport.response.PBSpecialeventTournamentTournamentroundreportResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class TournamentRoundReportsCommand extends BasicProtobufCommand
   {
       
      
      public function TournamentRoundReportsCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventTournamentTournamentroundreportRequest = new PBSpecialeventTournamentTournamentroundreportRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventTournamentTournamentroundreportResponse = param1 as PBSpecialeventTournamentTournamentroundreportResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventTournamentTournamentroundreportResult.OK:
               MafiaModel.specialEvent.tournamentEvent.parseRoundReport(_loc2_.opponents);
               return true;
            case PBSpecialeventTournamentTournamentroundreportResult.CORRUPT_INFO:
               break;
            case PBSpecialeventTournamentTournamentroundreportResult.NO_ACTIVE_TOURNAMENT:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventTournamentTournamentroundreportRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventTournamentTournamentroundreportResponse;
      }
   }
}
