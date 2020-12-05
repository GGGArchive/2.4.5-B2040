package com.goodgamestudios.mafia.controller.protobuf.mission.booster.getplayerbooster
{
   import com.goodgamestudios.mafia.controller.protobuf.mission.booster.getplayerbooster.response.PBMissionBoosterGetPlayerBoosterBooster;
   import com.goodgamestudios.mafia.controller.protobuf.mission.booster.getplayerbooster.response.PBMissionBoosterGetPlayerBoosterResult;
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
   
   public final class PBMissionBoosterGetPlayerBoosterResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.mission.booster.getplayerbooster.Response.result","result",1 << 3 | WireType.VARINT,PBMissionBoosterGetPlayerBoosterResult);
      
      public static const PLAYERID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.booster.getplayerbooster.Response.playerID","playerID",2 << 3 | WireType.VARINT);
      
      public static const BOOSTERS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.mission.booster.getplayerbooster.Response.boosters","boosters",3 << 3 | WireType.LENGTH_DELIMITED,PBMissionBoosterGetPlayerBoosterBooster);
       
      
      public var result:int;
      
      public var playerID:uint;
      
      public var boosters:Array;
      
      public function PBMissionBoosterGetPlayerBoosterResponse()
      {
         this.boosters = [];
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.playerID);
         var _loc2_:uint = 0;
         while(_loc2_ < this.boosters.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,this.boosters[_loc2_]);
            _loc2_++;
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc5_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc5_ >> 3)
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
                     throw new IOError("Bad data format: Response.playerID cannot be set twice.");
                  }
                  _loc4_++;
                  this.playerID = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  this.boosters.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBMissionBoosterGetPlayerBoosterBooster()));
                  continue;
               default:
                  super.readUnknown(param1,_loc5_);
                  continue;
            }
         }
      }
   }
}
