package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaCalendarEvent;
   import com.goodgamestudios.mafia.view.dialogs.calendarEvent.MafiaCalendarEventCalendarComponent;
   import com.goodgamestudios.mafia.view.dialogs.calendarEvent.MafiaCalendarEventOverviewComponent;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MafiaCalendarEventDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaCalendarEventDialog";
       
      
      protected var tabOverview:MafiaCalendarEventOverviewComponent;
      
      protected var tabCalendar:MafiaCalendarEventCalendarComponent;
      
      private var lastTabSelected:int = 0;
      
      public function MafiaCalendarEventDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.tabOverview = new MafiaCalendarEventOverviewComponent(this.dialog.overview);
         this.tabCalendar = new MafiaCalendarEventCalendarComponent(this.dialog.calendar);
         if(this.lastTabSelected == 0)
         {
            this.selectTabOverview();
         }
         else
         {
            this.selectTabCalendar();
         }
         this.dialog.btn_close.toolTipText = MafiaModel.languageData.getTextById("generic_btn_close");
         this.dialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_okay");
         TextFieldHelper.changeTextFromatSizeByTextWidth(15,this.dialog.header.txt_subtitle,MafiaModel.specialEvent.calendarEvent.eventSubtitle,2);
         controller.addEventListener(MafiaSpecialEventsEvent.CALENDAR_EVENT_DATA_UPDATED,this.onData);
         controller.addEventListener(MafiaSpecialEventsEvent.CALENDAR_TIME_UPDATE,this.onTimeUpdate);
         controller.addEventListener(MafiaSpecialEventsEvent.CALENDAR_NEXT_UNLOCK_TIME,this.onUnlockTimeUpdate);
         controller.addEventListener(MafiaSpecialEventsEvent.CALENDAR_EVENT_ENDED,this.onEventEnded);
         this.fill(MafiaModel.specialEvent.calendarEvent);
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaSpecialEventsEvent.CALENDAR_EVENT_DATA_UPDATED,this.onData);
         controller.removeEventListener(MafiaSpecialEventsEvent.CALENDAR_TIME_UPDATE,this.onTimeUpdate);
         controller.removeEventListener(MafiaSpecialEventsEvent.CALENDAR_NEXT_UNLOCK_TIME,this.onUnlockTimeUpdate);
         controller.removeEventListener(MafiaSpecialEventsEvent.CALENDAR_EVENT_ENDED,this.onEventEnded);
         super.removeEvents();
      }
      
      override public function updatePosition() : void
      {
         super.updatePosition();
         disp.y = disp.y - 30;
      }
      
      private function onData(param1:MafiaSpecialEventsEvent) : void
      {
         this.fill(param1.params[0]);
      }
      
      private function fill(param1:MafiaCalendarEvent) : void
      {
         this.tabOverview.fill(param1);
         this.tabCalendar.fill(param1);
         if(param1.isBossDead)
         {
            this.dialog.header.gotoAndStop(2);
            this.selectTabOverview();
         }
         else
         {
            this.dialog.header.gotoAndStop(1);
         }
      }
      
      private function onUnlockTimeUpdate(param1:MafiaSpecialEventsEvent) : void
      {
         this.tabCalendar.fillUnlockableField(param1.params[0]);
         if(!MafiaModel.specialEvent.calendarEvent.areAllUnlocked)
         {
            this.tabOverview.onTimeUpdate(param1.params[0]);
         }
      }
      
      private function onTimeUpdate(param1:MafiaSpecialEventsEvent) : void
      {
         if(MafiaModel.specialEvent.calendarEvent.areAllUnlocked)
         {
            this.tabOverview.onTimeUpdate(param1.params[0]);
         }
      }
      
      override protected function applyProperties() : void
      {
         super.applyProperties();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.dialog.overview:
               this.selectTabOverview();
               break;
            case this.dialog.calendar:
               this.selectTabCalendar();
               break;
            case this.dialog.btn_close:
            case this.dialog.btn_ok:
               hide();
         }
         super.onClick(param1);
         this.tabCalendar.onClickOnComponent(param1);
         this.tabOverview.onClickOnComponent(param1);
      }
      
      private function selectTabOverview() : void
      {
         this.tabOverview.sendToForeground();
         this.tabCalendar.sendToBackground();
         this.lastTabSelected = 0;
      }
      
      private function selectTabCalendar() : void
      {
         this.tabOverview.sendToBackground();
         this.tabCalendar.sendToForeground();
         this.lastTabSelected = 1;
      }
      
      protected function onEventEnded(param1:Event) : void
      {
         hide();
      }
      
      protected function get dialog() : EventDialog_7
      {
         return disp as EventDialog_7;
      }
   }
}
