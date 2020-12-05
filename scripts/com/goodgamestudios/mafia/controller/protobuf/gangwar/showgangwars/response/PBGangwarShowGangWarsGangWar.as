package com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.response
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCharacterClass;
   import com.goodgamestudios.mafia.controller.protobuf.quest.PBQuest;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBGangwarShowGangWarsGangWar extends Message
   {
      
      public static const DISTRICT_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.GangWar.district_id","districtId",1 << 3 | WireType.VARINT);
      
      public static const PLAYER_PROGRESS:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.GangWar.player_progress","playerProgress",2 << 3 | WireType.VARINT);
      
      public static const MIN_FRIENDS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.GangWar.min_friends","minFriends",3 << 3 | WireType.VARINT);
      
      public static const MIN_LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.GangWar.min_level","minLevel",4 << 3 | WireType.VARINT);
      
      public static const UNLOCK_PRICE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.GangWar.unlock_price","unlockPrice",5 << 3 | WireType.VARINT);
      
      public static const NEXT_CHALLENGE_LEVEL:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.GangWar.next_challenge_level","nextChallengeLevel",6 << 3 | WireType.VARINT);
      
      public static const NEXT_CHALLENGE_CLASS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.GangWar.next_challenge_class","nextChallengeClass",7 << 3 | WireType.VARINT,PBCharacterClass);
      
      public static const CITY_QUEST:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.GangWar.city_quest","cityQuest",8 << 3 | WireType.LENGTH_DELIMITED,PBQuest);
      
      public static const CITY_FIGHT_PROGRESS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.GangWar.city_fight_progress","cityFightProgress",9 << 3 | WireType.VARINT,PBGangwarShowGangWarsCityFightProgress);
      
      public static const CITY_FIGHTER_LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.GangWar.city_fighter_level","cityFighterLevel",10 << 3 | WireType.VARINT);
      
      public static const CITY_FIGHTER_CLASS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.GangWar.city_fighter_class","cityFighterClass",11 << 3 | WireType.VARINT,PBCharacterClass);
       
      
      public var districtId:uint;
      
      public var playerProgress:int;
      
      public var minFriends:uint;
      
      public var minLevel:uint;
      
      public var unlockPrice:uint;
      
      public var nextChallengeLevel:int;
      
      public var nextChallengeClass:int;
      
      private var city_quest$field:PBQuest;
      
      private var city_fight_progress$field:int;
      
      private var hasField$0:uint = 0;
      
      private var city_fighter_level$field:uint;
      
      private var city_fighter_class$field:int;
      
      public function PBGangwarShowGangWarsGangWar()
      {
         super();
      }
      
      public function clearCityQuest() : void
      {
         this.city_quest$field = null;
      }
      
      public function get hasCityQuest() : Boolean
      {
         return this.city_quest$field != null;
      }
      
      public function set cityQuest(param1:PBQuest) : void
      {
         this.city_quest$field = param1;
      }
      
      public function get cityQuest() : PBQuest
      {
         return this.city_quest$field;
      }
      
      public function clearCityFightProgress() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.city_fight_progress$field = new int();
      }
      
      public function get hasCityFightProgress() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set cityFightProgress(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.city_fight_progress$field = param1;
      }
      
      public function get cityFightProgress() : int
      {
         return this.city_fight_progress$field;
      }
      
      public function clearCityFighterLevel() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.city_fighter_level$field = new uint();
      }
      
      public function get hasCityFighterLevel() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set cityFighterLevel(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.city_fighter_level$field = param1;
      }
      
      public function get cityFighterLevel() : uint
      {
         return this.city_fighter_level$field;
      }
      
      public function clearCityFighterClass() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.city_fighter_class$field = new int();
      }
      
      public function get hasCityFighterClass() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set cityFighterClass(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.city_fighter_class$field = param1;
      }
      
      public function get cityFighterClass() : int
      {
         return this.city_fighter_class$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.districtId);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_INT32(param1,this.playerProgress);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.minFriends);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.minLevel);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_UINT32(param1,this.unlockPrice);
         WriteUtils.writeTag(param1,WireType.VARINT,6);
         WriteUtils.write$TYPE_INT32(param1,this.nextChallengeLevel);
         WriteUtils.writeTag(param1,WireType.VARINT,7);
         WriteUtils.write$TYPE_ENUM(param1,this.nextChallengeClass);
         if(this.hasCityQuest)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,8);
            WriteUtils.write$TYPE_MESSAGE(param1,this.city_quest$field);
         }
         if(this.hasCityFightProgress)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,9);
            WriteUtils.write$TYPE_ENUM(param1,this.city_fight_progress$field);
         }
         if(this.hasCityFighterLevel)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,10);
            WriteUtils.write$TYPE_UINT32(param1,this.city_fighter_level$field);
         }
         if(this.hasCityFighterClass)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,11);
            WriteUtils.write$TYPE_ENUM(param1,this.city_fighter_class$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:uint = 0;
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
         while(param1.bytesAvailable > param2)
         {
            _loc14_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc14_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GangWar.districtId cannot be set twice.");
                  }
                  _loc3_++;
                  this.districtId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GangWar.playerProgress cannot be set twice.");
                  }
                  _loc4_++;
                  this.playerProgress = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GangWar.minFriends cannot be set twice.");
                  }
                  _loc5_++;
                  this.minFriends = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GangWar.minLevel cannot be set twice.");
                  }
                  _loc6_++;
                  this.minLevel = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GangWar.unlockPrice cannot be set twice.");
                  }
                  _loc7_++;
                  this.unlockPrice = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GangWar.nextChallengeLevel cannot be set twice.");
                  }
                  _loc8_++;
                  this.nextChallengeLevel = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GangWar.nextChallengeClass cannot be set twice.");
                  }
                  _loc9_++;
                  this.nextChallengeClass = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GangWar.cityQuest cannot be set twice.");
                  }
                  _loc10_++;
                  this.cityQuest = new PBQuest();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.cityQuest);
                  continue;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GangWar.cityFightProgress cannot be set twice.");
                  }
                  _loc11_++;
                  this.cityFightProgress = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GangWar.cityFighterLevel cannot be set twice.");
                  }
                  _loc12_++;
                  this.cityFighterLevel = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GangWar.cityFighterClass cannot be set twice.");
                  }
                  _loc13_++;
                  this.cityFighterClass = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc14_);
                  continue;
            }
         }
      }
   }
}
