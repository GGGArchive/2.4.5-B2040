package com.goodgamestudios.mafia.controller.protobuf.family
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBHighscore;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBLevelProgress;
   import com.goodgamestudios.mafia.controller.protobuf.family.familyprofile.PBFamilyProfileFamilyBoosters;
   import com.goodgamestudios.mafia.controller.protobuf.family.familyprofile.PBFamilyProfileFamilyWar;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFamilyProfile extends Message
   {
      
      public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.id","id",1 << 3 | WireType.VARINT);
      
      public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.name","name",2 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const PROGRESS:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.progress","progress",3 << 3 | WireType.LENGTH_DELIMITED,PBLevelProgress);
      
      public static const GOLD:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.gold","gold",4 << 3 | WireType.VARINT);
      
      public static const MAX_MEMBER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.max_member","maxMember",5 << 3 | WireType.VARINT);
      
      public static const INCREASE_MAX_MEMBER_GOLD_COSTS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.increase_max_member_gold_costs","increaseMaxMemberGoldCosts",6 << 3 | WireType.VARINT);
      
      public static const HIGHSCORE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.highscore","highscore",7 << 3 | WireType.LENGTH_DELIMITED,PBHighscore);
      
      public static const BOOSTERS:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.boosters","boosters",8 << 3 | WireType.LENGTH_DELIMITED,PBFamilyProfileFamilyBoosters);
      
      public static const CREST:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.crest","crest",9 << 3 | WireType.LENGTH_DELIMITED,PBFamilyCrest);
      
      public static const PLAYER_ACTIVITY_POINTS_TODAY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.player_activity_points_today","playerActivityPointsToday",10 << 3 | WireType.VARINT);
      
      public static const PLAYER_ACTIVITY_POINTS_YESTERDAY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.player_activity_points_yesterday","playerActivityPointsYesterday",11 << 3 | WireType.VARINT);
      
      public static const ATTACKING:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.attacking","attacking",12 << 3 | WireType.LENGTH_DELIMITED,PBFamilyProfileFamilyWar);
      
      public static const DEFENDING:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.defending","defending",13 << 3 | WireType.LENGTH_DELIMITED,PBFamilyProfileFamilyWar);
      
      public static const MEMBER:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.member","member",14 << 3 | WireType.LENGTH_DELIMITED,PBFamilyMemberInfo);
       
      
      public var id:uint;
      
      public var name:String;
      
      public var progress:PBLevelProgress;
      
      public var gold:uint;
      
      public var maxMember:uint;
      
      public var increaseMaxMemberGoldCosts:uint;
      
      public var highscore:PBHighscore;
      
      public var boosters:PBFamilyProfileFamilyBoosters;
      
      public var crest:PBFamilyCrest;
      
      public var playerActivityPointsToday:uint;
      
      public var playerActivityPointsYesterday:uint;
      
      private var attacking$field:PBFamilyProfileFamilyWar;
      
      private var defending$field:PBFamilyProfileFamilyWar;
      
      public var member:Array;
      
      public function PBFamilyProfile()
      {
         this.member = [];
         super();
      }
      
      public function clearAttacking() : void
      {
         this.attacking$field = null;
      }
      
      public function get hasAttacking() : Boolean
      {
         return this.attacking$field != null;
      }
      
      public function set attacking(param1:PBFamilyProfileFamilyWar) : void
      {
         this.attacking$field = param1;
      }
      
      public function get attacking() : PBFamilyProfileFamilyWar
      {
         return this.attacking$field;
      }
      
      public function clearDefending() : void
      {
         this.defending$field = null;
      }
      
      public function get hasDefending() : Boolean
      {
         return this.defending$field != null;
      }
      
      public function set defending(param1:PBFamilyProfileFamilyWar) : void
      {
         this.defending$field = param1;
      }
      
      public function get defending() : PBFamilyProfileFamilyWar
      {
         return this.defending$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.id);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
         WriteUtils.write$TYPE_STRING(param1,this.name);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
         WriteUtils.write$TYPE_MESSAGE(param1,this.progress);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.gold);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_UINT32(param1,this.maxMember);
         WriteUtils.writeTag(param1,WireType.VARINT,6);
         WriteUtils.write$TYPE_UINT32(param1,this.increaseMaxMemberGoldCosts);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,7);
         WriteUtils.write$TYPE_MESSAGE(param1,this.highscore);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,8);
         WriteUtils.write$TYPE_MESSAGE(param1,this.boosters);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,9);
         WriteUtils.write$TYPE_MESSAGE(param1,this.crest);
         WriteUtils.writeTag(param1,WireType.VARINT,10);
         WriteUtils.write$TYPE_UINT32(param1,this.playerActivityPointsToday);
         WriteUtils.writeTag(param1,WireType.VARINT,11);
         WriteUtils.write$TYPE_UINT32(param1,this.playerActivityPointsYesterday);
         if(this.hasAttacking)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,12);
            WriteUtils.write$TYPE_MESSAGE(param1,this.attacking$field);
         }
         if(this.hasDefending)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,13);
            WriteUtils.write$TYPE_MESSAGE(param1,this.defending$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.member.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,14);
            WriteUtils.write$TYPE_MESSAGE(param1,this.member[_loc2_]);
            _loc2_++;
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:uint = 0;
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
         while(param1.bytesAvailable > param2)
         {
            _loc16_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc16_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.id cannot be set twice.");
                  }
                  _loc3_++;
                  this.id = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.name cannot be set twice.");
                  }
                  _loc4_++;
                  this.name = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.progress cannot be set twice.");
                  }
                  _loc5_++;
                  this.progress = new PBLevelProgress();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.progress);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.gold cannot be set twice.");
                  }
                  _loc6_++;
                  this.gold = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.maxMember cannot be set twice.");
                  }
                  _loc7_++;
                  this.maxMember = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.increaseMaxMemberGoldCosts cannot be set twice.");
                  }
                  _loc8_++;
                  this.increaseMaxMemberGoldCosts = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.highscore cannot be set twice.");
                  }
                  _loc9_++;
                  this.highscore = new PBHighscore();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.highscore);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.boosters cannot be set twice.");
                  }
                  _loc10_++;
                  this.boosters = new PBFamilyProfileFamilyBoosters();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.boosters);
                  continue;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.crest cannot be set twice.");
                  }
                  _loc11_++;
                  this.crest = new PBFamilyCrest();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.crest);
                  continue;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.playerActivityPointsToday cannot be set twice.");
                  }
                  _loc12_++;
                  this.playerActivityPointsToday = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.playerActivityPointsYesterday cannot be set twice.");
                  }
                  _loc13_++;
                  this.playerActivityPointsYesterday = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 12:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.attacking cannot be set twice.");
                  }
                  _loc14_++;
                  this.attacking = new PBFamilyProfileFamilyWar();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.attacking);
                  continue;
               case 13:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyProfile.defending cannot be set twice.");
                  }
                  _loc15_++;
                  this.defending = new PBFamilyProfileFamilyWar();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.defending);
                  continue;
               case 14:
                  this.member.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBFamilyMemberInfo()));
                  continue;
               default:
                  super.readUnknown(param1,_loc16_);
                  continue;
            }
         }
      }
   }
}
