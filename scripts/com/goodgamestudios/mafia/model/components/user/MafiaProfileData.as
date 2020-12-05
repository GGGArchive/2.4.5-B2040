package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_UnlockLevel;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.constants.enums.FamilyRank;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBPlayerProfile;
   
   public class MafiaProfileData
   {
      
      public static const maxChanceResistance:Number = 40;
      
      public static const maxChanceLuck:Number = 50;
       
      
      public var name:String = "";
      
      private var _playerID:int;
      
      public var clanName:String;
      
      public var clanID:Number;
      
      public var rankInClan:FamilyRank;
      
      public var picString:String;
      
      public var gender:CharacterGender;
      
      public var characterClass:CharacterClass;
      
      public var isInClan:Boolean;
      
      public var level:Number = 1;
      
      private var _defense:int;
      
      public var attack:Number = 0;
      
      public var endurance:Number = 0;
      
      public var luck:Number = 0;
      
      public var toughness:Number = 0;
      
      public var damage:Number = 0;
      
      public var health:Number = 0;
      
      public var criticalHitChance:Number = 0;
      
      public var resistance:Number = 0;
      
      public var rankInHighScoreAlltime:Number = 0;
      
      public var rankInHighScoreDynamic:Number = 0;
      
      public var rankInHighScoreWeekly:Number = 0;
      
      public var rankInHighScoreMonthly:Number = 0;
      
      public var gloryAlltime:Number = 0;
      
      public var gloryDynamic:Number = 0;
      
      public var gloryWeekly:Number = 0;
      
      public var gloryMonthly:Number = 0;
      
      public var wonDuells:Number = 0;
      
      public var lostDuells:Number = 0;
      
      public var isIgnored:Boolean = false;
      
      public var city:City;
      
      public var avatarChangeFree:Boolean;
      
      public function MafiaProfileData()
      {
         super();
      }
      
      public function parseDataPB(param1:PBPlayerProfile) : MafiaProfileData
      {
         this.name = param1.name;
         this.clanName = param1.clanName;
         if(this.clanName == null)
         {
            this.clanName = "";
         }
         this.clanID = param1.clanId;
         if(this.clanID <= 0 || this.clanID == Constants_Basic.LOOKING_FOR_CLAN_ID)
         {
            this.isInClan = false;
         }
         else
         {
            this.isInClan = true;
         }
         this.rankInClan = ProtobufEnumTranslator.translateProtoFamilyRank(param1.rankInClan);
         this.gender = ProtobufEnumTranslator.translateProtoCharacterGender(param1.gender);
         this.picString = param1.picString;
         this.characterClass = ProtobufEnumTranslator.translateProtoCharacterClass(param1.characterClass);
         this.attack = param1.attributes.attack;
         this.endurance = param1.attributes.endurance;
         this.luck = param1.attributes.luck;
         this.toughness = param1.attributes.toughness;
         this.damage = param1.combatStats.damage;
         this.health = param1.combatStats.health;
         this.criticalHitChance = Math.round(param1.combatStats.criticalHitChance * 100) / 100;
         this.resistance = Math.round(param1.combatStats.resistance * 100) / 100;
         this.rankInHighScoreAlltime = param1.highscore.alltime.rank;
         this.rankInHighScoreDynamic = param1.highscore.dynamic.rank;
         this.gloryAlltime = param1.highscore.alltime.glory;
         this.gloryDynamic = param1.highscore.dynamic.glory;
         this.wonDuells = param1.wonDuels;
         this.lostDuells = param1.lostDuels;
         this.isIgnored = param1.isIgnored;
         this.level = param1.level;
         this.city = ProtobufEnumTranslator.translateProtoCity(param1.cityId);
         return this;
      }
      
      public function get isClanMember() : Boolean
      {
         return this.clanID > 0 && this.clanID < Constants_Basic.LOOKING_FOR_CLAN_ID;
      }
      
      public function get isLookingForClan() : Boolean
      {
         return this.clanID == Constants_Basic.LOOKING_FOR_CLAN_ID;
      }
      
      public function get playerID() : int
      {
         return this._playerID;
      }
      
      public function set playerID(param1:int) : void
      {
         this._playerID = param1;
      }
      
      public function get isDuelUnlocked() : Boolean
      {
         return this.level >= Constants_UnlockLevel.UNLOCK_DUEL;
      }
      
      public function get isSurvivalUnlocked() : Boolean
      {
         return this.level >= Constants_UnlockLevel.UNLOCK_SURVIVAL;
      }
      
      public function get isBoosterUnlocked() : Boolean
      {
         return this.level >= Constants_UnlockLevel.UNLOCK_BOOSTER;
      }
      
      public function get isEmailVerificationUnlocked() : Boolean
      {
         return this.level >= Constants_UnlockLevel.UNLOCK_EMAIL_VERIFICATION;
      }
      
      public function get isWorkUnlocked() : Boolean
      {
         return this.level >= Constants_UnlockLevel.UNLOCK_WORK;
      }
      
      public function get isBarkeeperUnlocked() : Boolean
      {
         return this.level >= Constants_UnlockLevel.UNLOCK_BARKEEPER;
      }
      
      public function get isSlotmachineUnlocked() : Boolean
      {
         return this.level >= Constants_UnlockLevel.UNLOCK_SLOTMACHINE;
      }
      
      public function get isFastQuitMissionUnlocked() : Boolean
      {
         return this.level >= Constants_UnlockLevel.UNLOCK_FAST_QUIT_MISSION;
      }
      
      public function get isWantedUnlocked() : Boolean
      {
         return this.level >= Constants_UnlockLevel.UNLOCK_WANTED;
      }
      
      public function get isClanCreationUnlocked() : Boolean
      {
         return this.level >= Constants_UnlockLevel.UNLOCK_CLAN_CREATION;
      }
      
      public function get isActivityGainingUnlocked() : Boolean
      {
         return this.level >= Constants_UnlockLevel.UNLOCK_AP_GAIN;
      }
      
      public function get isFirstDungeonUnlocked() : Boolean
      {
         return this.level >= Constants_UnlockLevel.UNLOCK_DUNGEON1;
      }
      
      public function get defense() : int
      {
         return this._defense;
      }
      
      public function set defense(param1:int) : void
      {
         this._defense = param1;
      }
   }
}
