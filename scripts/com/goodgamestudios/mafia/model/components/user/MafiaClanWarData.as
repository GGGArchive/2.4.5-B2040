package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBSide;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFamilyWarParticipant;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFamilyWarResult;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightDataParser;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaMultiFightResultData;
   import com.goodgamestudios.mafia.vo.FighterVO;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.mafia.vo.fight.FightTurnVO;
   import com.goodgamestudios.mafia.vo.fight.actions.FightActionVO;
   
   public class MafiaClanWarData extends MafiaMultiFightResultData
   {
       
      
      public var attackerClanId:int;
      
      public var winnerClanId:int;
      
      public var playerClanId:int;
      
      public var playerClanName:String;
      
      public var playerClanGloryChange:int;
      
      public var enemyClanName:String;
      
      public var enemyClanId:int;
      
      public var playerReward:RewardVO;
      
      public function MafiaClanWarData(param1:PBFamilyWarResult)
      {
         super();
         this.attackerClanId = param1.attackerFamilyId;
         if(this.attackerClanId == MafiaModel.userData.profileData.clanID)
         {
            this.playerClanId = param1.attackerFamilyId;
            this.playerClanName = param1.attackerFamilyName;
            this.enemyClanId = param1.defenderFamilyId;
            this.enemyClanName = param1.defenderFamilyName;
         }
         else
         {
            this.playerClanId = param1.defenderFamilyId;
            this.playerClanName = param1.defenderFamilyName;
            this.enemyClanId = param1.attackerFamilyId;
            this.enemyClanName = param1.attackerFamilyName;
         }
         this.parseFights(param1.fights);
         if(this.isPlayerClanAttacking)
         {
            this.parseAdditionalFighters(param1.attackers,fightersLeft);
            this.parseAdditionalFighters(param1.defenders,fightersRight);
         }
         else
         {
            this.parseAdditionalFighters(param1.defenders,fightersLeft);
            this.parseAdditionalFighters(param1.attackers,fightersRight);
         }
         this.winnerClanId = param1.winnerFamilyId;
         if(this.isPlayerClanAttacking)
         {
            this.playerClanGloryChange = param1.attackerFamilyGloryChange;
         }
         else
         {
            this.playerClanGloryChange = param1.defenderFamilyGloryChange;
         }
         this.playerReward = MafiaFightDataParser.parseReward(param1.reward);
         if(this.playerReward.xp > 0 && this.winnerClanId == MafiaModel.userData.profileData.clanID && this.attackerClanId == MafiaModel.userData.profileData.clanID)
         {
            this.playerReward.drink = 1;
         }
      }
      
      private function parseFights(param1:Array) : void
      {
         var _loc2_:PBFight = null;
         var _loc3_:MafiaFightResultData = null;
         fights = new Vector.<MafiaFightResultData>();
         fightersLeft = new Vector.<FighterVO>();
         fightersRight = new Vector.<FighterVO>();
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = param1[_loc4_] as PBFight;
            _loc3_ = this.parseSingleFight(_loc2_);
            if(fightersLeft.length == 0 || fightersLeft[fightersLeft.length - 1].id != _loc3_.fighterLeft.id)
            {
               fightersLeft.push(_loc3_.fighterLeft);
            }
            if(fightersRight.length == 0 || fightersRight[fightersRight.length - 1].id != _loc3_.fighterRight.id)
            {
               fightersRight.push(_loc3_.fighterRight);
            }
            fights.push(_loc3_);
            _loc4_++;
         }
         if(this.attackerClanId != MafiaModel.userData.profileData.clanID)
         {
            this.swapSides();
         }
      }
      
      private function swapSides() : void
      {
         var _loc1_:MafiaFightResultData = null;
         var _loc2_:Vector.<FighterVO> = null;
         var _loc3_:FighterVO = null;
         var _loc4_:FightTurnVO = null;
         var _loc5_:FightActionVO = null;
         for each(_loc1_ in fights)
         {
            _loc3_ = _loc1_.fighterLeft;
            _loc1_.fighterLeft = _loc1_.fighterRight;
            _loc1_.fighterRight = _loc3_;
            _loc1_.isLeftFighterWinner = !_loc1_.isLeftFighterWinner;
            for each(_loc4_ in _loc1_.fightTurns)
            {
               if(_loc4_.fighterOnTurn == MafiaFightResultData.FIGHTER_LEFT)
               {
                  _loc4_.fighterOnTurn = MafiaFightResultData.FIGHTER_RIGHT;
               }
               else
               {
                  _loc4_.fighterOnTurn = MafiaFightResultData.FIGHTER_LEFT;
               }
               for each(_loc5_ in _loc4_.actions)
               {
                  if(_loc5_.effect)
                  {
                     if(_loc5_.effect.target == MafiaFightResultData.FIGHTER_LEFT)
                     {
                        _loc5_.effect.target = MafiaFightResultData.FIGHTER_RIGHT;
                     }
                     else
                     {
                        _loc5_.effect.target = MafiaFightResultData.FIGHTER_LEFT;
                     }
                  }
               }
            }
         }
         _loc2_ = fightersLeft;
         fightersLeft = fightersRight;
         fightersRight = _loc2_;
      }
      
      private function parseSingleFight(param1:PBFight) : MafiaFightResultData
      {
         var _loc2_:MafiaFightResultData = new MafiaFightResultData();
         _loc2_.fighterLeft = MafiaFightDataParser.parseFighter(param1.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         _loc2_.fighterRight = MafiaFightDataParser.parseFighter(param1.rightFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         _loc2_.fightTurns = MafiaFightDataParser.parseFightTurns(param1.turns);
         _loc2_.isLeftFighterWinner = param1.winner == PBSide.LEFT;
         return _loc2_;
      }
      
      private function parseAdditionalFighters(param1:Array, param2:Vector.<FighterVO>) : void
      {
         var _loc3_:PBFamilyWarParticipant = null;
         var _loc4_:Boolean = false;
         var _loc5_:FighterVO = null;
         var _loc6_:FighterVO = null;
         for each(_loc3_ in param1)
         {
            _loc4_ = false;
            for each(_loc5_ in param2)
            {
               if(_loc3_.id == _loc5_.id)
               {
                  _loc4_ = true;
                  break;
               }
            }
            if(!_loc4_)
            {
               _loc6_ = new FighterVO();
               _loc6_.name = _loc3_.name;
               _loc6_.id = _loc3_.id;
               param2.push(_loc6_);
            }
         }
      }
      
      public function get isPlayerClanAttacking() : Boolean
      {
         return this.playerClanId == this.attackerClanId;
      }
      
      public function get isPlayerClanDefending() : Boolean
      {
         return this.playerClanId != this.attackerClanId;
      }
   }
}
