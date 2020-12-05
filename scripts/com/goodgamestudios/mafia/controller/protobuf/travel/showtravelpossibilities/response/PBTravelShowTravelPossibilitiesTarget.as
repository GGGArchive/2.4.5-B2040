package com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.response
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCity;
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
   
   public final class PBTravelShowTravelPossibilitiesTarget extends Message
   {
      
      public static const CITY:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.Response.Target.city","city",1 << 3 | WireType.VARINT,PBCity);
      
      public static const NEXT_OPPONENT_LEVEL:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.Response.Target.next_opponent_level","nextOpponentLevel",2 << 3 | WireType.VARINT);
      
      public static const ENERGY_USAGE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.Response.Target.energy_usage","energyUsage",3 << 3 | WireType.VARINT);
      
      public static const FLIGHT_TIME:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.Response.Target.flight_time","flightTime",4 << 3 | WireType.VARINT);
      
      public static const UNLOCKED:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.Response.Target.unlocked","unlocked",5 << 3 | WireType.VARINT);
       
      
      public var city:int;
      
      public var nextOpponentLevel:int;
      
      public var energyUsage:int;
      
      public var flightTime:int;
      
      public var unlocked:Boolean;
      
      public function PBTravelShowTravelPossibilitiesTarget()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.city);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_INT32(param1,this.nextOpponentLevel);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_INT32(param1,this.energyUsage);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_INT32(param1,this.flightTime);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_BOOL(param1,this.unlocked);
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
                     throw new IOError("Bad data format: Target.city cannot be set twice.");
                  }
                  _loc3_++;
                  this.city = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Target.nextOpponentLevel cannot be set twice.");
                  }
                  _loc4_++;
                  this.nextOpponentLevel = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Target.energyUsage cannot be set twice.");
                  }
                  _loc5_++;
                  this.energyUsage = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Target.flightTime cannot be set twice.");
                  }
                  _loc6_++;
                  this.flightTime = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Target.unlocked cannot be set twice.");
                  }
                  _loc7_++;
                  this.unlocked = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc8_);
                  continue;
            }
         }
      }
   }
}
