package com.goodgamestudios.mafia.controller.protobuf.fight.showcityfightitems
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.fight.showcityfightitems.response.PBFightShowCityFightItemsResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightShowCityFightItemsResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.showcityfightitems.Response.result","result",1 << 3 | WireType.VARINT,PBFightShowCityFightItemsResult);
      
      public static const PIC_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.showcityfightitems.Response.pic_id","picId",2 << 3 | WireType.VARINT);
      
      public static const LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.showcityfightitems.Response.level","level",3 << 3 | WireType.VARINT);
      
      public static const ITEMS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.showcityfightitems.Response.items","items",4 << 3 | WireType.LENGTH_DELIMITED,PBItem);
       
      
      public var result:int;
      
      private var pic_id$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var level$field:uint;
      
      public var items:Array;
      
      public function PBFightShowCityFightItemsResponse()
      {
         this.items = [];
         super();
      }
      
      public function clearPicId() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.pic_id$field = new uint();
      }
      
      public function get hasPicId() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set picId(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.pic_id$field = param1;
      }
      
      public function get picId() : uint
      {
         return this.pic_id$field;
      }
      
      public function clearLevel() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.level$field = new uint();
      }
      
      public function get hasLevel() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set level(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.level$field = param1;
      }
      
      public function get level() : uint
      {
         return this.level$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasPicId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,this.pic_id$field);
         }
         if(this.hasLevel)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,this.level$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.items.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.items[_loc2_]);
            _loc2_++;
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
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
                     throw new IOError("Bad data format: Response.picId cannot be set twice.");
                  }
                  _loc4_++;
                  this.picId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.level cannot be set twice.");
                  }
                  _loc5_++;
                  this.level = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  this.items.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBItem()));
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
