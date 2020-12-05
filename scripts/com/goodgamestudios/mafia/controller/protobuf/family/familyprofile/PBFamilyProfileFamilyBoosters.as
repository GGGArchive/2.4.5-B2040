package com.goodgamestudios.mafia.controller.protobuf.family.familyprofile
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFamilyProfileFamilyBoosters extends Message
   {
      
      public static const GOLD_COST_LOW:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.FamilyBoosters.gold_cost_low","goldCostLow",1 << 3 | WireType.VARINT);
      
      public static const GOLD_COST_HIGH:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.FamilyBoosters.gold_cost_high","goldCostHigh",2 << 3 | WireType.VARINT);
      
      public static const CASH:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.FamilyBoosters.cash","cash",3 << 3 | WireType.LENGTH_DELIMITED,PBFamilyProfileFamilyBooster);
      
      public static const XP:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.FamilyProfile.FamilyBoosters.xp","xp",4 << 3 | WireType.LENGTH_DELIMITED,PBFamilyProfileFamilyBooster);
       
      
      public var goldCostLow:uint;
      
      public var goldCostHigh:uint;
      
      public var cash:PBFamilyProfileFamilyBooster;
      
      public var xp:PBFamilyProfileFamilyBooster;
      
      public function PBFamilyProfileFamilyBoosters()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.goldCostLow);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.goldCostHigh);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
         WriteUtils.write$TYPE_MESSAGE(param1,this.cash);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
         WriteUtils.write$TYPE_MESSAGE(param1,this.xp);
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
                     throw new IOError("Bad data format: FamilyBoosters.goldCostLow cannot be set twice.");
                  }
                  _loc3_++;
                  this.goldCostLow = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyBoosters.goldCostHigh cannot be set twice.");
                  }
                  _loc4_++;
                  this.goldCostHigh = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyBoosters.cash cannot be set twice.");
                  }
                  _loc5_++;
                  this.cash = new PBFamilyProfileFamilyBooster();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.cash);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyBoosters.xp cannot be set twice.");
                  }
                  _loc6_++;
                  this.xp = new PBFamilyProfileFamilyBooster();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.xp);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
