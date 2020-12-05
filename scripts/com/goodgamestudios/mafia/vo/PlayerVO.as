package com.goodgamestudios.mafia.vo
{
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   
   public class PlayerVO
   {
       
      
      public var playerID:int;
      
      public var name:String;
      
      public var level:int;
      
      public var characterClass:CharacterClass;
      
      public function PlayerVO()
      {
         super();
      }
   }
}
