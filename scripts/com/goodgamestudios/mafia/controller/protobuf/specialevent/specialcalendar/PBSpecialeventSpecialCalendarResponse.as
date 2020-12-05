package com.goodgamestudios.mafia.controller.protobuf.specialevent.specialcalendar
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_BOOL;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBSpecialeventSpecialCalendarResponse extends Message
   {
      
      public static const TIME_UNTIL_NEXT_UNLOCK:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.specialcalendar.Response.time_until_next_unlock","timeUntilNextUnlock",1 << 3 | WireType.VARINT);
      
      public static const ENEMY_DEFEATED:RepeatedFieldDescriptor$TYPE_BOOL = new RepeatedFieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.specialevent.specialcalendar.Response.enemy_defeated","enemyDefeated",2 << 3 | WireType.VARINT);
      
      public static const ITEM:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.specialevent.specialcalendar.Response.item","item",3 << 3 | WireType.LENGTH_DELIMITED,PBItem);
       
      
      public var timeUntilNextUnlock:uint;
      
      public var enemyDefeated:Array;
      
      private var item$field:PBItem;
      
      public function PBSpecialeventSpecialCalendarResponse()
      {
         this.enemyDefeated = [];
         super();
      }
      
      public function clearItem() : void
      {
         this.item$field = null;
      }
      
      public function get hasItem() : Boolean
      {
         return this.item$field != null;
      }
      
      public function set item(param1:PBItem) : void
      {
         this.item$field = param1;
      }
      
      public function get item() : PBItem
      {
         return this.item$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.timeUntilNextUnlock);
         var _loc2_:uint = 0;
         while(_loc2_ < this.enemyDefeated.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_BOOL(param1,this.enemyDefeated[_loc2_]);
            _loc2_++;
         }
         if(this.hasItem)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,this.item$field);
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
                     throw new IOError("Bad data format: Response.timeUntilNextUnlock cannot be set twice.");
                  }
                  _loc3_++;
                  this.timeUntilNextUnlock = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if((_loc5_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_BOOL,this.enemyDefeated);
                  }
                  else
                  {
                     this.enemyDefeated.push(ReadUtils.read$TYPE_BOOL(param1));
                  }
                  continue;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.item cannot be set twice.");
                  }
                  _loc4_++;
                  this.item = new PBItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.item);
                  continue;
               default:
                  super.readUnknown(param1,_loc5_);
                  continue;
            }
         }
      }
   }
}
