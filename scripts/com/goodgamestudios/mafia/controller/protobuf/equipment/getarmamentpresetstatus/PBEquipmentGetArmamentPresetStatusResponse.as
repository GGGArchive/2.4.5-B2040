package com.goodgamestudios.mafia.controller.protobuf.equipment.getarmamentpresetstatus
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBEquipmentGetArmamentPresetStatusResponse extends Message
   {
      
      public static const UNLOCKED_ARMAMENTS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.getarmamentpresetstatus.Response.unlocked_armaments","unlockedArmaments",1 << 3 | WireType.VARINT);
      
      public static const ACTIVE_ARMAMENT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.getarmamentpresetstatus.Response.active_armament","activeArmament",2 << 3 | WireType.VARINT);
      
      public static const UNLOCK_COST:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.getarmamentpresetstatus.Response.unlock_cost","unlockCost",3 << 3 | WireType.VARINT);
       
      
      public var unlockedArmaments:uint;
      
      public var activeArmament:uint;
      
      public var unlockCost:uint;
      
      public function PBEquipmentGetArmamentPresetStatusResponse()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.unlockedArmaments);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.activeArmament);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.unlockCost);
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
                     throw new IOError("Bad data format: Response.unlockedArmaments cannot be set twice.");
                  }
                  _loc3_++;
                  this.unlockedArmaments = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.activeArmament cannot be set twice.");
                  }
                  _loc4_++;
                  this.activeArmament = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.unlockCost cannot be set twice.");
                  }
                  _loc5_++;
                  this.unlockCost = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
