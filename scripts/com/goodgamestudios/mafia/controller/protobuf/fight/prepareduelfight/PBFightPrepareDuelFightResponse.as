package com.goodgamestudios.mafia.controller.protobuf.fight.prepareduelfight
{
   import com.goodgamestudios.mafia.controller.protobuf.fight.prepareduelfight.response.PBFightPrepareDuelFightResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightPrepareDuelFightResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.prepareduelfight.Response.result","result",1 << 3 | WireType.VARINT,PBFightPrepareDuelFightResult);
      
      public static const OPPONENT_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.prepareduelfight.Response.opponent_id","opponentId",2 << 3 | WireType.VARINT);
      
      public static const MAX_ATTACKS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.prepareduelfight.Response.max_attacks","maxAttacks",3 << 3 | WireType.VARINT);
       
      
      public var result:int;
      
      private var opponent_id$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var max_attacks$field:uint;
      
      public function PBFightPrepareDuelFightResponse()
      {
         super();
      }
      
      public function clearOpponentId() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.opponent_id$field = new uint();
      }
      
      public function get hasOpponentId() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set opponentId(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.opponent_id$field = param1;
      }
      
      public function get opponentId() : uint
      {
         return this.opponent_id$field;
      }
      
      public function clearMaxAttacks() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.max_attacks$field = new uint();
      }
      
      public function get hasMaxAttacks() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set maxAttacks(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.max_attacks$field = param1;
      }
      
      public function get maxAttacks() : uint
      {
         return this.max_attacks$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasOpponentId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,this.opponent_id$field);
         }
         if(this.hasMaxAttacks)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,this.max_attacks$field);
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.opponentId cannot be set twice.");
                  }
                  _loc4_++;
                  this.opponentId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.maxAttacks cannot be set twice.");
                  }
                  _loc5_++;
                  this.maxAttacks = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
