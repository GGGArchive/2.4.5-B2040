package com.goodgamestudios.mafia.model.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBPlayerProfile;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewgear.PBEquipmentViewGearResponse;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.MafiaAddFriendData;
   import com.goodgamestudios.mafia.model.components.user.MafiaArmamentData;
   import com.goodgamestudios.mafia.model.components.user.MafiaAttributeCostsData;
   import com.goodgamestudios.mafia.model.components.user.MafiaClanData;
   import com.goodgamestudios.mafia.model.components.user.MafiaExtrasShopData;
   import com.goodgamestudios.mafia.model.components.user.MafiaFeatureStatusData;
   import com.goodgamestudios.mafia.model.components.user.MafiaInventoryData;
   import com.goodgamestudios.mafia.model.components.user.MafiaLoginFeatureData;
   import com.goodgamestudios.mafia.model.components.user.MafiaMailVerificationData;
   import com.goodgamestudios.mafia.model.components.user.MafiaMessageData;
   import com.goodgamestudios.mafia.model.components.user.MafiaNewAchievementData;
   import com.goodgamestudios.mafia.model.components.user.MafiaNotificationData;
   import com.goodgamestudios.mafia.model.components.user.MafiaPoliceData;
   import com.goodgamestudios.mafia.model.components.user.MafiaPreCombatData;
   import com.goodgamestudios.mafia.model.components.user.MafiaProgressData;
   import com.goodgamestudios.mafia.model.components.user.MafiaShopData;
   import com.goodgamestudios.mafia.model.components.user.MafiaSpecialOfferData;
   import com.goodgamestudios.mafia.model.components.user.MafiaUnlockedAssetsData;
   import com.goodgamestudios.mafia.model.components.user.MafiaUserData;
   import com.goodgamestudios.mafia.model.components.user.MafiaWelcomeData;
   import com.goodgamestudios.mafia.model.components.user.booster.MafiaBoosterShopData;
   import com.goodgamestudios.mafia.model.components.user.duel.MafiaDuelData;
   import com.goodgamestudios.mafia.model.components.user.gangwar.MafiaGangwarsData;
   import com.goodgamestudios.mafia.model.components.user.mission.MafiaMissionData;
   import com.goodgamestudios.mafia.model.components.user.quest.MafiaCityQuestFightData;
   import com.goodgamestudios.mafia.model.components.user.quest.MafiaQuestData;
   import com.goodgamestudios.mafia.model.components.user.ranking.MafiaFamilyRankingData;
   import com.goodgamestudios.mafia.model.components.user.ranking.MafiaPlayerRankingData;
   import com.goodgamestudios.mafia.model.components.user.travels.MafiaTravelsData;
   import com.goodgamestudios.mafia.model.components.user.work.MafiaWorkData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class MafiaOwnUserData extends MafiaUserData
   {
       
      
      private var _cash:Number;
      
      private var _gold:Number;
      
      private var _isPayUser:Boolean;
      
      private var _paymentDoppler:int;
      
      public var userAP:int;
      
      public var playerRankingData:MafiaPlayerRankingData;
      
      public var familyRankingData:MafiaFamilyRankingData;
      
      public var workData:MafiaWorkData;
      
      public var progressData:MafiaProgressData;
      
      public var attributsCostsData:MafiaAttributeCostsData;
      
      public var inventory:MafiaInventoryData;
      
      public var weaponShop:MafiaShopData;
      
      public var kioskShop:MafiaShopData;
      
      public var consumablesShop:MafiaShopData;
      
      public var breakingTheLawShop:MafiaShopData;
      
      public var boosterShop:MafiaBoosterShopData;
      
      public var tournamentShop:MafiaShopData;
      
      public var extrasShop:MafiaExtrasShopData;
      
      public var missionData:MafiaMissionData;
      
      public var questData:MafiaQuestData;
      
      public var cityQuestFightData:MafiaCityQuestFightData;
      
      public var messageData:MafiaMessageData;
      
      public var duelData:MafiaDuelData;
      
      public var newAchievements:MafiaNewAchievementData;
      
      public var notificationsData:MafiaNotificationData;
      
      public var welcomeData:MafiaWelcomeData;
      
      public var userClan:MafiaClanData;
      
      public var otherClan:MafiaClanData;
      
      public var gangwarData:MafiaGangwarsData;
      
      public var offerData:MafiaSpecialOfferData;
      
      public var featureData:MafiaLoginFeatureData;
      
      public var mailVerification:MafiaMailVerificationData;
      
      public var addFriendData:MafiaAddFriendData;
      
      public var unlockedAssetsData:MafiaUnlockedAssetsData;
      
      public var travelsData:MafiaTravelsData;
      
      public var policeData:MafiaPoliceData;
      
      public var preCombatData:MafiaPreCombatData;
      
      public var featureStatusData:MafiaFeatureStatusData;
      
      private var _appRuntime:Number = 0;
      
      private var _status:int;
      
      public var emailVerified:Boolean;
      
      public var cryptedForumLoginData:String;
      
      private var nextupdatetime:Number = 0;
      
      public var allItemsLocked:Boolean = false;
      
      private const ITEM_LOCK_TIMEOUT:int = 30000;
      
      private var allItemsLockedTimer:Timer;
      
      public var allItemsLockedTimedOut:Boolean = false;
      
      public function MafiaOwnUserData()
      {
         super();
         this.playerRankingData = new MafiaPlayerRankingData();
         this.familyRankingData = new MafiaFamilyRankingData();
         this.attributsCostsData = new MafiaAttributeCostsData();
         this.progressData = new MafiaProgressData();
         this.inventory = new MafiaInventoryData();
         armament = new MafiaArmamentData();
         this.consumablesShop = new MafiaShopData();
         this.breakingTheLawShop = new MafiaShopData();
         this.weaponShop = new MafiaShopData();
         this.kioskShop = new MafiaShopData();
         this.boosterShop = new MafiaBoosterShopData();
         this.tournamentShop = new MafiaShopData();
         this.extrasShop = new MafiaExtrasShopData();
         this.missionData = new MafiaMissionData();
         this.questData = new MafiaQuestData();
         this.cityQuestFightData = new MafiaCityQuestFightData();
         this.workData = new MafiaWorkData();
         this.messageData = new MafiaMessageData();
         this.newAchievements = new MafiaNewAchievementData();
         this.notificationsData = new MafiaNotificationData();
         this.welcomeData = new MafiaWelcomeData();
         this.duelData = new MafiaDuelData();
         this.userClan = new MafiaClanData();
         this.otherClan = new MafiaClanData();
         this.gangwarData = new MafiaGangwarsData();
         this.offerData = new MafiaSpecialOfferData();
         this.featureData = new MafiaLoginFeatureData();
         this.mailVerification = new MafiaMailVerificationData();
         this.addFriendData = new MafiaAddFriendData();
         this.unlockedAssetsData = new MafiaUnlockedAssetsData();
         this.travelsData = new MafiaTravelsData();
         this.policeData = new MafiaPoliceData();
         this.preCombatData = new MafiaPreCombatData();
         this.featureStatusData = new MafiaFeatureStatusData();
         this.allItemsLockedTimer = new Timer(this.ITEM_LOCK_TIMEOUT);
         this.allItemsLockedTimer.addEventListener(TimerEvent.TIMER,this.onItemLockTimeout);
      }
      
      protected function onItemLockTimeout(param1:TimerEvent) : void
      {
         this.allItemsLockedTimedOut = true;
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_ITEM_RESPONSE_TIMEOUT,[]);
      }
      
      override public function parseUserData(param1:Array) : void
      {
         param1.shift();
         param1.shift();
         var _loc2_:Array = String(param1).split("+");
         this.userAP = _loc2_.shift();
         this.missionData.parseNextEnergyUpdateTime(_loc2_[7],_loc2_[6]);
         super.parseUserData(_loc2_);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.INIT_USERDATA));
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_DATA));
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA));
      }
      
      override public function parseProfileDataPB(param1:PBPlayerProfile) : void
      {
         super.parseProfileDataPB(param1);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA));
      }
      
      override public function parseBoosterData(param1:Array) : void
      {
         super.parseBoosterData(param1);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_BOOSTER_DATA));
      }
      
      public function parseAchievementData(param1:Array) : void
      {
         achievementsData.parseData(param1);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_ACHIEVEMENT_DATA));
      }
      
      override public function parseGearDataPB(param1:PBEquipmentViewGearResponse) : void
      {
         gearData.parseDataPB(param1,profileData);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_GEAR_DATA));
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA));
      }
      
      override public function parseFoodDataPB(param1:Array) : void
      {
         super.parseFoodDataPB(param1);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_FOOD_DATA));
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA));
      }
      
      public function parsePingData(param1:Array) : void
      {
         var _loc2_:City = null;
         param1.shift();
         this.status = param1.shift();
         var _loc3_:int = param1.shift();
         switch(_loc3_)
         {
            case City.NewYork.index:
               _loc2_ = City.NewYork;
               break;
            case City.Miami.index:
               _loc2_ = City.Miami;
               break;
            case City.Hongkong.index:
               _loc2_ = City.Hongkong;
               break;
            case City.Sicily.index:
               _loc2_ = City.Sicily;
         }
         this.gangwarData.city = _loc2_;
         var _loc4_:Array = String(param1.shift()).split("+");
         var _loc5_:int = _loc4_[0];
         var _loc6_:int = _loc4_[1];
         var _loc7_:int = _loc4_[2];
         var _loc8_:int = _loc4_[3];
         this.progressData.parseData(_loc5_,_loc6_,_loc7_,_loc8_);
         this.messageData.parseNewMessages(param1.shift());
         this.policeData.parseStatusData(param1.shift());
         if(param1[0] > 0)
         {
            this.duelData.pvpData.nextFreeDuelFightTime = getTimer() + parseInt(param1.shift()) * Constants_Basic.SEC2MILLISEC;
         }
         else
         {
            param1.shift();
            this.duelData.pvpData.nextFreeDuelFightTime = 0;
         }
         this.userClan.parseClanStatus(param1.shift());
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_PING_DATA));
      }
      
      public function update(param1:Number) : void
      {
         if(param1 > this.nextupdatetime)
         {
            this.nextupdatetime = param1 + Constants_Basic.DATA_UPDATE_DELAY;
            if(this.missionData.nextEnergyUpdateTime > 0)
            {
               this.missionData.checkEnergyUpdateTime(param1);
            }
            if(this.gangwarData.nextFreeGangwarFightTime > 0)
            {
               this.gangwarData.checkGangwarTime(param1);
            }
            this.duelData.update(param1);
            if(this.playerRankingData.listUpdateTimeInSeconds > 0)
            {
               this.playerRankingData.checkRankingUpdateTime(param1);
            }
            if(this.familyRankingData.listUpdateTimeInSeconds > 0)
            {
               this.familyRankingData.checkRankingUpdateTime(param1);
            }
            if(foodData.food)
            {
               foodData.checkFoodTime(param1);
            }
            if(boosterData.boosterID > 0)
            {
               boosterData.checkBoosterTime(param1);
            }
            if(this.progressData && this.progressData.duration > 0)
            {
               this.progressData.checkProgress(param1,this.status);
            }
            if(this.policeData)
            {
               this.policeData.checkTimes();
            }
            if(this.userClan)
            {
               this.userClan.checkTimes(param1);
            }
            if(this.offerData.offer)
            {
               this.offerData.checkOfferTime(param1);
            }
            if(this.offerData.offer && this.offerData.offer.offerID > 0)
            {
               this.offerData.checkGoldShineTime(param1);
            }
            if(this.messageData.nextMailRefreshTime > 0)
            {
               this.messageData.checkNextMailRefreshTime(param1);
            }
            if(this.weaponShop.newFreeItemsTime > 0)
            {
               this.weaponShop.checkNewItemsTime(param1);
            }
            if(this.kioskShop.newFreeItemsTime > 0)
            {
               this.kioskShop.checkNewItemsTime(param1);
            }
            if(this.consumablesShop.newFreeItemsTime > 0)
            {
               this.consumablesShop.checkNewItemsTime(param1);
            }
            if(this.extrasShop.newFreeItemsTime > 0)
            {
               this.extrasShop.checkNewItemsTime(param1);
            }
            if(this.featureStatusData.activeFeatures)
            {
               this.featureStatusData.checkFeatureStatusTime(param1);
            }
            if(gangData.playerGang && gangData.playerGang.length > 0)
            {
               gangData.checkPlayerGangMemberTime(param1);
            }
            if(MafiaLayoutManager.getInstance().isIngameState)
            {
               this.mailVerification.checkReminderTime(param1);
            }
            MafiaDialogHandler.getInstance().showDialog(param1);
         }
         MafiaModel.tipData.update(param1);
      }
      
      public function lockAllItems() : void
      {
         if(!this.allItemsLocked)
         {
            this.allItemsLockedTimer.start();
            this.allItemsLocked = true;
            BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.ITEMS_LOCKED));
         }
      }
      
      public function unlockAllItems() : void
      {
         if(this.allItemsLocked)
         {
            this.allItemsLockedTimer.reset();
            this.allItemsLocked = false;
            this.allItemsLockedTimedOut = false;
            BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.ITEMS_UNLOCKED));
         }
      }
      
      public function get appRuntime() : Number
      {
         return this._appRuntime;
      }
      
      public function set appRuntime(param1:Number) : void
      {
         this._appRuntime = param1;
      }
      
      public function get status() : int
      {
         return this._status;
      }
      
      public function set status(param1:int) : void
      {
         this._status = param1;
      }
      
      public function get cash() : Number
      {
         return this._cash;
      }
      
      public function get gold() : Number
      {
         return this._gold;
      }
      
      public function set gold(param1:Number) : void
      {
         this._gold = param1;
      }
      
      public function set cash(param1:Number) : void
      {
         this._cash = param1;
      }
      
      public function get isPayUser() : Boolean
      {
         return this._isPayUser;
      }
      
      public function set isPayUser(param1:Boolean) : void
      {
         this._isPayUser = param1;
      }
      
      public function get paymentDoppler() : int
      {
         return this._paymentDoppler;
      }
      
      public function set paymentDoppler(param1:int) : void
      {
         this._paymentDoppler = param1;
      }
      
      public function get hasPaymentDoppler() : Boolean
      {
         return this._paymentDoppler > 0;
      }
   }
}
