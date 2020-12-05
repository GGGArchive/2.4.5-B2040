package com.goodgamestudios.mafia.controller.protobuf.family.showfamily
{
   import com.goodgamestudios.mafia.controller.protobuf.family.PBFamilyProfile;
   import com.goodgamestudios.mafia.controller.protobuf.family.showfamily.response.PBFamilyShowFamilyResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFamilyShowFamilyResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.family.showfamily.Response.result","result",1 << 3 | WireType.VARINT,PBFamilyShowFamilyResult);
      
      public static const PROFILE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.family.showfamily.Response.profile","profile",2 << 3 | WireType.LENGTH_DELIMITED,PBFamilyProfile);
       
      
      public var result:int;
      
      private var profile$field:PBFamilyProfile;
      
      public function PBFamilyShowFamilyResponse()
      {
         super();
      }
      
      public function clearProfile() : void
      {
         this.profile$field = null;
      }
      
      public function get hasProfile() : Boolean
      {
         return this.profile$field != null;
      }
      
      public function set profile(param1:PBFamilyProfile) : void
      {
         this.profile$field = param1;
      }
      
      public function get profile() : PBFamilyProfile
      {
         return this.profile$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasProfile)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,this.profile$field);
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
                     throw new IOError("Bad data format: Response.profile cannot be set twice.");
                  }
                  _loc4_++;
                  this.profile = new PBFamilyProfile();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.profile);
                  continue;
               default:
                  super.readUnknown(param1,_loc5_);
                  continue;
            }
         }
      }
   }
}
