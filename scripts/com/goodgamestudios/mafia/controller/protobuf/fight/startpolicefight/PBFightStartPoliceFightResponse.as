package com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.response.PBFightStartPoliceFightPoliceInfo;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.response.PBFightStartPoliceFightResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightStartPoliceFightResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.Response.result","result",1 << 3 | WireType.VARINT,PBFightStartPoliceFightResult);
      
      public static const FIGHT:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.Response.fight","fight",2 << 3 | WireType.LENGTH_DELIMITED,PBFight);
      
      public static const REWARD:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.Response.reward","reward",3 << 3 | WireType.LENGTH_DELIMITED,PBReward);
      
      public static const POLICE_INFO:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.Response.police_info","policeInfo",4 << 3 | WireType.LENGTH_DELIMITED,PBFightStartPoliceFightPoliceInfo);
      
      public static const POLICEBADGEREWARD:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.Response.policeBadgeReward","policeBadgeReward",5 << 3 | WireType.VARINT);
       
      
      public var result:int;
      
      private var fight$field:PBFight;
      
      private var reward$field:PBReward;
      
      private var police_info$field:PBFightStartPoliceFightPoliceInfo;
      
      private var policeBadgeReward$field:uint;
      
      private var hasField$0:uint = 0;
      
      public function PBFightStartPoliceFightResponse()
      {
         super();
      }
      
      public function clearFight() : void
      {
         this.fight$field = null;
      }
      
      public function get hasFight() : Boolean
      {
         return this.fight$field != null;
      }
      
      public function set fight(param1:PBFight) : void
      {
         this.fight$field = param1;
      }
      
      public function get fight() : PBFight
      {
         return this.fight$field;
      }
      
      public function clearReward() : void
      {
         this.reward$field = null;
      }
      
      public function get hasReward() : Boolean
      {
         return this.reward$field != null;
      }
      
      public function set reward(param1:PBReward) : void
      {
         this.reward$field = param1;
      }
      
      public function get reward() : PBReward
      {
         return this.reward$field;
      }
      
      public function clearPoliceInfo() : void
      {
         this.police_info$field = null;
      }
      
      public function get hasPoliceInfo() : Boolean
      {
         return this.police_info$field != null;
      }
      
      public function set policeInfo(param1:PBFightStartPoliceFightPoliceInfo) : void
      {
         this.police_info$field = param1;
      }
      
      public function get policeInfo() : PBFightStartPoliceFightPoliceInfo
      {
         return this.police_info$field;
      }
      
      public function clearPoliceBadgeReward() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.policeBadgeReward$field = new uint();
      }
      
      public function get hasPoliceBadgeReward() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set policeBadgeReward(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.policeBadgeReward$field = param1;
      }
      
      public function get policeBadgeReward() : uint
      {
         return this.policeBadgeReward$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasFight)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,this.fight$field);
         }
         if(this.hasReward)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,this.reward$field);
         }
         if(this.hasPoliceInfo)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.police_info$field);
         }
         if(this.hasPoliceBadgeReward)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,this.policeBadgeReward$field);
         }
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
                     throw new IOError("Bad data format: Response.fight cannot be set twice.");
                  }
                  _loc4_++;
                  this.fight = new PBFight();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.fight);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.reward cannot be set twice.");
                  }
                  _loc5_++;
                  this.reward = new PBReward();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.reward);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.policeInfo cannot be set twice.");
                  }
                  _loc6_++;
                  this.policeInfo = new PBFightStartPoliceFightPoliceInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.policeInfo);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Response.policeBadgeReward cannot be set twice.");
                  }
                  _loc7_++;
                  this.policeBadgeReward = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc8_);
                  continue;
            }
         }
      }
   }
}
