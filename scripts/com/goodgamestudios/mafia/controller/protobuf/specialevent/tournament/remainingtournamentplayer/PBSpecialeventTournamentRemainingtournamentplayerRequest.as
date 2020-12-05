package com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.remainingtournamentplayer
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_INT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBSpecialeventTournamentRemainingtournamentplayerRequest extends Message
   {
      
      public static const SCROLL_POSITION:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.remainingtournamentplayer.Request.scroll_position","scrollPosition",1 << 3 | WireType.VARINT);
       
      
      public var scrollPosition:int;
      
      public function PBSpecialeventTournamentRemainingtournamentplayerRequest()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_INT32(param1,this.scrollPosition);
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc4_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc4_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: Request.scrollPosition cannot be set twice.");
                  }
                  _loc3_++;
                  this.scrollPosition = ReadUtils.read$TYPE_INT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc4_);
                  continue;
            }
         }
      }
   }
}
