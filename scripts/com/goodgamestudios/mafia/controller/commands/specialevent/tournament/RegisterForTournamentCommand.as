package com.goodgamestudios.mafia.controller.commands.specialevent.tournament
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.registerfortournament.PBSpecialeventTournamentRegisterForTournamentRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.registerfortournament.PBSpecialeventTournamentRegisterForTournamentResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.registerfortournament.response.PBSpecialeventTournamentRegisterForTournamentResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class RegisterForTournamentCommand extends BasicProtobufCommand
   {
       
      
      public function RegisterForTournamentCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventTournamentRegisterForTournamentRequest = new PBSpecialeventTournamentRegisterForTournamentRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventTournamentRegisterForTournamentResponse = param1 as PBSpecialeventTournamentRegisterForTournamentResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventTournamentRegisterForTournamentResult.OK:
               MafiaModel.specialEvent.tournamentEvent.playerRequestedTournamentInfo = true;
               ShowTournamentInfoCommand.sendCommand();
               return true;
            case PBSpecialeventTournamentRegisterForTournamentResult.ALLREADY_REGISTERED:
               break;
            case PBSpecialeventTournamentRegisterForTournamentResult.NOT_POSSIBLE_ANYMORE:
               break;
            default:
               trace("ViewTournamentFightCommand error " + _loc2_.result);
               return false;
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventTournamentRegisterForTournamentRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventTournamentRegisterForTournamentResponse;
      }
   }
}
