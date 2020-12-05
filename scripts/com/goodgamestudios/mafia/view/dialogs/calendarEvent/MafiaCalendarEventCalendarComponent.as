package com.goodgamestudios.mafia.view.dialogs.calendarEvent
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.ColorUtils;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.specialevent.calendar.UnlockNextDayCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaCalendarEvent;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCalendarEventDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaCalendarEventUnlockEnemyDialogProperties;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaSelfUpdatingTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaSelfUpdatingTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class MafiaCalendarEventCalendarComponent extends MafiaCalendarEventDialogComponent
   {
       
      
      private const COLOR_UNLOCKED:int = 16777215;
      
      private const COLOR_LOCKED:int = 4341564;
      
      private const COLOR_DEFEATED:int = 8749438;
      
      private var nextUnlockableField:Btn_CalendarButton;
      
      public function MafiaCalendarEventCalendarComponent(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,param2);
         sendToBackground();
         this.calendar.txt_calendar.text = MafiaModel.languageData.getTextById("event_eddyfrost_copy_3");
      }
      
      public function fill(param1:MafiaCalendarEvent) : void
      {
         var _loc2_:Btn_CalendarButton = null;
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         this.nextUnlockableField = null;
         this.calendar.field_25.thumb.gotoAndStop(25);
         this.calendar.field_25.mouseChildren = false;
         var _loc6_:Point = this.calendar.field_25.localToGlobal(new Point());
         _loc6_.x = (_loc6_.x - layoutManager.gameNullPoint) / layoutManager.scaleFactor;
         _loc6_.y = _loc6_.y / layoutManager.scaleFactor - 150;
         if(param1.isBossDead)
         {
            _loc7_ = MafiaModel.languageData.getTextById("event_eddyfrost_copy_8");
            _loc8_ = BasicCustomCursor.CURSOR_ARROW;
         }
         else if(param1.areAllUnlocked)
         {
            _loc7_ = MafiaModel.languageData.getTextById("event_eddyfrost_copy_7");
            _loc8_ = BasicCustomCursor.CURSOR_CLICK;
         }
         else
         {
            _loc7_ = MafiaModel.languageData.getTextById("event_jahbandulu_copy_6",[param1.bossName]);
            _loc8_ = BasicCustomCursor.CURSOR_ARROW;
         }
         this.calendar.field_25.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc7_),_loc6_,"",_loc8_);
         this.calendar.field_25.bloodCross.visible = param1.isBossDead;
         var _loc9_:int = 0;
         while(_loc9_ < MafiaCalendarEvent.NUMBER_OF_ENEMIES - 1)
         {
            _loc3_ = "field_" + (_loc9_ + 1);
            _loc2_ = this.calendar[_loc3_] as Btn_CalendarButton;
            _loc2_.thumb.gotoAndStop(_loc9_ + 1);
            if(param1.enemiesDefeated[_loc9_])
            {
               _loc2_.gotoAndStop(4);
               ColorUtils.setColor(_loc2_.num,this.COLOR_DEFEATED);
               _loc4_ = false;
               _loc5_ = MafiaModel.languageData.getTextById("event_eddyfrost_copy_8");
            }
            else if(_loc9_ > param1.nextToUnlock)
            {
               _loc2_.gotoAndStop(1);
               ColorUtils.setColor(_loc2_.num,this.COLOR_LOCKED);
               _loc4_ = false;
               _loc5_ = "<timeUntilUnlock>";
            }
            else if(_loc9_ == param1.nextToUnlock)
            {
               _loc2_.gotoAndStop(2);
               ColorUtils.setColor(_loc2_.num,this.COLOR_UNLOCKED);
               _loc4_ = true;
               _loc5_ = "<nextTimeUntilUnlock>";
            }
            else
            {
               _loc2_.gotoAndStop(3);
               ColorUtils.setColor(_loc2_.num,this.COLOR_UNLOCKED);
               _loc4_ = true;
               _loc5_ = MafiaModel.languageData.getTextById("event_eddyfrost_copy_7");
            }
            _loc2_.mouseChildren = false;
            _loc2_.num.gotoAndStop(_loc9_ + 1);
            this.fillToolTip(_loc2_,_loc5_,_loc4_);
            _loc9_++;
         }
      }
      
      override public function onClickOnComponent(param1:MouseEvent) : void
      {
         this.onClick(param1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is Btn_CalendarButton)
         {
            this.onClickOnCalendarField(param1.target as Btn_CalendarButton);
         }
         if(param1.target is Btn_CalendarButtonJah && MafiaModel.specialEvent.calendarEvent.areAllUnlocked && !MafiaModel.specialEvent.calendarEvent.isBossDead)
         {
            this.gotoWanted();
         }
         super.onClick(param1);
      }
      
      private function onClickOnCalendarField(param1:Btn_CalendarButton) : void
      {
         var _loc2_:MafiaCalendarEvent = MafiaModel.specialEvent.calendarEvent;
         var _loc3_:int = param1.num.currentFrame;
         if(_loc2_.canEnemyBeFought(_loc3_ - 1))
         {
            this.gotoWanted();
         }
         else if(_loc2_.canEnemyBeUnlocked(_loc3_ - 1))
         {
            layoutManager.showDialog(MafiaCalendarEventUnlockEnemyDialog.NAME,new MafiaCalendarEventUnlockEnemyDialogProperties(this.onUnlock));
         }
      }
      
      private function gotoWanted() : void
      {
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         MafiaDialogHandler.getInstance().onHideCurrentDialog();
         layoutManager.hideDialog(MafiaCalendarEventDialog);
         layoutManager.state = Constants_LayoutStates.STATE_DUEL;
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_DUEL,[1]);
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
      }
      
      private function onUnlock() : void
      {
         UnlockNextDayCommand.sendCommand();
      }
      
      public function fillUnlockableField(param1:String) : void
      {
         if(this.nextUnlockableField)
         {
            this.fillToolTip(this.nextUnlockableField,MafiaModel.languageData.getTextById("event_eddyfrost_copy_10") + " " + param1,false);
         }
      }
      
      private function fillToolTip(param1:Btn_CalendarButton, param2:String, param3:Boolean) : void
      {
         var _loc4_:Point = param1.localToGlobal(new Point());
         _loc4_.x = (_loc4_.x - layoutManager.gameNullPoint) / layoutManager.scaleFactor;
         _loc4_.y = _loc4_.y / layoutManager.scaleFactor - 70;
         if(_loc4_.x > 700)
         {
            _loc4_.x = _loc4_.x - 30;
         }
         else if(_loc4_.x < 80)
         {
            _loc4_.x = _loc4_.x + 30;
         }
         if(param2 == "<timeUntilUnlock>" || param2 == "<nextTimeUntilUnlock>")
         {
            param1.toolTipVO = new TooltipVO(MafiaSelfUpdatingTooltip.NAME,new MafiaSelfUpdatingTooltipProperties(this.onUpdateTimedTooltipText,[param1.num.currentFrame - 1,param2 == "<nextTimeUntilUnlock>"],1000),_loc4_,"",!!param3?int(BasicCustomCursor.CURSOR_CLICK):int(BasicCustomCursor.CURSOR_ARROW));
         }
         else
         {
            param1.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(param2),_loc4_,"",!!param3?int(BasicCustomCursor.CURSOR_CLICK):int(BasicCustomCursor.CURSOR_ARROW));
         }
      }
      
      private function onUpdateTimedTooltipText(param1:Array) : String
      {
         var _loc2_:int = param1[0];
         var _loc3_:Boolean = param1[1];
         var _loc4_:int = MafiaModel.specialEvent.calendarEvent.timeUntilUnlockOfEnemy(_loc2_);
         var _loc5_:String = "";
         if(_loc3_)
         {
            _loc5_ = _loc5_ + (MafiaModel.languageData.getTextById("event_eddyfrost_copy_9") + "\n\n");
         }
         _loc5_ = _loc5_ + (MafiaModel.languageData.getTextById("event_eddyfrost_copy_10") + " " + TimeStringHelper.getTimeToString((_loc4_ - getTimer()) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById));
         return _loc5_;
      }
      
      protected function get calendar() : EventDialog_7_ComponentCalendar
      {
         return disp as EventDialog_7_ComponentCalendar;
      }
   }
}
