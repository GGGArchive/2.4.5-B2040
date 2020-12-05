package com.goodgamestudios.mafia.controller.protobuf.equipment.equiparmament
{
   import com.goodgamestudios.mafia.controller.protobuf.equipment.equiparmament.response.PBEquipmentEquipArmamentResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBEquipmentEquipArmamentResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.equipment.equiparmament.Response.result","result",1 << 3 | WireType.VARINT,PBEquipmentEquipArmamentResult);
      
      public static const INVENTORY_SLOT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.equiparmament.Response.inventory_slot","inventorySlot",2 << 3 | WireType.VARINT);
      
      public static const USED_ANOTHER_SLOT:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.equipment.equiparmament.Response.used_another_slot","usedAnotherSlot",3 << 3 | WireType.VARINT);
      
      public static const SWAPPED_AMOUNT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.equiparmament.Response.swapped_amount","swappedAmount",4 << 3 | WireType.VARINT);
       
      
      public var result:int;
      
      private var inventory_slot$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var used_another_slot$field:Boolean;
      
      private var swapped_amount$field:uint;
      
      public function PBEquipmentEquipArmamentResponse()
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
      
      public function clearUsedAnotherSlot() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.used_another_slot$field = new Boolean();
      }
      
      public function get hasUsedAnotherSlot() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set usedAnotherSlot(param1:Boolean) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.used_another_slot$field = param1;
      }
      
      public function get usedAnotherSlot() : Boolean
      {
         return this.used_another_slot$field;
      }
      
      public function clearSwappedAmount() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.swapped_amount$field = new uint();
      }
      
      public function get hasSwappedAmount() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set swappedAmount(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
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
         if(this.hasUsedAnotherSlot)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_BOOL(param1,this.used_another_slot$field);
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
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.usedAnotherSlot cannot be set twice.");
                  }
                  _loc5_++;
                  this.usedAnotherSlot = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.swappedAmount cannot be set twice.");
                  }
                  _loc6_++;
                  this.swappedAmount = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
