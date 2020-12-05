package com.goodgamestudios.mafia.controller.protobuf.shop.buyitem
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBShopType;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBShopBuyItemRequest extends Message
   {
      
      public static const SHOP:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.shop.buyitem.Request.shop","shop",1 << 3 | WireType.VARINT,PBShopType);
      
      public static const SOURCE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.shop.buyitem.Request.source","source",2 << 3 | WireType.VARINT);
      
      public static const TARGET:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.shop.buyitem.Request.target","target",3 << 3 | WireType.VARINT);
       
      
      public var shop:int;
      
      public var source:int;
      
      public var target:uint;
      
      public function PBShopBuyItemRequest()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.shop);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_INT32(param1,this.source);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.target);
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
                     throw new IOError("Bad data format: Request.shop cannot be set twice.");
                  }
                  _loc3_++;
                  this.shop = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Request.source cannot be set twice.");
                  }
                  _loc4_++;
                  this.source = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Request.target cannot be set twice.");
                  }
                  _loc5_++;
                  this.target = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
