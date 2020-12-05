package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaEddyFrostEvent;
   import com.goodgamestudios.mafia.view.dialogs.eddyFrostEvent.MafiaEddyFrostEventComponent;
   import com.goodgamestudios.mafia.view.dialogs.eddyFrostEvent.MafiaEddyFrostEventOverviewComponent;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MafiaEddyFrostEventDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaEddyFrostEventDialog";
       
      
      protected var tabOverview:MafiaEddyFrostEventOverviewComponent;
      
      protected var tabCalendar:MafiaEddyFrostEventComponent;
      
      private var lastTabSelected:int = 0;
      
      public function MafiaEddyFrostEventDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.tabOverview = new MafiaEddyFrostEventOverviewComponent(this.dialog.overview);
         this.tabCalendar = new MafiaEddyFrostEventComponent(this.dialog.calendar);
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
         TextFieldHelper.changeTextFromatSizeByTextWidth(15,this.dialog.header.txt_subtitle,MafiaModel.specialEvent.eddyFrostEvent.eventSubtitle,2);
         controller.addEventListener(MafiaSpecialEventsEvent.EDDYFROST_EVENT_DATA_UPDATED,this.onData);
         controller.addEventListener(MafiaSpecialEventsEvent.EDDYFROST_TIME_UPDATE,this.onTimeUpdate);
         controller.addEventListener(MafiaSpecialEventsEvent.CALENDAR_NEXT_UNLOCK_TIME,this.onUnlockTimeUpdate);
         controller.addEventListener(MafiaSpecialEventsEvent.CALENDAR_EVENT_ENDED,this.onEventEnded);
         controller.addEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onEventEnded);
         this.fill(MafiaModel.specialEvent.eddyFrostEvent);
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaSpecialEventsEvent.EDDYFROST_EVENT_DATA_UPDATED,this.onData);
         controller.removeEventListener(MafiaSpecialEventsEvent.EDDYFROST_TIME_UPDATE,this.onTimeUpdate);
         controller.removeEventListener(MafiaSpecialEventsEvent.CALENDAR_NEXT_UNLOCK_TIME,this.onUnlockTimeUpdate);
         controller.removeEventListener(MafiaSpecialEventsEvent.CALENDAR_EVENT_ENDED,this.onEventEnded);
         controller.removeEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onEventEnded);
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
      
      private function fill(param1:MafiaEddyFrostEvent) : void
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
         if(!MafiaModel.specialEvent.eddyFrostEvent.areAllUnlocked)
         {
            this.tabOverview.onTimeUpdate(param1.params[0]);
         }
      }
      
      private function onTimeUpdate(param1:MafiaSpecialEventsEvent) : void
      {
         if(MafiaModel.specialEvent.eddyFrostEvent.areAllUnlocked)
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
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
         hide();
      }
      
      protected function get dialog() : EventDialog_10
      {
         return disp as EventDialog_10;
      }
   }
}
