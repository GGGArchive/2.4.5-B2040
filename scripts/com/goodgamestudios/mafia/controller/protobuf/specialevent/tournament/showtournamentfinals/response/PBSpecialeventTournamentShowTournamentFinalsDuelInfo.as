package com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.response
{
   import com.goodgamestudios.mafia.controller.protobuf.tournaments.PBPlayerInfo;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBSpecialeventTournamentShowTournamentFinalsDuelInfo extends Message
   {
      
      public static const STATE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.Response.DuelInfo.state","state",1 << 3 | WireType.VARINT,PBSpecialeventTournamentShowTournamentFinalsState);
      
      public static const FIRST_PLAYER_INFO:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.Response.DuelInfo.first_player_info","firstPlayerInfo",2 << 3 | WireType.LENGTH_DELIMITED,PBPlayerInfo);
      
      public static const SECOND_PLAYER_INFO:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.Response.DuelInfo.second_player_info","secondPlayerInfo",3 << 3 | WireType.LENGTH_DELIMITED,PBPlayerInfo);
       
      
      public var state:int;
      
      private var first_player_info$field:PBPlayerInfo;
      
      private var second_player_info$field:PBPlayerInfo;
      
      public function PBSpecialeventTournamentShowTournamentFinalsDuelInfo()
      {
         super();
      }
      
      public function clearFirstPlayerInfo() : void
      {
         this.first_player_info$field = null;
      }
      
      public function get hasFirstPlayerInfo() : Boolean
      {
         return this.first_player_info$field != null;
      }
      
      public function set firstPlayerInfo(param1:PBPlayerInfo) : void
      {
         this.first_player_info$field = param1;
      }
      
      public function get firstPlayerInfo() : PBPlayerInfo
      {
         return this.first_player_info$field;
      }
      
      public function clearSecondPlayerInfo() : void
      {
         this.second_player_info$field = null;
      }
      
      public function get hasSecondPlayerInfo() : Boolean
      {
         return this.second_player_info$field != null;
      }
      
      public function set secondPlayerInfo(param1:PBPlayerInfo) : void
      {
         this.second_player_info$field = param1;
      }
      
      public function get secondPlayerInfo() : PBPlayerInfo
      {
         return this.second_player_info$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.state);
         if(this.hasFirstPlayerInfo)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,this.first_player_info$field);
         }
         if(this.hasSecondPlayerInfo)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,this.second_player_info$field);
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
                     throw new IOError("Bad data format: DuelInfo.state cannot be set twice.");
                  }
                  _loc3_++;
                  this.state = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DuelInfo.firstPlayerInfo cannot be set twice.");
                  }
                  _loc4_++;
                  this.firstPlayerInfo = new PBPlayerInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.firstPlayerInfo);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DuelInfo.secondPlayerInfo cannot be set twice.");
                  }
                  _loc5_++;
                  this.secondPlayerInfo = new PBPlayerInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.secondPlayerInfo);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
