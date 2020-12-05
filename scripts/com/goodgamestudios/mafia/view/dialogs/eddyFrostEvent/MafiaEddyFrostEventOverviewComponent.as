package com.goodgamestudios.mafia.view.dialogs.eddyFrostEvent
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaEddyFrostEvent;
   import com.goodgamestudios.mafia.view.dialogs.calendarEvent.MafiaCalendarEventDialogComponent;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class MafiaEddyFrostEventOverviewComponent extends MafiaCalendarEventDialogComponent
   {
       
      
      public function MafiaEddyFrostEventOverviewComponent(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,param2);
         this.overview.deselectionLayer.gotoAndStop(1);
         sendToForeground();
         this.overview.txt_overview.text = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_1");
      }
      
      public function fill(param1:MafiaEddyFrostEvent) : void
      {
         var _loc3_:MovieClip = null;
         if(!param1.isBossDead)
         {
            if(!MafiaModel.userData.profileData.isWantedUnlocked)
            {
               this.overview.txt_copy.text = MafiaModel.languageData.getTextById("event_eddyfrost_copy_16",[param1.bossName]);
            }
            else
            {
               this.overview.txt_copy.text = MafiaModel.languageData.getTextById("event_eddyfrost_copy_2",[param1.bossName,param1.bossName,param1.bossName]);
            }
         }
         else
         {
            this.overview.txt_copy.text = MafiaModel.languageData.getTextById("event_eddyfrost_copy_14",[param1.bossName]);
         }
         this.overview.btn_info.visible = !param1.isBossDead;
         var _loc2_:Point = this.overview.btn_info.localToGlobal(new Point());
         _loc2_.x = (_loc2_.x - layoutManager.gameNullPoint) / layoutManager.scaleFactor - 80;
         _loc2_.y = _loc2_.y / layoutManager.scaleFactor - 50;
         this.overview.btn_info.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("event_jahbandulu_copy_4")),_loc2_,"",BasicCustomCursor.CURSOR_ARROW);
         this.overview.txt_reward.text = MafiaModel.languageData.getTextById("event_capovito_reward");
         if(!param1.areAllUnlocked)
         {
            this.overview.txt_time.text = MafiaModel.languageData.getTextById("event_eddyfrost_copy_4");
         }
         else
         {
            this.overview.txt_time.text = MafiaModel.languageData.getTextById("event_jahbandulu_copy_5",[param1.bossName]);
         }
         MovieClipHelper.clearMovieClip(this.overview.itemHolder);
         this.overview.itemHolder.toolTipVO = null;
         if(param1.item)
         {
            _loc3_ = MafiaItemData.getInstance().generateItemIcon(param1.item);
            this.overview.itemHolder.addChild(_loc3_);
            if(!param1.isBossDead)
            {
               this.overview.itemHolder.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(_loc3_.properties,TooltipDispPosition.None);
            }
         }
      }
      
      public function onTimeUpdate(param1:String) : void
      {
         if(MafiaModel.specialEvent.eddyFrostEvent.isBossDead)
         {
            this.overview.txt_time.text = "";
         }
         else if(MafiaModel.specialEvent.eddyFrostEvent.areAllUnlocked)
         {
            this.overview.txt_time.text = MafiaModel.languageData.getTextById("event_jahbandulu_copy_5",[MafiaModel.specialEvent.eddyFrostEvent.bossName]) + "\n" + param1;
         }
         else
         {
            this.overview.txt_time.text = MafiaModel.languageData.getTextById("event_eddyfrost_copy_4") + "\n" + param1;
         }
      }
      
      protected function get overview() : EventDialog_7_ComponentOverview
      {
         return disp as EventDialog_7_ComponentOverview;
      }
   }
}
