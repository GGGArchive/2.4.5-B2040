package com.goodgamestudios.mafia.controller.protobuf.equipment.unequiparmament
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBEquipmentUnequipArmamentRequest extends Message
   {
      
      public static const SOURCE_X:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.unequiparmament.Request.source_x","sourceX",1 << 3 | WireType.VARINT);
      
      public static const SOURCE_Y:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.unequiparmament.Request.source_y","sourceY",2 << 3 | WireType.VARINT);
      
      public static const TARGET:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.unequiparmament.Request.target","target",3 << 3 | WireType.VARINT);
      
      public static const ARMAMENT_NUMBER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.equipment.unequiparmament.Request.armament_number","armamentNumber",4 << 3 | WireType.VARINT);
       
      
      public var sourceX:uint;
      
      public var sourceY:uint;
      
      public var target:uint;
      
      public var armamentNumber:uint;
      
      public function PBEquipmentUnequipArmamentRequest()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.sourceX);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.sourceY);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.target);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.armamentNumber);
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
                     throw new IOError("Bad data format: Request.sourceX cannot be set twice.");
                  }
                  _loc3_++;
                  this.sourceX = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Request.sourceY cannot be set twice.");
                  }
                  _loc4_++;
                  this.sourceY = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Request.target cannot be set twice.");
                  }
                  _loc5_++;
                  this.target = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Request.armamentNumber cannot be set twice.");
                  }
                  _loc6_++;
                  this.armamentNumber = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
