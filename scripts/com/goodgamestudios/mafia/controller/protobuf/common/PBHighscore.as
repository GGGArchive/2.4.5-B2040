package com.goodgamestudios.mafia.controller.protobuf.common
{
   import com.goodgamestudios.mafia.controller.protobuf.common.highscore.PBHighscoreEntry;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBHighscore extends Message
   {
      
      public static const DYNAMIC:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.Highscore.dynamic","dynamic",1 << 3 | WireType.LENGTH_DELIMITED,PBHighscoreEntry);
      
      public static const ALLTIME:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.Highscore.alltime","alltime",2 << 3 | WireType.LENGTH_DELIMITED,PBHighscoreEntry);
       
      
      public var dynamic:PBHighscoreEntry;
      
      public var alltime:PBHighscoreEntry;
      
      public function PBHighscore()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
         WriteUtils.write$TYPE_MESSAGE(param1,this.dynamic);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
         WriteUtils.write$TYPE_MESSAGE(param1,this.alltime);
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
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
                     throw new IOError("Bad data format: Highscore.dynamic cannot be set twice.");
                  }
                  _loc3_++;
                  this.dynamic = new PBHighscoreEntry();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.dynamic);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Highscore.alltime cannot be set twice.");
                  }
                  _loc4_++;
                  this.alltime = new PBHighscoreEntry();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.alltime);
                  continue;
               default:
                  super.readUnknown(param1,_loc5_);
                  continue;
            }
         }
      }
   }
}
