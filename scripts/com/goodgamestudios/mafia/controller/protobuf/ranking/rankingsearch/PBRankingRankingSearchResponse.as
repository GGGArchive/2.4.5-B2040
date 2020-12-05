package com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch
{
   import com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.response.PBRankingRankingSearchResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBRankingRankingSearchResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.Response.result","result",1 << 3 | WireType.VARINT,PBRankingRankingSearchResult);
      
      public static const LIST_TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.Response.list_type","listType",2 << 3 | WireType.VARINT,PBRankingRankingSearchListType);
      
      public static const LIST_UPDATE_TIME_IN_SECS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.Response.list_update_time_in_secs","listUpdateTimeInSecs",3 << 3 | WireType.VARINT);
      
      public static const PLAYER_RANK_LIST:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.Response.player_rank_list","playerRankList",4 << 3 | WireType.LENGTH_DELIMITED,PBRankingRankingSearchPlayerRankingEntry);
      
      public static const FAMILY_RANK_LIST:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.ranking.rankingsearch.Response.family_rank_list","familyRankList",5 << 3 | WireType.LENGTH_DELIMITED,PBRankingRankingSearchFamilyRankingEntry);
       
      
      public var result:int = 1;
      
      private var list_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var list_update_time_in_secs$field:uint;
      
      public var playerRankList:Array;
      
      public var familyRankList:Array;
      
      public function PBRankingRankingSearchResponse()
      {
         this.playerRankList = [];
         this.familyRankList = [];
         super();
      }
      
      public function clearListType() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.list_type$field = new int();
      }
      
      public function get hasListType() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set listType(param1:int) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.list_type$field = param1;
      }
      
      public function get listType() : int
      {
         return this.list_type$field;
      }
      
      public function clearListUpdateTimeInSecs() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.list_update_time_in_secs$field = new uint();
      }
      
      public function get hasListUpdateTimeInSecs() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set listUpdateTimeInSecs(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.list_update_time_in_secs$field = param1;
      }
      
      public function get listUpdateTimeInSecs() : uint
      {
         return this.list_update_time_in_secs$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasListType)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_ENUM(param1,this.list_type$field);
         }
         if(this.hasListUpdateTimeInSecs)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,this.list_update_time_in_secs$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.playerRankList.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.playerRankList[_loc2_]);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this.familyRankList.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,5);
            WriteUtils.write$TYPE_MESSAGE(param1,this.familyRankList[_loc3_]);
            _loc3_++;
         }
         for(_loc4_ in this)
         {
            super.writeUnknown(param1,_loc4_);
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.listType cannot be set twice.");
                  }
                  _loc4_++;
                  this.listType = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.listUpdateTimeInSecs cannot be set twice.");
                  }
                  _loc5_++;
                  this.listUpdateTimeInSecs = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  this.playerRankList.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBRankingRankingSearchPlayerRankingEntry()));
                  continue;
               case 5:
                  this.familyRankList.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBRankingRankingSearchFamilyRankingEntry()));
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
