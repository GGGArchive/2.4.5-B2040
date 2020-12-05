package com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch
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
   
   public final class PBRankingRankingSearchPlayerRankingEntry extends Message
   {
      
      public static const RANK:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PlayerRankingEntry.rank","rank",1 << 3 | WireType.VARINT);
      
      public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PlayerRankingEntry.id","id",2 << 3 | WireType.VARINT);
      
      public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PlayerRankingEntry.name","name",3 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PlayerRankingEntry.level","level",4 << 3 | WireType.VARINT);
      
      public static const GLORY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PlayerRankingEntry.glory","glory",5 << 3 | WireType.VARINT);
      
      public static const TYPE_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PlayerRankingEntry.type_id","typeId",6 << 3 | WireType.VARINT);
      
      public static const FAMILY_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PlayerRankingEntry.family_id","familyId",7 << 3 | WireType.VARINT);
      
      public static const FAMILY_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.PlayerRankingEntry.family_name","familyName",8 << 3 | WireType.LENGTH_DELIMITED);
       
      
      public var rank:uint;
      
      public var id:uint;
      
      public var name:String;
      
      public var level:uint;
      
      public var glory:uint;
      
      public var typeId:uint;
      
      private var family_id$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var family_name$field:String;
      
      public function PBRankingRankingSearchPlayerRankingEntry()
      {
         super();
      }
      
      public function clearFamilyId() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.family_id$field = new uint();
      }
      
      public function get hasFamilyId() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set familyId(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.family_id$field = param1;
      }
      
      public function get familyId() : uint
      {
         return this.family_id$field;
      }
      
      public function clearFamilyName() : void
      {
         this.family_name$field = null;
      }
      
      public function get hasFamilyName() : Boolean
      {
         return this.family_name$field != null;
      }
      
      public function set familyName(param1:String) : void
      {
         this.family_name$field = param1;
      }
      
      public function get familyName() : String
      {
         return this.family_name$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.rank);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.id);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
         WriteUtils.write$TYPE_STRING(param1,this.name);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.level);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_UINT32(param1,this.glory);
         WriteUtils.writeTag(param1,WireType.VARINT,6);
         WriteUtils.write$TYPE_UINT32(param1,this.typeId);
         if(this.hasFamilyId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,this.family_id$field);
         }
         if(this.hasFamilyName)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,8);
            WriteUtils.write$TYPE_STRING(param1,this.family_name$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
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
                     throw new IOError("Bad data format: PlayerRankingEntry.rank cannot be set twice.");
                  }
                  _loc3_++;
                  this.rank = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerRankingEntry.id cannot be set twice.");
                  }
                  _loc4_++;
                  this.id = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerRankingEntry.name cannot be set twice.");
                  }
                  _loc5_++;
                  this.name = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerRankingEntry.level cannot be set twice.");
                  }
                  _loc6_++;
                  this.level = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerRankingEntry.glory cannot be set twice.");
                  }
                  _loc7_++;
                  this.glory = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerRankingEntry.typeId cannot be set twice.");
                  }
                  _loc8_++;
                  this.typeId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerRankingEntry.familyId cannot be set twice.");
                  }
                  _loc9_++;
                  this.familyId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerRankingEntry.familyName cannot be set twice.");
                  }
                  _loc10_++;
                  this.familyName = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc11_);
                  continue;
            }
         }
      }
   }
}
