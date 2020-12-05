package com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament
{
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.response.PBSpecialeventTournamentPlayerState;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.response.PBSpecialeventTournamentState;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBSpecialeventTournamentResponse extends Message
   {
      
      public static const TOURNAMENT_STATUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.Response.tournament_status","tournamentStatus",1 << 3 | WireType.VARINT,PBSpecialeventTournamentState);
      
      public static const PLAYER_STATUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.Response.player_status","playerStatus",2 << 3 | WireType.VARINT,PBSpecialeventTournamentPlayerState);
      
      public static const CURRENT_REGISTERED_PLAYERS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.Response.current_registered_players","currentRegisteredPlayers",3 << 3 | WireType.VARINT);
      
      public static const TIME_TO_NEXT_ROUND:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.Response.time_to_next_round","timeToNextRound",4 << 3 | WireType.VARINT);
      
      public static const REWARD_INDEX:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.Response.reward_index","rewardIndex",5 << 3 | WireType.VARINT);
       
      
      public var tournamentStatus:int;
      
      public var playerStatus:int;
      
      public var currentRegisteredPlayers:uint;
      
      public var timeToNextRound:uint;
      
      private var reward_index$field:uint;
      
      private var hasField$0:uint = 0;
      
      public function PBSpecialeventTournamentResponse()
      {
         super();
      }
      
      public function clearRewardIndex() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.reward_index$field = new uint();
      }
      
      public function get hasRewardIndex() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set rewardIndex(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.reward_index$field = param1;
      }
      
      public function get rewardIndex() : uint
      {
         return this.reward_index$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.tournamentStatus);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_ENUM(param1,this.playerStatus);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.currentRegisteredPlayers);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.timeToNextRound);
         if(this.hasRewardIndex)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,this.reward_index$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc8_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc8_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: Response.tournamentStatus cannot be set twice.");
                  }
                  _loc3_++;
                  this.tournamentStatus = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.playerStatus cannot be set twice.");
                  }
                  _loc4_++;
                  this.playerStatus = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.currentRegisteredPlayers cannot be set twice.");
                  }
                  _loc5_++;
                  this.currentRegisteredPlayers = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.timeToNextRound cannot be set twice.");
                  }
                  _loc6_++;
                  this.timeToNextRound = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Response.rewardIndex cannot be set twice.");
                  }
                  _loc7_++;
                  this.rewardIndex = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc8_);
                  continue;
            }
         }
      }
   }
}
