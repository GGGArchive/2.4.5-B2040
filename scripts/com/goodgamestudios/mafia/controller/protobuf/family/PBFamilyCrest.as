package com.goodgamestudios.mafia.controller.protobuf.family
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFamilyCrest extends Message
   {
      
      public static const PRIMARY:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.FamilyCrest.primary","primary",1 << 3 | WireType.LENGTH_DELIMITED,PBFamilyCrestPart);
      
      public static const SECONDARY:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.FamilyCrest.secondary","secondary",2 << 3 | WireType.LENGTH_DELIMITED,PBFamilyCrestPart);
      
      public static const BANDEROLE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.FamilyCrest.banderole","banderole",3 << 3 | WireType.LENGTH_DELIMITED,PBFamilyCrestPart);
       
      
      public var primary:PBFamilyCrestPart;
      
      public var secondary:PBFamilyCrestPart;
      
      public var banderole:PBFamilyCrestPart;
      
      public function PBFamilyCrest()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
         WriteUtils.write$TYPE_MESSAGE(param1,this.primary);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
         WriteUtils.write$TYPE_MESSAGE(param1,this.secondary);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
         WriteUtils.write$TYPE_MESSAGE(param1,this.banderole);
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
                     throw new IOError("Bad data format: FamilyCrest.primary cannot be set twice.");
                  }
                  _loc3_++;
                  this.primary = new PBFamilyCrestPart();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.primary);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyCrest.secondary cannot be set twice.");
                  }
                  _loc4_++;
                  this.secondary = new PBFamilyCrestPart();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.secondary);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FamilyCrest.banderole cannot be set twice.");
                  }
                  _loc5_++;
                  this.banderole = new PBFamilyCrestPart();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.banderole);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
