package com.goodgamestudios.mafia.controller.protobuf.fight.fightaction
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBSide;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_FLOAT;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightActionEffect extends Message
   {
      
      public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.Effect.id","id",1 << 3 | WireType.VARINT);
      
      public static const DURATION:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.Effect.duration","duration",2 << 3 | WireType.VARINT);
      
      public static const TARGET:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.Effect.target","target",3 << 3 | WireType.VARINT,PBSide);
      
      public static const VALUE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.Effect.value","value",4 << 3 | WireType.FIXED_32_BIT);
       
      
      public var id:uint;
      
      public var duration:uint;
      
      public var target:int;
      
      private var value$field:Number;
      
      private var hasField$0:uint = 0;
      
      public function PBFightActionEffect()
      {
         super();
      }
      
      public function clearValue() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.value$field = new Number();
      }
      
      public function get hasValue() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set value(param1:Number) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.value$field = param1;
      }
      
      public function get value() : Number
      {
         return this.value$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.id);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.duration);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_ENUM(param1,this.target);
         if(this.hasValue)
         {
            WriteUtils.writeTag(param1,WireType.FIXED_32_BIT,4);
            WriteUtils.write$TYPE_FLOAT(param1,this.value$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc7_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc7_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: Effect.id cannot be set twice.");
                  }
                  _loc3_++;
                  this.id = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Effect.duration cannot be set twice.");
                  }
                  _loc4_++;
                  this.duration = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Effect.target cannot be set twice.");
                  }
                  _loc5_++;
                  this.target = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Effect.value cannot be set twice.");
                  }
                  _loc6_++;
                  this.value = ReadUtils.read$TYPE_FLOAT(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
