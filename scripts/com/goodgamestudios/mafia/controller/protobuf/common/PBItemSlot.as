package com.goodgamestudios.mafia.controller.protobuf.common
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBItemSlot extends Message
   {
      
      public static const SLOT_X:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.ItemSlot.slot_x","slotX",1 << 3 | WireType.VARINT);
      
      public static const SLOT_Y:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.ItemSlot.slot_y","slotY",2 << 3 | WireType.VARINT);
      
      public static const ACTIVE:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.common.ItemSlot.active","active",3 << 3 | WireType.VARINT);
      
      public static const ITEM:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.ItemSlot.item","item",4 << 3 | WireType.LENGTH_DELIMITED,PBItem);
       
      
      public var slotX:uint;
      
      public var slotY:uint;
      
      private var active$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var item$field:PBItem;
      
      public function PBItemSlot()
      {
         super();
      }
      
      public function clearActive() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.active$field = new Boolean();
      }
      
      public function get hasActive() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set active(param1:Boolean) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.active$field = param1;
      }
      
      public function get active() : Boolean
      {
         return this.active$field;
      }
      
      public function clearItem() : void
      {
         this.item$field = null;
      }
      
      public function get hasItem() : Boolean
      {
         return this.item$field != null;
      }
      
      public function set item(param1:PBItem) : void
      {
         this.item$field = param1;
      }
      
      public function get item() : PBItem
      {
         return this.item$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.slotX);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.slotY);
         if(this.hasActive)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_BOOL(param1,this.active$field);
         }
         if(this.hasItem)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.item$field);
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
                     throw new IOError("Bad data format: ItemSlot.slotX cannot be set twice.");
                  }
                  _loc3_++;
                  this.slotX = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ItemSlot.slotY cannot be set twice.");
                  }
                  _loc4_++;
                  this.slotY = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ItemSlot.active cannot be set twice.");
                  }
                  _loc5_++;
                  this.active = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ItemSlot.item cannot be set twice.");
                  }
                  _loc6_++;
                  this.item = new PBItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.item);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
