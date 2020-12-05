package com.goodgamestudios.mafia.controller.protobuf.family.familyprofile
{
   import com.goodgamestudios.mafia.controller.protobuf.family.PBFamilyBoosterQuality;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFamilyProfileFamilyBooster extends Message
   {
      
      public static const QUALITY:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.FamilyBooster.quality","quality",1 << 3 | WireType.VARINT,PBFamilyBoosterQuality);
      
      public static const ENDTIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.FamilyBooster.endtime","endtime",2 << 3 | WireType.VARINT);
      
      public static const PERCENTAGE_FAMILY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.FamilyBooster.percentage_family","percentageFamily",3 << 3 | WireType.VARINT);
      
      public static const PERCENTAGE_PLAYER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.FamilyBooster.percentage_player","percentagePlayer",4 << 3 | WireType.VARINT);
       
      
      public var quality:int;
      
      public var endtime:uint;
      
      public var percentageFamily:uint;
      
      public var percentagePlayer:uint;
      
      public function PBFamilyProfileFamilyBooster()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.quality);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.endtime);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.percentageFamily);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.percentagePlayer);
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
                     throw new IOError("Bad data format: FamilyBooster.quality cannot be set twice.");
                  }
                  _loc3_++;
                  this.quality = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyBooster.endtime cannot be set twice.");
                  }
                  _loc4_++;
                  this.endtime = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyBooster.percentageFamily cannot be set twice.");
                  }
                  _loc5_++;
                  this.percentageFamily = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyBooster.percentagePlayer cannot be set twice.");
                  }
                  _loc6_++;
                  this.percentagePlayer = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
