package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_Police;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.PoliceType;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBSide;
   import com.goodgamestudios.mafia.controller.protobuf.fight.policeencounter.PBFightPoliceEncounterResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.PBFightStartPoliceFightResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.response.PBFightStartPoliceFightPoliceInfo;
   import com.goodgamestudios.mafia.controller.protobuf.police.PBEffectType;
   import com.goodgamestudios.mafia.event.model.MafiaPoliceEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightDataParser;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getTimer;
   
   public class MafiaPoliceData
   {
      
      public static const EFFECT_NONE:String = "effect_none";
      
      public static const EFFECT_DUEL_HONOR:String = "effect_duel_honor";
      
      public static const EFFECT_MISSION_CASH:String = "effect_mission_cash";
      
      public static const EFFECT_MISSION_XP:String = "effect_mission_xp";
       
      
      public var activeEffect:String = "effect_none";
      
      public var activeEffectValue:int = 0;
      
      private var _activeEffectTimeLeft:int = 0;
      
      public var activeEffectEndTime:int = 0;
      
      public var activeEffectBailCost:int = 0;
      
      public var possibleEffect:String = "effect_none";
      
      public var possibleEffectValueWin:int = 0;
      
      public var possibleEffectValueLose:int = 0;
      
      public var resultData:MafiaFightResultData;
      
      public var policeType:PoliceType;
      
      private var badgesToWin:int = 0;
      
      public var reward:RewardVO;
      
      public function MafiaPoliceData()
      {
         this.policeType = PoliceType.None;
         super();
         this.resultData = new MafiaFightResultData();
      }
      
      public static function getEffectByID(param1:int) : String
      {
         switch(param1)
         {
            case PBEffectType.DUEL_HONOR:
               return EFFECT_DUEL_HONOR;
            case PBEffectType.MISSION_CASH:
               return EFFECT_MISSION_CASH;
            case PBEffectType.MISSION_XP:
               return EFFECT_MISSION_XP;
            default:
               return EFFECT_NONE;
         }
      }
      
      public function parsePoliceEncounterData(param1:PBFightPoliceEncounterResponse) : void
      {
         this.resultData.fighterRight = MafiaFightDataParser.parseFighter(param1.fighter,Constants_ViewScales.SCALE_POLICEMEN_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.policeType = Constants_Police.getPoliceType(this.resultData.fighterRight.id);
         var _loc2_:PoliceEnemy_BG = new PoliceEnemy_BG();
         this.resultData.fighterRight.typeMC.addChildAt(_loc2_,0);
         if(param1.hasPoliceInfo)
         {
            this.possibleEffect = getEffectByID(param1.policeInfo.effectType);
            this.possibleEffectValueWin = param1.policeInfo.effectValueWon;
            this.possibleEffectValueLose = param1.policeInfo.effectValueLost;
         }
         if(param1.hasNumBadgesReward)
         {
            this.badgesToWin = param1.numBadgesReward;
         }
         else
         {
            this.badgesToWin = 0;
         }
      }
      
      public function clearActiveEffect() : void
      {
         this.activeEffect = EFFECT_NONE;
         this.activeEffectValue = 0;
         this.activeEffectEndTime = 0;
         this._activeEffectTimeLeft = 0;
         BasicController.getInstance().dispatchEvent(new MafiaPoliceEvent(MafiaPoliceEvent.CHANGE_POLICE_STATUS));
      }
      
      public function checkTimes() : void
      {
         if(this.isEffectActive())
         {
            if(this.activeEffectTimeLeft <= 0)
            {
               this.clearActiveEffect();
            }
            BasicController.getInstance().dispatchEvent(new MafiaPoliceEvent(MafiaPoliceEvent.CHANGE_POLICE_EFFECT_TIMER));
         }
      }
      
      public function isEffectActive() : Boolean
      {
         return this.activeEffect != EFFECT_NONE;
      }
      
      public function isRewardActive() : Boolean
      {
         return this.isEffectActive() && this.activeEffectValue > 0;
      }
      
      public function isPenaltyActive() : Boolean
      {
         return this.isEffectActive() && this.activeEffectValue < 0;
      }
      
      public function parsePoliceFightData(param1:PBFightStartPoliceFightResponse) : void
      {
         var _loc2_:PoliceEnemy_BG = null;
         this.resultData = new MafiaFightResultData();
         if(param1.hasFight)
         {
            this.resultData.fighterLeft = MafiaFightDataParser.parseFighter(param1.fight.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
            this.resultData.fighterRight = MafiaFightDataParser.parseFighter(param1.fight.rightFighter,Constants_ViewScales.SCALE_POLICEMEN_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
            _loc2_ = new PoliceEnemy_BG();
            this.resultData.fighterRight.typeMC.addChildAt(_loc2_,0);
            this.resultData.fightTurns = MafiaFightDataParser.parseFightTurns(param1.fight.turns);
            if(param1.hasReward)
            {
               this.reward = MafiaFightDataParser.parseReward(param1.reward);
            }
            this.reward.policeBadges = param1.policeBadgeReward;
            this.resultData.isLeftFighterWinner = param1.fight.winner == PBSide.LEFT;
            BasicController.getInstance().dispatchEvent(new MafiaPoliceEvent(MafiaPoliceEvent.POLICE_SHOW_FIGHT));
         }
         if(param1.hasPoliceInfo)
         {
            this.parseStatusDataProto(param1.policeInfo);
         }
         else
         {
            this.activeEffect = EFFECT_NONE;
         }
      }
      
      public function parseStatusDataProto(param1:PBFightStartPoliceFightPoliceInfo) : void
      {
         this._activeEffectTimeLeft = param1.effectTime;
         this.activeEffectEndTime = getTimer() + this._activeEffectTimeLeft * Constants_Basic.SEC2MILLISEC;
         this.activeEffectBailCost = param1.bailCost;
         this.activeEffect = MafiaPoliceData.getEffectByID(param1.effectType);
         this.activeEffectValue = param1.effectValue;
         BasicController.getInstance().dispatchEvent(new MafiaPoliceEvent(MafiaPoliceEvent.CHANGE_POLICE_STATUS));
      }
      
      public function parseStatusData(param1:String) : void
      {
         var _loc2_:Array = param1.split("+");
         this._activeEffectTimeLeft = _loc2_.shift();
         this.activeEffectEndTime = getTimer() + this._activeEffectTimeLeft * Constants_Basic.SEC2MILLISEC;
         this.activeEffect = MafiaPoliceData.getEffectByID(_loc2_.shift());
         this.activeEffectValue = _loc2_.shift();
         this.activeEffectBailCost = _loc2_.shift();
         BasicController.getInstance().dispatchEvent(new MafiaPoliceEvent(MafiaPoliceEvent.CHANGE_POLICE_STATUS));
      }
      
      public function get activeEffectTimeLeft() : int
      {
         return this.activeEffectEndTime - getTimer();
      }
      
      public function isEncounter() : Boolean
      {
         return this.resultData.fighterRight != null;
      }
      
      public function clearEncounter() : void
      {
         this.resultData.fighterRight = null;
      }
      
      public function getEffectDescription(param1:Boolean = false, param2:Boolean = false) : String
      {
         var _loc3_:int = 0;
         switch(!!param1?this.possibleEffect:this.activeEffect)
         {
            case MafiaPoliceData.EFFECT_DUEL_HONOR:
               _loc3_ = 1;
               break;
            case MafiaPoliceData.EFFECT_MISSION_CASH:
               _loc3_ = 2;
               break;
            case MafiaPoliceData.EFFECT_MISSION_XP:
               _loc3_ = 3;
         }
         var _loc4_:int = !!param1?!!param2?int(this.possibleEffectValueWin):int(this.possibleEffectValueLose):int(this.activeEffectValue);
         var _loc5_:String = "";
         if(_loc4_ > 0)
         {
            _loc5_ = MafiaModel.languageData.getTextById("tt_MafiaPolice_effect_reward_" + _loc3_,[_loc4_]);
         }
         else if(_loc4_ < 0)
         {
            _loc5_ = MafiaModel.languageData.getTextById("tt_MafiaPolice_effect_penalty_" + _loc3_,[Math.abs(_loc4_)]);
         }
         return _loc5_;
      }
      
      public function getEffectDescriptionWithDuration(param1:Boolean = false, param2:Boolean = false) : String
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         switch(!!param1?this.possibleEffect:this.activeEffect)
         {
            case MafiaPoliceData.EFFECT_NONE:
               _loc3_ = 0;
               break;
            case MafiaPoliceData.EFFECT_DUEL_HONOR:
               _loc3_ = 1;
               break;
            case MafiaPoliceData.EFFECT_MISSION_CASH:
               _loc3_ = 2;
               break;
            case MafiaPoliceData.EFFECT_MISSION_XP:
               _loc3_ = 3;
               break;
            default:
               throw new Error("no effect defined - missing proto policeInfo?");
         }
         var _loc4_:String = "";
         if(_loc3_ > 0)
         {
            _loc5_ = !!param1?!!param2?int(this.possibleEffectValueWin):int(this.possibleEffectValueLose):int(this.activeEffectValue);
            _loc6_ = TimeStringHelper.getTimeToString(Constants_Police.EFFECT_DURATION,TimeStringHelper.ONE_TIME_FORMAT,MafiaModel.languageData.getTextById);
            if(_loc5_ > 0)
            {
               _loc4_ = MafiaModel.languageData.getTextById("MafiaPolice_effect_reward_" + _loc3_,[_loc6_,_loc5_]);
            }
            else if(_loc5_ < 0)
            {
               _loc4_ = MafiaModel.languageData.getTextById("MafiaPolice_effect_penalty_" + _loc3_,[_loc6_,Math.abs(_loc5_)]);
            }
         }
         return _loc4_;
      }
   }
}
