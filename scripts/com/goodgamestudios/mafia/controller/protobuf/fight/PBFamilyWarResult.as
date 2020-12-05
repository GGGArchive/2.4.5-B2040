package com.goodgamestudios.mafia.controller.protobuf.fight
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBReward;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFamilyWarResult extends Message
   {
      
      public static const ATTACKER_FAMILY_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.fight.FamilyWarResult.attacker_family_name","attackerFamilyName",1 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const ATTACKER_FAMILY_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.FamilyWarResult.attacker_family_id","attackerFamilyId",2 << 3 | WireType.VARINT);
      
      public static const ATTACKER_FAMILY_GLORY_CHANGE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.fight.FamilyWarResult.attacker_family_glory_change","attackerFamilyGloryChange",3 << 3 | WireType.VARINT);
      
      public static const DEFENDER_FAMILY_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.fight.FamilyWarResult.defender_family_name","defenderFamilyName",4 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const DEFENDER_FAMILY_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.FamilyWarResult.defender_family_id","defenderFamilyId",5 << 3 | WireType.VARINT);
      
      public static const DEFENDER_FAMILY_GLORY_CHANGE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.fight.FamilyWarResult.defender_family_glory_change","defenderFamilyGloryChange",6 << 3 | WireType.VARINT);
      
      public static const WINNER_FAMILY_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.FamilyWarResult.winner_family_id","winnerFamilyId",7 << 3 | WireType.VARINT);
      
      public static const REWARD:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.FamilyWarResult.reward","reward",8 << 3 | WireType.LENGTH_DELIMITED,PBReward);
      
      public static const FIGHTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.FamilyWarResult.fights","fights",9 << 3 | WireType.LENGTH_DELIMITED,PBFight);
      
      public static const ATTACKERS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.FamilyWarResult.attackers","attackers",10 << 3 | WireType.LENGTH_DELIMITED,PBFamilyWarParticipant);
      
      public static const DEFENDERS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.FamilyWarResult.defenders","defenders",11 << 3 | WireType.LENGTH_DELIMITED,PBFamilyWarParticipant);
       
      
      public var attackerFamilyName:String;
      
      public var attackerFamilyId:uint;
      
      public var attackerFamilyGloryChange:int;
      
      public var defenderFamilyName:String;
      
      public var defenderFamilyId:uint;
      
      public var defenderFamilyGloryChange:int;
      
      public var winnerFamilyId:uint;
      
      public var reward:PBReward;
      
      public var fights:Array;
      
      public var attackers:Array;
      
      public var defenders:Array;
      
      public function PBFamilyWarResult()
      {
         this.fights = [];
         this.attackers = [];
         this.defenders = [];
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc5_:* = undefined;
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
         WriteUtils.write$TYPE_STRING(param1,this.attackerFamilyName);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.attackerFamilyId);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_INT32(param1,this.attackerFamilyGloryChange);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
         WriteUtils.write$TYPE_STRING(param1,this.defenderFamilyName);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_UINT32(param1,this.defenderFamilyId);
         WriteUtils.writeTag(param1,WireType.VARINT,6);
         WriteUtils.write$TYPE_INT32(param1,this.defenderFamilyGloryChange);
         WriteUtils.writeTag(param1,WireType.VARINT,7);
         WriteUtils.write$TYPE_UINT32(param1,this.winnerFamilyId);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,8);
         WriteUtils.write$TYPE_MESSAGE(param1,this.reward);
         var _loc2_:uint = 0;
         while(_loc2_ < this.fights.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,9);
            WriteUtils.write$TYPE_MESSAGE(param1,this.fights[_loc2_]);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this.attackers.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,10);
            WriteUtils.write$TYPE_MESSAGE(param1,this.attackers[_loc3_]);
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < this.defenders.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,11);
            WriteUtils.write$TYPE_MESSAGE(param1,this.defenders[_loc4_]);
            _loc4_++;
         }
         for(_loc5_ in this)
         {
            super.writeUnknown(param1,_loc5_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc11_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc11_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyWarResult.attackerFamilyName cannot be set twice.");
                  }
                  _loc3_++;
                  this.attackerFamilyName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyWarResult.attackerFamilyId cannot be set twice.");
                  }
                  _loc4_++;
                  this.attackerFamilyId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyWarResult.attackerFamilyGloryChange cannot be set twice.");
                  }
                  _loc5_++;
                  this.attackerFamilyGloryChange = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyWarResult.defenderFamilyName cannot be set twice.");
                  }
                  _loc6_++;
                  this.defenderFamilyName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyWarResult.defenderFamilyId cannot be set twice.");
                  }
                  _loc7_++;
                  this.defenderFamilyId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyWarResult.defenderFamilyGloryChange cannot be set twice.");
                  }
                  _loc8_++;
                  this.defenderFamilyGloryChange = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyWarResult.winnerFamilyId cannot be set twice.");
                  }
                  _loc9_++;
                  this.winnerFamilyId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyWarResult.reward cannot be set twice.");
                  }
                  _loc10_++;
                  this.reward = new PBReward();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.reward);
                  continue;
               case 9:
                  this.fights.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBFight()));
                  continue;
               case 10:
                  this.attackers.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBFamilyWarParticipant()));
                  continue;
               case 11:
                  this.defenders.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBFamilyWarParticipant()));
                  continue;
               default:
                  super.readUnknown(param1,_loc11_);
                  continue;
            }
         }
      }
   }
}
