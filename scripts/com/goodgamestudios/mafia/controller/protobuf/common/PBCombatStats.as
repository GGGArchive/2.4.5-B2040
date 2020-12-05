package com.goodgamestudios.mafia.controller.protobuf.common
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_FLOAT;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBCombatStats extends Message
   {
      
      public static const DAMAGE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.CombatStats.damage","damage",1 << 3 | WireType.VARINT);
      
      public static const HEALTH:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.CombatStats.health","health",2 << 3 | WireType.VARINT);
      
      public static const CRITICAL_HIT_CHANCE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.goodgamestudios.mafia.controller.protobuf.common.CombatStats.critical_hit_chance","criticalHitChance",3 << 3 | WireType.FIXED_32_BIT);
      
      public static const RESISTANCE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.goodgamestudios.mafia.controller.protobuf.common.CombatStats.resistance","resistance",4 << 3 | WireType.FIXED_32_BIT);
      
      public static const HIT_CHANCE:FieldDescriptor$TYPE_FLOAT = new FieldDescriptor$TYPE_FLOAT("com.goodgamestudios.mafia.controller.protobuf.common.CombatStats.hit_chance","hitChance",5 << 3 | WireType.FIXED_32_BIT);
       
      
      private var damage$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var health$field:uint;
      
      private var critical_hit_chance$field:Number;
      
      private var resistance$field:Number;
      
      private var hit_chance$field:Number;
      
      public function PBCombatStats()
      {
         super();
      }
      
      public function clearDamage() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.damage$field = new uint();
      }
      
      public function get hasDamage() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set damage(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.damage$field = param1;
      }
      
      public function get damage() : uint
      {
         if(!this.hasDamage)
         {
            return 0;
         }
         return this.damage$field;
      }
      
      public function clearHealth() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.health$field = new uint();
      }
      
      public function get hasHealth() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set health(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.health$field = param1;
      }
      
      public function get health() : uint
      {
         if(!this.hasHealth)
         {
            return 0;
         }
         return this.health$field;
      }
      
      public function clearCriticalHitChance() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.critical_hit_chance$field = new Number();
      }
      
      public function get hasCriticalHitChance() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set criticalHitChance(param1:Number) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.critical_hit_chance$field = param1;
      }
      
      public function get criticalHitChance() : Number
      {
         if(!this.hasCriticalHitChance)
         {
            return 0;
         }
         return this.critical_hit_chance$field;
      }
      
      public function clearResistance() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967287;
         this.resistance$field = new Number();
      }
      
      public function get hasResistance() : Boolean
      {
         return (this.hasField$0 & 8) != 0;
      }
      
      public function set resistance(param1:Number) : void
      {
         this.hasField$0 = this.hasField$0 | 8;
         this.resistance$field = param1;
      }
      
      public function get resistance() : Number
      {
         if(!this.hasResistance)
         {
            return 0;
         }
         return this.resistance$field;
      }
      
      public function clearHitChance() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967279;
         this.hit_chance$field = new Number();
      }
      
      public function get hasHitChance() : Boolean
      {
         return (this.hasField$0 & 16) != 0;
      }
      
      public function set hitChance(param1:Number) : void
      {
         this.hasField$0 = this.hasField$0 | 16;
         this.hit_chance$field = param1;
      }
      
      public function get hitChance() : Number
      {
         if(!this.hasHitChance)
         {
            return 0;
         }
         return this.hit_chance$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         if(this.hasDamage)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,this.damage$field);
         }
         if(this.hasHealth)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,this.health$field);
         }
         if(this.hasCriticalHitChance)
         {
            WriteUtils.writeTag(param1,WireType.FIXED_32_BIT,3);
            WriteUtils.write$TYPE_FLOAT(param1,this.critical_hit_chance$field);
         }
         if(this.hasResistance)
         {
            WriteUtils.writeTag(param1,WireType.FIXED_32_BIT,4);
            WriteUtils.write$TYPE_FLOAT(param1,this.resistance$field);
         }
         if(this.hasHitChance)
         {
            WriteUtils.writeTag(param1,WireType.FIXED_32_BIT,5);
            WriteUtils.write$TYPE_FLOAT(param1,this.hit_chance$field);
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
                     throw new IOError("Bad data format: CombatStats.damage cannot be set twice.");
                  }
                  _loc3_++;
                  this.damage = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CombatStats.health cannot be set twice.");
                  }
                  _loc4_++;
                  this.health = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CombatStats.criticalHitChance cannot be set twice.");
                  }
                  _loc5_++;
                  this.criticalHitChance = ReadUtils.read$TYPE_FLOAT(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CombatStats.resistance cannot be set twice.");
                  }
                  _loc6_++;
                  this.resistance = ReadUtils.read$TYPE_FLOAT(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CombatStats.hitChance cannot be set twice.");
                  }
                  _loc7_++;
                  this.hitChance = ReadUtils.read$TYPE_FLOAT(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc8_);
                  continue;
            }
         }
      }
   }
}
