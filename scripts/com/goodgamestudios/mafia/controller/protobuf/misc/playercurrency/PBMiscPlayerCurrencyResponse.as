package com.goodgamestudios.mafia.controller.protobuf.misc.playercurrency
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBMiscPlayerCurrencyResponse extends Message
   {
      
      public static const CASH:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.misc.playercurrency.Response.cash","cash",1 << 3 | WireType.VARINT);
      
      public static const GOLD:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.misc.playercurrency.Response.gold","gold",2 << 3 | WireType.VARINT);
      
      public static const POLICE_BADGES:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.misc.playercurrency.Response.police_badges","policeBadges",3 << 3 | WireType.VARINT);
       
      
      public var cash:uint;
      
      public var gold:uint;
      
      private var police_badges$field:uint;
      
      private var hasField$0:uint = 0;
      
      public function PBMiscPlayerCurrencyResponse()
      {
         super();
      }
      
      public function clearPoliceBadges() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.police_badges$field = new uint();
      }
      
      public function get hasPoliceBadges() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set policeBadges(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.police_badges$field = param1;
      }
      
      public function get policeBadges() : uint
      {
         return this.police_badges$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.cash);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.gold);
         if(this.hasPoliceBadges)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,this.police_badges$field);
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
                     throw new IOError("Bad data format: Response.cash cannot be set twice.");
                  }
                  _loc3_++;
                  this.cash = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.gold cannot be set twice.");
                  }
                  _loc4_++;
                  this.gold = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.policeBadges cannot be set twice.");
                  }
                  _loc5_++;
                  this.policeBadges = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
