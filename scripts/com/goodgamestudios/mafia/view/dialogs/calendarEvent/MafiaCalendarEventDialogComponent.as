package com.goodgamestudios.mafia.view.dialogs.calendarEvent
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.view.screens.MafiaScreen;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MafiaCalendarEventDialogComponent extends MafiaScreen
   {
       
      
      public function MafiaCalendarEventDialogComponent(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,false);
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaSpecialEventsEvent.CALENDAR_EVENT_ENDED,this.onEventEnded);
      }
      
      override public function hide() : void
      {
         super.hide();
         controller.removeEventListener(MafiaSpecialEventsEvent.CALENDAR_EVENT_ENDED,this.onEventEnded);
      }
      
      protected function onEventEnded(param1:Event) : void
      {
         this.hide();
      }
      
      public function sendToForeground() : void
      {
         this.calendarComponent.mouseChildren = true;
         this.calendarComponent.parent.setChildIndex(this.calendarComponent,this.calendarComponent.parent.numChildren - 1);
         this.calendarComponent.deselectionLayer.visible = false;
         this.calendarComponent.useHandCursor = false;
         this.calendarComponent.buttonMode = false;
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      public function sendToBackground() : void
      {
         this.calendarComponent.mouseChildren = false;
         this.calendarComponent.deselectionLayer.visible = true;
      }
      
      override public function updatePosition() : void
      {
      }
      
      public function onClickOnComponent(param1:MouseEvent) : void
      {
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(this.calendarComponent.mouseChildren == false)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            this.calendarComponent.useHandCursor = true;
            this.calendarComponent.buttonMode = true;
         }
         super.onMouseOver(param1);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(this.calendarComponent.mouseChildren == false || param1.target is Btn_CalendarButton)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            this.calendarComponent.useHandCursor = false;
            this.calendarComponent.buttonMode = false;
         }
         super.onMouseOut(param1);
      }
      
      protected function get calendarComponent() : MovieClip
      {
         return disp as MovieClip;
      }
   }
}
