package com.goodgamestudios.mafia.view.dialogs.breakingTheLaw
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaBreakingTheLawEvent;
   import com.goodgamestudios.mafia.view.screens.MafiaScreen;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class MafiaBreakingTheLawOverviewComponent extends MafiaScreen
   {
       
      
      public function MafiaBreakingTheLawOverviewComponent(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,param2);
         controller.addEventListener(MafiaSpecialEventsEvent.BREAKING_THE_LAW_TIME_UPDATE,this.onTimeUpdate);
      }
      
      public function registerEvents() : void
      {
         controller.addEventListener(MafiaSpecialEventsEvent.BREAKING_THE_LAW_TIME_UPDATE,this.onTimeUpdate);
      }
      
      public function fill(param1:MafiaBreakingTheLawEvent) : void
      {
         var _loc2_:int = BasicCustomCursor.CURSOR_CLICK;
         var _loc3_:Point = this.overview.btn_info.localToGlobal(new Point());
         _loc3_.x = (_loc3_.x - layoutManager.gameNullPoint) / layoutManager.scaleFactor;
         _loc3_.y = _loc3_.y / layoutManager.scaleFactor - 25;
         this.overview.btn_info.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("event_breakingthelaw_copy_6")),_loc3_,"",_loc2_);
         this.overview.txt_badges_owned_headline.text = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_4");
         this.overview.txt_badges_owned.text = MafiaModel.specialEvent.breakingTheLawEvent.policeBadges.toString();
         this.overview.txt_info.text = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_3");
         this.overview.txt_tabShop.text = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_2");
         this.overview.txt_tabOverview.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_1");
         this.setRemainingTime(MafiaModel.specialEvent.breakingTheLawEvent.runTimeString);
      }
      
      public function onTimeUpdate(param1:String) : void
      {
         this.setRemainingTime(MafiaModel.specialEvent.breakingTheLawEvent.runTimeString);
      }
      
      public function updateCurrency() : void
      {
         this.overview.txt_badges_owned.text = MafiaModel.specialEvent.breakingTheLawEvent.policeBadges.toString();
      }
      
      private function setRemainingTime(param1:String) : void
      {
         this.overview.txt_remaining_time.text = MafiaModel.languageData.getTextById("event_breakingthelaw_copy_7") + " " + MafiaModel.specialEvent.breakingTheLawEvent.runTimeString;
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         controller.removeEventListener(MafiaSpecialEventsEvent.BREAKING_THE_LAW_TIME_UPDATE,this.onTimeUpdate);
      }
      
      protected function get overview() : EventDialog_8_ComponentOverview
      {
         return disp as EventDialog_8_ComponentOverview;
      }
   }
}
