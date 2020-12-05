package com.goodgamestudios.mafia.controller.protobuf.fight.startduel
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItemSlot;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightStartDuelRequest extends Message
   {
      
      public static const OPPONENT_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.startduel.Request.opponent_id","opponentId",1 << 3 | WireType.VARINT);
      
      public static const CONSUMABLE_SLOTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.startduel.Request.consumable_slots","consumableSlots",2 << 3 | WireType.LENGTH_DELIMITED,PBItemSlot);
      
      public static const DISABLE_CONSUMABLES:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.fight.startduel.Request.disable_consumables","disableConsumables",3 << 3 | WireType.VARINT);
      
      public static const ARMAMENT_NUMBER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.startduel.Request.armament_number","armamentNumber",4 << 3 | WireType.VARINT);
       
      
      public var opponentId:uint;
      
      public var consumableSlots:Array;
      
      public var disableConsumables:Boolean = false;
      
      public var armamentNumber:uint;
      
      public function PBFightStartDuelRequest()
      {
         this.consumableSlots = [];
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.opponentId);
         var _loc2_:uint = 0;
         while(_loc2_ < this.consumableSlots.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,this.consumableSlots[_loc2_]);
            _loc2_++;
         }
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_BOOL(param1,this.disableConsumables);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.armamentNumber);
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
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
                     throw new IOError("Bad data format: Request.opponentId cannot be set twice.");
                  }
                  _loc3_++;
                  this.opponentId = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  this.consumableSlots.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBItemSlot()));
                  continue;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Request.disableConsumables cannot be set twice.");
                  }
                  _loc4_++;
                  this.disableConsumables = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Request.armamentNumber cannot be set twice.");
                  }
                  _loc5_++;
                  this.armamentNumber = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
