package com.goodgamestudios.mafia.controller.protobuf.fight.policeencounter
{
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFighter;
   import com.goodgamestudios.mafia.controller.protobuf.fight.policeencounter.response.PBFightPoliceEncounterPoliceInfo;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightPoliceEncounterResponse extends Message
   {
      
      public static const FIGHTER:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.policeencounter.Response.fighter","fighter",1 << 3 | WireType.LENGTH_DELIMITED,PBFighter);
      
      public static const POLICE_INFO:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.policeencounter.Response.police_info","policeInfo",2 << 3 | WireType.LENGTH_DELIMITED,PBFightPoliceEncounterPoliceInfo);
      
      public static const NUM_BADGES_REWARD:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.fight.policeencounter.Response.num_badges_reward","numBadgesReward",3 << 3 | WireType.VARINT);
       
      
      public var fighter:PBFighter;
      
      private var police_info$field:PBFightPoliceEncounterPoliceInfo;
      
      private var num_badges_reward$field:int;
      
      private var hasField$0:uint = 0;
      
      public function PBFightPoliceEncounterResponse()
      {
         super();
      }
      
      public function clearPoliceInfo() : void
      {
         this.police_info$field = null;
      }
      
      public function get hasPoliceInfo() : Boolean
      {
         return this.police_info$field != null;
      }
      
      public function set policeInfo(param1:PBFightPoliceEncounterPoliceInfo) : void
      {
         this.police_info$field = param1;
      }
      
      public function get policeInfo() : PBFightPoliceEncounterPoliceInfo
      {
         return this.police_info$field;
      }
      
      public function clearNumBadgesReward() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.num_badges_reward$field = new int();
      }
      
      public function get hasNumBadgesReward() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set numBadgesReward(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.num_badges_reward$field = param1;
      }
      
      public function get numBadgesReward() : int
      {
         return this.num_badges_reward$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
         WriteUtils.write$TYPE_MESSAGE(param1,this.fighter);
         if(this.hasPoliceInfo)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,this.police_info$field);
         }
         if(this.hasNumBadgesReward)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_INT32(param1,this.num_badges_reward$field);
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
                     throw new IOError("Bad data format: Response.fighter cannot be set twice.");
                  }
                  _loc3_++;
                  this.fighter = new PBFighter();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.fighter);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.policeInfo cannot be set twice.");
                  }
                  _loc4_++;
                  this.policeInfo = new PBFightPoliceEncounterPoliceInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.policeInfo);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.numBadgesReward cannot be set twice.");
                  }
                  _loc5_++;
                  this.numBadgesReward = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
