package com.goodgamestudios.mafia.controller.protobuf.fight.policeencounter.response
{
   import com.goodgamestudios.mafia.controller.protobuf.police.PBEffectType;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightPoliceEncounterPoliceInfo extends Message
   {
      
      public static const EFFECT_TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.policeencounter.Response.PoliceInfo.effect_type","effectType",1 << 3 | WireType.VARINT,PBEffectType);
      
      public static const EFFECT_VALUE_WON:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.policeencounter.Response.PoliceInfo.effect_value_won","effectValueWon",2 << 3 | WireType.VARINT);
      
      public static const EFFECT_VALUE_LOST:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.fight.policeencounter.Response.PoliceInfo.effect_value_lost","effectValueLost",3 << 3 | WireType.VARINT);
       
      
      public var effectType:int;
      
      public var effectValueWon:uint;
      
      public var effectValueLost:int;
      
      public function PBFightPoliceEncounterPoliceInfo()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.effectType);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.effectValueWon);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_INT32(param1,this.effectValueLost);
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc6_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc6_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PoliceInfo.effectType cannot be set twice.");
                  }
                  _loc3_++;
                  this.effectType = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PoliceInfo.effectValueWon cannot be set twice.");
                  }
                  _loc4_++;
                  this.effectValueWon = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PoliceInfo.effectValueLost cannot be set twice.");
                  }
                  _loc5_++;
                  this.effectValueLost = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
