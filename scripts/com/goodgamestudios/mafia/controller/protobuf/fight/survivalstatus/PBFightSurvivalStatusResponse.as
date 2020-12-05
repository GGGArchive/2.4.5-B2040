package com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCharacterClass;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.response.PBFightSurvivalStatusResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightSurvivalStatusResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.Response.result","result",1 << 3 | WireType.VARINT,PBFightSurvivalStatusResult);
      
      public static const TIME_UNTIL_RESET:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.Response.time_until_reset","timeUntilReset",2 << 3 | WireType.VARINT);
      
      public static const CURRENT_PROGRESS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.Response.current_progress","currentProgress",3 << 3 | WireType.VARINT);
      
      public static const LAST_PROGRESS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.Response.last_progress","lastProgress",4 << 3 | WireType.VARINT);
      
      public static const ENERGY_NEEDED:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.Response.energy_needed","energyNeeded",5 << 3 | WireType.VARINT);
      
      public static const REWARD_ITEM:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.Response.reward_item","rewardItem",6 << 3 | WireType.LENGTH_DELIMITED,PBItem);
      
      public static const STAT_BEST_PROGRESS_WITHOUT_DYING:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.Response.stat_best_progress_without_dying","statBestProgressWithoutDying",7 << 3 | WireType.VARINT);
      
      public static const STAT_CURRENT_PROGRESS_WITHOUT_DYING:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.Response.stat_current_progress_without_dying","statCurrentProgressWithoutDying",8 << 3 | WireType.VARINT);
      
      public static const STAT_TIMES_WAYPOINT_REACHED:RepeatedFieldDescriptor$TYPE_UINT32 = new RepeatedFieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.Response.stat_times_waypoint_reached","statTimesWaypointReached",9 << 3 | WireType.VARINT);
      
      public static const STAT_TIMES_COMPLETED:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.Response.stat_times_completed","statTimesCompleted",10 << 3 | WireType.VARINT);
      
      public static const OPPONENTCLASS:RepeatedFieldDescriptor$TYPE_ENUM = new RepeatedFieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.Response.opponentClass","opponentClass",11 << 3 | WireType.VARINT,PBCharacterClass);
       
      
      public var result:int;
      
      public var timeUntilReset:uint;
      
      public var currentProgress:uint;
      
      public var lastProgress:uint;
      
      public var energyNeeded:uint;
      
      public var rewardItem:PBItem;
      
      public var statBestProgressWithoutDying:uint;
      
      public var statCurrentProgressWithoutDying:uint;
      
      public var statTimesWaypointReached:Array;
      
      public var statTimesCompleted:uint;
      
      public var opponentClass:Array;
      
      public function PBFightSurvivalStatusResponse()
      {
         this.statTimesWaypointReached = [];
         this.opponentClass = [];
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.timeUntilReset);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.currentProgress);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.lastProgress);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_UINT32(param1,this.energyNeeded);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,6);
         WriteUtils.write$TYPE_MESSAGE(param1,this.rewardItem);
         WriteUtils.writeTag(param1,WireType.VARINT,7);
         WriteUtils.write$TYPE_UINT32(param1,this.statBestProgressWithoutDying);
         WriteUtils.writeTag(param1,WireType.VARINT,8);
         WriteUtils.write$TYPE_UINT32(param1,this.statCurrentProgressWithoutDying);
         var _loc2_:uint = 0;
         while(_loc2_ < this.statTimesWaypointReached.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,9);
            WriteUtils.write$TYPE_UINT32(param1,this.statTimesWaypointReached[_loc2_]);
            _loc2_++;
         }
         WriteUtils.writeTag(param1,WireType.VARINT,10);
         WriteUtils.write$TYPE_UINT32(param1,this.statTimesCompleted);
         var _loc3_:uint = 0;
         while(_loc3_ < this.opponentClass.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,11);
            WriteUtils.write$TYPE_ENUM(param1,this.opponentClass[_loc3_]);
            _loc3_++;
         }
         for(_loc4_ in this)
         {
            super.writeUnknown(param1,_loc4_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc12_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc12_ >> 3)
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
                     throw new IOError("Bad data format: Response.timeUntilReset cannot be set twice.");
                  }
                  _loc4_++;
                  this.timeUntilReset = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.currentProgress cannot be set twice.");
                  }
                  _loc5_++;
                  this.currentProgress = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.lastProgress cannot be set twice.");
                  }
                  _loc6_++;
                  this.lastProgress = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Response.energyNeeded cannot be set twice.");
                  }
                  _loc7_++;
                  this.energyNeeded = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Response.rewardItem cannot be set twice.");
                  }
                  _loc8_++;
                  this.rewardItem = new PBItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.rewardItem);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: Response.statBestProgressWithoutDying cannot be set twice.");
                  }
                  _loc9_++;
                  this.statBestProgressWithoutDying = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: Response.statCurrentProgressWithoutDying cannot be set twice.");
                  }
                  _loc10_++;
                  this.statCurrentProgressWithoutDying = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 9:
                  if((_loc12_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,this.statTimesWaypointReached);
                  }
                  else
                  {
                     this.statTimesWaypointReached.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  continue;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: Response.statTimesCompleted cannot be set twice.");
                  }
                  _loc11_++;
                  this.statTimesCompleted = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 11:
                  if((_loc12_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_ENUM,this.opponentClass);
                  }
                  else
                  {
                     this.opponentClass.push(ReadUtils.read$TYPE_ENUM(param1));
                  }
                  continue;
               default:
                  super.readUnknown(param1,_loc12_);
                  continue;
            }
         }
      }
   }
}
