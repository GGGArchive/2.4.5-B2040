package com.goodgamestudios.mafia.controller.protobuf.family.updatefamilybooster
{
   import com.goodgamestudios.mafia.controller.protobuf.family.PBFamilyBoosterQuality;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFamilyUpdatefamilyboosterRequest extends Message
   {
      
      public static const XP_BONUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.family.updatefamilybooster.Request.xp_bonus","xpBonus",1 << 3 | WireType.VARINT,PBFamilyBoosterQuality);
      
      public static const CASH_BONUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.family.updatefamilybooster.Request.cash_bonus","cashBonus",2 << 3 | WireType.VARINT,PBFamilyBoosterQuality);
      
      public static const UPGRADE_MAX_MEMBERS:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.family.updatefamilybooster.Request.upgrade_max_members","upgradeMaxMembers",3 << 3 | WireType.VARINT);
       
      
      private var xp_bonus$field:int;
      
      private var hasField$0:uint = 0;
      
      private var cash_bonus$field:int;
      
      private var upgrade_max_members$field:Boolean;
      
      public function PBFamilyUpdatefamilyboosterRequest()
      {
         super();
      }
      
      public function clearXpBonus() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.xp_bonus$field = new int();
      }
      
      public function get hasXpBonus() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set xpBonus(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.xp_bonus$field = param1;
      }
      
      public function get xpBonus() : int
      {
         return this.xp_bonus$field;
      }
      
      public function clearCashBonus() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.cash_bonus$field = new int();
      }
      
      public function get hasCashBonus() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set cashBonus(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.cash_bonus$field = param1;
      }
      
      public function get cashBonus() : int
      {
         return this.cash_bonus$field;
      }
      
      public function clearUpgradeMaxMembers() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.upgrade_max_members$field = new Boolean();
      }
      
      public function get hasUpgradeMaxMembers() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set upgradeMaxMembers(param1:Boolean) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.upgrade_max_members$field = param1;
      }
      
      public function get upgradeMaxMembers() : Boolean
      {
         return this.upgrade_max_members$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         if(this.hasXpBonus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_ENUM(param1,this.xp_bonus$field);
         }
         if(this.hasCashBonus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_ENUM(param1,this.cash_bonus$field);
         }
         if(this.hasUpgradeMaxMembers)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_BOOL(param1,this.upgrade_max_members$field);
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
                     throw new IOError("Bad data format: Request.xpBonus cannot be set twice.");
                  }
                  _loc3_++;
                  this.xpBonus = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Request.cashBonus cannot be set twice.");
                  }
                  _loc4_++;
                  this.cashBonus = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Request.upgradeMaxMembers cannot be set twice.");
                  }
                  _loc5_++;
                  this.upgradeMaxMembers = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
