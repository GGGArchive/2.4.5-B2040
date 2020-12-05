package com.goodgamestudios.mafia.controller.protobuf.fight.fightaction
{
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFightItem;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightActionConsume extends Message
   {
      
      public static const ITEM:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.Consume.item","item",1 << 3 | WireType.LENGTH_DELIMITED,PBFightItem);
      
      public static const DAMAGE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.Consume.damage","damage",2 << 3 | WireType.VARINT);
      
      public static const HEAL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.FightAction.Consume.heal","heal",3 << 3 | WireType.VARINT);
       
      
      public var item:PBFightItem;
      
      private var damage$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var heal$field:uint;
      
      public function PBFightActionConsume()
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
      
      public function clearHeal() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.heal$field = new uint();
      }
      
      public function get hasHeal() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set heal(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.heal$field = param1;
      }
      
      public function get heal() : uint
      {
         if(!this.hasHeal)
         {
            return 0;
         }
         return this.heal$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
         WriteUtils.write$TYPE_MESSAGE(param1,this.item);
         if(this.hasDamage)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,this.damage$field);
         }
         if(this.hasHeal)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,this.heal$field);
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
                     throw new IOError("Bad data format: Consume.item cannot be set twice.");
                  }
                  _loc3_++;
                  this.item = new PBFightItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.item);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Consume.damage cannot be set twice.");
                  }
                  _loc4_++;
                  this.damage = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Consume.heal cannot be set twice.");
                  }
                  _loc5_++;
                  this.heal = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
