package com.goodgamestudios.mafia.event.model
{
   public class MafiaRankingEvent extends MafiaEvent
   {
      
      public static const CHANGE_PLAYERRANKINGDATA:String = "changePlayerRankingData";
      
      public static const CHANGE_CLAN_RANKING_LIST_DATA:String = "changeClanRankingListData";
      
      public static const CHANGE_CLAN_RANKING_TOP_DATA:String = "changeClanRankingTopData";
      
      public static const CHANGE_PLAYER_RANKING_TIME:String = "changePlayerRankingTime";
      
      public static const CHANGE_CLAN_RANKING_TIME:String = "changeClanRankingTime";
       
      
      public function MafiaRankingEvent(param1:String, param2:Array = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}
