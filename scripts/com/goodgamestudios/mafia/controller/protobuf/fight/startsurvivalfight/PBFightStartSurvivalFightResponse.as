package com.goodgamestudios.mafia.controller.protobuf.fight.startsurvivalfight
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startsurvivalfight.response.PBFightStartSurvivalFightResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightStartSurvivalFightResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.startsurvivalfight.Response.result","result",1 << 3 | WireType.VARINT,PBFightStartSurvivalFightResult);
      
      public static const MAX_FIGHTERS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.startsurvivalfight.Response.max_fighters","maxFighters",2 << 3 | WireType.VARINT);
      
      public static const FIGHT:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.startsurvivalfight.Response.fight","fight",3 << 3 | WireType.LENGTH_DELIMITED,PBFight);
      
      public static const REWARD:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.startsurvivalfight.Response.reward","reward",4 << 3 | WireType.LENGTH_DELIMITED,PBReward);
       
      
      public var result:int;
      
      private var max_fighters$field:uint;
      
      private var hasField$0:uint = 0;
      
      public var fight:Array;
      
      private var reward$field:PBReward;
      
      public function PBFightStartSurvivalFightResponse()
      {
         this.fight = [];
         super();
      }
      
      public function clearMaxFighters() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.max_fighters$field = new uint();
      }
      
      public function get hasMaxFighters() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set maxFighters(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.max_fighters$field = param1;
      }
      
      public function get maxFighters() : uint
      {
         return this.max_fighters$field;
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
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasMaxFighters)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,this.max_fighters$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.fight.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,this.fight[_loc2_]);
            _loc2_++;
         }
         if(this.hasReward)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.reward$field);
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
                     throw new IOError("Bad data format: Response.maxFighters cannot be set twice.");
                  }
                  _loc4_++;
                  this.maxFighters = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  this.fight.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBFight()));
                  continue;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.reward cannot be set twice.");
                  }
                  _loc5_++;
                  this.reward = new PBReward();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.reward);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
