package com.goodgamestudios.mafia.controller.protobuf.shop.sellitem
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBShopSellItemRequest extends Message
   {
      
      public static const SOURCE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.shop.sellitem.Request.source","source",1 << 3 | WireType.VARINT);
      
      public static const AMOUNT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.shop.sellitem.Request.amount","amount",2 << 3 | WireType.VARINT);
       
      
      public var source:uint;
      
      private var amount$field:uint;
      
      private var hasField$0:uint = 0;
      
      public function PBShopSellItemRequest()
      {
         super();
      }
      
      public function clearAmount() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.amount$field = new uint();
      }
      
      public function get hasAmount() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set amount(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.amount$field = param1;
      }
      
      public function get amount() : uint
      {
         if(!this.hasAmount)
         {
            return 1;
         }
         return this.amount$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.source);
         if(this.hasAmount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,this.amount$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc5_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc5_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: Request.source cannot be set twice.");
                  }
                  _loc3_++;
                  this.source = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Request.amount cannot be set twice.");
                  }
                  _loc4_++;
                  this.amount = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc5_);
                  continue;
            }
         }
      }
   }
}
