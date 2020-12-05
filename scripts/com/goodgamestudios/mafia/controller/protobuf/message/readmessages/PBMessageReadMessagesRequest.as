package com.goodgamestudios.mafia.controller.protobuf.message.readmessages
{
   import com.goodgamestudios.mafia.controller.protobuf.messages.PBMessageType;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBMessageReadMessagesRequest extends Message
   {
      
      public static const MESSAGE_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Request.message_id","messageId",1 << 3 | WireType.VARINT);
      
      public static const MESSAGE_TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Request.message_type","messageType",2 << 3 | WireType.VARINT,PBMessageType);
       
      
      public var messageId:uint;
      
      public var messageType:int;
      
      public function PBMessageReadMessagesRequest()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.messageId);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_ENUM(param1,this.messageType);
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
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
                     throw new IOError("Bad data format: Request.messageId cannot be set twice.");
                  }
                  _loc3_++;
                  this.messageId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Request.messageType cannot be set twice.");
                  }
                  _loc4_++;
                  this.messageType = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc5_);
                  continue;
            }
         }
      }
   }
}
