package com.goodgamestudios.mafia.model.components.specialEvents
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.specialwanted.PBSpecialeventSpecialWantedResponse;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   
   public class MafiaCapoVitoEvent extends MafiaSpecialEvent
   {
       
      
      public var item:ItemVO;
      
      public function MafiaCapoVitoEvent()
      {
         _eventId = Constants_SpecialEvents.ID_CAPO_VITO;
         super();
      }
      
      public function parseEventDetails(param1:PBSpecialeventSpecialWantedResponse) : void
      {
         if(param1.hasItem)
         {
            this.item = MafiaItemData.parseItem(param1.item,ItemLocation.None,0) as ItemVO;
         }
         else
         {
            this.item = null;
         }
      }
      
      override public function update(param1:Number) : void
      {
         super.update(param1);
         if(isEventActive)
         {
            BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.CAPOVITO_TIME_UPDATE,[runTimeString]));
         }
      }
      
      override protected function eventEnded() : void
      {
         trace("capo vito event ended!");
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
         BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,[eventId]));
      }
   }
}
