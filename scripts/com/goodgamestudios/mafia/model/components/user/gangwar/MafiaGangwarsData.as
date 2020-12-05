package com.goodgamestudios.mafia.model.components.user.gangwar
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Avatarparts;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.constants.enums.CityFightProgress;
   import com.goodgamestudios.mafia.constants.enums.QuestAndFightProgress;
   import com.goodgamestudios.mafia.constants.enums.QuestStatus;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.commands.gangwars.SDOCommand;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBSide;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.response.PBGangwarShowGangWarsGangWar;
   import com.goodgamestudios.mafia.event.model.MafiaGangwarEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightDataParser;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.model.components.user.quest.MafiaQuestData;
   import com.goodgamestudios.mafia.vo.FighterVO;
   import com.goodgamestudios.mafia.vo.RewardVO;
   import com.goodgamestudios.mafia.vo.avatar.AvatarVO;
   import com.goodgamestudios.mafia.vo.gangwar.GangwarOpponentVO;
   import com.goodgamestudios.mafia.vo.gangwar.GangwarVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class MafiaGangwarsData
   {
       
      
      public var city:City;
      
      public var gangwars:Vector.<GangwarVO>;
      
      public var gangwarOpponents:Vector.<GangwarOpponentVO>;
      
      public var recruitedFriends:int;
      
      public var nextFreeGangwarFightTime:Number = 0;
      
      public var gangwarProgress:int = 0;
      
      public var bestDungeonOpponent:int = 0;
      
      public var currentGangwarID:int;
      
      public var reward:RewardVO;
      
      public var gangwarFightWon:Boolean = false;
      
      private var _wasInitialised:Boolean;
      
      public var gangwarResultData:MafiaFightResultData;
      
      private var lastUpdate:int = 0;
      
      public function MafiaGangwarsData()
      {
         super();
         this._wasInitialised = false;
      }
      
      public function parseData(param1:Array, param2:int, param3:uint) : void
      {
         var _loc5_:PBGangwarShowGangWarsGangWar = null;
         var _loc6_:GangwarVO = null;
         var _loc7_:FighterVO = null;
         this._wasInitialised = true;
         this.city = ProtobufEnumTranslator.translateProtoCity(param2);
         this.recruitedFriends = param3;
         this.gangwars = new Vector.<GangwarVO>();
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_] as PBGangwarShowGangWarsGangWar;
            _loc6_ = new GangwarVO();
            _loc7_ = new FighterVO();
            _loc6_.district_id = _loc5_.districtId;
            _loc6_.playerProgress = _loc5_.playerProgress;
            _loc6_.minRecruitedFriends = _loc5_.minFriends;
            _loc6_.minLevel = _loc5_.minLevel;
            _loc6_.unlockPriceC2 = _loc5_.unlockPrice;
            _loc6_.nextChallengeLevel = _loc5_.nextChallengeLevel;
            _loc6_.nextChallengeClass = ProtobufEnumTranslator.translateProtoCharacterClass(_loc5_.nextChallengeClass);
            _loc6_.cityFightProgress = ProtobufEnumTranslator.translateProtoCityFightProgress(_loc5_.cityFightProgress);
            if(_loc5_.hasCityQuest)
            {
               _loc6_.cityQuest = MafiaQuestData.parseQuest(_loc5_.cityQuest);
            }
            if(_loc5_.hasCityFighterLevel)
            {
               _loc6_.cityFighterLevel = _loc5_.cityFighterLevel;
            }
            if(_loc5_.hasCityFighterClass)
            {
               _loc6_.cityFighterClass = ProtobufEnumTranslator.translateProtoCharacterClass(_loc5_.cityFighterClass);
            }
            if(_loc5_.hasCityQuest)
            {
               if(_loc6_.cityQuest.questStatus != QuestStatus.Finished)
               {
                  switch(_loc6_.cityQuest.questStatus)
                  {
                     case QuestStatus.Locked:
                        _loc6_.questAndFightProgress = QuestAndFightProgress.AvailableQuest;
                        break;
                     case QuestStatus.Active:
                        _loc6_.questAndFightProgress = QuestAndFightProgress.ActiveQuest;
                        break;
                     case QuestStatus.Paused:
                        _loc6_.questAndFightProgress = QuestAndFightProgress.PausedQuest;
                        break;
                     default:
                        _loc6_.questAndFightProgress = QuestAndFightProgress.AvailableQuest;
                  }
               }
               if(_loc6_.cityQuest.questStatus == QuestStatus.Finished)
               {
                  switch(_loc6_.cityFightProgress)
                  {
                     case CityFightProgress.FightUnavailable:
                        _loc6_.questAndFightProgress = QuestAndFightProgress.UnavailableQuest;
                        break;
                     case CityFightProgress.FightAvailable:
                        _loc6_.questAndFightProgress = QuestAndFightProgress.FightAvailable;
                        break;
                     case CityFightProgress.FightWon:
                        _loc6_.questAndFightProgress = QuestAndFightProgress.FightVictory;
                        break;
                     case CityFightProgress.Reward_taken:
                        _loc6_.questAndFightProgress = QuestAndFightProgress.RewardTaken;
                        break;
                     default:
                        _loc6_.questAndFightProgress = QuestAndFightProgress.UnavailableQuest;
                  }
               }
            }
            if(this.gangwars.length > 0 && this.gangwars[_loc4_ - 1].playerProgress >= 0 && _loc6_.playerProgress == -1)
            {
               _loc6_.lockAndHasToolTip = true;
               if(MafiaModel.userData.profileData.level >= _loc6_.minLevel)
               {
                  _loc6_.unlockable = true;
               }
            }
            this.gangwars.push(_loc6_);
            _loc4_++;
         }
         BasicController.getInstance().dispatchEvent(new MafiaGangwarEvent(MafiaGangwarEvent.CHANGE_GANGWAR_DATA));
      }
      
      public function parseGangwarData(param1:Array) : void
      {
         var _loc4_:Array = null;
         var _loc5_:GangwarOpponentVO = null;
         var _loc6_:Class = null;
         var _loc7_:AvatarVO = null;
         param1.shift();
         if(param1[0] > 0)
         {
            this.nextFreeGangwarFightTime = getTimer() + parseInt(param1.shift()) * Constants_Basic.SEC2MILLISEC;
         }
         else
         {
            param1.shift();
            this.nextFreeGangwarFightTime = 0;
         }
         this.gangwarProgress = param1.shift();
         this.gangwarOpponents = new Vector.<GangwarOpponentVO>();
         var _loc2_:Array = String(param1.shift()).split("#");
         _loc2_.pop();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = String(_loc2_[_loc3_]).split("+");
            _loc5_ = new GangwarOpponentVO();
            _loc5_.picID = _loc4_.shift();
            _loc5_.nameID = _loc4_.shift();
            _loc5_.opponentLevel = _loc4_.shift();
            _loc5_.gender = CharacterGender.getById(int(_loc4_.shift()));
            switch(MafiaModel.userData.profileData.city)
            {
               case City.Miami:
               case City.NewYork:
                  _loc6_ = getDefinitionByName("Enemy" + _loc5_.picID) as Class;
                  _loc5_.picMC = new _loc6_();
                  break;
               case City.Hongkong:
                  _loc5_.picID--;
                  _loc7_ = AvatarHelper.createAvatarVOFromString(_loc5_.gender == CharacterGender.Male?Constants_Avatarparts.RANDOM_ASIAN_MALE_CHARACTERS[_loc5_.picID]:Constants_Avatarparts.RANDOM_ASIAN_FEMALE_CHARACTERS[_loc5_.picID]);
                  _loc5_.picMC = AvatarHelper.createAvatar(_loc7_,0.28,false,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
            }
            this.gangwarOpponents.push(_loc5_);
            _loc3_++;
         }
         BasicController.getInstance().dispatchEvent(new MafiaGangwarEvent(MafiaGangwarEvent.CHANGE_GANGWAR_OPPONENT_DATA,[this.gangwarOpponents,this.gangwarProgress]));
      }
      
      public function checkGangwarTime(param1:Number) : void
      {
         var _loc2_:Array = new Array();
         _loc2_.push(TimeStringHelper.getShortTimeString(this.nextFreeGangwarFightTime - param1));
         _loc2_.push(this.gangwarProgress);
         BasicController.getInstance().dispatchEvent(new MafiaGangwarEvent(MafiaGangwarEvent.CHANGE_GANGWAR_TIMER,_loc2_));
         if(param1 > this.nextFreeGangwarFightTime)
         {
            SDOCommand.sendCommand(this.currentGangwarID);
         }
         if(getTimer() > this.lastUpdate + 1000)
         {
            this.lastUpdate = getTimer();
         }
      }
      
      public function parseGangwarResultData(param1:PBFight, param2:PBReward) : void
      {
         var _loc3_:Class = null;
         var _loc4_:AvatarVO = null;
         this.gangwarResultData = new MafiaFightResultData();
         this.gangwarResultData.fighterLeft = MafiaFightDataParser.parseFighter(param1.leftFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.gangwarResultData.fighterRight = MafiaFightDataParser.parseFighter(param1.rightFighter,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
         this.reward = MafiaFightDataParser.parseReward(param2);
         switch(MafiaModel.userData.profileData.city)
         {
            case City.Miami:
            case City.NewYork:
               _loc3_ = getDefinitionByName("Enemy" + this.gangwarResultData.fighterRight.id) as Class;
               this.gangwarResultData.fighterRight.typeMC = new _loc3_();
               this.gangwarResultData.fighterRight.typeMC.scaleX = this.gangwarResultData.fighterRight.typeMC.scaleY = Constants_ViewScales.SCALE_GANGWAR_PICS_IN_FIGHT;
               this.gangwarResultData.fighterRight.name = MafiaModel.languageData.getTextById("MafiaGangwarfare_Enemy_" + this.gangwarOpponents[this.gangwarProgress].nameID);
               break;
            case City.Hongkong:
               this.gangwarResultData.fighterRight.id = this.gangwarResultData.fighterRight.id - 1;
               _loc4_ = AvatarHelper.createAvatarVOFromString(this.gangwarResultData.fighterRight.gender == CharacterGender.Male?Constants_Avatarparts.RANDOM_ASIAN_MALE_CHARACTERS[int(this.gangwarResultData.fighterRight.id)]:Constants_Avatarparts.RANDOM_ASIAN_FEMALE_CHARACTERS[int(this.gangwarResultData.fighterRight.id)]);
               this.gangwarResultData.fighterRight.typeMC = AvatarHelper.createAvatar(_loc4_,Constants_ViewScales.SCALE_NEW_AVATARPICS_IN_FIGHT,false,Constants_ViewScales.SCALE_AVATARBACKGROUND_IN_FIGHT);
               this.gangwarResultData.fighterRight.name = MafiaModel.languageData.getTextById("MafiaGangwarfare_Enemy_2_" + this.gangwarOpponents[this.gangwarProgress].nameID);
         }
         this.gangwarResultData.fightTurns = MafiaFightDataParser.parseFightTurns(param1.turns);
         this.gangwarResultData.isLeftFighterWinner = param1.winner == PBSide.LEFT;
      }
      
      public function get wasInitialized() : Boolean
      {
         return this._wasInitialised;
      }
   }
}
