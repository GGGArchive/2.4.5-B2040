package com.goodgamestudios.mafia.controller.protobuf.specialevent.city.showcityeventopponents
{
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.showcityeventopponents.response.PBSpecialeventCityShowCityEventOpponentsOpponent;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.showcityeventopponents.response.PBSpecialeventCityShowCityEventOpponentsResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBSpecialeventCityShowCityEventOpponentsResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.showcityeventopponents.Response.result","result",1 << 3 | WireType.VARINT,PBSpecialeventCityShowCityEventOpponentsResult);
      
      public static const NEXT_FREE_TIME:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.showcityeventopponents.Response.next_free_time","nextFreeTime",2 << 3 | WireType.VARINT);
      
      public static const GANGWAR_PROGRESS:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.showcityeventopponents.Response.gangwar_progress","gangwarProgress",3 << 3 | WireType.VARINT);
      
      public static const OPPONENTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.showcityeventopponents.Response.opponents","opponents",4 << 3 | WireType.LENGTH_DELIMITED,PBSpecialeventCityShowCityEventOpponentsOpponent);
       
      
      public var result:int;
      
      private var next_free_time$field:int;
      
      private var hasField$0:uint = 0;
      
      private var gangwar_progress$field:int;
      
      public var opponents:Array;
      
      public function PBSpecialeventCityShowCityEventOpponentsResponse()
      {
         this.opponents = [];
         super();
      }
      
      public function clearNextFreeTime() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.next_free_time$field = new int();
      }
      
      public function get hasNextFreeTime() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set nextFreeTime(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.next_free_time$field = param1;
      }
      
      public function get nextFreeTime() : int
      {
         return this.next_free_time$field;
      }
      
      public function clearGangwarProgress() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.gangwar_progress$field = new int();
      }
      
      public function get hasGangwarProgress() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set gangwarProgress(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.gangwar_progress$field = param1;
      }
      
      public function get gangwarProgress() : int
      {
         return this.gangwar_progress$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasNextFreeTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_INT32(param1,this.next_free_time$field);
         }
         if(this.hasGangwarProgress)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_INT32(param1,this.gangwar_progress$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.opponents.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.opponents[_loc2_]);
            _loc2_++;
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
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
                     throw new IOError("Bad data format: Response.nextFreeTime cannot be set twice.");
                  }
                  _loc4_++;
                  this.nextFreeTime = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.gangwarProgress cannot be set twice.");
                  }
                  _loc5_++;
                  this.gangwarProgress = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 4:
                  this.opponents.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBSpecialeventCityShowCityEventOpponentsOpponent()));
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
