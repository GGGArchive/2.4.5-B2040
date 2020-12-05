package com.goodgamestudios.mafia.controller.protobuf.shop.viewitems
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBShopType;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBShopViewItemsResponse extends Message
   {
      
      public static const SHOP:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.shop.viewitems.Response.shop","shop",1 << 3 | WireType.VARINT,PBShopType);
      
      public static const REFRESH:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.shop.viewitems.Response.refresh","refresh",2 << 3 | WireType.VARINT);
      
      public static const ITEMS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.shop.viewitems.Response.items","items",3 << 3 | WireType.LENGTH_DELIMITED,PBItem);
      
      public static const SAFE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.shop.viewitems.Response.safe","safe",4 << 3 | WireType.LENGTH_DELIMITED,PBItem);
      
      public static const REMAINING:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.shop.viewitems.Response.remaining","remaining",5 << 3 | WireType.VARINT);
       
      
      public var shop:int;
      
      public var refresh:int;
      
      public var items:Array;
      
      private var safe$field:PBItem;
      
      private var remaining$field:int;
      
      private var hasField$0:uint = 0;
      
      public function PBShopViewItemsResponse()
      {
         this.items = [];
         super();
      }
      
      public function clearSafe() : void
      {
         this.safe$field = null;
      }
      
      public function get hasSafe() : Boolean
      {
         return this.safe$field != null;
      }
      
      public function set safe(param1:PBItem) : void
      {
         this.safe$field = param1;
      }
      
      public function get safe() : PBItem
      {
         return this.safe$field;
      }
      
      public function clearRemaining() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.remaining$field = new int();
      }
      
      public function get hasRemaining() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set remaining(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.remaining$field = param1;
      }
      
      public function get remaining() : int
      {
         return this.remaining$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.shop);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_INT32(param1,this.refresh);
         var _loc2_:uint = 0;
         while(_loc2_ < this.items.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,this.items[_loc2_]);
            _loc2_++;
         }
         if(this.hasSafe)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.safe$field);
         }
         if(this.hasRemaining)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_INT32(param1,this.remaining$field);
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
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
                     throw new IOError("Bad data format: Response.shop cannot be set twice.");
                  }
                  _loc3_++;
                  this.shop = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.refresh cannot be set twice.");
                  }
                  _loc4_++;
                  this.refresh = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 3:
                  this.items.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBItem()));
                  continue;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.safe cannot be set twice.");
                  }
                  _loc5_++;
                  this.safe = new PBItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.safe);
                  continue;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.remaining cannot be set twice.");
                  }
                  _loc6_++;
                  this.remaining = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
