package com.goodgamestudios.mafia.controller.protobuf.equipment.changearmament
{
   import com.goodgamestudios.mafia.controller.protobuf.equipment.changearmament.response.PBEquipmentChangeArmamentResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBEquipmentChangeArmamentResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.equipment.changearmament.Response.result","result",1 << 3 | WireType.VARINT,PBEquipmentChangeArmamentResult);
      
      public static const INVENTORY_SLOT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.changearmament.Response.inventory_slot","inventorySlot",2 << 3 | WireType.VARINT);
      
      public static const SWAPPED_AMOUNT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.changearmament.Response.swapped_amount","swappedAmount",4 << 3 | WireType.VARINT);
       
      
      public var result:int;
      
      private var inventory_slot$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var swapped_amount$field:uint;
      
      public function PBEquipmentChangeArmamentResponse()
      {
         super();
      }
      
      public function clearInventorySlot() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.inventory_slot$field = new uint();
      }
      
      public function get hasInventorySlot() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set inventorySlot(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.inventory_slot$field = param1;
      }
      
      public function get inventorySlot() : uint
      {
         return this.inventory_slot$field;
      }
      
      public function clearSwappedAmount() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.swapped_amount$field = new uint();
      }
      
      public function get hasSwappedAmount() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set swappedAmount(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.swapped_amount$field = param1;
      }
      
      public function get swappedAmount() : uint
      {
         return this.swapped_amount$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasInventorySlot)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,this.inventory_slot$field);
         }
         if(this.hasSwappedAmount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,this.swapped_amount$field);
         }
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.inventorySlot cannot be set twice.");
                  }
                  _loc4_++;
                  this.inventorySlot = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.swappedAmount cannot be set twice.");
                  }
                  _loc5_++;
                  this.swappedAmount = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
