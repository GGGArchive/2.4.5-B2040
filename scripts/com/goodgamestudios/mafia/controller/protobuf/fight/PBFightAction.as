package com.goodgamestudios.mafia.controller.protobuf.fight
{
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionConsume;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionEffect;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionHit;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionType;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightAction extends Message
   {
      
      public static const TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.type","type",1 << 3 | WireType.VARINT,PBFightActionType);
      
      public static const HIT:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.hit","hit",2 << 3 | WireType.LENGTH_DELIMITED,PBFightActionHit);
      
      public static const CONSUME:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.consume","consume",3 << 3 | WireType.LENGTH_DELIMITED,PBFightActionConsume);
      
      public static const EFFECT:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.effect","effect",4 << 3 | WireType.LENGTH_DELIMITED,PBFightActionEffect);
       
      
      public var type:int;
      
      private var hit$field:PBFightActionHit;
      
      private var consume$field:PBFightActionConsume;
      
      private var effect$field:PBFightActionEffect;
      
      public function PBFightAction()
      {
         super();
      }
      
      public function clearHit() : void
      {
         this.hit$field = null;
      }
      
      public function get hasHit() : Boolean
      {
         return this.hit$field != null;
      }
      
      public function set hit(param1:PBFightActionHit) : void
      {
         this.hit$field = param1;
      }
      
      public function get hit() : PBFightActionHit
      {
         return this.hit$field;
      }
      
      public function clearConsume() : void
      {
         this.consume$field = null;
      }
      
      public function get hasConsume() : Boolean
      {
         return this.consume$field != null;
      }
      
      public function set consume(param1:PBFightActionConsume) : void
      {
         this.consume$field = param1;
      }
      
      public function get consume() : PBFightActionConsume
      {
         return this.consume$field;
      }
      
      public function clearEffect() : void
      {
         this.effect$field = null;
      }
      
      public function get hasEffect() : Boolean
      {
         return this.effect$field != null;
      }
      
      public function set effect(param1:PBFightActionEffect) : void
      {
         this.effect$field = param1;
      }
      
      public function get effect() : PBFightActionEffect
      {
         return this.effect$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.type);
         if(this.hasHit)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,this.hit$field);
         }
         if(this.hasConsume)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,this.consume$field);
         }
         if(this.hasEffect)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.effect$field);
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
                     throw new IOError("Bad data format: FightAction.type cannot be set twice.");
                  }
                  _loc3_++;
                  this.type = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FightAction.hit cannot be set twice.");
                  }
                  _loc4_++;
                  this.hit = new PBFightActionHit();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.hit);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FightAction.consume cannot be set twice.");
                  }
                  _loc5_++;
                  this.consume = new PBFightActionConsume();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.consume);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FightAction.effect cannot be set twice.");
                  }
                  _loc6_++;
                  this.effect = new PBFightActionEffect();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.effect);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
