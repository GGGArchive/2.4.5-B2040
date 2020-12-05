package com.goodgamestudios.mafia.model.components.specialEvents
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.luckydevil.PBSpecialeventLuckydevilResponse;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class MafiaLuckyDevilEvent extends MafiaSpecialEvent
   {
       
      
      private var _hasCards:Boolean;
      
      private var _cost:uint;
      
      public function MafiaLuckyDevilEvent()
      {
         _eventId = Constants_SpecialEvents.ID_LUCKY_DEVIL;
         super();
      }
      
      override public function get eventTitle() : String
      {
         return MafiaModel.languageData.getTextById("");
      }
      
      override public function update(param1:Number) : void
      {
         super.update(param1);
         if(isEventActive)
         {
            BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.LUCKY_DEVIL_TIMER_UPDATE,[runTimeString]));
         }
      }
      
      public function parseEventDetails(param1:PBSpecialeventLuckydevilResponse) : void
      {
         this._hasCards = param1.hasCards;
         this._cost = param1.cost;
         BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.LUCKY_DEVIL_EVENT_DATA,[]));
      }
      
      public function get hasCards() : Boolean
      {
         return this._hasCards;
      }
      
      public function set hasCards(param1:Boolean) : void
      {
         this._hasCards = param1;
      }
      
      public function get cost() : uint
      {
         return this._cost;
      }
   }
}
