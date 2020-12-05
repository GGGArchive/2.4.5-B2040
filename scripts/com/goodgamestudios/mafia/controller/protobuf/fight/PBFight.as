package com.goodgamestudios.mafia.controller.protobuf.fight
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBSide;
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
   
   public final class PBFight extends Message
   {
      
      public static const LEFT_FIGHTER:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.Fight.left_fighter","leftFighter",1 << 3 | WireType.LENGTH_DELIMITED,PBFighter);
      
      public static const RIGHT_FIGHTER:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.Fight.right_fighter","rightFighter",2 << 3 | WireType.LENGTH_DELIMITED,PBFighter);
      
      public static const WINNER:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.Fight.winner","winner",3 << 3 | WireType.VARINT,PBSide);
      
      public static const TURNS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.Fight.turns","turns",4 << 3 | WireType.LENGTH_DELIMITED,PBFightTurn);
      
      public static const LEFT_AMMUNITION:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.Fight.left_ammunition","leftAmmunition",5 << 3 | WireType.LENGTH_DELIMITED,PBFightItem);
      
      public static const RIGHT_AMMUNITION:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.Fight.right_ammunition","rightAmmunition",6 << 3 | WireType.LENGTH_DELIMITED,PBFightItem);
       
      
      public var leftFighter:PBFighter;
      
      public var rightFighter:PBFighter;
      
      public var winner:int;
      
      public var turns:Array;
      
      public var leftAmmunition:Array;
      
      public var rightAmmunition:Array;
      
      public function PBFight()
      {
         this.turns = [];
         this.leftAmmunition = [];
         this.rightAmmunition = [];
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc5_:* = undefined;
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
         WriteUtils.write$TYPE_MESSAGE(param1,this.leftFighter);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
         WriteUtils.write$TYPE_MESSAGE(param1,this.rightFighter);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_ENUM(param1,this.winner);
         var _loc2_:uint = 0;
         while(_loc2_ < this.turns.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.turns[_loc2_]);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this.leftAmmunition.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,5);
            WriteUtils.write$TYPE_MESSAGE(param1,this.leftAmmunition[_loc3_]);
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < this.rightAmmunition.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,6);
            WriteUtils.write$TYPE_MESSAGE(param1,this.rightAmmunition[_loc4_]);
            _loc4_++;
         }
         for(_loc5_ in this)
         {
            super.writeUnknown(param1,_loc5_);
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
                     throw new IOError("Bad data format: Fight.leftFighter cannot be set twice.");
                  }
                  _loc3_++;
                  this.leftFighter = new PBFighter();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.leftFighter);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Fight.rightFighter cannot be set twice.");
                  }
                  _loc4_++;
                  this.rightFighter = new PBFighter();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.rightFighter);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Fight.winner cannot be set twice.");
                  }
                  _loc5_++;
                  this.winner = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 4:
                  this.turns.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBFightTurn()));
                  continue;
               case 5:
                  this.leftAmmunition.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBFightItem()));
                  continue;
               case 6:
                  this.rightAmmunition.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBFightItem()));
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
