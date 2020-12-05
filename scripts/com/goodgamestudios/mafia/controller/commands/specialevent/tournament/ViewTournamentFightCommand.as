package com.goodgamestudios.mafia.controller.commands.specialevent.tournament
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaFightController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.viewtournamentfight.PBSpecialeventTournamentViewTournamentFightRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.viewtournamentfight.PBSpecialeventTournamentViewTournamentFightResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.viewtournamentfight.response.PBSpecialeventTournamentViewTournamentFightResult;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.netease.protobuf.Message;
   
   public class ViewTournamentFightCommand extends BasicProtobufCommand
   {
       
      
      public function ViewTournamentFightCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:int) : void
      {
         var _loc3_:PBSpecialeventTournamentViewTournamentFightRequest = new PBSpecialeventTournamentViewTournamentFightRequest();
         _loc3_.firstPlayerId = param1;
         _loc3_.secondPlayerId = param2;
         ProtobufController.getInstance().sendRequest(_loc3_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventTournamentViewTournamentFightResponse = param1 as PBSpecialeventTournamentViewTournamentFightResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventTournamentViewTournamentFightResult.OK:
               MafiaModel.specialEvent.tournamentEvent.parseFight(_loc2_.fight,_loc2_.reward);
               BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.TOURNAMENT_VIEW_FIGHT,[]));
               MafiaFightController.getInstance().startFight(MafiaModel.specialEvent.tournamentEvent.fightResultData,FightType.Tournament);
               return true;
            case PBSpecialeventTournamentViewTournamentFightResult.FIGHT_NOT_FOUND:
               break;
            case PBSpecialeventTournamentViewTournamentFightResult.BYE:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("event_lastmanstanding_copy_29"),MafiaModel.languageData.getTextById("event_lastmanstanding_copy_30")));
               break;
            default:
               trace("ViewTournamentFightCommand error " + _loc2_.result);
               return false;
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventTournamentViewTournamentFightRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventTournamentViewTournamentFightResponse;
      }
   }
}
