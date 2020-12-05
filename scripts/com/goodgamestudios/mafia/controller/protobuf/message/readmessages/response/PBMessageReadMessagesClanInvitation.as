package com.goodgamestudios.mafia.controller.protobuf.message.readmessages.response
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBMessageReadMessagesClanInvitation extends Message
   {
      
      public static const CLAN_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Response.ClanInvitation.clan_id","clanId",1 << 3 | WireType.VARINT);
      
      public static const CLAN_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Response.ClanInvitation.clan_name","clanName",2 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const INVITATION_HASH_CODE:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.message.readmessages.Response.ClanInvitation.invitation_hash_code","invitationHashCode",3 << 3 | WireType.LENGTH_DELIMITED);
       
      
      public var clanId:uint;
      
      public var clanName:String;
      
      public var invitationHashCode:String;
      
      public function PBMessageReadMessagesClanInvitation()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.clanId);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
         WriteUtils.write$TYPE_STRING(param1,this.clanName);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
         WriteUtils.write$TYPE_STRING(param1,this.invitationHashCode);
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
                     throw new IOError("Bad data format: ClanInvitation.clanId cannot be set twice.");
                  }
                  _loc3_++;
                  this.clanId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ClanInvitation.clanName cannot be set twice.");
                  }
                  _loc4_++;
                  this.clanName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ClanInvitation.invitationHashCode cannot be set twice.");
                  }
                  _loc5_++;
                  this.invitationHashCode = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
