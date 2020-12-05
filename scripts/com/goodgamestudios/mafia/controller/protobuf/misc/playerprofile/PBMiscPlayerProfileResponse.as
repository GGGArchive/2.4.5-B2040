package com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBPlayerProfile;
   import com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile.response.PBMiscPlayerProfileResult;
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
   
   public final class PBMiscPlayerProfileResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile.Response.result","result",1 << 3 | WireType.VARINT,PBMiscPlayerProfileResult);
      
      public static const PLAYER_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile.Response.player_id","playerId",2 << 3 | WireType.VARINT);
      
      public static const PLAYER_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile.Response.player_name","playerName",3 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const PROFILE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile.Response.profile","profile",4 << 3 | WireType.LENGTH_DELIMITED,PBPlayerProfile);
       
      
      public var result:int;
      
      private var player_id$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var player_name$field:String;
      
      private var profile$field:PBPlayerProfile;
      
      public function PBMiscPlayerProfileResponse()
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
      
      public function clearProfile() : void
      {
         this.profile$field = null;
      }
      
      public function get hasProfile() : Boolean
      {
         return this.profile$field != null;
      }
      
      public function set profile(param1:PBPlayerProfile) : void
      {
         this.profile$field = param1;
      }
      
      public function get profile() : PBPlayerProfile
      {
         return this.profile$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasPlayerId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,this.player_id$field);
         }
         if(this.hasPlayerName)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_STRING(param1,this.player_name$field);
         }
         if(this.hasProfile)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.profile$field);
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.playerId cannot be set twice.");
                  }
                  _loc4_++;
                  this.playerId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.playerName cannot be set twice.");
                  }
                  _loc5_++;
                  this.playerName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.profile cannot be set twice.");
                  }
                  _loc6_++;
                  this.profile = new PBPlayerProfile();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.profile);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
