package com.goodgamestudios.mafia.controller.protobuf.message.shownews.response
{
   import com.goodgamestudios.mafia.controller.protobuf.messages.PBMessageType;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBMessageShowNewsMessage extends Message
   {
      
      public static const MESSAGEID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.message.shownews.Response.Message.messageID","messageID",1 << 3 | WireType.VARINT);
      
      public static const MESSAGETYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.message.shownews.Response.Message.messageType","messageType",2 << 3 | WireType.VARINT,PBMessageType);
      
      public static const FROMPLAYERID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.message.shownews.Response.Message.fromplayerID","fromplayerID",3 << 3 | WireType.VARINT);
      
      public static const FROMPLAYERNAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.message.shownews.Response.Message.fromPlayerName","fromPlayerName",4 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const SECONDSINCESEND:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.message.shownews.Response.Message.secondSinceSend","secondSinceSend",5 << 3 | WireType.VARINT);
      
      public static const HASATTACHMENT:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.message.shownews.Response.Message.hasAttachment","hasAttachment",6 << 3 | WireType.VARINT);
       
      
      public var messageID:uint;
      
      public var messageType:int;
      
      public var fromplayerID:uint;
      
      public var fromPlayerName:String;
      
      public var secondSinceSend:uint;
      
      private var hasAttachment$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      public function PBMessageShowNewsMessage()
      {
         super();
      }
      
      public function clearHasAttachment() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.hasAttachment$field = new Boolean();
      }
      
      public function get hasHasAttachment() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set hasAttachment(param1:Boolean) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.hasAttachment$field = param1;
      }
      
      public function get hasAttachment() : Boolean
      {
         return this.hasAttachment$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.messageID);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_ENUM(param1,this.messageType);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.fromplayerID);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
         WriteUtils.write$TYPE_STRING(param1,this.fromPlayerName);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_UINT32(param1,this.secondSinceSend);
         if(this.hasHasAttachment)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_BOOL(param1,this.hasAttachment$field);
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
                     throw new IOError("Bad data format: Message.messageID cannot be set twice.");
                  }
                  _loc3_++;
                  this.messageID = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Message.messageType cannot be set twice.");
                  }
                  _loc4_++;
                  this.messageType = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Message.fromplayerID cannot be set twice.");
                  }
                  _loc5_++;
                  this.fromplayerID = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Message.fromPlayerName cannot be set twice.");
                  }
                  _loc6_++;
                  this.fromPlayerName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Message.secondSinceSend cannot be set twice.");
                  }
                  _loc7_++;
                  this.secondSinceSend = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Message.hasAttachment cannot be set twice.");
                  }
                  _loc8_++;
                  this.hasAttachment = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc9_);
                  continue;
            }
         }
      }
   }
}
