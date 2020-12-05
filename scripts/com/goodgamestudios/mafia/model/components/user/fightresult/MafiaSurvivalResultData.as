package com.goodgamestudios.mafia.model.components.user.fightresult
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.mafia.constants.Constants_Avatarparts;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBSide;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startsurvivalfight.PBFightStartSurvivalFightResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.PBFightSurvivalStatusResponse;
   import com.goodgamestudios.mafia.event.model.MafiaSurvivalEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSurvivalFightLostWonDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaSurvivalFightLostWonDialogProperties;
   import com.goodgamestudios.mafia.vo.FighterVO;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.math.SimpleRandom;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   
   public class MafiaSurvivalResultData extends MafiaMultiFightResultData
   {
      
      public static const MAX_ENEMIES:int = 30;
      
      public static const SURVIVAL_OPPONENTS_IN_ONE_ROUND:int = 5;
      
      public static const MAX_ROUNDS:int = 5;
      
      public static var ENEMY_NORMAL:int = 1;
      
      public static var ENEMY_LAST_BOSS:int = 2;
      
      public static var ENEMY_ROUND_BOSS:int = 3;
       
      
      public var survivalResetTime:Number;
      
      public var nextFreeSurvivalFightTime:Number;
      
      public var survivalProgress:int;
      
      public var absoluteKilledEnemies:int;
      
      public var neededEnergy:int;
      
      public var item:ItemVO;
      
      public var wonAgainstBoss:Boolean;
      
      public var opponentCharacterClass:Array;
      
      public var survivalCompleted:int;
      
      public var waypoint6Completed:int;
      
      public var waypoint5Completed:int;
      
      public var waypoint4Completed:int;
      
      public var waypoint3Completed:int;
      
      public var waypoint2Completed:int;
      
      public var waypoint1Completed:int;
      
      public var consecutiveEnemiesBeaten:int;
      
      private var _survivalFightDataCounter:int;
      
      private var _round:int;
      
      private var lastRound:Boolean;
      
      public var enemiesLeft:int;
      
      public var reward:RewardVO;
      
      public var preCombatProfile:FighterVO;
      
      public function MafiaSurvivalResultData()
      {
         super();
         this.survivalResetTime = 0;
         this.wonAgainstBoss = false;
      }
      
      public function get round() : int
      {
         return this._round;
      }
      
      public function set round(param1:int) : void
      {
         this._round = param1;
      }
      
      public function parseSurvivalData(param1:PBFightSurvivalStatusResponse) : void
      {
         var _loc2_:int = 0;
         var _loc3_:CharacterClass = null;
         this.opponentCharacterClass = new Array();
         for each(_loc2_ in param1.opponentClass)
         {
            _loc3_ = ProtobufEnumTranslator.translateProtoCharacterClass(_loc2_);
            this.opponentCharacterClass.push(_loc3_);
         }
         if(param1.timeUntilReset > 0)
         {
            this.survivalResetTime = getTimer() + param1.timeUntilReset * Constants_Basic.SEC2MILLISEC;
         }
         else
         {
            this.survivalResetTime = 0;
         }
         if(this.survivalProgress > 0 && param1.currentProgress == 0 && !this.wonAgainstBoss)
         {
            MafiaDialogHandler.getInstance().registerDialogs(MafiaSurvivalFightLostWonDialog.NAME,new MafiaSurvivalFightLostWonDialogProperties(false,true),true,BasicDialogHandler.PRIORITY_HIGH);
         }
         this.survivalProgress = param1.currentProgress;
         if(this.survivalProgress == 0)
         {
            this.survivalResetTime = 0;
         }
         this.absoluteKilledEnemies = param1.lastProgress;
         this.neededEnergy = param1.energyNeeded;
         this.item = MafiaItemData.parseItem(param1.rewardItem,ItemLocation.None,0);
         this.survivalCompleted = param1.statTimesCompleted;
         this.waypoint6Completed = param1.statTimesWaypointReached[5];
         this.waypoint5Completed = param1.statTimesWaypointReached[4];
         this.waypoint4Completed = param1.statTimesWaypointReached[3];
         this.waypoint3Completed = param1.statTimesWaypointReached[2];
         this.waypoint2Completed = param1.statTimesWaypointReached[1];
         this.waypoint1Completed = param1.statTimesWaypointReached[0];
         this.consecutiveEnemiesBeaten = param1.statBestProgressWithoutDying;
         this.wonAgainstBoss = false;
         this._survivalFightDataCounter = 0;
         BasicController.getInstance().dispatchEvent(new MafiaSurvivalEvent(MafiaSurvivalEvent.CHANGE_SURVIVALDATA));
      }
      
      public function parseSurvivalCoolDown(param1:Array) : void
      {
         param1.shift();
         if(param1[0] > 0)
         {
            this.nextFreeSurvivalFightTime = getTimer() + parseInt(param1.shift()) * Constants_Basic.SEC2MILLISEC;
         }
         else
         {
            param1.shift();
            this.nextFreeSurvivalFightTime = 0;
         }
         BasicController.getInstance().dispatchEvent(new MafiaSurvivalEvent(MafiaSurvivalEvent.CHANGE_SURVIVALDATA));
      }
      
      public function checkSurvivalResetTime(param1:Number) : void
      {
         var _loc2_:Array = new Array();
         _loc2_.push(TimeStringHelper.getShortTimeString(this.survivalResetTime - param1));
         BasicController.getInstance().dispatchEvent(new MafiaSurvivalEvent(MafiaSurvivalEvent.CHANGE_SURVIVALRESETTIMER,_loc2_));
         if(param1 > this.survivalResetTime)
         {
            this.survivalResetTime = 0;
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_SURVIVAL_COOLDOWN,[]);
            if(MafiaLayoutManager.getInstance().currentState == Constants_LayoutStates.STATE_SURVIVAL)
            {
               MafiaLayoutManager.getInstance().state = Constants_LayoutStates.STATE_DUEL;
            }
         }
      }
      
      public function checkSurvivalCoolDownTime(param1:Number) : void
      {
         var _loc2_:Array = new Array();
         _loc2_.push(TimeStringHelper.getShortTimeString(this.nextFreeSurvivalFightTime - param1));
         BasicController.getInstance().dispatchEvent(new MafiaSurvivalEvent(MafiaSurvivalEvent.CHANGE_SURVIVALCOOLDOWNTIMER,_loc2_));
         if(param1 > this.nextFreeSurvivalFightTime)
         {
            this.nextFreeSurvivalFightTime = 0;
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_SURVIVAL_COOLDOWN,[]);
         }
      }
      
      public function parseSurvivalResultData(param1:PBFightStartSurvivalFightResponse) : void
      {
         var _loc2_:PBFight = null;
         var _loc3_:MafiaFightResultData = null;
         var _loc4_:Sprite = null;
         var _loc5_:SimpleRandom = null;
         var _loc6_:* = false;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         super.fightersLeft = new Vector.<FighterVO>();
         super.fightersRight = new Vector.<FighterVO>();
         this.enemiesLeft = param1.maxFighters;
         this.lastRound = param1.maxFighters == 1;
         this.reward = new RewardVO();
         if(param1.hasReward)
         {
            this.reward.cash = param1.reward.cash;
            this.reward.xp = param1.reward.xp;
            this.reward.gold = param1.reward.gold;
            this.reward.ap = param1.reward.activity;
            if(param1.reward.hasItem)
            {
               this.reward.item = MafiaItemData.parseItem(param1.reward.item,ItemLocation.None,0);
            }
         }
         for each(_loc2_ in param1.fight)
         {
            if(this._survivalFightDataCounter == 0)
            {
               fights = new Vector.<MafiaFightResultData>();
            }
            _loc3_ = new MafiaFightResultData();
            _loc3_.fighterLeft = MafiaFightDataParser.parseFighter(_loc2_.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
            _loc3_.fighterRight = MafiaFightDataParser.parseFighter(_loc2_.rightFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
            _loc5_ = new SimpleRandom(_loc3_.fighterRight.id);
            _loc6_ = _loc3_.fighterRight.id % 2 == 0;
            _loc7_ = _loc5_.nextInt(30) + 1;
            _loc8_ = _loc5_.nextInt(30) + 1;
            if(_loc6_)
            {
               _loc4_ = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(Constants_Avatarparts.RANDOM_MALE_CHARACTERS[_loc7_]),Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,true,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
               _loc3_.fighterRight.name = MafiaModel.languageData.getTextById("MafiaEnemyName_male_" + String(_loc8_));
            }
            else
            {
               _loc4_ = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(Constants_Avatarparts.RANDOM_FEMALE_CHARACTERS[_loc7_]),Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,true,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
               _loc3_.fighterRight.name = MafiaModel.languageData.getTextById("MafiaEnemyName_female_" + String(_loc8_));
            }
            _loc9_ = _loc5_.nextInt(60) + 1;
            trace("typeID " + int(_loc3_.fighterRight.id));
            trace("name" + _loc8_ + "surnameId " + _loc9_);
            _loc3_.fighterRight.name = _loc3_.fighterRight.name + (" " + MafiaModel.languageData.getTextById("MafiaEnemyName_surname_" + String(_loc9_)));
            _loc3_.fighterRight.typeMC = _loc4_;
            _loc3_.fightTurns = MafiaFightDataParser.parseFightTurns(_loc2_.turns);
            _loc3_.isLeftFighterWinner = _loc2_.winner == PBSide.LEFT;
            fights.push(_loc3_);
            super.fightersLeft.push(_loc3_.fighterLeft);
            super.fightersRight.push(_loc3_.fighterRight);
            this._survivalFightDataCounter++;
         }
      }
      
      public function remainingEnemies() : Vector.<FighterVO>
      {
         var _loc2_:MafiaFightResultData = null;
         var _loc1_:Vector.<FighterVO> = new Vector.<FighterVO>();
         for each(_loc2_ in fights)
         {
            _loc1_.push(_loc2_.fighterRight);
         }
         return _loc1_;
      }
      
      public function getNextEnemyType() : int
      {
         if(this.enemiesLeft == 1)
         {
            if(this.lastRound)
            {
               return ENEMY_LAST_BOSS;
            }
            return ENEMY_ROUND_BOSS;
         }
         return ENEMY_NORMAL;
      }
      
      public function getEnemyTypeByIndex(param1:int) : int
      {
         if(this.lastRound)
         {
            return ENEMY_LAST_BOSS;
         }
         if((param1 + 1) % SURVIVAL_OPPONENTS_IN_ONE_ROUND == 0)
         {
            return ENEMY_ROUND_BOSS;
         }
         return ENEMY_NORMAL;
      }
   }
}
