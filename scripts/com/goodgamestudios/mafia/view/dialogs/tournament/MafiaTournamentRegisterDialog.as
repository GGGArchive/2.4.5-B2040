package com.goodgamestudios.mafia.view.dialogs.tournament
{
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaTournamentRegisterDialogProperties;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MafiaTournamentRegisterDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaTournamentRegisterDialog";
       
      
      public function MafiaTournamentRegisterDialog(param1:Sprite)
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
         if(MafiaModel.specialEvent.tournamentEvent.isTournamentApplicationOpen)
         {
            this.standardDialog.btn_yes.enableButton = true;
         }
         else
         {
            this.standardDialog.btn_yes.enableButton = false;
         }
         controller.addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_REGISTER_REMAINING_TIME,this.onTimeUpdate);
         controller.addEventListener(MafiaSpecialEventsEvent.TOURNAMENT_REGISTRATION_ENDED,this.onRegistrationEnded);
      }
      
      override protected function applyProperties() : void
      {
         this.standardDialog.txt_registeredplayers_value.text = String(MafiaModel.specialEvent.tournamentEvent.numRegisteredPlayers);
         this.standardDialog.mc_reward.gotoAndStop(MafiaModel.specialEvent.tournamentEvent.rewardIndex + 1);
         super.applyProperties();
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_REGISTER_REMAINING_TIME,this.onTimeUpdate);
         controller.removeEventListener(MafiaSpecialEventsEvent.TOURNAMENT_REGISTRATION_ENDED,this.onRegistrationEnded);
         super.removeEvents();
      }
      
      private function initTextFields() : void
      {
         this.standardDialog.btn_yes.label = MafiaModel.languageData.getTextById("event_lastmanstanding_btn_participateYes");
         this.standardDialog.btn_no.label = MafiaModel.languageData.getTextById("event_lastmanstanding_btn_participateNo");
         this.standardDialog.txt_event_lastmanstanding_copy_1.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_1");
         this.standardDialog.txt_event_lastmanstanding_copy_2.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_2");
         this.standardDialog.txt_event_lastmanstanding_copy_3.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_3");
         this.standardDialog.txt_event_lastmanstanding_copy_4.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_4");
         this.standardDialog.txt_event_lastmanstanding_copy_5.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_5");
         this.standardDialog.txt_event_lastmanstanding_copy_6.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_6");
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_no:
            case this.standardDialog.btn_close:
               hide();
               break;
            case this.standardDialog.btn_yes:
               if(this.standardDialog.btn_yes.enabled)
               {
                  hide();
                  if(this.standardDialogProperties.functionYes != null)
                  {
                     this.standardDialogProperties.functionYes();
                  }
               }
         }
      }
      
      private function onTimeUpdate(param1:MafiaSpecialEventsEvent) : void
      {
         this.standardDialog.txt_deadline_value.text = TimeStringHelper.getTimeToString(param1.params[0],TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
      }
      
      protected function onRegistrationEnded(param1:Event) : void
      {
         this.standardDialog.txt_deadline_value.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_63");
         this.standardDialog.btn_yes.enableButton = false;
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            super.updatePosition();
            disp.y = disp.stage.stageHeight / 2;
            disp.x = disp.stage.stageWidth / 2;
         }
      }
      
      protected function get standardDialogProperties() : MafiaTournamentRegisterDialogProperties
      {
         return properties as MafiaTournamentRegisterDialogProperties;
      }
      
      protected function get standardDialog() : MafiaTournamentRegister
      {
         return disp as MafiaTournamentRegister;
      }
   }
}
