package com.goodgamestudios.mafia.controller.protobuf.family.familymessage
{
   import com.goodgamestudios.mafia.controller.protobuf.family.familymessage.response.PBFamilyFamilyMessageFamilyChatMessage;
   import com.goodgamestudios.mafia.controller.protobuf.family.familymessage.response.PBFamilyFamilyMessageFamilyNotification;
   import com.goodgamestudios.mafia.controller.protobuf.family.familymessage.response.PBFamilyFamilyMessageResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFamilyFamilyMessageResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.family.familymessage.Response.result","result",1 << 3 | WireType.VARINT,PBFamilyFamilyMessageResult);
      
      public static const TIME_STAMP:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.family.familymessage.Response.time_stamp","timeStamp",2 << 3 | WireType.VARINT);
      
      public static const FAMILY_MESSAGES:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.familymessage.Response.family_messages","familyMessages",3 << 3 | WireType.LENGTH_DELIMITED,PBFamilyFamilyMessageFamilyChatMessage);
      
      public static const FAMILY_NOTIFICATIONS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.familymessage.Response.family_notifications","familyNotifications",4 << 3 | WireType.LENGTH_DELIMITED,PBFamilyFamilyMessageFamilyNotification);
      
      public static const FAMILY_ACCOUNTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.familymessage.Response.family_accounts","familyAccounts",5 << 3 | WireType.LENGTH_DELIMITED,PBFamilyFamilyMessageFamilyNotification);
       
      
      public var result:int;
      
      public var timeStamp:int;
      
      public var familyMessages:Array;
      
      public var familyNotifications:Array;
      
      public var familyAccounts:Array;
      
      public function PBFamilyFamilyMessageResponse()
      {
         this.familyMessages = [];
         this.familyNotifications = [];
         this.familyAccounts = [];
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc5_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_INT32(param1,this.timeStamp);
         var _loc2_:uint = 0;
         while(_loc2_ < this.familyMessages.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,this.familyMessages[_loc2_]);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this.familyNotifications.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.familyNotifications[_loc3_]);
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < this.familyAccounts.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,5);
            WriteUtils.write$TYPE_MESSAGE(param1,this.familyAccounts[_loc4_]);
            _loc4_++;
         }
         for(_loc5_ in this)
         {
            super.writeUnknown(param1,_loc5_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc5_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc5_ >> 3)
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
                     throw new IOError("Bad data format: Response.timeStamp cannot be set twice.");
                  }
                  _loc4_++;
                  this.timeStamp = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 3:
                  this.familyMessages.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBFamilyFamilyMessageFamilyChatMessage()));
                  continue;
               case 4:
                  this.familyNotifications.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBFamilyFamilyMessageFamilyNotification()));
                  continue;
               case 5:
                  this.familyAccounts.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBFamilyFamilyMessageFamilyNotification()));
                  continue;
               default:
                  super.readUnknown(param1,_loc5_);
                  continue;
            }
         }
      }
   }
}
