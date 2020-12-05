package com.goodgamestudios.mafia.model.components.specialEvents
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class MafiaBreakingTheLawEvent extends MafiaSpecialEvent
   {
       
      
      public const SWAT_BADGE_REWARD:int = 3;
      
      public var policeBadges:int = 0;
      
      public var badgeCosts:Vector.<int>;
      
      public function MafiaBreakingTheLawEvent()
      {
         _eventId = Constants_SpecialEvents.ID_BREAKING_THE_LAW;
         super();
      }
      
      override public function get eventTitle() : String
      {
         return MafiaModel.languageData.getTextById("event_breakingthelaw_copy_1");
      }
      
      override public function parseEvent(param1:Array) : void
      {
         super.parseEvent(param1);
         this.badgeCosts = new Vector.<int>();
         this.badgeCosts[0] = param1.shift();
         this.badgeCosts[1] = param1.shift();
         this.badgeCosts[2] = param1.shift();
      }
      
      override public function update(param1:Number) : void
      {
         super.update(param1);
         if(isEventActive)
         {
            BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.BREAKING_THE_LAW_TIME_UPDATE,[runTimeString]));
         }
      }
   }
}
