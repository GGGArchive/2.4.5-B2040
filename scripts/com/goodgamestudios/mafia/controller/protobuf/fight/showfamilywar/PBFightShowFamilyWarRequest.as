package com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar
{
   import com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar.request.PBFightShowFamilyWarFamilyWarType;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightShowFamilyWarRequest extends Message
   {
      
      public static const FAMILY_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar.Request.family_id","familyId",1 << 3 | WireType.VARINT);
      
      public static const FAMILY_WAR_TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar.Request.family_war_type","familyWarType",2 << 3 | WireType.VARINT,PBFightShowFamilyWarFamilyWarType);
      
      public static const FIGHT_TIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar.Request.fight_time","fightTime",3 << 3 | WireType.VARINT);
       
      
      public var familyId:uint;
      
      public var familyWarType:int;
      
      public var fightTime:uint;
      
      public function PBFightShowFamilyWarRequest()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.familyId);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_ENUM(param1,this.familyWarType);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.fightTime);
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
                     throw new IOError("Bad data format: Request.familyId cannot be set twice.");
                  }
                  _loc3_++;
                  this.familyId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Request.familyWarType cannot be set twice.");
                  }
                  _loc4_++;
                  this.familyWarType = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Request.fightTime cannot be set twice.");
                  }
                  _loc5_++;
                  this.fightTime = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
