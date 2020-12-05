package com.goodgamestudios.mafia.controller.protobuf.message.readmessages
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.controller.protobuf.message.readmessages.response.PBMessageReadMessagesClanInvitation;
   import com.goodgamestudios.mafia.controller.protobuf.message.readmessages.response.PBMessageReadMessagesResult;
   import com.goodgamestudios.mafia.controller.protobuf.messages.PBMessageType;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBMessageReadMessagesResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Response.result","result",1 << 3 | WireType.VARINT,PBMessageReadMessagesResult);
      
      public static const MESSAGE_TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Response.message_type","messageType",2 << 3 | WireType.VARINT,PBMessageType);
      
      public static const FIGHT:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Response.fight","fight",3 << 3 | WireType.LENGTH_DELIMITED,PBFight);
      
      public static const REWARD:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Response.reward","reward",4 << 3 | WireType.LENGTH_DELIMITED,PBReward);
      
      public static const CLAN_INVITATION:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Response.clan_invitation","clanInvitation",5 << 3 | WireType.LENGTH_DELIMITED,PBMessageReadMessagesClanInvitation);
      
      public static const TEXT:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Response.text","text",6 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const DOPPLER_COUNT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Response.doppler_count","dopplerCount",7 << 3 | WireType.VARINT);
      
      public static const ITEM:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Response.item","item",8 << 3 | WireType.LENGTH_DELIMITED,PBItem);
       
      
      public var result:int;
      
      private var message_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var fight$field:PBFight;
      
      private var reward$field:PBReward;
      
      private var clan_invitation$field:PBMessageReadMessagesClanInvitation;
      
      private var text$field:String;
      
      private var doppler_count$field:uint;
      
      private var item$field:PBItem;
      
      public function PBMessageReadMessagesResponse()
      {
         super();
      }
      
      public function clearMessageType() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.message_type$field = new int();
      }
      
      public function get hasMessageType() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set messageType(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.message_type$field = param1;
      }
      
      public function get messageType() : int
      {
         return this.message_type$field;
      }
      
      public function clearFight() : void
      {
         this.fight$field = null;
      }
      
      public function get hasFight() : Boolean
      {
         return this.fight$field != null;
      }
      
      public function set fight(param1:PBFight) : void
      {
         this.fight$field = param1;
      }
      
      public function get fight() : PBFight
      {
         return this.fight$field;
      }
      
      public function clearReward() : void
      {
         this.reward$field = null;
      }
      
      public function get hasReward() : Boolean
      {
         return this.reward$field != null;
      }
      
      public function set reward(param1:PBReward) : void
      {
         this.reward$field = param1;
      }
      
      public function get reward() : PBReward
      {
         return this.reward$field;
      }
      
      public function clearClanInvitation() : void
      {
         this.clan_invitation$field = null;
      }
      
      public function get hasClanInvitation() : Boolean
      {
         return this.clan_invitation$field != null;
      }
      
      public function set clanInvitation(param1:PBMessageReadMessagesClanInvitation) : void
      {
         this.clan_invitation$field = param1;
      }
      
      public function get clanInvitation() : PBMessageReadMessagesClanInvitation
      {
         return this.clan_invitation$field;
      }
      
      public function clearText() : void
      {
         this.text$field = null;
      }
      
      public function get hasText() : Boolean
      {
         return this.text$field != null;
      }
      
      public function set text(param1:String) : void
      {
         this.text$field = param1;
      }
      
      public function get text() : String
      {
         return this.text$field;
      }
      
      public function clearDopplerCount() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.doppler_count$field = new uint();
      }
      
      public function get hasDopplerCount() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set dopplerCount(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.doppler_count$field = param1;
      }
      
      public function get dopplerCount() : uint
      {
         return this.doppler_count$field;
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
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasMessageType)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_ENUM(param1,this.message_type$field);
         }
         if(this.hasFight)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,this.fight$field);
         }
         if(this.hasReward)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.reward$field);
         }
         if(this.hasClanInvitation)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,5);
            WriteUtils.write$TYPE_MESSAGE(param1,this.clan_invitation$field);
         }
         if(this.hasText)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,6);
            WriteUtils.write$TYPE_STRING(param1,this.text$field);
         }
         if(this.hasDopplerCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,this.doppler_count$field);
         }
         if(this.hasItem)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,8);
            WriteUtils.write$TYPE_MESSAGE(param1,this.item$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc11_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc11_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.messageType cannot be set twice.");
                  }
                  _loc4_++;
                  this.messageType = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.fight cannot be set twice.");
                  }
                  _loc5_++;
                  this.fight = new PBFight();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.fight);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.reward cannot be set twice.");
                  }
                  _loc6_++;
                  this.reward = new PBReward();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.reward);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Response.clanInvitation cannot be set twice.");
                  }
                  _loc7_++;
                  this.clanInvitation = new PBMessageReadMessagesClanInvitation();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.clanInvitation);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Response.text cannot be set twice.");
                  }
                  _loc8_++;
                  this.text = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: Response.dopplerCount cannot be set twice.");
                  }
                  _loc9_++;
                  this.dopplerCount = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: Response.item cannot be set twice.");
                  }
                  _loc10_++;
                  this.item = new PBItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.item);
                  continue;
               default:
                  super.readUnknown(param1,_loc11_);
                  continue;
            }
         }
      }
   }
}
