package com.goodgamestudios.mafia.controller.protobuf.shop.buyitem
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.shop.buyitem.response.PBShopBuyItemResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBShopBuyItemResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.shop.buyitem.Response.result","result",1 << 3 | WireType.VARINT,PBShopBuyItemResult);
      
      public static const ITEM:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.shop.buyitem.Response.item","item",2 << 3 | WireType.LENGTH_DELIMITED,PBItem);
      
      public static const STACKED:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.shop.buyitem.Response.stacked","stacked",3 << 3 | WireType.VARINT);
       
      
      public var result:int = 1;
      
      private var item$field:PBItem;
      
      private var stacked$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      public function PBShopBuyItemResponse()
      {
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
      
      public function clearStacked() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.stacked$field = new Boolean();
      }
      
      public function get hasStacked() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set stacked(param1:Boolean) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.stacked$field = param1;
      }
      
      public function get stacked() : Boolean
      {
         if(!this.hasStacked)
         {
            return false;
         }
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
         if(this.hasStacked)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_BOOL(param1,this.stacked$field);
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
                     throw new IOError("Bad data format: Response.stacked cannot be set twice.");
                  }
                  _loc5_++;
                  this.stacked = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
