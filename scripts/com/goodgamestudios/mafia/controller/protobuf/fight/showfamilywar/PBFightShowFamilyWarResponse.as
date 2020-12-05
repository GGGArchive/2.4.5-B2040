package com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar
{
   import com.goodgamestudios.mafia.controller.protobuf.fight.PBFamilyWarResult;
   import com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar.response.PBFightShowFamilyWarResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFightShowFamilyWarResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar.Response.result","result",1 << 3 | WireType.VARINT,PBFightShowFamilyWarResult);
      
      public static const FAMILY_WAR_RESULT:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar.Response.family_war_result","familyWarResult",2 << 3 | WireType.LENGTH_DELIMITED,PBFamilyWarResult);
       
      
      public var result:int;
      
      private var family_war_result$field:PBFamilyWarResult;
      
      public function PBFightShowFamilyWarResponse()
      {
         super();
      }
      
      public function clearFamilyWarResult() : void
      {
         this.family_war_result$field = null;
      }
      
      public function get hasFamilyWarResult() : Boolean
      {
         return this.family_war_result$field != null;
      }
      
      public function set familyWarResult(param1:PBFamilyWarResult) : void
      {
         this.family_war_result$field = param1;
      }
      
      public function get familyWarResult() : PBFamilyWarResult
      {
         return this.family_war_result$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasFamilyWarResult)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,this.family_war_result$field);
         }
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.familyWarResult cannot be set twice.");
                  }
                  _loc4_++;
                  this.familyWarResult = new PBFamilyWarResult();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.familyWarResult);
                  continue;
               default:
                  super.readUnknown(param1,_loc5_);
                  continue;
            }
         }
      }
   }
}
