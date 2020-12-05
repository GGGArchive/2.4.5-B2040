package com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch
{
   import com.goodgamestudios.mafia.controller.protobuf.family.PBFamilyCrest;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBRankingRankingSearchFamilyRankingEntry extends Message
   {
      
      public static const RANK:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.rank","rank",1 << 3 | WireType.VARINT);
      
      public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.id","id",2 << 3 | WireType.VARINT);
      
      public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.name","name",3 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.level","level",4 << 3 | WireType.VARINT);
      
      public static const GLORY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.glory","glory",5 << 3 | WireType.VARINT);
      
      public static const LEADER_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.leader_id","leaderId",6 << 3 | WireType.VARINT);
      
      public static const LEADER_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.leader_name","leaderName",7 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const MEMBER_COUNT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.member_count","memberCount",8 << 3 | WireType.VARINT);
      
      public static const ATTACK_FAMILY_WAR_TIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.attack_family_war_time","attackFamilyWarTime",9 << 3 | WireType.VARINT);
      
      public static const ATTACK_FAMILY_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.attack_family_name","attackFamilyName",10 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const DEFENSE_FAMILY_WAR_TIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.defense_family_war_time","defenseFamilyWarTime",11 << 3 | WireType.VARINT);
      
      public static const DEFENSE_FAMILY_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.defense_family_name","defenseFamilyName",12 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const CREST:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.FamilyRankingEntry.crest","crest",13 << 3 | WireType.LENGTH_DELIMITED,PBFamilyCrest);
       
      
      public var rank:uint;
      
      public var id:uint;
      
      public var name:String;
      
      public var level:uint;
      
      public var glory:uint;
      
      public var leaderId:uint;
      
      public var leaderName:String;
      
      public var memberCount:uint;
      
      private var attack_family_war_time$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var attack_family_name$field:String;
      
      private var defense_family_war_time$field:uint;
      
      private var defense_family_name$field:String;
      
      private var crest$field:PBFamilyCrest;
      
      public function PBRankingRankingSearchFamilyRankingEntry()
      {
         super();
      }
      
      public function clearAttackFamilyWarTime() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.attack_family_war_time$field = new uint();
      }
      
      public function get hasAttackFamilyWarTime() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set attackFamilyWarTime(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.attack_family_war_time$field = param1;
      }
      
      public function get attackFamilyWarTime() : uint
      {
         return this.attack_family_war_time$field;
      }
      
      public function clearAttackFamilyName() : void
      {
         this.attack_family_name$field = null;
      }
      
      public function get hasAttackFamilyName() : Boolean
      {
         return this.attack_family_name$field != null;
      }
      
      public function set attackFamilyName(param1:String) : void
      {
         this.attack_family_name$field = param1;
      }
      
      public function get attackFamilyName() : String
      {
         return this.attack_family_name$field;
      }
      
      public function clearDefenseFamilyWarTime() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.defense_family_war_time$field = new uint();
      }
      
      public function get hasDefenseFamilyWarTime() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set defenseFamilyWarTime(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.defense_family_war_time$field = param1;
      }
      
      public function get defenseFamilyWarTime() : uint
      {
         return this.defense_family_war_time$field;
      }
      
      public function clearDefenseFamilyName() : void
      {
         this.defense_family_name$field = null;
      }
      
      public function get hasDefenseFamilyName() : Boolean
      {
         return this.defense_family_name$field != null;
      }
      
      public function set defenseFamilyName(param1:String) : void
      {
         this.defense_family_name$field = param1;
      }
      
      public function get defenseFamilyName() : String
      {
         return this.defense_family_name$field;
      }
      
      public function clearCrest() : void
      {
         this.crest$field = null;
      }
      
      public function get hasCrest() : Boolean
      {
         return this.crest$field != null;
      }
      
      public function set crest(param1:PBFamilyCrest) : void
      {
         this.crest$field = param1;
      }
      
      public function get crest() : PBFamilyCrest
      {
         return this.crest$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.rank);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.id);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
         WriteUtils.write$TYPE_STRING(param1,this.name);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.level);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_UINT32(param1,this.glory);
         WriteUtils.writeTag(param1,WireType.VARINT,6);
         WriteUtils.write$TYPE_UINT32(param1,this.leaderId);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,7);
         WriteUtils.write$TYPE_STRING(param1,this.leaderName);
         WriteUtils.writeTag(param1,WireType.VARINT,8);
         WriteUtils.write$TYPE_UINT32(param1,this.memberCount);
         if(this.hasAttackFamilyWarTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,9);
            WriteUtils.write$TYPE_UINT32(param1,this.attack_family_war_time$field);
         }
         if(this.hasAttackFamilyName)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,10);
            WriteUtils.write$TYPE_STRING(param1,this.attack_family_name$field);
         }
         if(this.hasDefenseFamilyWarTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,11);
            WriteUtils.write$TYPE_UINT32(param1,this.defense_family_war_time$field);
         }
         if(this.hasDefenseFamilyName)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,12);
            WriteUtils.write$TYPE_STRING(param1,this.defense_family_name$field);
         }
         if(this.hasCrest)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,13);
            WriteUtils.write$TYPE_MESSAGE(param1,this.crest$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:uint = 0;
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
         while(param1.bytesAvailable > param2)
         {
            _loc16_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc16_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.rank cannot be set twice.");
                  }
                  _loc3_++;
                  this.rank = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.id cannot be set twice.");
                  }
                  _loc4_++;
                  this.id = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.name cannot be set twice.");
                  }
                  _loc5_++;
                  this.name = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.level cannot be set twice.");
                  }
                  _loc6_++;
                  this.level = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.glory cannot be set twice.");
                  }
                  _loc7_++;
                  this.glory = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.leaderId cannot be set twice.");
                  }
                  _loc8_++;
                  this.leaderId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.leaderName cannot be set twice.");
                  }
                  _loc9_++;
                  this.leaderName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.memberCount cannot be set twice.");
                  }
                  _loc10_++;
                  this.memberCount = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.attackFamilyWarTime cannot be set twice.");
                  }
                  _loc11_++;
                  this.attackFamilyWarTime = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.attackFamilyName cannot be set twice.");
                  }
                  _loc12_++;
                  this.attackFamilyName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.defenseFamilyWarTime cannot be set twice.");
                  }
                  _loc13_++;
                  this.defenseFamilyWarTime = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 12:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.defenseFamilyName cannot be set twice.");
                  }
                  _loc14_++;
                  this.defenseFamilyName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 13:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyRankingEntry.crest cannot be set twice.");
                  }
                  _loc15_++;
                  this.crest = new PBFamilyCrest();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.crest);
                  continue;
               default:
                  super.readUnknown(param1,_loc16_);
                  continue;
            }
         }
      }
   }
}
