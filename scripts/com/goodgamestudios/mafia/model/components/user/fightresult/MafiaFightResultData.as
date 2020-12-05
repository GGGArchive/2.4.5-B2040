package com.goodgamestudios.mafia.model.components.user.fightresult
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.vo.FighterVO;
   import com.goodgamestudios.mafia.vo.fight.FightItemVO;
   import com.goodgamestudios.mafia.vo.fight.FightTurnVO;
   import com.goodgamestudios.mafia.vo.fight.actions.FightActionVO;
   
   public class MafiaFightResultData
   {
      
      public static const FIGHTER_LEFT:int = 1;
      
      public static const FIGHTER_RIGHT:int = 2;
      
      public static const PLAYER_NOT_PARTICIPATING_IN_FIGHT:int = -1;
       
      
      public var fighterRight:FighterVO;
      
      public var fighterLeft:FighterVO;
      
      public var fightTurns:Vector.<FightTurnVO>;
      
      public var isLeftFighterWinner:Boolean;
      
      public var left_ammunition:Vector.<FightItemVO>;
      
      public var right_ammunition:Vector.<FightItemVO>;
      
      public var currentAction:FightActionVO;
      
      public var currentTurn:FightTurnVO;
      
      public var skip:Boolean;
      
      public function MafiaFightResultData()
      {
         super();
      }
      
      public function get currentAttacker() : int
      {
         return this.currentTurn.fighterOnTurn;
      }
      
      public function get currentDefender() : int
      {
         return this.currentAttacker == FIGHTER_LEFT?int(FIGHTER_RIGHT):int(FIGHTER_LEFT);
      }
      
      public function damageFighter(param1:int, param2:int) : void
      {
         this.getFighter(param1).currentHitpoints = this.getFighter(param1).currentHitpoints - param2;
         if(this.getFighter(param1).currentHitpoints > this.getFighter(param1).totalHitpoints)
         {
            this.getFighter(param1).currentHitpoints = this.getFighter(param1).totalHitpoints;
         }
      }
      
      public function healFighter(param1:int, param2:uint) : void
      {
         this.damageFighter(param1,param2 * -1);
      }
      
      public function getFighterCurrentHP(param1:int) : int
      {
         return this.getFighter(param1).currentHitpoints;
      }
      
      public function getFighterTotalHP(param1:int) : int
      {
         return this.getFighter(param1).totalHitpoints;
      }
      
      public function getWinner() : int
      {
         return !!this.isLeftFighterWinner?int(FIGHTER_LEFT):int(FIGHTER_RIGHT);
      }
      
      public function getLoser() : int
      {
         return !!this.isLeftFighterWinner?int(FIGHTER_RIGHT):int(FIGHTER_LEFT);
      }
      
      public function getPlayer() : int
      {
         if(this.fighterLeft.id == MafiaModel.userData.playerID)
         {
            return FIGHTER_LEFT;
         }
         if(this.fighterRight.id == MafiaModel.userData.playerID)
         {
            return FIGHTER_RIGHT;
         }
         return PLAYER_NOT_PARTICIPATING_IN_FIGHT;
      }
      
      public function getFighter(param1:int) : FighterVO
      {
         if(param1 == FIGHTER_LEFT)
         {
            return this.fighterLeft;
         }
         return this.fighterRight;
      }
   }
}
