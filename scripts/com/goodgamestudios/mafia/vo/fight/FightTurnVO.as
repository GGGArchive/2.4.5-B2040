package com.goodgamestudios.mafia.vo.fight
{
   import com.goodgamestudios.mafia.vo.fight.actions.FightActionVO;
   
   public class FightTurnVO
   {
       
      
      public var actions:Vector.<FightActionVO>;
      
      public var fighterOnTurn:int;
      
      public function FightTurnVO()
      {
         super();
      }
   }
}
