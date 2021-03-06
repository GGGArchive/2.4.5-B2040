package com.goodgamestudios.mafia.controller.protobuf.misc.loginwelcome
{
   import com.goodgamestudios.mafia.controller.protobuf.misc.loginwelcome.response.PBMiscLoginWelcomeReward;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.utils.IDataInput;
   
   public final class PBMiscLoginWelcomeResponse extends Message
   {
      
      public static const REWARD:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.misc.loginwelcome.Response.reward","reward",1 << 3 | WireType.LENGTH_DELIMITED,PBMiscLoginWelcomeReward);
       
      
      public var reward:Array;
      
      public function PBMiscLoginWelcomeResponse()
      {
         this.reward = [];
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:uint = 0;
         while(_loc2_ < this.reward.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,this.reward[_loc2_]);
            _loc2_++;
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc3_ >> 3)
            {
               case 1:
                  this.reward.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBMiscLoginWelcomeReward()));
                  continue;
               default:
                  super.readUnknown(param1,_loc3_);
                  continue;
            }
         }
      }
   }
}
