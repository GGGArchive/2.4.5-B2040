package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   
   public class MafiaSicilianMissionAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaSicilianMissionAdvancedTooltip";
       
      
      public function MafiaSicilianMissionAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.advancedTooltip.txt_time.text = "";
         controller.addEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
         this.updateTime();
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
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_title.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_event");
         TextFieldHelper.changeTextFromatSizeByTextWidth(20,this.advancedTooltip.txt_name,MafiaModel.languageData.getTextById("event_sicilianbeast_title"));
         this.advancedTooltip.txt_progress.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_11",[MafiaModel.specialEvent.sicilianEvent.solvedMissions,MafiaModel.specialEvent.sicilianEvent.totalMissions]);
         this.advancedTooltip.progressBar.scaleX = MafiaModel.specialEvent.sicilianEvent.totalMissions * MafiaModel.specialEvent.sicilianEvent.solvedMissions / 100;
      }
      
      private function onSicilianTimer(param1:MafiaSpecialEventsEvent) : void
      {
         this.updateTime();
      }
      
      private function updateTime() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(MafiaModel.specialEvent.sicilianEvent.missionCooldown > 0)
         {
            _loc2_ = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_9") + "\n" + MafiaModel.specialEvent.sicilianEvent.missionCooldownTimeString;
            _loc1_ = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_6");
         }
         else
         {
            _loc2_ = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_4") + "\n" + MafiaModel.specialEvent.sicilianEvent.runTimeString;
            _loc1_ = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_7");
         }
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.advancedTooltip.txt_copy,_loc1_,5);
         TextFieldHelper.changeTextFromatSizeByTextWidth(18,this.advancedTooltip.txt_time,_loc2_,2);
      }
      
      protected function get advancedTooltip() : MafiaSicilianMissionTooltip
      {
         return disp as MafiaSicilianMissionTooltip;
      }
   }
}
