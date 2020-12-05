package com.goodgamestudios.mafia.vo
{
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import flash.display.Sprite;
   
   public class DuelOpponentVO
   {
       
      
      public var playerID:int;
      
      public var playerName:String;
      
      public var level:int;
      
      public var clanName:String;
      
      public var gender:CharacterGender;
      
      public var picString:String;
      
      public var typePic:Sprite;
      
      public var characterClass:CharacterClass;
      
      public var classPic:Sprite;
      
      public function DuelOpponentVO()
      {
         super();
      }
   }
}
