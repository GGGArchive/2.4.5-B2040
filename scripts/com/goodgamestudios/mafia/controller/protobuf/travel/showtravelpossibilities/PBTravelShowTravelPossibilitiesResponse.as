package com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities
{
   import com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.response.PBTravelShowTravelPossibilitiesResult;
   import com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.response.PBTravelShowTravelPossibilitiesTarget;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBTravelShowTravelPossibilitiesResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.Response.result","result",1 << 3 | WireType.VARINT,PBTravelShowTravelPossibilitiesResult);
      
      public static const CITY_EVENT:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.Response.city_event","cityEvent",2 << 3 | WireType.LENGTH_DELIMITED,PBTravelShowTravelPossibilitiesTarget);
      
      public static const CITIES:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.Response.cities","cities",3 << 3 | WireType.LENGTH_DELIMITED,PBTravelShowTravelPossibilitiesTarget);
       
      
      public var result:int;
      
      private var city_event$field:PBTravelShowTravelPossibilitiesTarget;
      
      public var cities:Array;
      
      public function PBTravelShowTravelPossibilitiesResponse()
      {
         this.cities = [];
         super();
      }
      
      public function clearCityEvent() : void
      {
         this.city_event$field = null;
      }
      
      public function get hasCityEvent() : Boolean
      {
         return this.city_event$field != null;
      }
      
      public function set cityEvent(param1:PBTravelShowTravelPossibilitiesTarget) : void
      {
         this.city_event$field = param1;
      }
      
      public function get cityEvent() : PBTravelShowTravelPossibilitiesTarget
      {
         return this.city_event$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasCityEvent)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,this.city_event$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.cities.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,this.cities[_loc2_]);
            _loc2_++;
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
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
                     throw new IOError("Bad data format: Response.cityEvent cannot be set twice.");
                  }
                  _loc4_++;
                  this.cityEvent = new PBTravelShowTravelPossibilitiesTarget();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.cityEvent);
                  continue;
               case 3:
                  this.cities.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBTravelShowTravelPossibilitiesTarget()));
                  continue;
               default:
                  super.readUnknown(param1,_loc5_);
                  continue;
            }
         }
      }
   }
}
