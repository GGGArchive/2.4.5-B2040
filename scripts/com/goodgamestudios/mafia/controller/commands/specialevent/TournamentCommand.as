package com.goodgamestudios.mafia.controller.commands.specialevent
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.PBSpecialeventTournamentRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.PBSpecialeventTournamentResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class TournamentCommand extends BasicProtobufCommand
   {
       
      
      public function TournamentCommand()
      {
         super();
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventTournamentResponse = param1 as PBSpecialeventTournamentResponse;
         MafiaModel.specialEvent.tournamentEvent.parseEventDetails(_loc2_);
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventTournamentRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventTournamentResponse;
      }
   }
}
