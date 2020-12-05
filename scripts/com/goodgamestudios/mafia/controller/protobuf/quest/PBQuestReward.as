package com.goodgamestudios.mafia.controller.protobuf.quest
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCity;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBQuestReward extends Message
   {
      
      public static const CASH:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.quest.QuestReward.cash","cash",1 << 3 | WireType.VARINT);
      
      public static const GOLD:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.quest.QuestReward.gold","gold",2 << 3 | WireType.VARINT);
      
      public static const XP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.quest.QuestReward.xp","xp",3 << 3 | WireType.VARINT);
      
      public static const AP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.quest.QuestReward.ap","ap",4 << 3 | WireType.VARINT);
      
      public static const ITEM:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.quest.QuestReward.item","item",5 << 3 | WireType.LENGTH_DELIMITED,PBItem);
      
      public static const UNLOCK_CITY:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.quest.QuestReward.unlock_city","unlockCity",6 << 3 | WireType.VARINT,PBCity);
       
      
      private var cash$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var gold$field:uint;
      
      private var xp$field:uint;
      
      private var ap$field:uint;
      
      private var item$field:PBItem;
      
      private var unlock_city$field:int;
      
      public function PBQuestReward()
      {
         super();
      }
      
      public function clearCash() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.cash$field = new uint();
      }
      
      public function get hasCash() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set cash(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.cash$field = param1;
      }
      
      public function get cash() : uint
      {
         return this.cash$field;
      }
      
      public function clearGold() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.gold$field = new uint();
      }
      
      public function get hasGold() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set gold(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.gold$field = param1;
      }
      
      public function get gold() : uint
      {
         return this.gold$field;
      }
      
      public function clearXp() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.xp$field = new uint();
      }
      
      public function get hasXp() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set xp(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.xp$field = param1;
      }
      
      public function get xp() : uint
      {
         return this.xp$field;
      }
      
      public function clearAp() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967287;
         this.ap$field = new uint();
      }
      
      public function get hasAp() : Boolean
      {
         return (this.hasField$0 & 8) != 0;
      }
      
      public function set ap(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 8;
         this.ap$field = param1;
      }
      
      public function get ap() : uint
      {
         return this.ap$field;
      }
      
      public function clearItem() : void
      {
         this.item$field = null;
      }
      
      public function get hasItem() : Boolean
      {
         return this.item$field != null;
      }
      
      public function set item(param1:PBItem) : void
      {
         this.item$field = param1;
      }
      
      public function get item() : PBItem
      {
         return this.item$field;
      }
      
      public function clearUnlockCity() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967279;
         this.unlock_city$field = new int();
      }
      
      public function get hasUnlockCity() : Boolean
      {
         return (this.hasField$0 & 16) != 0;
      }
      
      public function set unlockCity(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 16;
         this.unlock_city$field = param1;
      }
      
      public function get unlockCity() : int
      {
         return this.unlock_city$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         if(this.hasCash)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,this.cash$field);
         }
         if(this.hasGold)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,this.gold$field);
         }
         if(this.hasXp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,this.xp$field);
         }
         if(this.hasAp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,this.ap$field);
         }
         if(this.hasItem)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,5);
            WriteUtils.write$TYPE_MESSAGE(param1,this.item$field);
         }
         if(this.hasUnlockCity)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_ENUM(param1,this.unlock_city$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc9_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc9_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: QuestReward.cash cannot be set twice.");
                  }
                  _loc3_++;
                  this.cash = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: QuestReward.gold cannot be set twice.");
                  }
                  _loc4_++;
                  this.gold = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: QuestReward.xp cannot be set twice.");
                  }
                  _loc5_++;
                  this.xp = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: QuestReward.ap cannot be set twice.");
                  }
                  _loc6_++;
                  this.ap = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: QuestReward.item cannot be set twice.");
                  }
                  _loc7_++;
                  this.item = new PBItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.item);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: QuestReward.unlockCity cannot be set twice.");
                  }
                  _loc8_++;
                  this.unlockCity = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc9_);
                  continue;
            }
         }
      }
   }
}
