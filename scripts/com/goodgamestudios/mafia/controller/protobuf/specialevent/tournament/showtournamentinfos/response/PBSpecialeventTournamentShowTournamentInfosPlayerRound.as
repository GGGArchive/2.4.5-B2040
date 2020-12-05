package com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.response
{
   import com.goodgamestudios.mafia.controller.protobuf.tournaments.PBFighterState;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBSpecialeventTournamentShowTournamentInfosPlayerRound extends Message
   {
      
      public static const ROUND:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.PlayerRound.round","round",1 << 3 | WireType.VARINT);
      
      public static const PLAYER_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.PlayerRound.player_id","playerId",2 << 3 | WireType.VARINT);
      
      public static const PLAYER_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.PlayerRound.player_name","playerName",3 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const FIGHT_RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentinfos.Response.PlayerRound.fight_result","fightResult",4 << 3 | WireType.VARINT,PBFighterState);
       
      
      public var round:uint;
      
      public var playerId:uint;
      
      public var playerName:String;
      
      public var fightResult:int;
      
      public function PBSpecialeventTournamentShowTournamentInfosPlayerRound()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.round);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.playerId);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
         WriteUtils.write$TYPE_STRING(param1,this.playerName);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_ENUM(param1,this.fightResult);
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
                     throw new IOError("Bad data format: PlayerRound.round cannot be set twice.");
                  }
                  _loc3_++;
                  this.round = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerRound.playerId cannot be set twice.");
                  }
                  _loc4_++;
                  this.playerId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerRound.playerName cannot be set twice.");
                  }
                  _loc5_++;
                  this.playerName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerRound.fightResult cannot be set twice.");
                  }
                  _loc6_++;
                  this.fightResult = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
