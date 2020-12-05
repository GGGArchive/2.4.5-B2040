package com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBMiscPlayerProfileRequest extends Message
   {
      
      public static const PLAYER_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile.Request.player_id","playerId",1 << 3 | WireType.VARINT);
      
      public static const PLAYER_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile.Request.player_name","playerName",2 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const SHORT_INFO:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile.Request.short_info","shortInfo",3 << 3 | WireType.VARINT);
       
      
      private var player_id$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var player_name$field:String;
      
      public var shortInfo:Boolean;
      
      public function PBMiscPlayerProfileRequest()
      {
         super();
      }
      
      public function clearPlayerId() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.player_id$field = new uint();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set playerId(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.player_id$field = param1;
      }
      
      public function get playerId() : uint
      {
         return this.player_id$field;
      }
      
      public function clearPlayerName() : void
      {
         this.player_name$field = null;
      }
      
      public function get hasPlayerName() : Boolean
      {
         return this.player_name$field != null;
      }
      
      public function set playerName(param1:String) : void
      {
         this.player_name$field = param1;
      }
      
      public function get playerName() : String
      {
         return this.player_name$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         if(this.hasPlayerId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,this.player_id$field);
         }
         if(this.hasPlayerName)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_STRING(param1,this.player_name$field);
         }
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_BOOL(param1,this.shortInfo);
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
                     throw new IOError("Bad data format: Request.playerId cannot be set twice.");
                  }
                  _loc3_++;
                  this.playerId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Request.playerName cannot be set twice.");
                  }
                  _loc4_++;
                  this.playerName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Request.shortInfo cannot be set twice.");
                  }
                  _loc5_++;
                  this.shortInfo = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
