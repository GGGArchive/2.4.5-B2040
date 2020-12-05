package com.goodgamestudios.mafia.controller.protobuf.fight.startcityfight
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startcityfight.response.PBFightStartCityFightResult;
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
   
   public final class PBFightStartCityFightResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.startcityfight.Response.result","result",1 << 3 | WireType.VARINT,PBFightStartCityFightResult);
      
      public static const REWARD:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.startcityfight.Response.reward","reward",2 << 3 | WireType.LENGTH_DELIMITED,PBReward);
      
      public static const FIGHT:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.startcityfight.Response.fight","fight",3 << 3 | WireType.LENGTH_DELIMITED,PBFight);
      
      public static const ITEMS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.startcityfight.Response.items","items",4 << 3 | WireType.LENGTH_DELIMITED,PBItem);
       
      
      public var result:int;
      
      private var reward$field:PBReward;
      
      private var fight$field:PBFight;
      
      public var items:Array;
      
      public function PBFightStartCityFightResponse()
      {
         this.items = [];
         super();
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
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasReward)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,this.reward$field);
         }
         if(this.hasFight)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,this.fight$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.items.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.items[_loc2_]);
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
                     throw new IOError("Bad data format: Response.reward cannot be set twice.");
                  }
                  _loc4_++;
                  this.reward = new PBReward();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.reward);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.fight cannot be set twice.");
                  }
                  _loc5_++;
                  this.fight = new PBFight();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.fight);
                  continue;
               case 4:
                  this.items.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBItem()));
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
