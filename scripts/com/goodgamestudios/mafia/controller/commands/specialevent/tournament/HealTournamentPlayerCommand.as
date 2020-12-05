package com.goodgamestudios.mafia.controller.commands.specialevent.tournament
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.healtournamentplayer.PBSpecialeventTournamentHealTournamentPlayerRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.healtournamentplayer.PBSpecialeventTournamentHealTournamentPlayerResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.healtournamentplayer.response.PBSpecialeventTournamentHealTournamentPlayerResult;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class HealTournamentPlayerCommand extends BasicProtobufCommand
   {
       
      
      public function HealTournamentPlayerCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventTournamentHealTournamentPlayerRequest = new PBSpecialeventTournamentHealTournamentPlayerRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventTournamentHealTournamentPlayerResponse = param1 as PBSpecialeventTournamentHealTournamentPlayerResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventTournamentHealTournamentPlayerResult.OK:
               controller.soundController.playSoundEffect(MafiaSoundController.SND_SOLD);
               MafiaModel.specialEvent.tournamentEvent.currentHealth = 100;
               controller.dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_EVENT_DATA_UPDATED,[]));
               break;
            case PBSpecialeventTournamentHealTournamentPlayerResult.ALLREADY_FULL_HP:
            case PBSpecialeventTournamentHealTournamentPlayerResult.NO_ACTIVE_TOURNAMENT:
            case PBSpecialeventTournamentHealTournamentPlayerResult.NO_NEXT_FIGHT:
            case PBSpecialeventTournamentHealTournamentPlayerResult.NOT_ENOUGH_CASH:
               break;
            default:
               trace("ViewTournamentFightCommand error " + _loc2_.result);
               return false;
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventTournamentHealTournamentPlayerRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventTournamentHealTournamentPlayerResponse;
      }
   }
}
