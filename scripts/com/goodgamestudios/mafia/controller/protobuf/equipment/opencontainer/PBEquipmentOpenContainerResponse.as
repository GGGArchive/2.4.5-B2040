package com.goodgamestudios.mafia.controller.protobuf.equipment.opencontainer
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.opencontainer.response.PBEquipmentOpenContainerResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBEquipmentOpenContainerResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.equipment.opencontainer.Response.result","result",1 << 3 | WireType.VARINT,PBEquipmentOpenContainerResult);
      
      public static const ITEM:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.equipment.opencontainer.Response.item","item",2 << 3 | WireType.LENGTH_DELIMITED,PBItem);
      
      public static const CONTAINERSLOTID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.opencontainer.Response.containerSlotId","containerSlotId",3 << 3 | WireType.VARINT);
      
      public static const STACKED:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.equipment.opencontainer.Response.stacked","stacked",4 << 3 | WireType.LENGTH_DELIMITED,PBItem);
       
      
      public var result:int;
      
      private var item$field:PBItem;
      
      private var containerSlotId$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var stacked$field:PBItem;
      
      public function PBEquipmentOpenContainerResponse()
      {
         this.result = PBEquipmentOpenContainerResult.OK;
         super();
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
      
      public function clearContainerSlotId() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.containerSlotId$field = new uint();
      }
      
      public function get hasContainerSlotId() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set containerSlotId(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.containerSlotId$field = param1;
      }
      
      public function get containerSlotId() : uint
      {
         return this.containerSlotId$field;
      }
      
      public function clearStacked() : void
      {
         this.stacked$field = null;
      }
      
      public function get hasStacked() : Boolean
      {
         return this.stacked$field != null;
      }
      
      public function set stacked(param1:PBItem) : void
      {
         this.stacked$field = param1;
      }
      
      public function get stacked() : PBItem
      {
         return this.stacked$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasItem)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,this.item$field);
         }
         if(this.hasContainerSlotId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,this.containerSlotId$field);
         }
         if(this.hasStacked)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.stacked$field);
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
                     throw new IOError("Bad data format: Response.item cannot be set twice.");
                  }
                  _loc4_++;
                  this.item = new PBItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.item);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.containerSlotId cannot be set twice.");
                  }
                  _loc5_++;
                  this.containerSlotId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.stacked cannot be set twice.");
                  }
                  _loc6_++;
                  this.stacked = new PBItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.stacked);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
