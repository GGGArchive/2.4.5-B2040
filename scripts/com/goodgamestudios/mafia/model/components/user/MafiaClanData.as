package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.ChangeClanMemberType;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.FamilyBoosterQuality;
   import com.goodgamestudios.mafia.constants.enums.FamilyRank;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.ProtobufVOTranslator;
   import com.goodgamestudios.mafia.controller.commands.clan.ShowClanCommand;
   import com.goodgamestudios.mafia.controller.commands.clan.ShowClanWarCommand;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.controller.protobuf.family.PBFamilyMemberInfo;
   import com.goodgamestudios.mafia.controller.protobuf.family.PBFamilyProfile;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFamilyWarResult;
   import com.goodgamestudios.mafia.event.model.MafiaClanEvent;
   import com.goodgamestudios.mafia.event.panel.MafiaPanelEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.MafiaSocialData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaClanLevelUpDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaShowClanWarDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaClanLevelUpDialogProperties;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaShowClanWarDialogProperties;
   import com.goodgamestudios.mafia.vo.clan.ClanChatVO;
   import com.goodgamestudios.mafia.vo.clan.ClanMemberVO;
   import com.goodgamestudios.mafia.vo.clan.ClanStatusVO;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestPartVO;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class MafiaClanData
   {
      
      public static const CLAN_STATUS_UPDATE_LEVEL_UP:uint = 1;
      
      public static const CLAN_STATUS_UPDATE_ATTACK_WAR_STARTED:uint = 2;
      
      public static const CLAN_STATUS_UPDATE_ATTACK_CLANWAR_LOST:uint = 3;
      
      public static const CLAN_STATUS_UPDATE_ATTACK_CLANWAR_WON:uint = 4;
      
      public static const CLAN_STATUS_UPDATE_DEFEND_CLANWAR_STARTED:uint = 5;
      
      public static const CLAN_STATUS_UPDATE_DEFEND_CLANWAR_LOST:uint = 6;
      
      public static const CLAN_STATUS_UPDATE_DEFEND_CLANWAR_WON:uint = 7;
      
      public static const CLAN_STATUS_UPDATE_CLAN_KICKED:uint = 8;
      
      public static const FONT_COLOR_LOST_WAR:int = 13369344;
       
      
      public var members:Vector.<ClanMemberVO>;
      
      public var clanId:int;
      
      public var clanName:String;
      
      public var familyCrest:FamilyCrestVO;
      
      public var level:int;
      
      public var xp:Number;
      
      public var xpForThisLevel:Number;
      
      public var xpForNextLevel:Number;
      
      public var currency2:int;
      
      public var playerAttackClanWarStatus:Boolean;
      
      public var playerDefendClanWarStatus:Boolean;
      
      public var xpBoosterAmountForFamily:int;
      
      public var cashBoosterAmountForFamily:int;
      
      public var xpBoosterAmountForPlayer:int;
      
      public var cashBoosterAmountForPlayer:int;
      
      public var playerActivityPointsCollectedToday:int;
      
      public var playerActivityPointsCollectedYesterday:int;
      
      public var membersCount:int;
      
      public var maxMembers:int;
      
      public var increaseMaxMemberGoldCosts:int;
      
      public var gloryDynamic:Number;
      
      public var gloryAlltime:Number = 0;
      
      public var rankDynamic:Number;
      
      public var rankAlltime:Number = 0;
      
      private var _timeUntilDefending:Number = 0;
      
      public var defendTime:String = "";
      
      public var defendingAgainstClanName:String = "";
      
      public var defendingAgainstClanID:int;
      
      private var _timeUntilAttack:Number = 0;
      
      public var attackTime:String = "";
      
      public var attackingAnotherClanName:String = "";
      
      public var attackingAnotherClanID:int;
      
      public var xpBoosterQuality:FamilyBoosterQuality;
      
      private var xpBoosterEndtime:Number;
      
      public var xpBoosterEndtimeString:String = "";
      
      public var cashBoosterQuality:FamilyBoosterQuality;
      
      private var cashBoosterEndtime:Number;
      
      public var cashBoosterEndtimeString:String = "";
      
      public var boosterLowQualityGoldCost:int;
      
      public var boosterHighQualityGoldCost:int;
      
      public var availableFamilyCrestPrimaryParts:Vector.<FamilyCrestPartVO>;
      
      public var availableFamilyCrestSecondaryParts:Vector.<FamilyCrestPartVO>;
      
      public var availableFamilyCrestBanderoleParts:Vector.<FamilyCrestPartVO>;
      
      public var lastViewedClan:String = "";
      
      public var changeClanParams:Array;
      
      public var clanWar:MafiaClanWarData;
      
      public var chatMessages:Vector.<ClanChatVO>;
      
      public var statusMessages:Vector.<ClanChatVO>;
      
      public var bankMessages:Vector.<ClanChatVO>;
      
      public var serverTimeStamp:Number;
      
      public var clanStatusList:Vector.<ClanStatusVO>;
      
      private const CLAN_STATUS_UPDATE_CLAN_PROMOTE:uint = 9;
      
      private const CLAN_STATUS_UPDATE_CLAN_PROMOTED_TO_BOSS:uint = 10;
      
      private const CLAN_STATUS_UPDATE_CLAN_DEGRADED_TO_NORMAL:uint = 11;
      
      private const CLAN_STATUS_UPDATE_REGISTER_FOR_ATTACK:uint = 12;
      
      private const CLAN_STATUS_UPDATE_REGISTER_FOR_DEFENSE:uint = 13;
      
      private const CLAN_STATUS_UPDATE_MEMBER_JOIN:uint = 14;
      
      private const CLAN_STATUS_UPDATE_MEMBER_DONATE:uint = 15;
      
      private const CLAN_STATUS_UPDATE_MEMBER_LEFT:uint = 16;
      
      private const CLAN_STATUS_UPDATE_BOUGHT_CASH_BONUS:uint = 17;
      
      private const CLAN_STATUS_UPDATE_BOUGHT_XP_BONUS:uint = 18;
      
      private const CLAN_STATUS_UPDATE_BOUGHT_MAXMEMBERS:uint = 19;
      
      private const CLAN_STATUS_UPDATE_INVITE_PLAYER:uint = 20;
      
      private const CLAN_STATUS_UPDATE_CHAT_BANISH:uint = 21;
      
      private const CLAN_STATUS_UPDATE_CHAT_BAD_WORD:uint = 22;
      
      private const CLAN_STATUS_UPDATE_ATTACK_WAR_STARTED_SELF:uint = 23;
      
      private const CLAN_STATUS_UPDATE_BOUGHT_CRESTPARTS:uint = 24;
      
      private const FONT_COLOR_NORMAL:int = 4537640;
      
      private const FONT_COLOR_STATUS:int = 10027161;
      
      private const FONT_COLOR_WON_WAR:int = 52224;
      
      private const FONT_COLOR_START_WAR:int = 16760624;
      
      private const FONT_COLOR_BAD_CHAT:int = 16711884;
      
      private const MAX_BONUS_TIME:int = 604800;
      
      public var user:ClanMemberVO;
      
      public var pinboard_content:String;
      
      public var pinboard_lastChangedBy:String;
      
      public var pinboard_writeRights:Boolean = false;
      
      public function MafiaClanData()
      {
         this.members = new Vector.<ClanMemberVO>();
         super();
         this.chatMessages = new Vector.<ClanChatVO>();
         this.statusMessages = new Vector.<ClanChatVO>();
         this.bankMessages = new Vector.<ClanChatVO>();
      }
      
      public function get timeUntilDefending() : Number
      {
         return this._timeUntilDefending;
      }
      
      public function parseData(param1:PBFamilyProfile) : void
      {
         this.parseClanData(param1);
      }
      
      private function parseClanData(param1:PBFamilyProfile) : void
      {
         this.defendingAgainstClanName = "";
         this.defendingAgainstClanID = 0;
         this.attackingAnotherClanName = "";
         this.attackingAnotherClanID = 0;
         this._timeUntilDefending = 0;
         this.defendTime = "";
         this._timeUntilAttack = 0;
         this.attackTime = "";
         this.clanId = param1.id;
         this.clanName = param1.name;
         this.level = param1.progress.level;
         this.xp = param1.progress.xp;
         this.xpForThisLevel = param1.progress.xpForCurrentLevel;
         this.xpForNextLevel = param1.progress.xpForNextLevel;
         this.currency2 = param1.gold;
         this.maxMembers = param1.maxMember;
         this.increaseMaxMemberGoldCosts = param1.increaseMaxMemberGoldCosts;
         this.gloryAlltime = param1.highscore.alltime.glory;
         this.gloryDynamic = param1.highscore.dynamic.glory;
         this.rankAlltime = param1.highscore.alltime.rank;
         this.rankDynamic = param1.highscore.dynamic.rank;
         this._timeUntilDefending = 0;
         if(param1.defending != null)
         {
            if(param1.defending.timeLeft > 0)
            {
               this._timeUntilDefending = getTimer() + param1.defending.timeLeft * Constants_Basic.SEC2MILLISEC;
               this.defendTime = TimeStringHelper.getTimeToString((this._timeUntilDefending - getTimer()) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
            }
            this.defendingAgainstClanName = param1.defending.familyName;
            this.defendingAgainstClanID = param1.defending.familyId;
         }
         this._timeUntilAttack = 0;
         if(param1.attacking != null)
         {
            if(param1.attacking.timeLeft > 0)
            {
               this._timeUntilAttack = getTimer() + param1.attacking.timeLeft * Constants_Basic.SEC2MILLISEC;
               this.attackTime = TimeStringHelper.getTimeToString((this._timeUntilAttack - getTimer()) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
            }
            this.attackingAnotherClanName = param1.attacking.familyName;
            this.attackingAnotherClanID = param1.attacking.familyId;
         }
         this.playerActivityPointsCollectedToday = param1.playerActivityPointsToday;
         this.playerActivityPointsCollectedYesterday = param1.playerActivityPointsYesterday;
         this.xpBoosterEndtime = 0;
         if(param1.boosters.xp.endtime > 0)
         {
            this.xpBoosterEndtime = getTimer() + param1.boosters.xp.endtime * Constants_Basic.SEC2MILLISEC;
            this.xpBoosterEndtimeString = TimeStringHelper.getTimeToString((this.xpBoosterEndtime - getTimer()) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
         }
         this.xpBoosterQuality = ProtobufEnumTranslator.translateProtoFamilyBoosterQuality(param1.boosters.xp.quality);
         this.xpBoosterAmountForPlayer = param1.boosters.xp.percentagePlayer;
         this.xpBoosterAmountForFamily = param1.boosters.xp.percentageFamily;
         this.cashBoosterEndtime = 0;
         if(param1.boosters.cash.endtime > 0)
         {
            this.cashBoosterEndtime = getTimer() + param1.boosters.cash.endtime * Constants_Basic.SEC2MILLISEC;
            this.cashBoosterEndtimeString = TimeStringHelper.getTimeToString((this.cashBoosterEndtime - getTimer()) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
         }
         this.cashBoosterQuality = ProtobufEnumTranslator.translateProtoFamilyBoosterQuality(param1.boosters.cash.quality);
         this.cashBoosterAmountForPlayer = param1.boosters.cash.percentagePlayer;
         this.cashBoosterAmountForFamily = param1.boosters.cash.percentageFamily;
         this.boosterLowQualityGoldCost = param1.boosters.goldCostLow;
         this.boosterHighQualityGoldCost = param1.boosters.goldCostHigh;
         this.parseMembers(param1.member);
         this.familyCrest = ProtobufVOTranslator.translateProtoFamilyCrest(param1.crest);
      }
      
      private function parseMembers(param1:Array) : void
      {
         var _loc3_:PBFamilyMemberInfo = null;
         var _loc4_:ClanMemberVO = null;
         this.members = new Vector.<ClanMemberVO>();
         this.membersCount = param1.length;
         var _loc2_:uint = 0;
         while(_loc2_ < this.membersCount)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = new ClanMemberVO();
            _loc4_.playerID = _loc3_.id;
            _loc4_.rankInHighScore = _loc3_.rankHighscore;
            _loc4_.rankInClan = ProtobufEnumTranslator.translateProtoFamilyRank(_loc3_.rankFamily);
            _loc4_.name = _loc3_.name;
            _loc4_.characterClass = CharacterClass.getById(_loc3_.characterClass);
            _loc4_.level = _loc3_.level;
            _loc4_.donatedGold = _loc3_.donatedGold;
            _loc4_.attackParticipation = _loc3_.attackParticipation;
            _loc4_.defendParticipation = _loc3_.defendParticipation;
            _loc4_.activityPoints = _loc3_.activityPoints;
            _loc4_.activityPointsYesterday = _loc3_.yesterdayActivityPoints;
            _loc4_.isOnline = _loc3_.isOnline;
            _loc4_.clanID = this.clanId;
            if(_loc4_.playerID == MafiaModel.userData.playerID)
            {
               this.playerAttackClanWarStatus = _loc4_.attackParticipation;
               this.playerDefendClanWarStatus = _loc4_.defendParticipation;
               this.user = _loc4_;
            }
            this.members.push(_loc4_);
            _loc2_++;
         }
      }
      
      public function updateMember() : void
      {
         var _loc1_:int = this.changeClanParams[0];
         var _loc2_:ChangeClanMemberType = this.changeClanParams[1];
         if(_loc1_ == MafiaModel.userData.playerID)
         {
            if(_loc2_ == ChangeClanMemberType.kick)
            {
               this.chatMessages = new Vector.<ClanChatVO>();
               this.statusMessages = new Vector.<ClanChatVO>();
               this.bankMessages = new Vector.<ClanChatVO>();
               MafiaLayoutManager.getInstance().state = Constants_LayoutStates.STATE_PROFILE;
               BasicController.getInstance().dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_CLANMEMBER,[ChangeClanMemberType.kick]));
               return;
            }
            ShowClanCommand.sendCommand();
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this.members.length)
         {
            if(this.members[_loc3_].playerID == _loc1_)
            {
               if(_loc2_ == ChangeClanMemberType.kick)
               {
                  this.members.splice(_loc3_,1);
                  this.membersCount--;
               }
               else
               {
                  this.members[_loc3_].rankInClan = ProtobufEnumTranslator.translateChangeTypeToFamilyRank(_loc2_);
                  if(this.members[_loc3_].rankInClan == FamilyRank.Leader)
                  {
                     ShowClanCommand.sendCommand();
                  }
               }
               break;
            }
            _loc3_++;
         }
         BasicController.getInstance().dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_CLANMEMBER));
      }
      
      public function parseClanStatus(param1:String) : void
      {
         var _loc4_:Array = null;
         var _loc5_:ClanStatusVO = null;
         if(!param1)
         {
            return;
         }
         var _loc2_:Array = param1.split("#");
         _loc2_.pop();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = String(_loc2_[_loc3_]).split("+");
            _loc5_ = new ClanStatusVO();
            _loc5_.id = _loc4_.shift();
            _loc5_.value = _loc4_.shift();
            if(_loc4_.length > 0)
            {
               _loc5_.clanId = _loc4_.shift();
            }
            switch(_loc5_.id)
            {
               case MafiaClanData.CLAN_STATUS_UPDATE_LEVEL_UP:
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaClanLevelUpDialog.NAME,new MafiaClanLevelUpDialogProperties(MafiaModel.languageData.getTextById("MafiaLevelUpDialog_title"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_familyfeeds_3",[_loc5_.value]),MafiaModel.languageData.getTextById("generic_btn_share"),MafiaModel.languageData.getTextById("generic_btn_okay"),this.feedClanLevelUp,null),true,BasicDialogHandler.PRIORITY_MIDDLE);
                  break;
               case MafiaClanData.CLAN_STATUS_UPDATE_ATTACK_WAR_STARTED:
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaFamilyDialog_title_familywar"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_chatnotif_23",[_loc5_.value]),this.showClan),true,BasicDialogHandler.PRIORITY_MIDDLE);
                  break;
               case MafiaClanData.CLAN_STATUS_UPDATE_DEFEND_CLANWAR_STARTED:
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaFamilyDialog_title_familywar"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_chatnotif_5",[_loc5_.value]),this.showClan),true,BasicDialogHandler.PRIORITY_MIDDLE);
                  break;
               case MafiaClanData.CLAN_STATUS_UPDATE_ATTACK_CLANWAR_WON:
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaShowClanWarDialog.NAME,new MafiaShowClanWarDialogProperties(MafiaModel.languageData.getTextById("MafiaFamilyDialog_title_familywar"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_familyfeeds_7",[_loc5_.value]),1,_loc5_.clanId,-1,this.showClanWar,null,null,MafiaModel.languageData.getTextById("MafiaMailScreen_btn_view"),MafiaModel.languageData.getTextById("generic_btn_okay")),true,BasicDialogHandler.PRIORITY_MIDDLE);
                  break;
               case MafiaClanData.CLAN_STATUS_UPDATE_DEFEND_CLANWAR_WON:
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaShowClanWarDialog.NAME,new MafiaShowClanWarDialogProperties(MafiaModel.languageData.getTextById("MafiaFamilyDialog_title_familywar"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_familyfeeds_5",[_loc5_.value]),2,_loc5_.clanId,-1,this.showClanWar,null,null,MafiaModel.languageData.getTextById("MafiaMailScreen_btn_view"),MafiaModel.languageData.getTextById("generic_btn_okay")),true,BasicDialogHandler.PRIORITY_MIDDLE);
                  break;
               case MafiaClanData.CLAN_STATUS_UPDATE_ATTACK_CLANWAR_LOST:
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaShowClanWarDialog.NAME,new MafiaShowClanWarDialogProperties(MafiaModel.languageData.getTextById("MafiaFamilyDialog_title_familywar"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_familyfeeds_8",[_loc5_.value]),1,_loc5_.clanId,-1,this.showClanWar,null,null,MafiaModel.languageData.getTextById("MafiaMailScreen_btn_view"),MafiaModel.languageData.getTextById("generic_btn_okay")),true,BasicDialogHandler.PRIORITY_MIDDLE);
                  break;
               case MafiaClanData.CLAN_STATUS_UPDATE_DEFEND_CLANWAR_LOST:
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaShowClanWarDialog.NAME,new MafiaShowClanWarDialogProperties(MafiaModel.languageData.getTextById("MafiaFamilyDialog_title_familywar"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_familyfeeds_6",[_loc5_.value]),2,_loc5_.clanId,-1,this.showClanWar,null,null,MafiaModel.languageData.getTextById("MafiaMailScreen_btn_view"),MafiaModel.languageData.getTextById("generic_btn_okay")),true,BasicDialogHandler.PRIORITY_MIDDLE);
                  break;
               case MafiaClanData.CLAN_STATUS_UPDATE_CLAN_KICKED:
                  MafiaModel.userData.userClan = new MafiaClanData();
                  this.toProfile();
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaFamilyDialog_title_familynotif"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_8",[_loc5_.value]),null),true,BasicDialogHandler.PRIORITY_MIDDLE);
            }
            _loc3_++;
         }
      }
      
      private function toProfile() : void
      {
         BasicLayoutManager.getInstance().state = Constants_LayoutStates.STATE_PROFILE;
      }
      
      public function parseAvailableCrestParts(param1:Vector.<FamilyCrestPartVO>) : void
      {
         var _loc2_:FamilyCrestPartVO = null;
         this.availableFamilyCrestPrimaryParts = new Vector.<FamilyCrestPartVO>();
         this.availableFamilyCrestSecondaryParts = new Vector.<FamilyCrestPartVO>();
         this.availableFamilyCrestBanderoleParts = new Vector.<FamilyCrestPartVO>();
         for each(_loc2_ in param1)
         {
            switch(_loc2_.category)
            {
               case 3:
                  this.availableFamilyCrestPrimaryParts.push(_loc2_);
                  continue;
               case 2:
                  this.availableFamilyCrestSecondaryParts.push(_loc2_);
                  continue;
               case 1:
                  this.availableFamilyCrestBanderoleParts.push(_loc2_);
                  continue;
               default:
                  continue;
            }
         }
      }
      
      private function feedClanLevelUp(param1:Object = null) : void
      {
         MafiaModel.socialData.postFeed(MafiaSocialData.EXTERNAL_SHARE_LEVELUP_CLAN,[MafiaModel.userData.userClan.level,MafiaModel.userData.profileData.clanName]);
      }
      
      private function showClanWar(param1:Array) : void
      {
         MafiaDialogHandler.getInstance().blockDialogs = true;
         var _loc2_:int = param1[0];
         var _loc3_:int = param1[1];
         var _loc4_:Number = param1[2];
         ShowClanWarCommand.sendCommand(_loc2_,_loc3_,_loc4_);
         MafiaLayoutManager.getInstance().state = Constants_LayoutStates.STATE_CLAN_FIGHT;
      }
      
      private function showClan(param1:int) : void
      {
         MafiaLayoutManager.getInstance().state = Constants_LayoutStates.STATE_USERCLAN;
         ShowClanCommand.sendCommand();
      }
      
      public function parseClanWar(param1:PBFamilyWarResult) : void
      {
         this.clanWar = new MafiaClanWarData(param1);
         BasicController.getInstance().dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_CLANWARDATA));
      }
      
      public function checkTimes(param1:Number) : void
      {
         var _loc2_:Array = new Array();
         if(this.defendingAgainstClanID > 0)
         {
            if(param1 >= this._timeUntilDefending)
            {
               this.defendingAgainstClanID = 0;
               ShowClanCommand.sendCommand();
            }
            _loc2_[0] = this.defendingAgainstClanName + "\n" + TimeStringHelper.getTimeToString((this._timeUntilDefending - param1) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
            BasicController.getInstance().dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_ATTACKCLANWARTIME,_loc2_));
         }
         if(this.attackingAnotherClanID > 0)
         {
            if(param1 >= this._timeUntilAttack)
            {
               this.attackingAnotherClanID = 0;
               ShowClanCommand.sendCommand();
            }
            _loc2_[0] = this.attackingAnotherClanName + "\n" + TimeStringHelper.getTimeToString((this._timeUntilAttack - param1) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
            BasicController.getInstance().dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_DEFENDCLANWARTIME,_loc2_));
         }
         if(this.xpBoosterQuality != FamilyBoosterQuality.None)
         {
            if(param1 >= this.xpBoosterEndtime)
            {
               this.xpBoosterQuality = FamilyBoosterQuality.None;
               ShowClanCommand.sendCommand();
            }
            _loc2_[0] = TimeStringHelper.getTimeToString((this.xpBoosterEndtime - param1) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
            _loc2_[1] = this.xpBoosterEndtime * Constants_Basic.MILLISEC2SEC / this.MAX_BONUS_TIME;
            BasicController.getInstance().dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_TEMPBOOSTERXPTIME,_loc2_));
         }
         if(this.cashBoosterQuality != FamilyBoosterQuality.None)
         {
            if(param1 >= this.cashBoosterEndtime)
            {
               this.cashBoosterQuality = FamilyBoosterQuality.None;
               ShowClanCommand.sendCommand();
            }
            _loc2_[0] = TimeStringHelper.getTimeToString((this.cashBoosterEndtime - param1) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
            _loc2_[1] = this.cashBoosterEndtime * Constants_Basic.MILLISEC2SEC / this.MAX_BONUS_TIME;
            BasicController.getInstance().dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_TEMPBOOSTERC1TIME,_loc2_));
         }
      }
      
      public function parseChatData(param1:int, param2:Array) : void
      {
         var _loc6_:ClanChatVO = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc13_:int = 0;
         var _loc3_:Date = new Date();
         var _loc4_:Number = Math.round(_loc3_.getTime() / 1000);
         this.serverTimeStamp = param1;
         var _loc5_:uint = 0;
         while(_loc5_ < param2.length)
         {
            if(param2[_loc5_] != "")
            {
               _loc6_ = new ClanChatVO();
               if(BasicLanguageFontManager.getInstance().useDefaultFont)
               {
                  BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc6_.nameText.txt_msg);
                  BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc6_.msgText.txt_msg);
               }
               else
               {
                  _loc6_.nameText.txt_msg.embedFonts = false;
                  _loc6_.msgText.txt_msg.embedFonts = false;
               }
               if(param2[_loc5_].hasOwnProperty("senderName"))
               {
                  _loc7_ = param2[_loc5_].senderName;
                  _loc8_ = param2[_loc5_].senderId;
               }
               _loc9_ = param2[_loc5_].date;
               _loc6_.date = _loc9_;
               _loc10_ = TimeStringHelper.getDateToString((_loc4_ - (this.serverTimeStamp - _loc9_)) * Constants_Basic.SEC2MILLISEC,TimeStringHelper.DATE_TIMEOCLOCK_FORMAT_ADVANCED,MafiaModel.languageData.getTextById);
               _loc6_.playerID = _loc8_;
               _loc11_ = param2[_loc5_].text;
               _loc11_ = _loc11_.replace(/&percnt /g,"%");
               _loc11_ = _loc11_.replace(/&percnt;/g,"%");
               if(_loc11_.indexOf("$") == -1)
               {
                  _loc6_.msgText.txt_msg.text = _loc11_;
                  _loc6_.msgText.txt_msg.selectable = true;
                  _loc6_.msgText.txt_msg.mouseEnabled = true;
                  _loc6_.nameText.txt_msg.text = "[" + _loc10_ + "]" + _loc7_ + ":";
                  if(_loc7_ != MafiaModel.userData.profileData.name && param2.length == 1 && MafiaLayoutManager.getInstance().actState != Constants_LayoutStates.STATE_USERCLAN)
                  {
                     BasicController.getInstance().dispatchEvent(new MafiaPanelEvent(MafiaPanelEvent.CHAT_INPUT,[_loc7_]));
                  }
                  this.chatMessages.push(_loc6_);
               }
               else
               {
                  _loc12_ = _loc11_.split("$");
                  if(String(_loc12_[0]).length == 0)
                  {
                     _loc12_.shift();
                  }
                  _loc13_ = _loc12_.shift();
                  switch(_loc13_)
                  {
                     case this.CLAN_STATUS_UPDATE_CHAT_BANISH:
                        _loc6_.msgText.txt_msg.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_chatnotif_21");
                        _loc6_.msgText.txt_msg.textColor = this.FONT_COLOR_BAD_CHAT;
                        _loc6_.nameText.txt_msg.text = "[" + _loc10_ + "] " + MafiaModel.languageData.getTextById("MafiaRankingScreen_text_status") + ":";
                        this.chatMessages.push(_loc6_);
                        break;
                     case this.CLAN_STATUS_UPDATE_CHAT_BAD_WORD:
                        _loc6_.msgText.txt_msg.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_chatnotif_22");
                        _loc6_.msgText.txt_msg.textColor = this.FONT_COLOR_BAD_CHAT;
                        _loc6_.nameText.txt_msg.text = "[" + _loc10_ + "] " + MafiaModel.languageData.getTextById("MafiaRankingScreen_text_status") + ":";
                        this.chatMessages.push(_loc6_);
                  }
               }
            }
            _loc5_++;
         }
         BasicController.getInstance().dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_FAMILY_MESSAGE));
      }
      
      public function parseAccountHistory(param1:int, param2:Array) : void
      {
         var _loc6_:ClanChatVO = null;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:Array = null;
         var _loc12_:int = 0;
         var _loc3_:Date = new Date();
         var _loc4_:Number = Math.round(_loc3_.getTime() / 1000);
         this.serverTimeStamp = param1;
         var _loc5_:uint = 0;
         while(_loc5_ < param2.length)
         {
            if(param2[_loc5_] != "")
            {
               _loc6_ = new ClanChatVO();
               if(BasicLanguageFontManager.getInstance().useDefaultFont)
               {
                  BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc6_.nameText.txt_msg);
                  BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc6_.msgText.txt_msg);
               }
               else
               {
                  _loc6_.nameText.txt_msg.embedFonts = false;
                  _loc6_.msgText.txt_msg.embedFonts = false;
               }
               _loc7_ = param2[_loc5_].date;
               _loc6_.date = _loc7_;
               _loc8_ = TimeStringHelper.getDateToString((_loc4_ - (this.serverTimeStamp - _loc7_)) * Constants_Basic.SEC2MILLISEC,TimeStringHelper.DATE_TIMEOCLOCK_FORMAT_ADVANCED,MafiaModel.languageData.getTextById);
               _loc9_ = TimeStringHelper.getDateToString((_loc4_ - (this.serverTimeStamp - _loc7_)) * Constants_Basic.SEC2MILLISEC,TimeStringHelper.DATE_DAY_FORMAT,MafiaModel.languageData.getTextById);
               _loc10_ = param2[_loc5_].text;
               _loc10_ = _loc10_.replace(/&percnt;/g,"%");
               _loc11_ = _loc10_.split("$");
               if(String(_loc11_[0]).length == 0)
               {
                  _loc11_.shift();
               }
               _loc12_ = _loc11_.shift();
               switch(_loc12_)
               {
                  case this.CLAN_STATUS_UPDATE_BOUGHT_CASH_BONUS:
                  case this.CLAN_STATUS_UPDATE_BOUGHT_XP_BONUS:
                  case this.CLAN_STATUS_UPDATE_BOUGHT_MAXMEMBERS:
                  case this.CLAN_STATUS_UPDATE_MEMBER_DONATE:
                  case this.CLAN_STATUS_UPDATE_BOUGHT_CRESTPARTS:
                     _loc6_.msgText.txt_msg.text = this.addStatusMessage(_loc12_,_loc11_);
                     _loc6_.nameText.txt_msg.text = _loc9_ + " " + _loc8_;
                     if(_loc12_ == this.CLAN_STATUS_UPDATE_MEMBER_DONATE)
                     {
                        _loc6_.msgText.txt_msg.textColor = FONT_COLOR_LOST_WAR;
                     }
                     this.bankMessages.push(_loc6_);
               }
            }
            _loc5_++;
         }
         BasicController.getInstance().dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_FAMILY_ACCOUNT));
      }
      
      public function parseFamilyNotification(param1:int, param2:Array) : void
      {
         var _loc6_:ClanChatVO = null;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc3_:Date = new Date();
         var _loc4_:Number = Math.round(_loc3_.getTime() / 1000);
         this.serverTimeStamp = param1;
         var _loc5_:uint = 0;
         while(_loc5_ < param2.length)
         {
            if(param2[_loc5_] != "")
            {
               _loc6_ = new ClanChatVO();
               if(BasicLanguageFontManager.getInstance().useDefaultFont)
               {
                  BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc6_.nameText.txt_msg);
                  BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc6_.msgText.txt_msg);
               }
               else
               {
                  _loc6_.nameText.txt_msg.embedFonts = false;
                  _loc6_.msgText.txt_msg.embedFonts = false;
               }
               _loc7_ = param2[_loc5_].date;
               _loc6_.date = _loc7_;
               _loc8_ = TimeStringHelper.getDateToString((_loc4_ - (this.serverTimeStamp - _loc7_)) * Constants_Basic.SEC2MILLISEC,TimeStringHelper.DATE_TIMEOCLOCK_FORMAT_ADVANCED,MafiaModel.languageData.getTextById);
               _loc9_ = param2[_loc5_].text;
               _loc9_ = _loc9_.replace(/&percnt;/g,"%");
               _loc10_ = _loc9_.split("$");
               if(String(_loc10_[0]).length == 0)
               {
                  _loc10_.shift();
               }
               _loc11_ = _loc10_.shift();
               switch(_loc11_)
               {
                  case CLAN_STATUS_UPDATE_ATTACK_CLANWAR_WON:
                  case CLAN_STATUS_UPDATE_DEFEND_CLANWAR_WON:
                     _loc6_.isWar = true;
                     _loc6_.msgText.txt_msg.text = this.addStatusMessage(_loc11_,_loc10_);
                     _loc6_.msgText.txt_msg.textColor = this.FONT_COLOR_WON_WAR;
                     _loc6_.msgText.properties = [_loc11_ == CLAN_STATUS_UPDATE_DEFEND_CLANWAR_WON?2:1,_loc10_[1],_loc6_.date];
                     _loc6_.msgText.addEventListener(MouseEvent.CLICK,this.onClickWar);
                     _loc6_.msgText.addEventListener(MouseEvent.MOUSE_OVER,this.onOverWar);
                     _loc6_.msgText.addEventListener(MouseEvent.MOUSE_OUT,this.onOutWar);
                     _loc6_.nameText.txt_msg.text = "[" + _loc8_ + "] " + MafiaModel.languageData.getTextById("MafiaRankingScreen_text_status") + ":";
                     this.statusMessages.push(_loc6_);
                     break;
                  case CLAN_STATUS_UPDATE_ATTACK_CLANWAR_LOST:
                  case CLAN_STATUS_UPDATE_DEFEND_CLANWAR_LOST:
                     _loc6_.isWar = true;
                     _loc6_.msgText.txt_msg.text = this.addStatusMessage(_loc11_,_loc10_);
                     _loc6_.msgText.txt_msg.textColor = FONT_COLOR_LOST_WAR;
                     _loc6_.msgText.properties = [_loc11_ == CLAN_STATUS_UPDATE_ATTACK_CLANWAR_LOST?1:2,_loc10_[1],_loc6_.date];
                     _loc6_.msgText.addEventListener(MouseEvent.CLICK,this.onClickWar);
                     _loc6_.msgText.addEventListener(MouseEvent.MOUSE_OVER,this.onOverWar);
                     _loc6_.msgText.addEventListener(MouseEvent.MOUSE_OUT,this.onOutWar);
                     _loc6_.nameText.txt_msg.text = "[" + _loc8_ + "] " + MafiaModel.languageData.getTextById("MafiaRankingScreen_text_status") + ":";
                     this.statusMessages.push(_loc6_);
                     break;
                  case CLAN_STATUS_UPDATE_ATTACK_WAR_STARTED:
                     _loc6_.msgText.txt_msg.text = this.addStatusMessage(_loc11_,_loc10_);
                     _loc6_.msgText.txt_msg.textColor = this.FONT_COLOR_START_WAR;
                     _loc6_.nameText.txt_msg.text = "[" + _loc8_ + "] " + MafiaModel.languageData.getTextById("MafiaRankingScreen_text_status") + ":";
                     this.statusMessages.push(_loc6_);
                     break;
                  case CLAN_STATUS_UPDATE_DEFEND_CLANWAR_STARTED:
                     _loc6_.msgText.txt_msg.text = this.addStatusMessage(_loc11_,_loc10_);
                     _loc6_.msgText.txt_msg.textColor = this.FONT_COLOR_START_WAR;
                     _loc6_.nameText.txt_msg.text = "[" + _loc8_ + "] " + MafiaModel.languageData.getTextById("MafiaRankingScreen_text_status") + ":";
                     this.statusMessages.push(_loc6_);
                     break;
                  case CLAN_STATUS_UPDATE_LEVEL_UP:
                     _loc6_.msgText.txt_msg.text = this.addStatusMessage(_loc11_,_loc10_);
                     _loc6_.msgText.txt_msg.textColor = this.FONT_COLOR_STATUS;
                     _loc6_.nameText.txt_msg.text = "[" + _loc8_ + "] " + MafiaModel.languageData.getTextById("MafiaRankingScreen_text_status") + ":";
                     this.statusMessages.push(_loc6_);
                     break;
                  case CLAN_STATUS_UPDATE_CLAN_KICKED:
                  case this.CLAN_STATUS_UPDATE_CLAN_PROMOTE:
                  case this.CLAN_STATUS_UPDATE_CLAN_DEGRADED_TO_NORMAL:
                     _loc6_.msgText.txt_msg.text = this.addStatusMessage(_loc11_,_loc10_);
                     _loc6_.msgText.txt_msg.textColor = this.FONT_COLOR_STATUS;
                     _loc6_.nameText.txt_msg.text = "[" + _loc8_ + "] " + MafiaModel.languageData.getTextById("MafiaRankingScreen_text_status") + ":";
                     this.statusMessages.push(_loc6_);
                     if(_loc10_[1] == MafiaModel.userData.profileData.name)
                     {
                        if(param2.length == 1)
                        {
                           PlayerProfileCommand.sendCommand(MafiaModel.userData.playerID,false);
                        }
                        if(_loc11_ == CLAN_STATUS_UPDATE_CLAN_KICKED)
                        {
                           this.chatMessages = new Vector.<ClanChatVO>();
                           this.statusMessages = new Vector.<ClanChatVO>();
                           this.clanStatusList = new Vector.<ClanStatusVO>();
                        }
                     }
                     break;
                  case this.CLAN_STATUS_UPDATE_CLAN_PROMOTED_TO_BOSS:
                  case this.CLAN_STATUS_UPDATE_REGISTER_FOR_ATTACK:
                  case this.CLAN_STATUS_UPDATE_REGISTER_FOR_DEFENSE:
                  case this.CLAN_STATUS_UPDATE_MEMBER_JOIN:
                  case this.CLAN_STATUS_UPDATE_MEMBER_LEFT:
                  case this.CLAN_STATUS_UPDATE_INVITE_PLAYER:
                     _loc6_.msgText.txt_msg.text = this.addStatusMessage(_loc11_,_loc10_);
                     _loc6_.msgText.txt_msg.textColor = this.FONT_COLOR_STATUS;
                     _loc6_.nameText.txt_msg.text = "[" + _loc8_ + "] " + MafiaModel.languageData.getTextById("MafiaRankingScreen_text_status") + ":";
                     this.statusMessages.push(_loc6_);
               }
            }
            _loc5_++;
         }
         BasicController.getInstance().dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_FAMILY_NOTIFICATION));
      }
      
      public function get defendClanWarTimeInSecond() : Number
      {
         return this._timeUntilAttack;
      }
      
      private function onClickWar(param1:MouseEvent) : void
      {
         MafiaDialogHandler.getInstance().blockDialogs = true;
         var _loc2_:int = param1.currentTarget.properties[0];
         var _loc3_:int = param1.currentTarget.properties[1];
         var _loc4_:Number = param1.currentTarget.properties[2];
         ShowClanWarCommand.sendCommand(_loc2_,_loc3_,_loc4_);
         MafiaLayoutManager.getInstance().state = Constants_LayoutStates.STATE_CLAN_FIGHT;
      }
      
      private function onOverWar(param1:MouseEvent) : void
      {
         MafiaLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
      }
      
      private function onOutWar(param1:MouseEvent) : void
      {
         MafiaLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      private function addStatusMessage(param1:int, param2:Array = null) : String
      {
         var _loc3_:String = MafiaModel.languageData.getTextById("MafiaFamilyScreen_chatnotif_" + String(param1),param2);
         return _loc3_;
      }
      
      public function parsePinboardData(param1:String, param2:String, param3:Boolean) : void
      {
         if(param1)
         {
            this.pinboard_content = param1;
         }
         if(param2 != "")
         {
            this.pinboard_lastChangedBy = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_21",[param2]);
         }
         else
         {
            this.pinboard_lastChangedBy = "";
         }
         this.pinboard_writeRights = param3;
         BasicController.getInstance().dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_PINBOARDDATA));
      }
   }
}
