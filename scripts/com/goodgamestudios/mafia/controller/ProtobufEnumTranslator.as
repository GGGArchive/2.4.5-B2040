package com.goodgamestudios.mafia.controller
{
   import com.goodgamestudios.mafia.constants.enums.ChangeClanMemberType;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.constants.enums.CityFightProgress;
   import com.goodgamestudios.mafia.constants.enums.ConsumableType;
   import com.goodgamestudios.mafia.constants.enums.ExtraType;
   import com.goodgamestudios.mafia.constants.enums.FamilyBoosterQuality;
   import com.goodgamestudios.mafia.constants.enums.FamilyRank;
   import com.goodgamestudios.mafia.constants.enums.FeatureType;
   import com.goodgamestudios.mafia.constants.enums.FighterState;
   import com.goodgamestudios.mafia.constants.enums.GearType;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemQuality;
   import com.goodgamestudios.mafia.constants.enums.ItemSubtype;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.MessageType;
   import com.goodgamestudios.mafia.constants.enums.PlayerTournamentStatus;
   import com.goodgamestudios.mafia.constants.enums.QuestStatus;
   import com.goodgamestudios.mafia.constants.enums.QuestType;
   import com.goodgamestudios.mafia.constants.enums.RankingListType;
   import com.goodgamestudios.mafia.constants.enums.WeaponType;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCharacterClass;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCity;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBConsumableType;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBExtraType;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBFamilyRank;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBGearType;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBGender;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBShopType;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBWeaponType;
   import com.goodgamestudios.mafia.controller.protobuf.common.item.PBItemQuality;
   import com.goodgamestudios.mafia.controller.protobuf.common.item.PBItemType;
   import com.goodgamestudios.mafia.controller.protobuf.family.PBFamilyBoosterQuality;
   import com.goodgamestudios.mafia.controller.protobuf.family.changefamilymemberstatus.request.PBFamilyChangeFamilyMemberStatusChangeType;
   import com.goodgamestudios.mafia.controller.protobuf.featurestatus.getfeaturestatus.response.PBFeaturestatusGetFeatureStatusFeature;
   import com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.response.PBGangwarShowGangWarsCityFightProgress;
   import com.goodgamestudios.mafia.controller.protobuf.messages.PBMessageType;
   import com.goodgamestudios.mafia.controller.protobuf.quest.PBQuestStatus;
   import com.goodgamestudios.mafia.controller.protobuf.quest.PBQuestType;
   import com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PBRankingRankingSearchListType;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.searchtournamentplayer.response.PBSpecialeventTournamentSearchtournamentplayerStatus;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.response.PBSpecialeventTournamentShowTournamentFinalsState;
   import com.goodgamestudios.mafia.controller.protobuf.tournaments.PBFighterState;
   import com.goodgamestudios.mafia.vo.tournament.TournamentFinalFightVO;
   
   public class ProtobufEnumTranslator
   {
       
      
      public function ProtobufEnumTranslator()
      {
         super();
      }
      
      public static function translateProtoCharacterGender(param1:int) : CharacterGender
      {
         var _loc2_:CharacterGender = null;
         switch(param1)
         {
            case PBGender.MALE:
               _loc2_ = CharacterGender.Male;
               break;
            case PBGender.FEMALE:
               _loc2_ = CharacterGender.Female;
               break;
            default:
               _loc2_ = CharacterGender.None;
         }
         return _loc2_;
      }
      
      public static function translateCharacterGenderToProto(param1:CharacterGender) : int
      {
         return param1.index;
      }
      
      public static function translateProtoCharacterClass(param1:int) : CharacterClass
      {
         var _loc2_:CharacterClass = null;
         switch(param1)
         {
            case PBCharacterClass.BULLY:
               _loc2_ = CharacterClass.Bully;
               break;
            case PBCharacterClass.ROGUE:
               _loc2_ = CharacterClass.Rogue;
               break;
            case PBCharacterClass.TACTICIAN:
               _loc2_ = CharacterClass.Tactician;
               break;
            default:
               _loc2_ = CharacterClass.None;
         }
         return _loc2_;
      }
      
      public static function translateCharacterClassToProto(param1:CharacterClass) : int
      {
         return param1.index;
      }
      
      public static function translateProtoItemQuality(param1:int) : ItemQuality
      {
         var _loc2_:ItemQuality = null;
         switch(param1)
         {
            case PBItemQuality.NORMAL:
               _loc2_ = ItemQuality.Normal;
               break;
            case PBItemQuality.PREMIUM:
               _loc2_ = ItemQuality.Premium;
               break;
            case PBItemQuality.EPIC:
               _loc2_ = ItemQuality.Epic;
               break;
            case PBItemQuality.LEGENDARY:
               _loc2_ = ItemQuality.Legendary;
               break;
            default:
               _loc2_ = ItemQuality.None;
         }
         return _loc2_;
      }
      
      public static function translateProtoItemType(param1:int) : ItemType
      {
         var _loc2_:ItemType = null;
         switch(param1)
         {
            case PBItemType.ACCESSORY:
               _loc2_ = ItemType.Accessory;
               break;
            case PBItemType.CONSUMABLE:
               _loc2_ = ItemType.Consumable;
               break;
            case PBItemType.FOOD:
               _loc2_ = ItemType.Food;
               break;
            case PBItemType.GEAR:
               _loc2_ = ItemType.Gear;
               break;
            case PBItemType.SKILL:
               _loc2_ = ItemType.Skill;
               break;
            case PBItemType.WEAPON:
               _loc2_ = ItemType.Weapon;
               break;
            case PBItemType.EXTRA:
               _loc2_ = ItemType.Extra;
               break;
            default:
               _loc2_ = ItemType.None;
         }
         return _loc2_;
      }
      
      public static function translateProtoItemSubtype(param1:ItemType, param2:int) : ItemSubtype
      {
         var _loc3_:ItemSubtype = null;
         switch(param1)
         {
            case ItemType.Gear:
               switch(param2)
               {
                  case PBGearType.VEHICLE:
                     _loc3_ = GearType.Vehicle;
                     break;
                  case PBGearType.HOUSE:
                     _loc3_ = GearType.House;
                     break;
                  case PBGearType.PET:
                     _loc3_ = GearType.Pet;
                     break;
                  case PBGearType.LUXURY:
                     _loc3_ = GearType.Luxury;
                     break;
                  case PBGearType.BODYGUARD:
                     _loc3_ = GearType.Bodyguard;
                     break;
                  case PBGearType.ACCESSORY:
                     _loc3_ = GearType.Accessory;
                     break;
                  case PBGearType.TATTOO:
                     _loc3_ = GearType.Tattoo;
                     break;
                  case PBGearType.LUCKYCHARM:
                     _loc3_ = GearType.LuckyCharm;
                     break;
                  default:
                     _loc3_ = ItemSubtype.None;
               }
               return _loc3_;
            case ItemType.Weapon:
               switch(param2)
               {
                  case PBWeaponType.PISTOL:
                     _loc3_ = WeaponType.Pistol;
                     break;
                  case PBWeaponType.SMG:
                     _loc3_ = WeaponType.Smg;
                     break;
                  case PBWeaponType.SHOTGUN:
                     _loc3_ = WeaponType.Shotgun;
                     break;
                  case PBWeaponType.ASSAULT:
                     _loc3_ = WeaponType.Assault;
                     break;
                  case PBWeaponType.SNIPER:
                     _loc3_ = WeaponType.Sniper;
                     break;
                  case PBWeaponType.ANY:
                     _loc3_ = WeaponType.Any;
                     break;
                  default:
                     _loc3_ = ItemSubtype.None;
               }
               return _loc3_;
            case ItemType.Consumable:
               switch(param2)
               {
                  case PBConsumableType.AMMUNITION:
                     _loc3_ = ConsumableType.Ammunition;
                     break;
                  case PBConsumableType.SURPRISE:
                     _loc3_ = ConsumableType.Surprise;
                     break;
                  case PBConsumableType.HEALING:
                     _loc3_ = ConsumableType.Healing;
                     break;
                  case PBConsumableType.ACTION:
                     _loc3_ = ConsumableType.Action;
                     break;
                  default:
                     _loc3_ = ItemSubtype.None;
               }
               return _loc3_;
            case ItemType.Extra:
               switch(param2)
               {
                  case PBExtraType.CONTAINER:
                     _loc3_ = ExtraType.Container;
                     break;
                  default:
                     _loc3_ = ItemSubtype.None;
               }
               return _loc3_;
            default:
               return ItemSubtype.None;
         }
      }
      
      public static function translateProtoShopLocation(param1:uint) : ItemLocation
      {
         var _loc2_:ItemLocation = null;
         switch(param1)
         {
            case PBShopType.BLACK_MARKET:
               _loc2_ = ItemLocation.ShopBlackMarket;
               break;
            case PBShopType.KIOSK:
               _loc2_ = ItemLocation.ShopKiosk;
               break;
            case PBShopType.CONSUMABLES:
               _loc2_ = ItemLocation.ShopConsumables;
               break;
            case PBShopType.POLICE:
               _loc2_ = ItemLocation.ShopBreakingTheLaw;
               break;
            case PBShopType.EXTRAS:
               _loc2_ = ItemLocation.ShopExtras;
               break;
            case PBShopType.TOURNAMENT:
               _loc2_ = ItemLocation.ShopTournament;
               break;
            default:
               trace("trying to map unknown protobuf shop type to a client location!");
               _loc2_ = ItemLocation.None;
         }
         return _loc2_;
      }
      
      public static function translateShopLocationToProto(param1:ItemLocation) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case ItemLocation.ShopBlackMarket:
               _loc2_ = PBShopType.BLACK_MARKET;
               break;
            case ItemLocation.ShopKiosk:
               _loc2_ = PBShopType.KIOSK;
               break;
            case ItemLocation.ShopConsumables:
               _loc2_ = PBShopType.CONSUMABLES;
               break;
            case ItemLocation.ShopBreakingTheLaw:
               _loc2_ = PBShopType.POLICE;
               break;
            case ItemLocation.ShopExtras:
               _loc2_ = PBShopType.EXTRAS;
               break;
            case ItemLocation.ShopTournament:
               _loc2_ = PBShopType.TOURNAMENT;
               break;
            default:
               trace("trying to map a non-shop location to a protobuf shop type!");
               _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public static function translateProtoFamilyBoosterQuality(param1:int) : FamilyBoosterQuality
      {
         var _loc2_:FamilyBoosterQuality = null;
         switch(param1)
         {
            case PBFamilyBoosterQuality.LOW:
               _loc2_ = FamilyBoosterQuality.Low;
               break;
            case PBFamilyBoosterQuality.HIGH:
               _loc2_ = FamilyBoosterQuality.High;
               break;
            case PBFamilyBoosterQuality.NONE:
            default:
               _loc2_ = FamilyBoosterQuality.None;
         }
         return _loc2_;
      }
      
      public static function translateFamilyBoosterQualityToProto(param1:FamilyBoosterQuality) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case FamilyBoosterQuality.Low:
               _loc2_ = PBFamilyBoosterQuality.LOW;
               break;
            case FamilyBoosterQuality.High:
               _loc2_ = PBFamilyBoosterQuality.HIGH;
               break;
            case FamilyBoosterQuality.None:
            default:
               _loc2_ = PBFamilyBoosterQuality.NONE;
         }
         return _loc2_;
      }
      
      public static function translateProtoFamilyRank(param1:int) : FamilyRank
      {
         var _loc2_:FamilyRank = null;
         switch(param1)
         {
            case PBFamilyRank.LEADER:
               _loc2_ = FamilyRank.Leader;
               break;
            case PBFamilyRank.ASSISTANT:
               _loc2_ = FamilyRank.Assistant;
               break;
            case PBFamilyRank.OFFICER:
               _loc2_ = FamilyRank.Officer;
               break;
            case PBFamilyRank.MEMBER:
               _loc2_ = FamilyRank.Member;
               break;
            case PBFamilyRank.NONE:
            default:
               _loc2_ = FamilyRank.None;
         }
         return _loc2_;
      }
      
      public static function translateFamilyRankToProto(param1:FamilyRank) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case FamilyRank.None:
               _loc2_ = PBFamilyRank.NONE;
               break;
            case FamilyRank.Leader:
               _loc2_ = PBFamilyRank.LEADER;
               break;
            case FamilyRank.Assistant:
               _loc2_ = PBFamilyRank.ASSISTANT;
               break;
            case FamilyRank.Officer:
               _loc2_ = PBFamilyRank.OFFICER;
               break;
            case FamilyRank.Member:
               _loc2_ = PBFamilyRank.MEMBER;
               break;
            default:
               _loc2_ = PBFamilyRank.NONE;
         }
         return _loc2_;
      }
      
      public static function translateProtoRankingListType(param1:int) : RankingListType
      {
         var _loc2_:RankingListType = null;
         switch(param1)
         {
            case PBRankingRankingSearchListType.PLAYER_DYNAMIC:
               _loc2_ = RankingListType.PlayerDynamic;
               break;
            case PBRankingRankingSearchListType.PLAYER_ALLTIME:
               _loc2_ = RankingListType.PlayerAlltime;
               break;
            case PBRankingRankingSearchListType.FAMILY_DYNAMIC:
               _loc2_ = RankingListType.FamilyDynamic;
               break;
            case PBRankingRankingSearchListType.FAMILY_ALLTIME:
               _loc2_ = RankingListType.FamilyAlltime;
               break;
            default:
               _loc2_ = RankingListType.None;
         }
         return _loc2_;
      }
      
      public static function translateRankingListTypeToProto(param1:RankingListType) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case RankingListType.PlayerDynamic:
               _loc2_ = PBRankingRankingSearchListType.PLAYER_DYNAMIC;
               break;
            case RankingListType.PlayerAlltime:
               _loc2_ = PBRankingRankingSearchListType.PLAYER_ALLTIME;
               break;
            case RankingListType.FamilyDynamic:
               _loc2_ = PBRankingRankingSearchListType.FAMILY_DYNAMIC;
               break;
            case RankingListType.FamilyAlltime:
               _loc2_ = PBRankingRankingSearchListType.FAMILY_ALLTIME;
               break;
            default:
               _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public static function translateChangeTypeToProto(param1:ChangeClanMemberType) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case ChangeClanMemberType.kick:
               _loc2_ = PBFamilyChangeFamilyMemberStatusChangeType.KICK;
               break;
            case ChangeClanMemberType.leader:
               _loc2_ = PBFamilyChangeFamilyMemberStatusChangeType.MAKE_LEADER;
               break;
            case ChangeClanMemberType.assistant:
               _loc2_ = PBFamilyChangeFamilyMemberStatusChangeType.MAKE_ASSISTANT;
               break;
            case ChangeClanMemberType.officer:
               _loc2_ = PBFamilyChangeFamilyMemberStatusChangeType.MAKE_OFFICER;
               break;
            case ChangeClanMemberType.normal:
               _loc2_ = PBFamilyChangeFamilyMemberStatusChangeType.MAKE_NORMAL;
               break;
            default:
               _loc2_ = PBFamilyChangeFamilyMemberStatusChangeType.KICK;
         }
         return _loc2_;
      }
      
      public static function translateCityToProto(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case City.NewYork.index:
               _loc2_ = PBCity.NEW_YORK;
               break;
            case City.Miami.index:
               _loc2_ = PBCity.MIAMI;
               break;
            case City.Hongkong.index:
               _loc2_ = PBCity.HONG_KONG;
               break;
            case City.Sicily.index:
               _loc2_ = PBCity.CITY_EVENT;
         }
         return _loc2_;
      }
      
      public static function translateChangeTypeToFamilyRank(param1:ChangeClanMemberType) : FamilyRank
      {
         var _loc2_:FamilyRank = null;
         switch(param1)
         {
            case ChangeClanMemberType.kick:
               _loc2_ = FamilyRank.None;
               break;
            case ChangeClanMemberType.leader:
               _loc2_ = FamilyRank.Leader;
               break;
            case ChangeClanMemberType.assistant:
               _loc2_ = FamilyRank.Assistant;
               break;
            case ChangeClanMemberType.officer:
               _loc2_ = FamilyRank.Officer;
               break;
            case ChangeClanMemberType.normal:
               _loc2_ = FamilyRank.Member;
               break;
            default:
               _loc2_ = FamilyRank.None;
         }
         return _loc2_;
      }
      
      public static function translateProtoQuestType(param1:int) : QuestType
      {
         var _loc2_:QuestType = null;
         switch(param1)
         {
            case PBQuestType.CITY_QUEST:
               _loc2_ = QuestType.CityQuest;
               break;
            case PBQuestType.CITY_UNLOCK_QUEST:
               _loc2_ = QuestType.CityUnlockQuest;
               break;
            case PBQuestType.GUIDING_QUEST:
               _loc2_ = QuestType.GuidingQuest;
               break;
            default:
               _loc2_ = QuestType.None;
         }
         return _loc2_;
      }
      
      public static function translateProtoCity(param1:int) : City
      {
         var _loc2_:City = null;
         switch(param1)
         {
            case PBCity.NEW_YORK:
               _loc2_ = City.NewYork;
               break;
            case PBCity.MIAMI:
               _loc2_ = City.Miami;
               break;
            case PBCity.HONG_KONG:
               _loc2_ = City.Hongkong;
               break;
            case PBCity.CITY_EVENT:
               _loc2_ = City.Sicily;
               break;
            default:
               _loc2_ = City.None;
         }
         return _loc2_;
      }
      
      public static function translateProtoCityFightProgress(param1:int) : CityFightProgress
      {
         var _loc2_:CityFightProgress = null;
         switch(param1)
         {
            case PBGangwarShowGangWarsCityFightProgress.FIGHT_UNAVAILABLE:
               _loc2_ = CityFightProgress.FightUnavailable;
               break;
            case PBGangwarShowGangWarsCityFightProgress.FIGHT_AVAILABLE:
               _loc2_ = CityFightProgress.FightAvailable;
               break;
            case PBGangwarShowGangWarsCityFightProgress.FIGHT_WON:
               _loc2_ = CityFightProgress.FightWon;
               break;
            case PBGangwarShowGangWarsCityFightProgress.REWARD_TAKEN:
               _loc2_ = CityFightProgress.Reward_taken;
               break;
            default:
               _loc2_ = CityFightProgress.FightUnavailable;
         }
         return _loc2_;
      }
      
      public static function translateProtoQuestStatus(param1:int) : QuestStatus
      {
         var _loc2_:QuestStatus = null;
         switch(param1)
         {
            case PBQuestStatus.LOCKED:
               _loc2_ = QuestStatus.Locked;
               break;
            case PBQuestStatus.ACTIVE:
               _loc2_ = QuestStatus.Active;
               break;
            case PBQuestStatus.PAUSED:
               _loc2_ = QuestStatus.Paused;
               break;
            case PBQuestStatus.FINISHED:
               _loc2_ = QuestStatus.Finished;
               break;
            default:
               _loc2_ = QuestStatus.Locked;
         }
         return _loc2_;
      }
      
      public static function translateProtoMessageType(param1:int) : MessageType
      {
         var _loc2_:MessageType = null;
         switch(param1)
         {
            case PBMessageType.FIGHT_WON:
               _loc2_ = MessageType.FightWon;
               break;
            case PBMessageType.FIGHT_LOST:
               _loc2_ = MessageType.FightLost;
               break;
            case PBMessageType.CLAN_INVITATION:
               _loc2_ = MessageType.ClanInvitation;
               break;
            case PBMessageType.NEWSLETTER:
               _loc2_ = MessageType.Newsletter;
               break;
            case PBMessageType.CLAN_KICK:
               _loc2_ = MessageType.ClanKick;
               break;
            case PBMessageType.ADMIN:
               _loc2_ = MessageType.Admin;
               break;
            case PBMessageType.PLAYER_MESSAGE:
               _loc2_ = MessageType.PlayerMessage;
               break;
            case PBMessageType.PAYMENT_DOPPLER:
               _loc2_ = MessageType.PaymentDoppler;
               break;
            default:
               _loc2_ = null;
         }
         return _loc2_;
      }
      
      public static function translateProtoFeatureType(param1:int) : FeatureType
      {
         var _loc2_:FeatureType = null;
         switch(param1)
         {
            case PBFeaturestatusGetFeatureStatusFeature.EXTRAS_SHOP:
               _loc2_ = FeatureType.ExtrasShop;
               break;
            default:
               _loc2_ = FeatureType.None;
         }
         return _loc2_;
      }
      
      public static function translateProtoTournamentFinalsState(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case PBSpecialeventTournamentShowTournamentFinalsState.UPCOMING:
               _loc2_ = TournamentFinalFightVO.STATE_UPCOMING;
               break;
            case PBSpecialeventTournamentShowTournamentFinalsState.OVER:
               _loc2_ = TournamentFinalFightVO.STATE_OVER;
         }
         return _loc2_;
      }
      
      public static function translateProtoPlayerTournamentStatus(param1:int) : PlayerTournamentStatus
      {
         var _loc2_:PlayerTournamentStatus = null;
         switch(param1)
         {
            case PBSpecialeventTournamentSearchtournamentplayerStatus.NOT_PARTICIPATING:
               _loc2_ = PlayerTournamentStatus.NotParticipating;
               break;
            case PBSpecialeventTournamentSearchtournamentplayerStatus.PARTICIPATING:
               _loc2_ = PlayerTournamentStatus.Participating;
               break;
            case PBSpecialeventTournamentSearchtournamentplayerStatus.ELIMINATED:
               _loc2_ = PlayerTournamentStatus.Eliminated;
         }
         return _loc2_;
      }
      
      public static function translateProtoFighterState(param1:int) : FighterState
      {
         var _loc2_:FighterState = null;
         switch(param1)
         {
            case PBFighterState.UNKNOWN:
               _loc2_ = FighterState.None;
               break;
            case PBFighterState.READY:
               _loc2_ = FighterState.Ready;
               break;
            case PBFighterState.LOST:
               _loc2_ = FighterState.Lost;
               break;
            case PBFighterState.LEFT:
               _loc2_ = FighterState.Left;
               break;
            case PBFighterState.WON:
               _loc2_ = FighterState.Won;
               break;
            case PBFighterState.BYE:
               _loc2_ = FighterState.Freecard;
         }
         return _loc2_;
      }
   }
}
