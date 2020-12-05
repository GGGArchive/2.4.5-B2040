package com.goodgamestudios.mafia.controller.protobuf.quest
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCity;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBQuest extends Message
   {
      
      public static const QUEST_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.quest.Quest.quest_id","questId",1 << 3 | WireType.VARINT);
      
      public static const QUEST_TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.quest.Quest.quest_type","questType",2 << 3 | WireType.VARINT,PBQuestType);
      
      public static const QUEST_STATUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.quest.Quest.quest_status","questStatus",3 << 3 | WireType.VARINT,PBQuestStatus);
      
      public static const TASKS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.quest.Quest.tasks","tasks",4 << 3 | WireType.LENGTH_DELIMITED,PBTask);
      
      public static const REWARD:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.quest.Quest.reward","reward",5 << 3 | WireType.LENGTH_DELIMITED,PBQuestReward);
      
      public static const CITY:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.quest.Quest.city","city",6 << 3 | WireType.VARINT,PBCity);
      
      public static const DISTRICT_NUMBER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.quest.Quest.district_number","districtNumber",7 << 3 | WireType.VARINT);
       
      
      public var questId:uint;
      
      public var questType:int;
      
      public var questStatus:int;
      
      public var tasks:Array;
      
      private var reward$field:PBQuestReward;
      
      private var city$field:int;
      
      private var hasField$0:uint = 0;
      
      private var district_number$field:uint;
      
      public function PBQuest()
      {
         this.tasks = [];
         super();
      }
      
      public function clearReward() : void
      {
         this.reward$field = null;
      }
      
      public function get hasReward() : Boolean
      {
         return this.reward$field != null;
      }
      
      public function set reward(param1:PBQuestReward) : void
      {
         this.reward$field = param1;
      }
      
      public function get reward() : PBQuestReward
      {
         return this.reward$field;
      }
      
      public function clearCity() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.city$field = new int();
      }
      
      public function get hasCity() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set city(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.city$field = param1;
      }
      
      public function get city() : int
      {
         return this.city$field;
      }
      
      public function clearDistrictNumber() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.district_number$field = new uint();
      }
      
      public function get hasDistrictNumber() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set districtNumber(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.district_number$field = param1;
      }
      
      public function get districtNumber() : uint
      {
         return this.district_number$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.questId);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_ENUM(param1,this.questType);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_ENUM(param1,this.questStatus);
         var _loc2_:uint = 0;
         while(_loc2_ < this.tasks.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.tasks[_loc2_]);
            _loc2_++;
         }
         if(this.hasReward)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,5);
            WriteUtils.write$TYPE_MESSAGE(param1,this.reward$field);
         }
         if(this.hasCity)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_ENUM(param1,this.city$field);
         }
         if(this.hasDistrictNumber)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,this.district_number$field);
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
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
                     throw new IOError("Bad data format: Quest.questId cannot be set twice.");
                  }
                  _loc3_++;
                  this.questId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Quest.questType cannot be set twice.");
                  }
                  _loc4_++;
                  this.questType = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Quest.questStatus cannot be set twice.");
                  }
                  _loc5_++;
                  this.questStatus = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 4:
                  this.tasks.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBTask()));
                  continue;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Quest.reward cannot be set twice.");
                  }
                  _loc6_++;
                  this.reward = new PBQuestReward();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.reward);
                  continue;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Quest.city cannot be set twice.");
                  }
                  _loc7_++;
                  this.city = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Quest.districtNumber cannot be set twice.");
                  }
                  _loc8_++;
                  this.districtNumber = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc9_);
                  continue;
            }
         }
      }
   }
}
