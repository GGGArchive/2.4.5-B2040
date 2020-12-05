package com.goodgamestudios.mafia.vo.tournament
{
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import flash.display.Sprite;
   
   public class TournamentOpponentVO
   {
       
      
      public var ID:int;
      
      public var level:int;
      
      public var levelProgress:int;
      
      public var characterClass:CharacterClass;
      
      public var HP:int;
      
      public var name:String;
      
      public var clanName:String;
      
      public var avatarPicString:String;
      
      public var typeMC:Sprite;
      
      public function TournamentOpponentVO()
      {
         super();
      }
   }
}
