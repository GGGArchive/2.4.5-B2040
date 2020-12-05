package com.goodgamestudios.mafia.controller.protobuf.specialevent.cityevent
{
   import com.goodgamestudios.mafia.controller.protobuf.cityevents.PBCityEventState;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBSpecialeventCityEventResponse extends Message
   {
      
      public static const STATE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.cityevent.Response.state","state",1 << 3 | WireType.VARINT,PBCityEventState);
      
      public static const TIME_FOR_MISSION:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.cityevent.Response.time_for_mission","timeForMission",2 << 3 | WireType.VARINT);
      
      public static const TIME_TO_END:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.cityevent.Response.time_to_end","timeToEnd",3 << 3 | WireType.VARINT);
      
      public static const INSTANT_MISSION_COOLDOWN_GOLD:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.cityevent.Response.instant_mission_cooldown_gold","instantMissionCooldownGold",4 << 3 | WireType.VARINT);
      
      public static const FINAL_REWARD:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.specialevent.cityevent.Response.final_reward","finalReward",5 << 3 | WireType.LENGTH_DELIMITED,PBItem);
       
      
      public var state:int;
      
      public var timeForMission:uint;
      
      public var timeToEnd:uint;
      
      public var instantMissionCooldownGold:uint;
      
      public var finalReward:PBItem;
      
      public function PBSpecialeventCityEventResponse()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.state);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.timeForMission);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.timeToEnd);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.instantMissionCooldownGold);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,5);
         WriteUtils.write$TYPE_MESSAGE(param1,this.finalReward);
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc8_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc8_ >> 3)
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
                     throw new IOError("Bad data format: Response.timeForMission cannot be set twice.");
                  }
                  _loc4_++;
                  this.timeForMission = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.timeToEnd cannot be set twice.");
                  }
                  _loc5_++;
                  this.timeToEnd = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.instantMissionCooldownGold cannot be set twice.");
                  }
                  _loc6_++;
                  this.instantMissionCooldownGold = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Response.finalReward cannot be set twice.");
                  }
                  _loc7_++;
                  this.finalReward = new PBItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.finalReward);
                  continue;
               default:
                  super.readUnknown(param1,_loc8_);
                  continue;
            }
         }
      }
   }
}
