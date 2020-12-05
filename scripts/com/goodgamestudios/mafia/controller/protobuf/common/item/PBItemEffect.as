package com.goodgamestudios.mafia.controller.protobuf.common.item
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_FLOAT;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBItemEffect extends Message
   {
      
      public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.Item.Effect.id","id",1 << 3 | WireType.VARINT);
      
      public static const FIRST:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.goodgamestudios.mafia.controller.protobuf.common.Item.Effect.first","first",2 << 3 | WireType.FIXED_32_BIT);
      
      public static const SECOND:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.goodgamestudios.mafia.controller.protobuf.common.Item.Effect.second","second",3 << 3 | WireType.FIXED_32_BIT);
       
      
      public var id:uint;
      
      public var first:Number;
      
      private var second$field:Number;
      
      private var hasField$0:uint = 0;
      
      public function PBItemEffect()
      {
         super();
      }
      
      public function clearSecond() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.second$field = new Number();
      }
      
      public function get hasSecond() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set second(param1:Number) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.second$field = param1;
      }
      
      public function get second() : Number
      {
         if(!this.hasSecond)
         {
            return 0;
         }
         return this.second$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.id);
         WriteUtils.writeTag(param1,WireType.FIXED_32_BIT,2);
         WriteUtils.write$TYPE_FLOAT(param1,this.first);
         if(this.hasSecond)
         {
            WriteUtils.writeTag(param1,WireType.FIXED_32_BIT,3);
            WriteUtils.write$TYPE_FLOAT(param1,this.second$field);
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
                     throw new IOError("Bad data format: Effect.id cannot be set twice.");
                  }
                  _loc3_++;
                  this.id = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Effect.first cannot be set twice.");
                  }
                  _loc4_++;
                  this.first = ReadUtils.read$TYPE_FLOAT(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Effect.second cannot be set twice.");
                  }
                  _loc5_++;
                  this.second = ReadUtils.read$TYPE_FLOAT(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
