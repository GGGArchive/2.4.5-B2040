package com.goodgamestudios.mafia.view.dialogs.tournament
{
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.FighterState;
   import com.goodgamestudios.mafia.controller.commands.specialevent.tournament.ViewTournamentFightCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.MafiaDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaTournamentRoundReportDialogProperties;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MafiaTournamentRoundReportDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaTournamentRoundReportDialog";
       
      
      public function MafiaTournamentRoundReportDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      override public function show() : void
      {
         super.show();
         this.initTextFields();
         basicController.addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_VIEW_FIGHT,this.onViewFight);
      }
      
      protected function onViewFight(param1:Event) : void
      {
         layoutManager.state = Constants_LayoutStates.STATE_TOURNAMENT_FIGHT;
         hide();
         MafiaDialogHandler.getInstance().blockDialogs = true;
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         basicController.removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_VIEW_FIGHT,this.onViewFight);
      }
      
      private function initTextFields() : void
      {
         this.dialog.txt_ap.text = String(this.dialogProperties.roundReportVO.ap);
         this.dialog.txt_xp.text = String(this.dialogProperties.roundReportVO.xp);
         this.dialog.txt_cash.text = String(this.dialogProperties.roundReportVO.cash);
         this.dialog.txt_fame.text = String(this.dialogProperties.roundReportVO.glory);
         this.dialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_okay");
         switch(this.dialogProperties.roundReportVO.fightResult)
         {
            case FighterState.Lost:
               this.dialog.txt_headline.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_66");
               this.dialog.txt_info.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_56",[this.dialogProperties.roundReportVO.opponentName]);
               this.dialog.btn_viewFight.visible = true;
               break;
            case FighterState.Won:
               this.dialog.txt_headline.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_64");
               this.dialog.txt_info.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_54",[this.dialogProperties.roundReportVO.opponentName]);
               this.dialog.btn_viewFight.visible = true;
               break;
            case FighterState.Freecard:
               this.dialog.txt_headline.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_65");
               this.dialog.txt_info.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_55");
               this.dialog.btn_viewFight.visible = false;
         }
         this.dialog.txt_top.text = MafiaModel.specialEvent.tournamentEvent.getRoundname(this.dialogProperties.roundReportVO.nextRound);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.dialog.btn_viewFight:
               ViewTournamentFightCommand.sendCommand(MafiaModel.userData.playerID,this.dialogProperties.roundReportVO.opponentID);
               break;
            case this.dialog.btn_ok:
               hide();
         }
         super.onClick(param1);
      }
      
      protected function get dialogProperties() : MafiaTournamentRoundReportDialogProperties
      {
         return properties as MafiaTournamentRoundReportDialogProperties;
      }
      
      protected function get dialog() : MafiaTournamentRoundReport
      {
         return disp as MafiaTournamentRoundReport;
      }
   }
}
