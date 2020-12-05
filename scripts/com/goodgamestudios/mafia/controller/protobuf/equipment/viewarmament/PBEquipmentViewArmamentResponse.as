package com.goodgamestudios.mafia.controller.protobuf.equipment.viewarmament
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItemSlot;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBEquipmentViewArmamentResponse extends Message
   {
      
      public static const PLAYER_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.viewarmament.Response.player_id","playerId",1 << 3 | WireType.VARINT);
      
      public static const WIDTH:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.viewarmament.Response.width","width",2 << 3 | WireType.VARINT);
      
      public static const HEIGHT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.viewarmament.Response.height","height",3 << 3 | WireType.VARINT);
      
      public static const ITEM_SLOTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.equipment.viewarmament.Response.item_slots","itemSlots",4 << 3 | WireType.LENGTH_DELIMITED,PBItemSlot);
      
      public static const IS_UNLOCKABLE:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.equipment.viewarmament.Response.is_unlockable","isUnlockable",5 << 3 | WireType.VARINT);
      
      public static const UNLOCK_COST:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.viewarmament.Response.unlock_cost","unlockCost",6 << 3 | WireType.VARINT);
      
      public static const NEXT_PAID_UNLOCK_LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.viewarmament.Response.next_paid_unlock_level","nextPaidUnlockLevel",7 << 3 | WireType.VARINT);
      
      public static const NEXT_FREE_UNLOCK_LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.viewarmament.Response.next_free_unlock_level","nextFreeUnlockLevel",8 << 3 | WireType.VARINT);
       
      
      public var playerId:uint;
      
      public var width:uint;
      
      public var height:uint;
      
      public var itemSlots:Array;
      
      public var isUnlockable:Boolean;
      
      private var unlock_cost$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var next_paid_unlock_level$field:uint;
      
      private var next_free_unlock_level$field:uint;
      
      public function PBEquipmentViewArmamentResponse()
      {
         this.itemSlots = [];
         super();
      }
      
      public function clearUnlockCost() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.unlock_cost$field = new uint();
      }
      
      public function get hasUnlockCost() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set unlockCost(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.unlock_cost$field = param1;
      }
      
      public function get unlockCost() : uint
      {
         return this.unlock_cost$field;
      }
      
      public function clearNextPaidUnlockLevel() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.next_paid_unlock_level$field = new uint();
      }
      
      public function get hasNextPaidUnlockLevel() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set nextPaidUnlockLevel(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.next_paid_unlock_level$field = param1;
      }
      
      public function get nextPaidUnlockLevel() : uint
      {
         return this.next_paid_unlock_level$field;
      }
      
      public function clearNextFreeUnlockLevel() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.next_free_unlock_level$field = new uint();
      }
      
      public function get hasNextFreeUnlockLevel() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set nextFreeUnlockLevel(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.next_free_unlock_level$field = param1;
      }
      
      public function get nextFreeUnlockLevel() : uint
      {
         return this.next_free_unlock_level$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.playerId);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.width);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.height);
         var _loc2_:uint = 0;
         while(_loc2_ < this.itemSlots.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.itemSlots[_loc2_]);
            _loc2_++;
         }
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_BOOL(param1,this.isUnlockable);
         if(this.hasUnlockCost)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,this.unlock_cost$field);
         }
         if(this.hasNextPaidUnlockLevel)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,this.next_paid_unlock_level$field);
         }
         if(this.hasNextFreeUnlockLevel)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,8);
            WriteUtils.write$TYPE_UINT32(param1,this.next_free_unlock_level$field);
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc10_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc10_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: Response.playerId cannot be set twice.");
                  }
                  _loc3_++;
                  this.playerId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.width cannot be set twice.");
                  }
                  _loc4_++;
                  this.width = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.height cannot be set twice.");
                  }
                  _loc5_++;
                  this.height = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  this.itemSlots.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBItemSlot()));
                  continue;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.isUnlockable cannot be set twice.");
                  }
                  _loc6_++;
                  this.isUnlockable = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Response.unlockCost cannot be set twice.");
                  }
                  _loc7_++;
                  this.unlockCost = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Response.nextPaidUnlockLevel cannot be set twice.");
                  }
                  _loc8_++;
                  this.nextPaidUnlockLevel = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: Response.nextFreeUnlockLevel cannot be set twice.");
                  }
                  _loc9_++;
                  this.nextFreeUnlockLevel = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc10_);
                  continue;
            }
         }
      }
   }
}
