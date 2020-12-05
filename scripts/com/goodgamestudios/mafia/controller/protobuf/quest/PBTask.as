package com.goodgamestudios.mafia.controller.protobuf.quest
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCity;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBTask extends Message
   {
      
      public static const TASK_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.quest.Task.task_id","taskId",1 << 3 | WireType.VARINT);
      
      public static const ICON_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.quest.Task.icon_id","iconId",2 << 3 | WireType.VARINT);
      
      public static const REQUIRED_VALUE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.quest.Task.required_value","requiredValue",3 << 3 | WireType.VARINT);
      
      public static const CURRENT_VALUE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.quest.Task.current_value","currentValue",4 << 3 | WireType.VARINT);
      
      public static const CITY:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.quest.Task.city","city",5 << 3 | WireType.VARINT,PBCity);
      
      public static const DISTRICT_NUMBER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.quest.Task.district_number","districtNumber",6 << 3 | WireType.VARINT);
       
      
      public var taskId:uint;
      
      public var iconId:uint;
      
      public var requiredValue:uint;
      
      public var currentValue:uint;
      
      private var city$field:int;
      
      private var hasField$0:uint = 0;
      
      private var district_number$field:uint;
      
      public function PBTask()
      {
         super();
      }
      
      public function clearCity() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.city$field = new int();
      }
      
      public function get hasCity() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set city(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.city$field = param1;
      }
      
      public function get city() : int
      {
         return this.city$field;
      }
      
      public function clearDistrictNumber() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.district_number$field = new uint();
      }
      
      public function get hasDistrictNumber() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set districtNumber(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.district_number$field = param1;
      }
      
      public function get districtNumber() : uint
      {
         return this.district_number$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.taskId);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.iconId);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.requiredValue);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.currentValue);
         if(this.hasCity)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_ENUM(param1,this.city$field);
         }
         if(this.hasDistrictNumber)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,this.district_number$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc9_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc9_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: Task.taskId cannot be set twice.");
                  }
                  _loc3_++;
                  this.taskId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Task.iconId cannot be set twice.");
                  }
                  _loc4_++;
                  this.iconId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Task.requiredValue cannot be set twice.");
                  }
                  _loc5_++;
                  this.requiredValue = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Task.currentValue cannot be set twice.");
                  }
                  _loc6_++;
                  this.currentValue = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Task.city cannot be set twice.");
                  }
                  _loc7_++;
                  this.city = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Task.districtNumber cannot be set twice.");
                  }
                  _loc8_++;
                  this.districtNumber = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc9_);
                  continue;
            }
         }
      }
   }
}
