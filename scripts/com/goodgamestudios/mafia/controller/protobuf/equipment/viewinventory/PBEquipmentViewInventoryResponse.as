package com.goodgamestudios.mafia.controller.protobuf.equipment.viewinventory
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBEquipmentViewInventoryResponse extends Message
   {
      
      public static const ITEMS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.equipment.viewinventory.Response.items","items",1 << 3 | WireType.LENGTH_DELIMITED,PBItem);
      
      public static const UNLOCK_COST:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.equipment.viewinventory.Response.unlock_cost","unlockCost",2 << 3 | WireType.VARINT);
       
      
      public var items:Array;
      
      private var unlock_cost$field:int;
      
      private var hasField$0:uint = 0;
      
      public function PBEquipmentViewInventoryResponse()
      {
         this.items = [];
         super();
      }
      
      public function clearUnlockCost() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.unlock_cost$field = new int();
      }
      
      public function get hasUnlockCost() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set unlockCost(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.unlock_cost$field = param1;
      }
      
      public function get unlockCost() : int
      {
         if(!this.hasUnlockCost)
         {
            return -1;
         }
         return this.unlock_cost$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:uint = 0;
         while(_loc2_ < this.items.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,this.items[_loc2_]);
            _loc2_++;
         }
         if(this.hasUnlockCost)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_INT32(param1,this.unlock_cost$field);
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc4_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc4_ >> 3)
            {
               case 1:
                  this.items.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBItem()));
                  continue;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: Response.unlockCost cannot be set twice.");
                  }
                  _loc3_++;
                  this.unlockCost = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc4_);
                  continue;
            }
         }
      }
   }
}
