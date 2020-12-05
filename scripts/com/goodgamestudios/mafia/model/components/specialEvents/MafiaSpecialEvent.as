package com.goodgamestudios.mafia.model.components.specialEvents
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getTimer;
   
   public class MafiaSpecialEvent
   {
       
      
      protected var endTime:Number;
      
      private var _isActive:Boolean = false;
      
      private var _teaserReceived:Boolean = false;
      
      public var waitForServerMessage:Boolean = false;
      
      protected var _eventId:int;
      
      public function MafiaSpecialEvent()
      {
         super();
      }
      
      public function parseEvent(param1:Array) : void
      {
         this.waitForServerMessage = false;
         var _loc2_:Boolean = this.isEventActive;
         this.isEventActive = int(param1.shift()) == 1;
         if(_loc2_ && !this.isEventActive)
         {
            this.eventEnded();
         }
         var _loc3_:Number = int(param1.shift()) * Constants_Basic.SEC2MILLISEC;
         this._teaserReceived = int(param1.shift()) == 1;
         this.endTime = getTimer() + _loc3_;
      }
      
      protected function eventEnded() : void
      {
         BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,[this.eventId]));
      }
      
      public function get runTimeString() : String
      {
         return TimeStringHelper.getTimeToString(this.runTimeInSeconds,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
      }
      
      public function get runTimeInSeconds() : Number
      {
         return (this.endTime - getTimer()) * Constants_Basic.MILLISEC2SEC;
      }
      
      public function get isEventActive() : Boolean
      {
         return this._isActive;
      }
      
      public function set isEventActive(param1:Boolean) : void
      {
         this._isActive = param1;
      }
      
      public function get wasTeaserReceived() : Boolean
      {
         return this._teaserReceived;
      }
      
      public function set teaserReceived(param1:Boolean) : void
      {
         this._teaserReceived = param1;
      }
      
      public function get eventTitle() : String
      {
         return "Special Event";
      }
      
      public function update(param1:Number) : void
      {
         if(this.runTimeInSeconds <= 0)
         {
            this.isEventActive = false;
            this.eventEnded();
         }
      }
      
      public function get eventId() : int
      {
         return this._eventId;
      }
   }
}
