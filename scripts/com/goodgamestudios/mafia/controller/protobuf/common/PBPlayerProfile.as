package com.goodgamestudios.mafia.controller.protobuf.common
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBPlayerProfile extends Message
   {
      
      public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.name","name",1 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const GENDER:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.gender","gender",2 << 3 | WireType.VARINT,PBGender);
      
      public static const PIC_STRING:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.pic_string","picString",3 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const CHARACTER_CLASS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.character_class","characterClass",4 << 3 | WireType.VARINT,PBCharacterClass);
      
      public static const ATTRIBUTES:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.attributes","attributes",5 << 3 | WireType.LENGTH_DELIMITED,PBAttributes);
      
      public static const COMBAT_STATS:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.combat_stats","combatStats",6 << 3 | WireType.LENGTH_DELIMITED,PBCombatStats);
      
      public static const HIGHSCORE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.highscore","highscore",9 << 3 | WireType.LENGTH_DELIMITED,PBHighscore);
      
      public static const WON_DUELS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.won_duels","wonDuels",11 << 3 | WireType.VARINT);
      
      public static const LOST_DUELS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.lost_duels","lostDuels",12 << 3 | WireType.VARINT);
      
      public static const IS_IGNORED:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.is_ignored","isIgnored",13 << 3 | WireType.VARINT);
      
      public static const LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.level","level",14 << 3 | WireType.VARINT);
      
      public static const CITY_ID:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.city_id","cityId",15 << 3 | WireType.VARINT,PBCity);
      
      public static const CLAN_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.clan_name","clanName",16 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const CLAN_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.clan_id","clanId",17 << 3 | WireType.VARINT);
      
      public static const RANK_IN_CLAN:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.common.PlayerProfile.rank_in_clan","rankInClan",18 << 3 | WireType.VARINT,PBFamilyRank);
       
      
      public var name:String;
      
      public var gender:int;
      
      public var picString:String;
      
      public var characterClass:int;
      
      public var attributes:PBAttributes;
      
      public var combatStats:PBCombatStats;
      
      public var highscore:PBHighscore;
      
      public var wonDuels:uint;
      
      public var lostDuels:uint;
      
      public var isIgnored:Boolean;
      
      public var level:uint;
      
      public var cityId:int;
      
      private var clan_name$field:String;
      
      private var clan_id$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var rank_in_clan$field:int;
      
      public function PBPlayerProfile()
      {
         super();
      }
      
      public function clearClanName() : void
      {
         this.clan_name$field = null;
      }
      
      public function get hasClanName() : Boolean
      {
         return this.clan_name$field != null;
      }
      
      public function set clanName(param1:String) : void
      {
         this.clan_name$field = param1;
      }
      
      public function get clanName() : String
      {
         return this.clan_name$field;
      }
      
      public function clearClanId() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.clan_id$field = new uint();
      }
      
      public function get hasClanId() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set clanId(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.clan_id$field = param1;
      }
      
      public function get clanId() : uint
      {
         return this.clan_id$field;
      }
      
      public function clearRankInClan() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.rank_in_clan$field = new int();
      }
      
      public function get hasRankInClan() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set rankInClan(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.rank_in_clan$field = param1;
      }
      
      public function get rankInClan() : int
      {
         if(!this.hasRankInClan)
         {
            return PBFamilyRank.NONE;
         }
         return this.rank_in_clan$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
         WriteUtils.write$TYPE_STRING(param1,this.name);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_ENUM(param1,this.gender);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
         WriteUtils.write$TYPE_STRING(param1,this.picString);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_ENUM(param1,this.characterClass);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,5);
         WriteUtils.write$TYPE_MESSAGE(param1,this.attributes);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,6);
         WriteUtils.write$TYPE_MESSAGE(param1,this.combatStats);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,9);
         WriteUtils.write$TYPE_MESSAGE(param1,this.highscore);
         WriteUtils.writeTag(param1,WireType.VARINT,11);
         WriteUtils.write$TYPE_UINT32(param1,this.wonDuels);
         WriteUtils.writeTag(param1,WireType.VARINT,12);
         WriteUtils.write$TYPE_UINT32(param1,this.lostDuels);
         WriteUtils.writeTag(param1,WireType.VARINT,13);
         WriteUtils.write$TYPE_BOOL(param1,this.isIgnored);
         WriteUtils.writeTag(param1,WireType.VARINT,14);
         WriteUtils.write$TYPE_UINT32(param1,this.level);
         WriteUtils.writeTag(param1,WireType.VARINT,15);
         WriteUtils.write$TYPE_ENUM(param1,this.cityId);
         if(this.hasClanName)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,16);
            WriteUtils.write$TYPE_STRING(param1,this.clan_name$field);
         }
         if(this.hasClanId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,17);
            WriteUtils.write$TYPE_UINT32(param1,this.clan_id$field);
         }
         if(this.hasRankInClan)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,18);
            WriteUtils.write$TYPE_ENUM(param1,this.rank_in_clan$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc18_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc18_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc18_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.name cannot be set twice.");
                  }
                  _loc3_++;
                  this.name = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.gender cannot be set twice.");
                  }
                  _loc4_++;
                  this.gender = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.picString cannot be set twice.");
                  }
                  _loc5_++;
                  this.picString = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.characterClass cannot be set twice.");
                  }
                  _loc6_++;
                  this.characterClass = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.attributes cannot be set twice.");
                  }
                  _loc7_++;
                  this.attributes = new PBAttributes();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.attributes);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.combatStats cannot be set twice.");
                  }
                  _loc8_++;
                  this.combatStats = new PBCombatStats();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.combatStats);
                  continue;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.highscore cannot be set twice.");
                  }
                  _loc9_++;
                  this.highscore = new PBHighscore();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.highscore);
                  continue;
               case 11:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.wonDuels cannot be set twice.");
                  }
                  _loc10_++;
                  this.wonDuels = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 12:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.lostDuels cannot be set twice.");
                  }
                  _loc11_++;
                  this.lostDuels = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 13:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.isIgnored cannot be set twice.");
                  }
                  _loc12_++;
                  this.isIgnored = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               case 14:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.level cannot be set twice.");
                  }
                  _loc13_++;
                  this.level = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 15:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.cityId cannot be set twice.");
                  }
                  _loc14_++;
                  this.cityId = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 16:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.clanName cannot be set twice.");
                  }
                  _loc15_++;
                  this.clanName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 17:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.clanId cannot be set twice.");
                  }
                  _loc16_++;
                  this.clanId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 18:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerProfile.rankInClan cannot be set twice.");
                  }
                  _loc17_++;
                  this.rankInClan = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc18_);
                  continue;
            }
         }
      }
   }
}
