package com.goodgamestudios.mafia.vo
{
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.vo.fight.actions.FightActionEffectVO;
   import flash.display.Sprite;
   
   public class FighterVO
   {
       
      
      public var id:int;
      
      public var totalHitpoints:int;
      
      public var currentHitpoints:int;
      
      public var attack:int;
      
      public var endurance:int;
      
      public var luck:int;
      
      public var toughness:int;
      
      public var weaponID:int;
      
      public var name:String;
      
      public var characterClass:CharacterClass;
      
      public var characterClassMC:Sprite;
      
      public var typeMC:Sprite;
      
      public var gender:CharacterGender;
      
      public var level:int;
      
      public var effects:Vector.<FightActionEffectVO>;
      
      public var effectsLastRound:Vector.<FightActionEffectVO>;
      
      public function FighterVO()
      {
         super();
      }
   }
}
