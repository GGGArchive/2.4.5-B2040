package com.goodgamestudios.mafia.event.model
{
   import flash.events.Event;
   
   public class MafiaSpecialEventsEvent extends Event
   {
      
      public static const SPECIAL_EVENT_STARTED:String = "special_event_started";
      
      public static const SPECIAL_EVENT_IS_OVER:String = "special_event_is_over";
      
      public static const SICILIAN_TIME_UPDATE:String = "sicilian_time_update";
      
      public static const SICILIAN_EVENT_DATA_UPDATED:String = "sicilian_event_data_updated";
      
      public static const CAPOVITO_TIME_UPDATE:String = "capovito_time_update";
      
      public static const CAPOVITO_EVENT_DATA_UPDATED:String = "capovito_event_data_updated";
      
      public static const NIGHTOFHORROR_TIME_UPDATE:String = "nightofhorror_time_update";
      
      public static const NIGHTOFHORROR_DATA_UPDATED:String = "nightofhorror_event_data_updated";
      
      public static const EDDYFROST_TIME_UPDATE:String = "eddyfrost_time_update";
      
      public static const EDDYFROST_EVENT_DATA_UPDATED:String = "eddyfrost_event_data_updated";
      
      public static const CALENDAR_TIME_UPDATE:String = "calendar_time_update";
      
      public static const CALENDAR_EVENT_DATA_UPDATED:String = "calendar_event_data_updated";
      
      public static const CALENDAR_NEXT_UNLOCK_TIME:String = "calendar_next_unlock_time";
      
      public static const CALENDAR_EVENT_ENDED:String = "calendar_event_ended";
      
      public static const TOURNAMENT_TIME_UPDATE:String = "tournament_time_update";
      
      public static const TOURNAMENT_TIME_ROUND_ENDED:String = "tournament_time_round_ended";
      
      public static const TOURNAMENT_EVENT_DATA_UPDATED:String = "tournament_event_data_updated";
      
      public static const TOURNAMENT_REGISTER_REMAINING_TIME:String = "tournament_register_remaining_time";
      
      public static const TOURNAMENT_REGISTRATION_ENDED:String = "tournament_registeration_ended";
      
      public static const TOURNAMENT_REMAINING_PLAYERS_UPDATED:String = "tournament_remaining_players_updated";
      
      public static const TOURNAMENT_FINALS_OVERVIEW_UPDATED:String = "tournament_finals_overview_updated";
      
      public static const TOURNAMENT_SEARCHED_PLAYER_UPDATED:String = "tournament_searched_player_updated";
      
      public static const TOURNAMENT_VIEW_FIGHT:String = "tournament_view_fight";
      
      public static const TOURNAMENT_ROUND_REPORT:String = "tournament_round_report";
      
      public static const TOURNAMENT_PLAYER_NOTFOUND:String = "tournament_player_notfound";
      
      public static const BREAK_THE_LAW_DATA_UPDATED:String = "break_the_law_data_updated";
      
      public static const BREAKING_THE_LAW_TIME_UPDATE:String = "breaking_the_law_time_update";
      
      public static const LUCKY_DEVIL_EVENT_DATA:String = "lucky_devil_event_data";
      
      public static const LUCKY_DEVIL_ITEM_RECEIVED:String = "lucky_devil_item_received";
      
      public static const LUCKY_DEVIL_CARDS_BOUGHT:String = "lucky_devil_cards_bought";
      
      public static const LUCKY_DEVIL_TIMER_UPDATE:String = "lucky_devil_timer_update";
       
      
      public var params:Array;
      
      public function MafiaSpecialEventsEvent(param1:String, param2:Array, param3:Boolean = false, param4:Boolean = false)
      {
         this.params = param2;
         super(param1,param3,param4);
      }
   }
}
