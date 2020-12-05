package com.goodgamestudios.mafia.vo.fight.actions
{
   import com.goodgamestudios.mafia.vo.fight.FightItemVO;
   
   public class FightActionHitVO
   {
       
      
      public var result:uint;
      
      public var weapon:FightItemVO;
      
      public var firstDamage:uint;
      
      public var secondDamage:uint;
      
      public var isCritical:Boolean;
      
      public function FightActionHitVO()
      {
         super();
      }
   }
}
