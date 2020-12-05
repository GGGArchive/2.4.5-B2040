package com.goodgamestudios.mafia.controller.protobuf.fight.fightaction
{
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFightItem;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.hit.PBFightActionHitResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightActionHit extends Message
   {
      
      public static const WEAPON:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.Hit.weapon","weapon",1 << 3 | WireType.LENGTH_DELIMITED,PBFightItem);
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.Hit.result","result",2 << 3 | WireType.VARINT,PBFightActionHitResult);
      
      public static const FIRST_DMG:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.Hit.first_dmg","firstDmg",3 << 3 | WireType.VARINT);
      
      public static const SECOND_DMG:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.Hit.second_dmg","secondDmg",4 << 3 | WireType.VARINT);
      
      public static const CRITICAL:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.Hit.critical","critical",5 << 3 | WireType.VARINT);
       
      
      public var weapon:PBFightItem;
      
      public var result:int;
      
      private var first_dmg$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var second_dmg$field:uint;
      
      private var critical$field:Boolean;
      
      public function PBFightActionHit()
      {
         super();
      }
      
      public function clearFirstDmg() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.first_dmg$field = new uint();
      }
      
      public function get hasFirstDmg() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set firstDmg(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.first_dmg$field = param1;
      }
      
      public function get firstDmg() : uint
      {
         if(!this.hasFirstDmg)
         {
            return 0;
         }
         return this.first_dmg$field;
      }
      
      public function clearSecondDmg() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.second_dmg$field = new uint();
      }
      
      public function get hasSecondDmg() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set secondDmg(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.second_dmg$field = param1;
      }
      
      public function get secondDmg() : uint
      {
         if(!this.hasSecondDmg)
         {
            return 0;
         }
         return this.second_dmg$field;
      }
      
      public function clearCritical() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.critical$field = new Boolean();
      }
      
      public function get hasCritical() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set critical(param1:Boolean) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.critical$field = param1;
      }
      
      public function get critical() : Boolean
      {
         if(!this.hasCritical)
         {
            return false;
         }
         return this.critical$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
         WriteUtils.write$TYPE_MESSAGE(param1,this.weapon);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasFirstDmg)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,this.first_dmg$field);
         }
         if(this.hasSecondDmg)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,this.second_dmg$field);
         }
         if(this.hasCritical)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_BOOL(param1,this.critical$field);
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
                     throw new IOError("Bad data format: Hit.weapon cannot be set twice.");
                  }
                  _loc3_++;
                  this.weapon = new PBFightItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.weapon);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Hit.result cannot be set twice.");
                  }
                  _loc4_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Hit.firstDmg cannot be set twice.");
                  }
                  _loc5_++;
                  this.firstDmg = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Hit.secondDmg cannot be set twice.");
                  }
                  _loc6_++;
                  this.secondDmg = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Hit.critical cannot be set twice.");
                  }
                  _loc7_++;
                  this.critical = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc8_);
                  continue;
            }
         }
      }
   }
}
