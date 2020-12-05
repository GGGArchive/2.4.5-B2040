package com.goodgamestudios.mafia.controller.protobuf.fight
{
   import com.goodgamestudios.mafia.controller.protobuf.common.item.PBItemQuality;
   import com.goodgamestudios.mafia.controller.protobuf.common.item.PBItemType;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightItem extends Message
   {
      
      public static const TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.FightItem.type","type",1 << 3 | WireType.VARINT,PBItemType);
      
      public static const ITEM_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.FightItem.item_id","itemId",2 << 3 | WireType.VARINT);
      
      public static const QUALITY:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.FightItem.quality","quality",3 << 3 | WireType.VARINT,PBItemQuality);
      
      public static const SUB_TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.FightItem.sub_type","subType",4 << 3 | WireType.VARINT);
       
      
      public var type:int;
      
      public var itemId:uint;
      
      public var quality:int;
      
      private var sub_type$field:uint;
      
      private var hasField$0:uint = 0;
      
      public function PBFightItem()
      {
         super();
      }
      
      public function clearSubType() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.sub_type$field = new uint();
      }
      
      public function get hasSubType() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set subType(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.sub_type$field = param1;
      }
      
      public function get subType() : uint
      {
         if(!this.hasSubType)
         {
            return 0;
         }
         return this.sub_type$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.type);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.itemId);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_ENUM(param1,this.quality);
         if(this.hasSubType)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,this.sub_type$field);
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
                     throw new IOError("Bad data format: FightItem.type cannot be set twice.");
                  }
                  _loc3_++;
                  this.type = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FightItem.itemId cannot be set twice.");
                  }
                  _loc4_++;
                  this.itemId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FightItem.quality cannot be set twice.");
                  }
                  _loc5_++;
                  this.quality = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FightItem.subType cannot be set twice.");
                  }
                  _loc6_++;
                  this.subType = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
