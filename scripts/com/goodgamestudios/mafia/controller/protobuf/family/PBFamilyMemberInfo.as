package com.goodgamestudios.mafia.controller.protobuf.family
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCharacterClass;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBFamilyRank;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFamilyMemberInfo extends Message
   {
      
      public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyMemberInfo.id","id",1 << 3 | WireType.VARINT);
      
      public static const RANK_HIGHSCORE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyMemberInfo.rank_highscore","rankHighscore",2 << 3 | WireType.VARINT);
      
      public static const RANK_FAMILY:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.family.FamilyMemberInfo.rank_family","rankFamily",3 << 3 | WireType.VARINT,PBFamilyRank);
      
      public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.family.FamilyMemberInfo.name","name",4 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const CHARACTER_CLASS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.family.FamilyMemberInfo.character_class","characterClass",5 << 3 | WireType.VARINT,PBCharacterClass);
      
      public static const LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyMemberInfo.level","level",6 << 3 | WireType.VARINT);
      
      public static const DONATED_GOLD:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyMemberInfo.donated_gold","donatedGold",7 << 3 | WireType.VARINT);
      
      public static const ATTACK_PARTICIPATION:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.family.FamilyMemberInfo.attack_participation","attackParticipation",8 << 3 | WireType.VARINT);
      
      public static const DEFEND_PARTICIPATION:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.family.FamilyMemberInfo.defend_participation","defendParticipation",9 << 3 | WireType.VARINT);
      
      public static const ACTIVITY_POINTS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyMemberInfo.activity_points","activityPoints",10 << 3 | WireType.VARINT);
      
      public static const YESTERDAY_ACTIVITY_POINTS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyMemberInfo.yesterday_activity_points","yesterdayActivityPoints",11 << 3 | WireType.VARINT);
      
      public static const IS_ONLINE:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.family.FamilyMemberInfo.is_online","isOnline",12 << 3 | WireType.VARINT);
       
      
      public var id:uint;
      
      public var rankHighscore:uint;
      
      public var rankFamily:int;
      
      public var name:String;
      
      public var characterClass:int;
      
      public var level:uint;
      
      public var donatedGold:uint;
      
      public var attackParticipation:Boolean;
      
      public var defendParticipation:Boolean;
      
      public var activityPoints:uint;
      
      public var yesterdayActivityPoints:uint;
      
      public var isOnline:Boolean;
      
      public function PBFamilyMemberInfo()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.id);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.rankHighscore);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_ENUM(param1,this.rankFamily);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
         WriteUtils.write$TYPE_STRING(param1,this.name);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_ENUM(param1,this.characterClass);
         WriteUtils.writeTag(param1,WireType.VARINT,6);
         WriteUtils.write$TYPE_UINT32(param1,this.level);
         WriteUtils.writeTag(param1,WireType.VARINT,7);
         WriteUtils.write$TYPE_UINT32(param1,this.donatedGold);
         WriteUtils.writeTag(param1,WireType.VARINT,8);
         WriteUtils.write$TYPE_BOOL(param1,this.attackParticipation);
         WriteUtils.writeTag(param1,WireType.VARINT,9);
         WriteUtils.write$TYPE_BOOL(param1,this.defendParticipation);
         WriteUtils.writeTag(param1,WireType.VARINT,10);
         WriteUtils.write$TYPE_UINT32(param1,this.activityPoints);
         WriteUtils.writeTag(param1,WireType.VARINT,11);
         WriteUtils.write$TYPE_UINT32(param1,this.yesterdayActivityPoints);
         WriteUtils.writeTag(param1,WireType.VARINT,12);
         WriteUtils.write$TYPE_BOOL(param1,this.isOnline);
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:uint = 0;
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
         while(param1.bytesAvailable > param2)
         {
            _loc15_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc15_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyMemberInfo.id cannot be set twice.");
                  }
                  _loc3_++;
                  this.id = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyMemberInfo.rankHighscore cannot be set twice.");
                  }
                  _loc4_++;
                  this.rankHighscore = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyMemberInfo.rankFamily cannot be set twice.");
                  }
                  _loc5_++;
                  this.rankFamily = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyMemberInfo.name cannot be set twice.");
                  }
                  _loc6_++;
                  this.name = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyMemberInfo.characterClass cannot be set twice.");
                  }
                  _loc7_++;
                  this.characterClass = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyMemberInfo.level cannot be set twice.");
                  }
                  _loc8_++;
                  this.level = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyMemberInfo.donatedGold cannot be set twice.");
                  }
                  _loc9_++;
                  this.donatedGold = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyMemberInfo.attackParticipation cannot be set twice.");
                  }
                  _loc10_++;
                  this.attackParticipation = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyMemberInfo.defendParticipation cannot be set twice.");
                  }
                  _loc11_++;
                  this.defendParticipation = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyMemberInfo.activityPoints cannot be set twice.");
                  }
                  _loc12_++;
                  this.activityPoints = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyMemberInfo.yesterdayActivityPoints cannot be set twice.");
                  }
                  _loc13_++;
                  this.yesterdayActivityPoints = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 12:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyMemberInfo.isOnline cannot be set twice.");
                  }
                  _loc14_++;
                  this.isOnline = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc15_);
                  continue;
            }
         }
      }
   }
}
