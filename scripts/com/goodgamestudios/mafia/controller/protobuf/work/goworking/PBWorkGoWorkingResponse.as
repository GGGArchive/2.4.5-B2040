package com.goodgamestudios.mafia.controller.protobuf.work.goworking
{
   import com.goodgamestudios.mafia.controller.protobuf.work.goworking.response.PBWorkGoWorkingResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBWorkGoWorkingResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.work.goworking.Response.result","result",1 << 3 | WireType.VARINT,PBWorkGoWorkingResult);
      
      public static const CURRENT_WORK_DURATION:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.work.goworking.Response.current_work_duration","currentWorkDuration",2 << 3 | WireType.VARINT);
       
      
      public var result:int;
      
      private var current_work_duration$field:uint;
      
      private var hasField$0:uint = 0;
      
      public function PBWorkGoWorkingResponse()
      {
         super();
      }
      
      public function clearCurrentWorkDuration() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.current_work_duration$field = new uint();
      }
      
      public function get hasCurrentWorkDuration() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set currentWorkDuration(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.current_work_duration$field = param1;
      }
      
      public function get currentWorkDuration() : uint
      {
         return this.current_work_duration$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasCurrentWorkDuration)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,this.current_work_duration$field);
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.currentWorkDuration cannot be set twice.");
                  }
                  _loc4_++;
                  this.currentWorkDuration = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc5_);
                  continue;
            }
         }
      }
   }
}
