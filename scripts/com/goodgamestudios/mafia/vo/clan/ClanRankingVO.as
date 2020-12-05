package com.goodgamestudios.mafia.vo.clan
{
   public class ClanRankingVO
   {
       
      
      public var rank:int;
      
      public var clanID:int;
      
      public var name:String;
      
      public var founderID:int;
      
      public var leader:String;
      
      public var member:int;
      
      public var glory:int;
      
      public var level:int;
      
      public var attackClanWarTimeInSeconds:Number;
      
      public var attackClanWarTime:String;
      
      public var attackingClanName:String;
      
      public var defendClanWarTimeInSeconds:Number;
      
      public var defendClanWarTime:String;
      
      public var defendingClanName:String;
      
      public var crest:FamilyCrestVO;
      
      public function ClanRankingVO()
      {
         super();
      }
   }
}
