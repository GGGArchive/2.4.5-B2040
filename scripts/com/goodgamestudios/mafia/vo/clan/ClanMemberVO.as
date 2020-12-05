package com.goodgamestudios.mafia.vo.clan
{
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.FamilyRank;
   
   public class ClanMemberVO
   {
       
      
      public var playerID:int;
      
      public var name:String;
      
      public var level:int;
      
      public var characterClass:CharacterClass;
      
      public var rankInClan:FamilyRank;
      
      public var rankInHighScore:int;
      
      public var attackParticipation:Boolean;
      
      public var defendParticipation:Boolean;
      
      public var clanID:int;
      
      public var donatedGold:int;
      
      public var activityPoints:Number;
      
      public var activityPointsYesterday:Number;
      
      public var isOnline:Boolean;
      
      public function ClanMemberVO()
      {
         super();
      }
   }
}
