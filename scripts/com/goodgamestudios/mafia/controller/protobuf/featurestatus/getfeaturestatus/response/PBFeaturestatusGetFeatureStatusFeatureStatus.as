package com.goodgamestudios.mafia.controller.protobuf.featurestatus.getfeaturestatus.response
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFeaturestatusGetFeatureStatusFeatureStatus extends Message
   {
      
      public static const FEATURE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.featurestatus.getfeaturestatus.Response.FeatureStatus.feature","feature",1 << 3 | WireType.VARINT,PBFeaturestatusGetFeatureStatusFeature);
      
      public static const RUNTIME_PERIOD:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.featurestatus.getfeaturestatus.Response.FeatureStatus.runtime_period","runtimePeriod",2 << 3 | WireType.VARINT);
      
      public static const REMAINING_UNTIL_END:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.featurestatus.getfeaturestatus.Response.FeatureStatus.remaining_until_end","remainingUntilEnd",3 << 3 | WireType.VARINT);
      
      public static const REMAINING_UNTIL_START:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.featurestatus.getfeaturestatus.Response.FeatureStatus.remaining_until_start","remainingUntilStart",4 << 3 | WireType.VARINT);
       
      
      public var feature:int;
      
      public var runtimePeriod:int;
      
      public var remainingUntilEnd:int;
      
      public var remainingUntilStart:int;
      
      public function PBFeaturestatusGetFeatureStatusFeatureStatus()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.feature);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_INT32(param1,this.runtimePeriod);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_INT32(param1,this.remainingUntilEnd);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_INT32(param1,this.remainingUntilStart);
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
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
                     throw new IOError("Bad data format: FeatureStatus.feature cannot be set twice.");
                  }
                  _loc3_++;
                  this.feature = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FeatureStatus.runtimePeriod cannot be set twice.");
                  }
                  _loc4_++;
                  this.runtimePeriod = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FeatureStatus.remainingUntilEnd cannot be set twice.");
                  }
                  _loc5_++;
                  this.remainingUntilEnd = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FeatureStatus.remainingUntilStart cannot be set twice.");
                  }
                  _loc6_++;
                  this.remainingUntilStart = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
