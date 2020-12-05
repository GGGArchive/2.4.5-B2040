package com.goodgamestudios.mafia.event.model
{
   public class MafiaQuestEvent extends MafiaEvent
   {
      
      public static const QUEST_STARTED:String = "questStarted";
      
      public static const QUEST_COMPLETED:String = "questCompleted";
      
      public static const TASK_PROGRESS:String = "taskProgress";
      
      public static const CHANGE_QUESTLOG_DATA:String = "changeQuestlogData";
      
      public static const CHANGE_CITY_FIGHT_DATA:String = "changeCityFightData";
      
      public static const CHANGE_CITY_FIGHT_ITEMS_DATA:String = "changeCityFightItemsData";
      
      public static const CHANGE_CITY_FIGHT_RESULT_DATA:String = "changeCityFightResultData";
      
      public static const PAUSE_ACTIVE_CITY_QUEST:String = "pauseActiveCityQuest";
      
      public static const REMOVE_CITY_FIGHT_TIMER:String = "remove_city_fight_timer";
      
      public static const CHANGE_CITY_FIGHT_TIMER:String = "change_city_fight_timer";
       
      
      public function MafiaQuestEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
