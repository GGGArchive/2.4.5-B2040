package com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.response
{
   import com.goodgamestudios.mafia.controller.protobuf.police.PBEffectType;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightStartPoliceFightPoliceInfo extends Message
   {
      
      public static const EFFECT_TIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.Response.PoliceInfo.effect_time","effectTime",1 << 3 | WireType.VARINT);
      
      public static const EFFECT_TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.Response.PoliceInfo.effect_type","effectType",2 << 3 | WireType.VARINT,PBEffectType);
      
      public static const EFFECT_VALUE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.Response.PoliceInfo.effect_value","effectValue",3 << 3 | WireType.VARINT);
      
      public static const BAIL_COST:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.Response.PoliceInfo.bail_cost","bailCost",4 << 3 | WireType.VARINT);
       
      
      public var effectTime:uint;
      
      public var effectType:int;
      
      public var effectValue:uint;
      
      public var bailCost:uint;
      
      public function PBFightStartPoliceFightPoliceInfo()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.effectTime);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_ENUM(param1,this.effectType);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.effectValue);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.bailCost);
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc7_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc7_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PoliceInfo.effectTime cannot be set twice.");
                  }
                  _loc3_++;
                  this.effectTime = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PoliceInfo.effectType cannot be set twice.");
                  }
                  _loc4_++;
                  this.effectType = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PoliceInfo.effectValue cannot be set twice.");
                  }
                  _loc5_++;
                  this.effectValue = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PoliceInfo.bailCost cannot be set twice.");
                  }
                  _loc6_++;
                  this.bailCost = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
