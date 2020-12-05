package com.goodgamestudios.mafia.controller.protobuf.account.createavatar
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCharacterClass;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBGender;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBAccountCreateAvatarRequest extends Message
   {
      
      public static const GENDER:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.account.createavatar.Request.gender","gender",1 << 3 | WireType.VARINT,PBGender);
      
      public static const CHARACTER_CLASS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.account.createavatar.Request.Character_class","characterClass",2 << 3 | WireType.VARINT,PBCharacterClass);
      
      public static const PORTRAIT:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.account.createavatar.Request.portrait","portrait",3 << 3 | WireType.LENGTH_DELIMITED);
       
      
      public var gender:int;
      
      public var characterClass:int;
      
      public var portrait:String;
      
      public function PBAccountCreateAvatarRequest()
      {
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.gender);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_ENUM(param1,this.characterClass);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
         WriteUtils.write$TYPE_STRING(param1,this.portrait);
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
                     throw new IOError("Bad data format: Request.gender cannot be set twice.");
                  }
                  _loc3_++;
                  this.gender = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Request.characterClass cannot be set twice.");
                  }
                  _loc4_++;
                  this.characterClass = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Request.portrait cannot be set twice.");
                  }
                  _loc5_++;
                  this.portrait = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
