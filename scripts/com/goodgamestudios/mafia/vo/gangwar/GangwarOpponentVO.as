package com.goodgamestudios.mafia.vo.gangwar
{
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import flash.display.Sprite;
   
   public class GangwarOpponentVO
   {
       
      
      public var picID:int;
      
      public var picMC:Sprite;
      
      public var nameID:int;
      
      public var opponentLevel:int;
      
      public var gender:CharacterGender;
      
      public var characterClass:CharacterClass;
      
      public function GangwarOpponentVO()
      {
         super();
      }
   }
}
