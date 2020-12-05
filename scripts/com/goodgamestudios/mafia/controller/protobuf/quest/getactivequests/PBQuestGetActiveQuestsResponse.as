package com.goodgamestudios.mafia.controller.protobuf.quest.getactivequests
{
   import com.goodgamestudios.mafia.controller.protobuf.quest.PBQuest;
   import com.goodgamestudios.mafia.controller.protobuf.quest.getactivequests.response.PBQuestGetActiveQuestsResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBQuestGetActiveQuestsResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.quest.getactivequests.Response.result","result",1 << 3 | WireType.VARINT,PBQuestGetActiveQuestsResult);
      
      public static const QUESTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.quest.getactivequests.Response.quests","quests",2 << 3 | WireType.LENGTH_DELIMITED,PBQuest);
      
      public static const NEW_QUESTS_AVAILABLE:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.quest.getactivequests.Response.new_quests_available","newQuestsAvailable",3 << 3 | WireType.VARINT);
       
      
      public var result:int;
      
      public var quests:Array;
      
      public var newQuestsAvailable:Boolean;
      
      public function PBQuestGetActiveQuestsResponse()
      {
         this.quests = [];
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         var _loc2_:uint = 0;
         while(_loc2_ < this.quests.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,this.quests[_loc2_]);
            _loc2_++;
         }
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_BOOL(param1,this.newQuestsAvailable);
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  this.quests.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBQuest()));
                  continue;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.newQuestsAvailable cannot be set twice.");
                  }
                  _loc4_++;
                  this.newQuestsAvailable = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc5_);
                  continue;
            }
         }
      }
   }
}
