package com.goodgamestudios.mafia.controller.protobuf.mission.booster.showmissionbooster.response
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBMissionBoosterShowMissionBoosterBooster extends Message
   {
      
      public static const BOOSTERID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.booster.showmissionbooster.Response.Booster.boosterID","boosterID",1 << 3 | WireType.VARINT);
      
      public static const BOOSTERPOWER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.booster.showmissionbooster.Response.Booster.boosterPower","boosterPower",2 << 3 | WireType.VARINT);
      
      public static const DURATION:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.booster.showmissionbooster.Response.Booster.duration","duration",3 << 3 | WireType.VARINT);
      
      public static const COSTCURRENCY1:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.booster.showmissionbooster.Response.Booster.costCurrency1","costCurrency1",4 << 3 | WireType.VARINT);
      
      public static const COSTCURRENCY2:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.booster.showmissionbooster.Response.Booster.costCurrency2","costCurrency2",5 << 3 | WireType.VARINT);
      
      public static const EARNCURRENCY1:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.booster.showmissionbooster.Response.Booster.earnCurrency1","earnCurrency1",6 << 3 | WireType.VARINT);
       
      
      public var boosterID:uint;
      
      public var boosterPower:uint;
      
      public var duration:uint;
      
      public var costCurrency1:uint;
      
      public var costCurrency2:uint;
      
      public var earnCurrency1:uint;
      
      public function PBMissionBoosterShowMissionBoosterBooster()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.boosterID);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.boosterPower);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.duration);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.costCurrency1);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_UINT32(param1,this.costCurrency2);
         WriteUtils.writeTag(param1,WireType.VARINT,6);
         WriteUtils.write$TYPE_UINT32(param1,this.earnCurrency1);
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc9_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc9_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: Booster.boosterID cannot be set twice.");
                  }
                  _loc3_++;
                  this.boosterID = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Booster.boosterPower cannot be set twice.");
                  }
                  _loc4_++;
                  this.boosterPower = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Booster.duration cannot be set twice.");
                  }
                  _loc5_++;
                  this.duration = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Booster.costCurrency1 cannot be set twice.");
                  }
                  _loc6_++;
                  this.costCurrency1 = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Booster.costCurrency2 cannot be set twice.");
                  }
                  _loc7_++;
                  this.costCurrency2 = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Booster.earnCurrency1 cannot be set twice.");
                  }
                  _loc8_++;
                  this.earnCurrency1 = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc9_);
                  continue;
            }
         }
      }
   }
}
