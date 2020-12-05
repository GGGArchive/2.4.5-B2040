package com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventmission
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBPlayerStatus;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventmission.response.PBSpecialeventCityStartCityEventMissionResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBSpecialeventCityStartCityEventMissionResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventmission.Response.result","result",1 << 3 | WireType.VARINT,PBSpecialeventCityStartCityEventMissionResult);
      
      public static const PLAYER_STATUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventmission.Response.player_status","playerStatus",2 << 3 | WireType.VARINT,PBPlayerStatus);
      
      public static const PROGRESS_TIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventmission.Response.progress_time","progressTime",3 << 3 | WireType.VARINT);
      
      public static const REMAINING_TIME:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventmission.Response.remaining_time","remainingTime",4 << 3 | WireType.VARINT);
      
      public static const MISSION_GIVER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventmission.Response.mission_giver","missionGiver",5 << 3 | WireType.VARINT);
      
      public static const MISSION_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.city.startcityeventmission.Response.mission_id","missionId",6 << 3 | WireType.VARINT);
       
      
      public var result:int;
      
      private var player_status$field:int;
      
      private var hasField$0:uint = 0;
      
      private var progress_time$field:uint;
      
      private var remaining_time$field:int;
      
      private var mission_giver$field:uint;
      
      private var mission_id$field:uint;
      
      public function PBSpecialeventCityStartCityEventMissionResponse()
      {
         super();
      }
      
      public function clearPlayerStatus() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.player_status$field = new int();
      }
      
      public function get hasPlayerStatus() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set playerStatus(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.player_status$field = param1;
      }
      
      public function get playerStatus() : int
      {
         return this.player_status$field;
      }
      
      public function clearProgressTime() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.progress_time$field = new uint();
      }
      
      public function get hasProgressTime() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set progressTime(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.progress_time$field = param1;
      }
      
      public function get progressTime() : uint
      {
         return this.progress_time$field;
      }
      
      public function clearRemainingTime() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.remaining_time$field = new int();
      }
      
      public function get hasRemainingTime() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set remainingTime(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.remaining_time$field = param1;
      }
      
      public function get remainingTime() : int
      {
         return this.remaining_time$field;
      }
      
      public function clearMissionGiver() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967287;
         this.mission_giver$field = new uint();
      }
      
      public function get hasMissionGiver() : Boolean
      {
         return (this.hasField$0 & 8) != 0;
      }
      
      public function set missionGiver(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 8;
         this.mission_giver$field = param1;
      }
      
      public function get missionGiver() : uint
      {
         if(!this.hasMissionGiver)
         {
            return 0;
         }
         return this.mission_giver$field;
      }
      
      public function clearMissionId() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967279;
         this.mission_id$field = new uint();
      }
      
      public function get hasMissionId() : Boolean
      {
         return (this.hasField$0 & 16) != 0;
      }
      
      public function set missionId(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 16;
         this.mission_id$field = param1;
      }
      
      public function get missionId() : uint
      {
         if(!this.hasMissionId)
         {
            return 0;
         }
         return this.mission_id$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasPlayerStatus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_ENUM(param1,this.player_status$field);
         }
         if(this.hasProgressTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,this.progress_time$field);
         }
         if(this.hasRemainingTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_INT32(param1,this.remaining_time$field);
         }
         if(this.hasMissionGiver)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,this.mission_giver$field);
         }
         if(this.hasMissionId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,this.mission_id$field);
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.playerStatus cannot be set twice.");
                  }
                  _loc4_++;
                  this.playerStatus = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.progressTime cannot be set twice.");
                  }
                  _loc5_++;
                  this.progressTime = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.remainingTime cannot be set twice.");
                  }
                  _loc6_++;
                  this.remainingTime = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Response.missionGiver cannot be set twice.");
                  }
                  _loc7_++;
                  this.missionGiver = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Response.missionId cannot be set twice.");
                  }
                  _loc8_++;
                  this.missionId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc9_);
                  continue;
            }
         }
      }
   }
}
