package com.goodgamestudios.mafia.controller.protobuf.tournaments
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCharacterClass;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBPlayerInfo extends Message
   {
      
      public static const ID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.tournaments.PlayerInfo.id","id",1 << 3 | WireType.VARINT);
      
      public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.tournaments.PlayerInfo.name","name",2 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.tournaments.PlayerInfo.level","level",3 << 3 | WireType.VARINT);
      
      public static const CHARACTER_CLASS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.tournaments.PlayerInfo.character_class","characterClass",4 << 3 | WireType.VARINT,PBCharacterClass);
      
      public static const FAMILY_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.tournaments.PlayerInfo.family_id","familyId",5 << 3 | WireType.VARINT);
      
      public static const FAMILY_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.tournaments.PlayerInfo.family_name","familyName",6 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const AVATAR_PIC_STRING:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.tournaments.PlayerInfo.avatar_pic_string","avatarPicString",7 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const STATE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.tournaments.PlayerInfo.state","state",8 << 3 | WireType.VARINT,PBFighterState);
      
      public static const REWARD:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.tournaments.PlayerInfo.reward","reward",9 << 3 | WireType.LENGTH_DELIMITED,PBReward);
      
      public static const ROUND_NUMBER:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.tournaments.PlayerInfo.round_number","roundNumber",10 << 3 | WireType.VARINT);
      
      public static const LEVEL_PROGRESS:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.tournaments.PlayerInfo.level_progress","levelProgress",11 << 3 | WireType.VARINT);
      
      public static const HEALTH:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.tournaments.PlayerInfo.health","health",12 << 3 | WireType.VARINT);
       
      
      public var id:int;
      
      private var name$field:String;
      
      private var level$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var character_class$field:int;
      
      private var family_id$field:uint;
      
      private var family_name$field:String;
      
      private var avatar_pic_string$field:String;
      
      private var state$field:int;
      
      private var reward$field:PBReward;
      
      private var round_number$field:int;
      
      private var level_progress$field:int;
      
      private var health$field:int;
      
      public function PBPlayerInfo()
      {
         super();
      }
      
      public function clearName() : void
      {
         this.name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return this.name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         this.name$field = param1;
      }
      
      public function get name() : String
      {
         return this.name$field;
      }
      
      public function clearLevel() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.level$field = new uint();
      }
      
      public function get hasLevel() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set level(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.level$field = param1;
      }
      
      public function get level() : uint
      {
         return this.level$field;
      }
      
      public function clearCharacterClass() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.character_class$field = new int();
      }
      
      public function get hasCharacterClass() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set characterClass(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.character_class$field = param1;
      }
      
      public function get characterClass() : int
      {
         return this.character_class$field;
      }
      
      public function clearFamilyId() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.family_id$field = new uint();
      }
      
      public function get hasFamilyId() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set familyId(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.family_id$field = param1;
      }
      
      public function get familyId() : uint
      {
         return this.family_id$field;
      }
      
      public function clearFamilyName() : void
      {
         this.family_name$field = null;
      }
      
      public function get hasFamilyName() : Boolean
      {
         return this.family_name$field != null;
      }
      
      public function set familyName(param1:String) : void
      {
         this.family_name$field = param1;
      }
      
      public function get familyName() : String
      {
         return this.family_name$field;
      }
      
      public function clearAvatarPicString() : void
      {
         this.avatar_pic_string$field = null;
      }
      
      public function get hasAvatarPicString() : Boolean
      {
         return this.avatar_pic_string$field != null;
      }
      
      public function set avatarPicString(param1:String) : void
      {
         this.avatar_pic_string$field = param1;
      }
      
      public function get avatarPicString() : String
      {
         return this.avatar_pic_string$field;
      }
      
      public function clearState() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967287;
         this.state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (this.hasField$0 & 8) != 0;
      }
      
      public function set state(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 8;
         this.state$field = param1;
      }
      
      public function get state() : int
      {
         return this.state$field;
      }
      
      public function clearReward() : void
      {
         this.reward$field = null;
      }
      
      public function get hasReward() : Boolean
      {
         return this.reward$field != null;
      }
      
      public function set reward(param1:PBReward) : void
      {
         this.reward$field = param1;
      }
      
      public function get reward() : PBReward
      {
         return this.reward$field;
      }
      
      public function clearRoundNumber() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967279;
         this.round_number$field = new int();
      }
      
      public function get hasRoundNumber() : Boolean
      {
         return (this.hasField$0 & 16) != 0;
      }
      
      public function set roundNumber(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 16;
         this.round_number$field = param1;
      }
      
      public function get roundNumber() : int
      {
         return this.round_number$field;
      }
      
      public function clearLevelProgress() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967263;
         this.level_progress$field = new int();
      }
      
      public function get hasLevelProgress() : Boolean
      {
         return (this.hasField$0 & 32) != 0;
      }
      
      public function set levelProgress(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 32;
         this.level_progress$field = param1;
      }
      
      public function get levelProgress() : int
      {
         return this.level_progress$field;
      }
      
      public function clearHealth() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967231;
         this.health$field = new int();
      }
      
      public function get hasHealth() : Boolean
      {
         return (this.hasField$0 & 64) != 0;
      }
      
      public function set health(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 64;
         this.health$field = param1;
      }
      
      public function get health() : int
      {
         return this.health$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_INT32(param1,this.id);
         if(this.hasName)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_STRING(param1,this.name$field);
         }
         if(this.hasLevel)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,this.level$field);
         }
         if(this.hasCharacterClass)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_ENUM(param1,this.character_class$field);
         }
         if(this.hasFamilyId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,this.family_id$field);
         }
         if(this.hasFamilyName)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,6);
            WriteUtils.write$TYPE_STRING(param1,this.family_name$field);
         }
         if(this.hasAvatarPicString)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,7);
            WriteUtils.write$TYPE_STRING(param1,this.avatar_pic_string$field);
         }
         if(this.hasState)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,8);
            WriteUtils.write$TYPE_ENUM(param1,this.state$field);
         }
         if(this.hasReward)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,9);
            WriteUtils.write$TYPE_MESSAGE(param1,this.reward$field);
         }
         if(this.hasRoundNumber)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,10);
            WriteUtils.write$TYPE_INT32(param1,this.round_number$field);
         }
         if(this.hasLevelProgress)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,11);
            WriteUtils.write$TYPE_INT32(param1,this.level_progress$field);
         }
         if(this.hasHealth)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,12);
            WriteUtils.write$TYPE_INT32(param1,this.health$field);
         }
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
                     throw new IOError("Bad data format: PlayerInfo.id cannot be set twice.");
                  }
                  _loc3_++;
                  this.id = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfo.name cannot be set twice.");
                  }
                  _loc4_++;
                  this.name = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfo.level cannot be set twice.");
                  }
                  _loc5_++;
                  this.level = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfo.characterClass cannot be set twice.");
                  }
                  _loc6_++;
                  this.characterClass = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfo.familyId cannot be set twice.");
                  }
                  _loc7_++;
                  this.familyId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfo.familyName cannot be set twice.");
                  }
                  _loc8_++;
                  this.familyName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfo.avatarPicString cannot be set twice.");
                  }
                  _loc9_++;
                  this.avatarPicString = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfo.state cannot be set twice.");
                  }
                  _loc10_++;
                  this.state = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfo.reward cannot be set twice.");
                  }
                  _loc11_++;
                  this.reward = new PBReward();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.reward);
                  continue;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfo.roundNumber cannot be set twice.");
                  }
                  _loc12_++;
                  this.roundNumber = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfo.levelProgress cannot be set twice.");
                  }
                  _loc13_++;
                  this.levelProgress = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 12:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfo.health cannot be set twice.");
                  }
                  _loc14_++;
                  this.health = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc15_);
                  continue;
            }
         }
      }
   }
}
