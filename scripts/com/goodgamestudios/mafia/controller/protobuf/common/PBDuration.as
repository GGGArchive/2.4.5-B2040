package com.goodgamestudios.mafia.controller.protobuf.common
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBDuration extends Message
   {
      
      public static const TOTAL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.Duration.total","total",1 << 3 | WireType.VARINT);
      
      public static const REMAINING:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.common.Duration.remaining","remaining",2 << 3 | WireType.VARINT);
       
      
      public var total:uint;
      
      private var remaining$field:int;
      
      private var hasField$0:uint = 0;
      
      public function PBDuration()
      {
         super();
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
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.total);
         if(this.hasRemaining)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_INT32(param1,this.remaining$field);
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
                     throw new IOError("Bad data format: Duration.total cannot be set twice.");
                  }
                  _loc3_++;
                  this.total = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Duration.remaining cannot be set twice.");
                  }
                  _loc4_++;
                  this.remaining = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc5_);
                  continue;
            }
         }
      }
   }
}
