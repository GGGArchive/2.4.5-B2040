package com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.viewtournamentfight
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFight;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.viewtournamentfight.response.PBSpecialeventTournamentViewTournamentFightResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBSpecialeventTournamentViewTournamentFightResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.viewtournamentfight.Response.result","result",1 << 3 | WireType.VARINT,PBSpecialeventTournamentViewTournamentFightResult);
      
      public static const FIRST_PLAYER_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.viewtournamentfight.Response.first_player_name","firstPlayerName",2 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const SECOND_PLAYER_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.viewtournamentfight.Response.second_player_name","secondPlayerName",3 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const FIGHT:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.viewtournamentfight.Response.fight","fight",4 << 3 | WireType.LENGTH_DELIMITED,PBFight);
      
      public static const REWARD:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.viewtournamentfight.Response.reward","reward",5 << 3 | WireType.LENGTH_DELIMITED,PBReward);
       
      
      public var result:int;
      
      private var first_player_name$field:String;
      
      private var second_player_name$field:String;
      
      private var fight$field:PBFight;
      
      private var reward$field:PBReward;
      
      public function PBSpecialeventTournamentViewTournamentFightResponse()
      {
         super();
      }
      
      public function clearFirstPlayerName() : void
      {
         this.first_player_name$field = null;
      }
      
      public function get hasFirstPlayerName() : Boolean
      {
         return this.first_player_name$field != null;
      }
      
      public function set firstPlayerName(param1:String) : void
      {
         this.first_player_name$field = param1;
      }
      
      public function get firstPlayerName() : String
      {
         return this.first_player_name$field;
      }
      
      public function clearSecondPlayerName() : void
      {
         this.second_player_name$field = null;
      }
      
      public function get hasSecondPlayerName() : Boolean
      {
         return this.second_player_name$field != null;
      }
      
      public function set secondPlayerName(param1:String) : void
      {
         this.second_player_name$field = param1;
      }
      
      public function get secondPlayerName() : String
      {
         return this.second_player_name$field;
      }
      
      public function clearFight() : void
      {
         this.fight$field = null;
      }
      
      public function get hasFight() : Boolean
      {
         return this.fight$field != null;
      }
      
      public function set fight(param1:PBFight) : void
      {
         this.fight$field = param1;
      }
      
      public function get fight() : PBFight
      {
         return this.fight$field;
      }
      
      public function clearReward() : void
      {
         this.reward$field = null;
      }
      
      public function get hasReward() : Boolean
      {
         return this.reward$field != null;
      }
      
      public function set reward(param1:PBReward) : void
      {
         this.reward$field = param1;
      }
      
      public function get reward() : PBReward
      {
         return this.reward$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasFirstPlayerName)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_STRING(param1,this.first_player_name$field);
         }
         if(this.hasSecondPlayerName)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_STRING(param1,this.second_player_name$field);
         }
         if(this.hasFight)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.fight$field);
         }
         if(this.hasReward)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,5);
            WriteUtils.write$TYPE_MESSAGE(param1,this.reward$field);
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.firstPlayerName cannot be set twice.");
                  }
                  _loc4_++;
                  this.firstPlayerName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.secondPlayerName cannot be set twice.");
                  }
                  _loc5_++;
                  this.secondPlayerName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.fight cannot be set twice.");
                  }
                  _loc6_++;
                  this.fight = new PBFight();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.fight);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Response.reward cannot be set twice.");
                  }
                  _loc7_++;
                  this.reward = new PBReward();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.reward);
                  continue;
               default:
                  super.readUnknown(param1,_loc8_);
                  continue;
            }
         }
      }
   }
}
