package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   
   public class MafiaSicilianDungeonAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaSicilianDungeonAdvancedTooltip";
       
      
      public function MafiaSicilianDungeonAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
      }
      
      override public function hide() : void
      {
         super.hide();
         controller.removeEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
      }
      
      private function onSicilianTimer(param1:MafiaSpecialEventsEvent) : void
      {
         TextFieldHelper.changeTextFromatSizeByTextWidth(18,this.advancedTooltip.txt_time,MafiaModel.languageData.getTextById("event_sicilianbeast_copy_12") + "\n" + String(param1.params[0]),2);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_title.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_event");
         TextFieldHelper.changeTextFromatSizeByTextWidth(17,this.advancedTooltip.txt_name,MafiaModel.languageData.getTextById("event_sicilianbeast_title"));
         if(MafiaModel.specialEvent.sicilianEvent.gangwarEnemiesKilled == Constants_SpecialEvents.SICILIAN_DUNGEONENEMIES)
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.advancedTooltip.txt_copy,MafiaModel.languageData.getTextById("event_sicilianbeast_copy_18"),5);
         }
         else
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.advancedTooltip.txt_copy,MafiaModel.languageData.getTextById("event_sicilianbeast_copy_13"),5);
         }
         this.advancedTooltip.txt_progress.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_11",[MafiaModel.specialEvent.sicilianEvent.gangwarEnemiesKilled,Constants_SpecialEvents.SICILIAN_DUNGEONENEMIES]);
         this.advancedTooltip.progressBar.scaleX = MafiaModel.specialEvent.sicilianEvent.gangwarEnemiesKilled / Constants_SpecialEvents.SICILIAN_DUNGEONENEMIES;
      }
      
      protected function get advancedTooltip() : MafiaSicilianGangwarTooltip
      {
         return disp as MafiaSicilianGangwarTooltip;
      }
   }
}
