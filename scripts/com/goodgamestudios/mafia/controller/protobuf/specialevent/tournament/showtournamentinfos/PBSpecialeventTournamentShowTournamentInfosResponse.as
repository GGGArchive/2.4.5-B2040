package com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos
{
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.response.PBSpecialeventTournamentShowTournamentInfosPlayerRound;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.response.PBSpecialeventTournamentShowTournamentInfosPlayerStatus;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.response.PBSpecialeventTournamentShowTournamentInfosResult;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.response.PBSpecialeventTournamentShowTournamentInfosTournamentStatus;
   import com.goodgamestudios.mafia.controller.protobuf.tournaments.PBPlayerInfo;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBSpecialeventTournamentShowTournamentInfosResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.result","result",1 << 3 | WireType.VARINT,PBSpecialeventTournamentShowTournamentInfosResult);
      
      public static const STATUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.status","status",2 << 3 | WireType.VARINT,PBSpecialeventTournamentShowTournamentInfosTournamentStatus);
      
      public static const PLAYER_STATUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.player_status","playerStatus",3 << 3 | WireType.VARINT,PBSpecialeventTournamentShowTournamentInfosPlayerStatus);
      
      public static const ROUND:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.round","round",4 << 3 | WireType.VARINT);
      
      public static const TIME_TO_NEXT_FIGHT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.time_to_next_fight","timeToNextFight",5 << 3 | WireType.VARINT);
      
      public static const PARTICIPANTS_COUNT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.participants_count","participantsCount",6 << 3 | WireType.VARINT);
      
      public static const REMAINING_PARTICIPANTS_COUNT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.remaining_participants_count","remainingParticipantsCount",7 << 3 | WireType.VARINT);
      
      public static const TIME_TO_REFRESH:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.time_to_refresh","timeToRefresh",8 << 3 | WireType.VARINT);
      
      public static const WINNER:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.winner","winner",9 << 3 | WireType.LENGTH_DELIMITED,PBPlayerInfo);
      
      public static const CURRENT_HEALTH:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.current_health","currentHealth",10 << 3 | WireType.VARINT);
      
      public static const HEALING_COSTS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.healing_costs","healingCosts",11 << 3 | WireType.VARINT);
      
      public static const PLAYER_ROUNDS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.player_rounds","playerRounds",12 << 3 | WireType.LENGTH_DELIMITED,PBSpecialeventTournamentShowTournamentInfosPlayerRound);
      
      public static const NEXT_REWARD_XP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.next_reward_xp","nextRewardXp",13 << 3 | WireType.VARINT);
      
      public static const NEXT_REWARD_CASH:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.next_reward_cash","nextRewardCash",14 << 3 | WireType.VARINT);
      
      public static const NEXT_REWARD_GLORY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.next_reward_glory","nextRewardGlory",15 << 3 | WireType.VARINT);
      
      public static const NEXT_REWARD_AP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.next_reward_ap","nextRewardAp",16 << 3 | WireType.VARINT);
      
      public static const NEXT_OPPONENT_ID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.next_opponent_id","nextOpponentId",17 << 3 | WireType.VARINT);
      
      public static const OPPONENT:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.opponent","opponent",18 << 3 | WireType.LENGTH_DELIMITED,PBPlayerInfo);
      
      public static const OPPONENT_ROUNDS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.opponent_rounds","opponentRounds",19 << 3 | WireType.LENGTH_DELIMITED,PBSpecialeventTournamentShowTournamentInfosPlayerRound);
       
      
      public var result:int;
      
      private var status$field:int;
      
      private var hasField$0:uint = 0;
      
      private var player_status$field:int;
      
      private var round$field:int;
      
      private var time_to_next_fight$field:uint;
      
      private var participants_count$field:uint;
      
      private var remaining_participants_count$field:uint;
      
      private var time_to_refresh$field:uint;
      
      private var winner$field:PBPlayerInfo;
      
      private var current_health$field:uint;
      
      private var healing_costs$field:uint;
      
      public var playerRounds:Array;
      
      private var next_reward_xp$field:uint;
      
      private var next_reward_cash$field:uint;
      
      private var next_reward_glory$field:uint;
      
      private var next_reward_ap$field:uint;
      
      private var next_opponent_id$field:int;
      
      private var opponent$field:PBPlayerInfo;
      
      public var opponentRounds:Array;
      
      public function PBSpecialeventTournamentShowTournamentInfosResponse()
      {
         this.playerRounds = [];
         this.opponentRounds = [];
         super();
      }
      
      public function clearStatus() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.status$field = new int();
      }
      
      public function get hasStatus() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set status(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.status$field = param1;
      }
      
      public function get status() : int
      {
         return this.status$field;
      }
      
      public function clearPlayerStatus() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.player_status$field = new int();
      }
      
      public function get hasPlayerStatus() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set playerStatus(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.player_status$field = param1;
      }
      
      public function get playerStatus() : int
      {
         return this.player_status$field;
      }
      
      public function clearRound() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.round$field = new int();
      }
      
      public function get hasRound() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set round(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.round$field = param1;
      }
      
      public function get round() : int
      {
         return this.round$field;
      }
      
      public function clearTimeToNextFight() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967287;
         this.time_to_next_fight$field = new uint();
      }
      
      public function get hasTimeToNextFight() : Boolean
      {
         return (this.hasField$0 & 8) != 0;
      }
      
      public function set timeToNextFight(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 8;
         this.time_to_next_fight$field = param1;
      }
      
      public function get timeToNextFight() : uint
      {
         return this.time_to_next_fight$field;
      }
      
      public function clearParticipantsCount() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967279;
         this.participants_count$field = new uint();
      }
      
      public function get hasParticipantsCount() : Boolean
      {
         return (this.hasField$0 & 16) != 0;
      }
      
      public function set participantsCount(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 16;
         this.participants_count$field = param1;
      }
      
      public function get participantsCount() : uint
      {
         return this.participants_count$field;
      }
      
      public function clearRemainingParticipantsCount() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967263;
         this.remaining_participants_count$field = new uint();
      }
      
      public function get hasRemainingParticipantsCount() : Boolean
      {
         return (this.hasField$0 & 32) != 0;
      }
      
      public function set remainingParticipantsCount(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 32;
         this.remaining_participants_count$field = param1;
      }
      
      public function get remainingParticipantsCount() : uint
      {
         return this.remaining_participants_count$field;
      }
      
      public function clearTimeToRefresh() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967231;
         this.time_to_refresh$field = new uint();
      }
      
      public function get hasTimeToRefresh() : Boolean
      {
         return (this.hasField$0 & 64) != 0;
      }
      
      public function set timeToRefresh(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 64;
         this.time_to_refresh$field = param1;
      }
      
      public function get timeToRefresh() : uint
      {
         return this.time_to_refresh$field;
      }
      
      public function clearWinner() : void
      {
         this.winner$field = null;
      }
      
      public function get hasWinner() : Boolean
      {
         return this.winner$field != null;
      }
      
      public function set winner(param1:PBPlayerInfo) : void
      {
         this.winner$field = param1;
      }
      
      public function get winner() : PBPlayerInfo
      {
         return this.winner$field;
      }
      
      public function clearCurrentHealth() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967167;
         this.current_health$field = new uint();
      }
      
      public function get hasCurrentHealth() : Boolean
      {
         return (this.hasField$0 & 128) != 0;
      }
      
      public function set currentHealth(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 128;
         this.current_health$field = param1;
      }
      
      public function get currentHealth() : uint
      {
         return this.current_health$field;
      }
      
      public function clearHealingCosts() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967039;
         this.healing_costs$field = new uint();
      }
      
      public function get hasHealingCosts() : Boolean
      {
         return (this.hasField$0 & 256) != 0;
      }
      
      public function set healingCosts(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 256;
         this.healing_costs$field = param1;
      }
      
      public function get healingCosts() : uint
      {
         return this.healing_costs$field;
      }
      
      public function clearNextRewardXp() : void
      {
         this.hasField$0 = this.hasField$0 & 4294966783;
         this.next_reward_xp$field = new uint();
      }
      
      public function get hasNextRewardXp() : Boolean
      {
         return (this.hasField$0 & 512) != 0;
      }
      
      public function set nextRewardXp(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 512;
         this.next_reward_xp$field = param1;
      }
      
      public function get nextRewardXp() : uint
      {
         return this.next_reward_xp$field;
      }
      
      public function clearNextRewardCash() : void
      {
         this.hasField$0 = this.hasField$0 & 4294966271;
         this.next_reward_cash$field = new uint();
      }
      
      public function get hasNextRewardCash() : Boolean
      {
         return (this.hasField$0 & 1024) != 0;
      }
      
      public function set nextRewardCash(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1024;
         this.next_reward_cash$field = param1;
      }
      
      public function get nextRewardCash() : uint
      {
         return this.next_reward_cash$field;
      }
      
      public function clearNextRewardGlory() : void
      {
         this.hasField$0 = this.hasField$0 & 4294965247;
         this.next_reward_glory$field = new uint();
      }
      
      public function get hasNextRewardGlory() : Boolean
      {
         return (this.hasField$0 & 2048) != 0;
      }
      
      public function set nextRewardGlory(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2048;
         this.next_reward_glory$field = param1;
      }
      
      public function get nextRewardGlory() : uint
      {
         return this.next_reward_glory$field;
      }
      
      public function clearNextRewardAp() : void
      {
         this.hasField$0 = this.hasField$0 & 4294963199;
         this.next_reward_ap$field = new uint();
      }
      
      public function get hasNextRewardAp() : Boolean
      {
         return (this.hasField$0 & 4096) != 0;
      }
      
      public function set nextRewardAp(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 4096;
         this.next_reward_ap$field = param1;
      }
      
      public function get nextRewardAp() : uint
      {
         return this.next_reward_ap$field;
      }
      
      public function clearNextOpponentId() : void
      {
         this.hasField$0 = this.hasField$0 & 4294959103;
         this.next_opponent_id$field = new int();
      }
      
      public function get hasNextOpponentId() : Boolean
      {
         return (this.hasField$0 & 8192) != 0;
      }
      
      public function set nextOpponentId(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 8192;
         this.next_opponent_id$field = param1;
      }
      
      public function get nextOpponentId() : int
      {
         return this.next_opponent_id$field;
      }
      
      public function clearOpponent() : void
      {
         this.opponent$field = null;
      }
      
      public function get hasOpponent() : Boolean
      {
         return this.opponent$field != null;
      }
      
      public function set opponent(param1:PBPlayerInfo) : void
      {
         this.opponent$field = param1;
      }
      
      public function get opponent() : PBPlayerInfo
      {
         return this.opponent$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasStatus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_ENUM(param1,this.status$field);
         }
         if(this.hasPlayerStatus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_ENUM(param1,this.player_status$field);
         }
         if(this.hasRound)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_INT32(param1,this.round$field);
         }
         if(this.hasTimeToNextFight)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,this.time_to_next_fight$field);
         }
         if(this.hasParticipantsCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,this.participants_count$field);
         }
         if(this.hasRemainingParticipantsCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,this.remaining_participants_count$field);
         }
         if(this.hasTimeToRefresh)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,8);
            WriteUtils.write$TYPE_UINT32(param1,this.time_to_refresh$field);
         }
         if(this.hasWinner)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,9);
            WriteUtils.write$TYPE_MESSAGE(param1,this.winner$field);
         }
         if(this.hasCurrentHealth)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,10);
            WriteUtils.write$TYPE_UINT32(param1,this.current_health$field);
         }
         if(this.hasHealingCosts)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,11);
            WriteUtils.write$TYPE_UINT32(param1,this.healing_costs$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.playerRounds.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,12);
            WriteUtils.write$TYPE_MESSAGE(param1,this.playerRounds[_loc2_]);
            _loc2_++;
         }
         if(this.hasNextRewardXp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,13);
            WriteUtils.write$TYPE_UINT32(param1,this.next_reward_xp$field);
         }
         if(this.hasNextRewardCash)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,14);
            WriteUtils.write$TYPE_UINT32(param1,this.next_reward_cash$field);
         }
         if(this.hasNextRewardGlory)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,15);
            WriteUtils.write$TYPE_UINT32(param1,this.next_reward_glory$field);
         }
         if(this.hasNextRewardAp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,16);
            WriteUtils.write$TYPE_UINT32(param1,this.next_reward_ap$field);
         }
         if(this.hasNextOpponentId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,17);
            WriteUtils.write$TYPE_INT32(param1,this.next_opponent_id$field);
         }
         if(this.hasOpponent)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,18);
            WriteUtils.write$TYPE_MESSAGE(param1,this.opponent$field);
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this.opponentRounds.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,19);
            WriteUtils.write$TYPE_MESSAGE(param1,this.opponentRounds[_loc3_]);
            _loc3_++;
         }
         for(_loc4_ in this)
         {
            super.writeUnknown(param1,_loc4_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc20_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc20_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc20_ >> 3)
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
                     throw new IOError("Bad data format: Response.status cannot be set twice.");
                  }
                  _loc4_++;
                  this.status = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.playerStatus cannot be set twice.");
                  }
                  _loc5_++;
                  this.playerStatus = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.round cannot be set twice.");
                  }
                  _loc6_++;
                  this.round = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Response.timeToNextFight cannot be set twice.");
                  }
                  _loc7_++;
                  this.timeToNextFight = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Response.participantsCount cannot be set twice.");
                  }
                  _loc8_++;
                  this.participantsCount = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: Response.remainingParticipantsCount cannot be set twice.");
                  }
                  _loc9_++;
                  this.remainingParticipantsCount = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: Response.timeToRefresh cannot be set twice.");
                  }
                  _loc10_++;
                  this.timeToRefresh = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: Response.winner cannot be set twice.");
                  }
                  _loc11_++;
                  this.winner = new PBPlayerInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.winner);
                  continue;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: Response.currentHealth cannot be set twice.");
                  }
                  _loc12_++;
                  this.currentHealth = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: Response.healingCosts cannot be set twice.");
                  }
                  _loc13_++;
                  this.healingCosts = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 12:
                  this.playerRounds.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBSpecialeventTournamentShowTournamentInfosPlayerRound()));
                  continue;
               case 13:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: Response.nextRewardXp cannot be set twice.");
                  }
                  _loc14_++;
                  this.nextRewardXp = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 14:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: Response.nextRewardCash cannot be set twice.");
                  }
                  _loc15_++;
                  this.nextRewardCash = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 15:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: Response.nextRewardGlory cannot be set twice.");
                  }
                  _loc16_++;
                  this.nextRewardGlory = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 16:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: Response.nextRewardAp cannot be set twice.");
                  }
                  _loc17_++;
                  this.nextRewardAp = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 17:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: Response.nextOpponentId cannot be set twice.");
                  }
                  _loc18_++;
                  this.nextOpponentId = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 18:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: Response.opponent cannot be set twice.");
                  }
                  _loc19_++;
                  this.opponent = new PBPlayerInfo();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.opponent);
                  continue;
               case 19:
                  this.opponentRounds.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBSpecialeventTournamentShowTournamentInfosPlayerRound()));
                  continue;
               default:
                  super.readUnknown(param1,_loc20_);
                  continue;
            }
         }
      }
   }
}
