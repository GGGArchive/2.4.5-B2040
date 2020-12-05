package com.goodgamestudios.mafia.controller
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionType;
   import com.goodgamestudios.mafia.event.model.MafiaEvent;
   import com.goodgamestudios.mafia.event.model.MafiaFightEvent;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.vo.FighterVO;
   import com.goodgamestudios.mafia.vo.fight.actions.FightActionEffectVO;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class MafiaFightController extends EventDispatcher
   {
      
      private static var _mafiaFightController:MafiaFightController;
       
      
      private var data:MafiaFightResultData;
      
      private var effectsFinished:Vector.<Boolean>;
      
      private var _lastFightType:FightType;
      
      private var _fightTypeBeforeLastPoliceFight:FightType;
      
      private const FIGHT_TURN_CAP:int = 1000;
      
      public function MafiaFightController(param1:SingletonEnforcer#107)
      {
         super();
      }
      
      public static function getInstance() : MafiaFightController
      {
         if(!_mafiaFightController)
         {
            _mafiaFightController = new MafiaFightController(new SingletonEnforcer#107());
         }
         return _mafiaFightController;
      }
      
      protected function onResultAnimationFinished(param1:Event) : void
      {
         BasicController.getInstance().dispatchEvent(new MafiaFightEvent(MafiaFightEvent.UPDATE_EFFECTS));
      }
      
      private function onSkipCombat(param1:Event) : void
      {
         this.data.skip = true;
         this.makeAction();
      }
      
      public function startFight(param1:MafiaFightResultData, param2:FightType) : void
      {
         BasicController.getInstance().addEventListener(MafiaFightEvent.SKIP_COMBAT,this.onSkipCombat);
         BasicController.getInstance().addEventListener(MafiaFightEvent.RESULT_ANIMATION_FINISHED,this.onResultAnimationFinished);
         BasicController.getInstance().addEventListener(MafiaFightEvent.EFFECT_ANIMATION_FINISHED,this.onEffectAnimationFinished);
         this.effectsFinished = new Vector.<Boolean>(MafiaFightResultData.FIGHTER_RIGHT + 1);
         if(param2 == FightType.Police)
         {
            this._fightTypeBeforeLastPoliceFight = this._lastFightType;
         }
         this._lastFightType = param2;
         if(param1 && param1.fightTurns)
         {
            this.data = param1;
            BasicController.getInstance().dispatchEvent(new MafiaFightEvent(MafiaFightEvent.START_COMBAT));
            this.makeTurn();
         }
         else
         {
            trace("Error: Fight result data or fight turns are null");
         }
      }
      
      private function makeTurn() : void
      {
         if(this.data.fightTurns.length == 0)
         {
            this.endOfCombat();
         }
         else if(this.data.fightTurns.length > this.FIGHT_TURN_CAP)
         {
            this.endOfCombat();
         }
         else
         {
            this.data.currentTurn = this.data.fightTurns.shift();
            this.makeAction();
         }
      }
      
      private function makeAction() : void
      {
         if(this.data.currentTurn.actions.length == 0)
         {
            this.updateEffects(this.data.currentAttacker);
            this.updateEffects(this.data.currentDefender);
            this.makeTurn();
         }
         else
         {
            this.data.currentAction = this.data.currentTurn.actions.shift();
            if(this.data.currentAction.effect)
            {
               this.addEffects(this.data.currentAction.effect);
            }
            switch(this.data.currentAction.type)
            {
               case PBFightActionType.HIT:
                  this.data.damageFighter(this.data.currentDefender,this.data.currentAction.hit.firstDamage);
                  this.data.damageFighter(this.data.currentDefender,this.data.currentAction.hit.secondDamage);
                  if(!this.data.skip)
                  {
                     BasicController.getInstance().dispatchEvent(new MafiaFightEvent(MafiaFightEvent.PLAY_WEAPON_ANIMATION));
                  }
                  else
                  {
                     this.makeAction();
                  }
                  break;
               case PBFightActionType.CONSUME:
                  this.data.damageFighter(this.data.currentDefender,this.data.currentAction.consume.damage);
                  this.data.healFighter(this.data.currentAttacker,this.data.currentAction.consume.heal);
                  if(!this.data.skip)
                  {
                     BasicController.getInstance().dispatchEvent(new MafiaFightEvent(MafiaFightEvent.PLAY_CONSUMABLE_ANIMATION));
                  }
                  else
                  {
                     this.makeAction();
                  }
                  break;
               case PBFightActionType.PASSIVE:
                  this.makeAction();
            }
         }
      }
      
      protected function onEffectAnimationFinished(param1:MafiaEvent) : void
      {
         var _loc2_:int = param1.params[0];
         this.effectsFinished[_loc2_] = true;
         if(this.effectsFinished[MafiaFightResultData.FIGHTER_LEFT] && this.effectsFinished[MafiaFightResultData.FIGHTER_RIGHT])
         {
            this.effectsFinished[MafiaFightResultData.FIGHTER_LEFT] = false;
            this.effectsFinished[MafiaFightResultData.FIGHTER_RIGHT] = false;
            this.copyEffects(this.data.currentAttacker);
            this.copyEffects(this.data.currentDefender);
            this.makeAction();
         }
      }
      
      private function updateEffects(param1:int) : void
      {
         var _loc2_:FighterVO = null;
         var _loc3_:int = 0;
         var _loc4_:FightActionEffectVO = null;
         _loc2_ = this.data.getFighter(param1);
         if(_loc2_.effects)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.effects.length)
            {
               _loc4_ = _loc2_.effects[_loc3_];
               _loc4_.durationLeft--;
               if(_loc4_.durationLeft <= 0)
               {
                  _loc2_.effects.splice(_loc3_,1);
                  _loc3_--;
               }
               _loc3_++;
            }
         }
      }
      
      private function copyEffects(param1:int) : void
      {
         var _loc3_:FightActionEffectVO = null;
         var _loc2_:FighterVO = this.data.getFighter(param1);
         _loc2_.effectsLastRound = new Vector.<FightActionEffectVO>();
         for each(_loc3_ in _loc2_.effects)
         {
            _loc2_.effectsLastRound.push(_loc3_);
         }
      }
      
      private function addEffects(param1:FightActionEffectVO) : void
      {
         var _loc2_:FighterVO = null;
         var _loc3_:int = 0;
         var _loc4_:FightActionEffectVO = null;
         _loc2_ = this.data.getFighter(param1.target);
         if(this.data.currentAction.effect && this.data.currentAction.effect.durationLeft > 0)
         {
            if(!_loc2_.effects)
            {
               _loc2_.effects = new Vector.<FightActionEffectVO>();
               _loc2_.effectsLastRound = new Vector.<FightActionEffectVO>();
            }
            if(param1.buffType == FightActionEffectVO.DEBUFF)
            {
               _loc2_.effects.push(this.data.currentAction.effect);
            }
            else
            {
               _loc3_ = 0;
               for each(_loc4_ in _loc2_.effects)
               {
                  if(_loc4_.buffType == FightActionEffectVO.BUFF)
                  {
                     _loc3_++;
                  }
               }
               _loc2_.effects.splice(_loc3_,0,this.data.currentAction.effect);
            }
         }
      }
      
      private function clearEffects() : void
      {
         this.data.fighterLeft.effects = new Vector.<FightActionEffectVO>();
         this.data.fighterRight.effects = new Vector.<FightActionEffectVO>();
      }
      
      private function endOfCombat() : void
      {
         this.clearEffects();
         BasicController.getInstance().removeEventListener(MafiaFightEvent.SKIP_COMBAT,this.onSkipCombat);
         BasicController.getInstance().removeEventListener(MafiaFightEvent.RESULT_ANIMATION_FINISHED,this.onResultAnimationFinished);
         BasicController.getInstance().removeEventListener(MafiaFightEvent.EFFECT_ANIMATION_FINISHED,this.onEffectAnimationFinished);
         BasicController.getInstance().dispatchEvent(new MafiaFightEvent(MafiaFightEvent.UPDATE_EFFECTS));
         BasicController.getInstance().dispatchEvent(new MafiaFightEvent(MafiaFightEvent.END_COMBAT));
      }
      
      public function get lastFightType() : FightType
      {
         return this._lastFightType;
      }
      
      public function get fightTypeBeforeLastPoliceFight() : FightType
      {
         return this._fightTypeBeforeLastPoliceFight;
      }
   }
}

class SingletonEnforcer#107
{
    
   
   function SingletonEnforcer#107()
   {
      super();
   }
}
