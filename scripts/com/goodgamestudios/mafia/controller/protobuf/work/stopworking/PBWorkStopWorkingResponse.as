package com.goodgamestudios.mafia.controller.protobuf.work.stopworking
{
   import com.goodgamestudios.mafia.controller.protobuf.work.stopworking.response.PBWorkStopWorkingResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBWorkStopWorkingResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.work.stopworking.Response.result","result",1 << 3 | WireType.VARINT,PBWorkStopWorkingResult);
      
      public static const CASH_FOR_WORK:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.work.stopworking.Response.cash_for_work","cashForWork",2 << 3 | WireType.VARINT);
      
      public static const CASH_BONUS_FOR_FAMILY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.work.stopworking.Response.cash_bonus_for_family","cashBonusForFamily",3 << 3 | WireType.VARINT);
      
      public static const CASH_BONUS_FOR_ACHIEVEMENT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.work.stopworking.Response.cash_bonus_for_achievement","cashBonusForAchievement",4 << 3 | WireType.VARINT);
      
      public static const WORK_DURATION:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.work.stopworking.Response.work_duration","workDuration",5 << 3 | WireType.VARINT);
       
      
      public var result:int;
      
      public var cashForWork:uint;
      
      public var cashBonusForFamily:uint;
      
      public var cashBonusForAchievement:uint;
      
      public var workDuration:uint;
      
      public function PBWorkStopWorkingResponse()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.cashForWork);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.cashBonusForFamily);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.cashBonusForAchievement);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_UINT32(param1,this.workDuration);
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.cashForWork cannot be set twice.");
                  }
                  _loc4_++;
                  this.cashForWork = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.cashBonusForFamily cannot be set twice.");
                  }
                  _loc5_++;
                  this.cashBonusForFamily = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.cashBonusForAchievement cannot be set twice.");
                  }
                  _loc6_++;
                  this.cashBonusForAchievement = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Response.workDuration cannot be set twice.");
                  }
                  _loc7_++;
                  this.workDuration = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc8_);
                  continue;
            }
         }
      }
   }
}
