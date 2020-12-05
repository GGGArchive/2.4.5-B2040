package com.goodgamestudios.mafia.controller.protobuf.common
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBAttributes extends Message
   {
      
      public static const ATTACK:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.Attributes.attack","attack",1 << 3 | WireType.VARINT);
      
      public static const ENDURANCE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.Attributes.endurance","endurance",2 << 3 | WireType.VARINT);
      
      public static const LUCK:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.Attributes.luck","luck",3 << 3 | WireType.VARINT);
      
      public static const TOUGHNESS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.Attributes.toughness","toughness",4 << 3 | WireType.VARINT);
       
      
      private var attack$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var endurance$field:uint;
      
      private var luck$field:uint;
      
      private var toughness$field:uint;
      
      public function PBAttributes()
      {
         super();
      }
      
      public function clearAttack() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.attack$field = new uint();
      }
      
      public function get hasAttack() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set attack(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.attack$field = param1;
      }
      
      public function get attack() : uint
      {
         if(!this.hasAttack)
         {
            return 0;
         }
         return this.attack$field;
      }
      
      public function clearEndurance() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.endurance$field = new uint();
      }
      
      public function get hasEndurance() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set endurance(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.endurance$field = param1;
      }
      
      public function get endurance() : uint
      {
         if(!this.hasEndurance)
         {
            return 0;
         }
         return this.endurance$field;
      }
      
      public function clearLuck() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.luck$field = new uint();
      }
      
      public function get hasLuck() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set luck(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.luck$field = param1;
      }
      
      public function get luck() : uint
      {
         if(!this.hasLuck)
         {
            return 0;
         }
         return this.luck$field;
      }
      
      public function clearToughness() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967287;
         this.toughness$field = new uint();
      }
      
      public function get hasToughness() : Boolean
      {
         return (this.hasField$0 & 8) != 0;
      }
      
      public function set toughness(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 8;
         this.toughness$field = param1;
      }
      
      public function get toughness() : uint
      {
         if(!this.hasToughness)
         {
            return 0;
         }
         return this.toughness$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         if(this.hasAttack)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,this.attack$field);
         }
         if(this.hasEndurance)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,this.endurance$field);
         }
         if(this.hasLuck)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,this.luck$field);
         }
         if(this.hasToughness)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,this.toughness$field);
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
                     throw new IOError("Bad data format: Attributes.attack cannot be set twice.");
                  }
                  _loc3_++;
                  this.attack = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Attributes.endurance cannot be set twice.");
                  }
                  _loc4_++;
                  this.endurance = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Attributes.luck cannot be set twice.");
                  }
                  _loc5_++;
                  this.luck = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Attributes.toughness cannot be set twice.");
                  }
                  _loc6_++;
                  this.toughness = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
