package com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress
{
   import com.goodgamestudios.mafia.controller.protobuf.cityevents.PBCityEventState;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBSpecialeventCityCityEventProgressResponse extends Message
   {
      
      public static const STATE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress.Response.state","state",1 << 3 | WireType.VARINT,PBCityEventState);
      
      public static const MISSION:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress.Response.mission","mission",2 << 3 | WireType.VARINT);
      
      public static const FIGHT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress.Response.fight","fight",3 << 3 | WireType.VARINT);
      
      public static const MISSION_COOLDOWN:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress.Response.mission_cooldown","missionCooldown",4 << 3 | WireType.VARINT);
      
      public static const FIGHT_COOLDOWN:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress.Response.fight_cooldown","fightCooldown",5 << 3 | WireType.VARINT);
      
      public static const MISSION_COUNT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress.Response.mission_count","missionCount",6 << 3 | WireType.VARINT);
      
      public static const TIME_LEFT:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress.Response.time_left","timeLeft",7 << 3 | WireType.VARINT);
      
      public static const IS_FLYING_FROM_EVENT:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress.Response.is_flying_from_event","isFlyingFromEvent",8 << 3 | WireType.VARINT);
      
      public static const IS_FLYING_TO_EVENT:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.cityeventprogress.Response.is_flying_to_event","isFlyingToEvent",9 << 3 | WireType.VARINT);
       
      
      public var state:int;
      
      private var mission$field:int;
      
      private var hasField$0:uint = 0;
      
      private var fight$field:int;
      
      private var mission_cooldown$field:int;
      
      private var fight_cooldown$field:int;
      
      private var mission_count$field:int;
      
      private var time_left$field:int;
      
      private var is_flying_from_event$field:Boolean;
      
      private var is_flying_to_event$field:Boolean;
      
      public function PBSpecialeventCityCityEventProgressResponse()
      {
         super();
      }
      
      public function clearMission() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.mission$field = new int();
      }
      
      public function get hasMission() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set mission(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.mission$field = param1;
      }
      
      public function get mission() : int
      {
         return this.mission$field;
      }
      
      public function clearFight() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.fight$field = new int();
      }
      
      public function get hasFight() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set fight(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.fight$field = param1;
      }
      
      public function get fight() : int
      {
         return this.fight$field;
      }
      
      public function clearMissionCooldown() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.mission_cooldown$field = new int();
      }
      
      public function get hasMissionCooldown() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set missionCooldown(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.mission_cooldown$field = param1;
      }
      
      public function get missionCooldown() : int
      {
         return this.mission_cooldown$field;
      }
      
      public function clearFightCooldown() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967287;
         this.fight_cooldown$field = new int();
      }
      
      public function get hasFightCooldown() : Boolean
      {
         return (this.hasField$0 & 8) != 0;
      }
      
      public function set fightCooldown(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 8;
         this.fight_cooldown$field = param1;
      }
      
      public function get fightCooldown() : int
      {
         return this.fight_cooldown$field;
      }
      
      public function clearMissionCount() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967279;
         this.mission_count$field = new int();
      }
      
      public function get hasMissionCount() : Boolean
      {
         return (this.hasField$0 & 16) != 0;
      }
      
      public function set missionCount(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 16;
         this.mission_count$field = param1;
      }
      
      public function get missionCount() : int
      {
         return this.mission_count$field;
      }
      
      public function clearTimeLeft() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967263;
         this.time_left$field = new int();
      }
      
      public function get hasTimeLeft() : Boolean
      {
         return (this.hasField$0 & 32) != 0;
      }
      
      public function set timeLeft(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 32;
         this.time_left$field = param1;
      }
      
      public function get timeLeft() : int
      {
         return this.time_left$field;
      }
      
      public function clearIsFlyingFromEvent() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967231;
         this.is_flying_from_event$field = new Boolean();
      }
      
      public function get hasIsFlyingFromEvent() : Boolean
      {
         return (this.hasField$0 & 64) != 0;
      }
      
      public function set isFlyingFromEvent(param1:Boolean) : void
      {
         this.hasField$0 = this.hasField$0 | 64;
         this.is_flying_from_event$field = param1;
      }
      
      public function get isFlyingFromEvent() : Boolean
      {
         return this.is_flying_from_event$field;
      }
      
      public function clearIsFlyingToEvent() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967167;
         this.is_flying_to_event$field = new Boolean();
      }
      
      public function get hasIsFlyingToEvent() : Boolean
      {
         return (this.hasField$0 & 128) != 0;
      }
      
      public function set isFlyingToEvent(param1:Boolean) : void
      {
         this.hasField$0 = this.hasField$0 | 128;
         this.is_flying_to_event$field = param1;
      }
      
      public function get isFlyingToEvent() : Boolean
      {
         return this.is_flying_to_event$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.state);
         if(this.hasMission)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_INT32(param1,this.mission$field);
         }
         if(this.hasFight)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_INT32(param1,this.fight$field);
         }
         if(this.hasMissionCooldown)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_INT32(param1,this.mission_cooldown$field);
         }
         if(this.hasFightCooldown)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_INT32(param1,this.fight_cooldown$field);
         }
         if(this.hasMissionCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_INT32(param1,this.mission_count$field);
         }
         if(this.hasTimeLeft)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_INT32(param1,this.time_left$field);
         }
         if(this.hasIsFlyingFromEvent)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,8);
            WriteUtils.write$TYPE_BOOL(param1,this.is_flying_from_event$field);
         }
         if(this.hasIsFlyingToEvent)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,9);
            WriteUtils.write$TYPE_BOOL(param1,this.is_flying_to_event$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc12_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc12_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: Response.state cannot be set twice.");
                  }
                  _loc3_++;
                  this.state = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.mission cannot be set twice.");
                  }
                  _loc4_++;
                  this.mission = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.fight cannot be set twice.");
                  }
                  _loc5_++;
                  this.fight = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.missionCooldown cannot be set twice.");
                  }
                  _loc6_++;
                  this.missionCooldown = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Response.fightCooldown cannot be set twice.");
                  }
                  _loc7_++;
                  this.fightCooldown = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Response.missionCount cannot be set twice.");
                  }
                  _loc8_++;
                  this.missionCount = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: Response.timeLeft cannot be set twice.");
                  }
                  _loc9_++;
                  this.timeLeft = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: Response.isFlyingFromEvent cannot be set twice.");
                  }
                  _loc10_++;
                  this.isFlyingFromEvent = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: Response.isFlyingToEvent cannot be set twice.");
                  }
                  _loc11_++;
                  this.isFlyingToEvent = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc12_);
                  continue;
            }
         }
      }
   }
}
