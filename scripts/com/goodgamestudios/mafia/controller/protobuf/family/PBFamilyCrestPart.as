package com.goodgamestudios.mafia.controller.protobuf.family
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFamilyCrestPart extends Message
   {
      
      public static const CATEGORY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyCrestPart.category","category",1 << 3 | WireType.VARINT);
      
      public static const TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyCrestPart.type","type",2 << 3 | WireType.VARINT);
      
      public static const VARIATION:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyCrestPart.variation","variation",3 << 3 | WireType.VARINT);
      
      public static const COLOR:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyCrestPart.color","color",4 << 3 | WireType.VARINT);
      
      public static const PRICE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyCrestPart.price","price",5 << 3 | WireType.VARINT);
       
      
      public var category:uint;
      
      public var type:uint;
      
      public var variation:uint;
      
      private var color$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var price$field:uint;
      
      public function PBFamilyCrestPart()
      {
         super();
      }
      
      public function clearColor() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.color$field = new uint();
      }
      
      public function get hasColor() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set color(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.color$field = param1;
      }
      
      public function get color() : uint
      {
         return this.color$field;
      }
      
      public function clearPrice() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.price$field = new uint();
      }
      
      public function get hasPrice() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set price(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.price$field = param1;
      }
      
      public function get price() : uint
      {
         return this.price$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.category);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.type);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.variation);
         if(this.hasColor)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,this.color$field);
         }
         if(this.hasPrice)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,this.price$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc8_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc8_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyCrestPart.category cannot be set twice.");
                  }
                  _loc3_++;
                  this.category = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyCrestPart.type cannot be set twice.");
                  }
                  _loc4_++;
                  this.type = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyCrestPart.variation cannot be set twice.");
                  }
                  _loc5_++;
                  this.variation = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyCrestPart.color cannot be set twice.");
                  }
                  _loc6_++;
                  this.color = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyCrestPart.price cannot be set twice.");
                  }
                  _loc7_++;
                  this.price = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc8_);
                  continue;
            }
         }
      }
   }
}
