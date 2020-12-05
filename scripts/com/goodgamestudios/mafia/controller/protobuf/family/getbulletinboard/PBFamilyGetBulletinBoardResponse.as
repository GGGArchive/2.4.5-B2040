package com.goodgamestudios.mafia.controller.protobuf.family.getbulletinboard
{
   import com.goodgamestudios.mafia.controller.protobuf.family.getbulletinboard.response.PBFamilyGetBulletinBoardResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFamilyGetBulletinBoardResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.family.getbulletinboard.Response.result","result",1 << 3 | WireType.VARINT,PBFamilyGetBulletinBoardResult);
      
      public static const CONTENT:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.family.getbulletinboard.Response.content","content",2 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const LAST_CHANGED_BY:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.family.getbulletinboard.Response.last_changed_by","lastChangedBy",3 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const WRITE_RIGHTS:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.family.getbulletinboard.Response.write_rights","writeRights",4 << 3 | WireType.VARINT);
       
      
      public var result:int;
      
      private var content$field:String;
      
      private var last_changed_by$field:String;
      
      private var write_rights$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      public function PBFamilyGetBulletinBoardResponse()
      {
         super();
      }
      
      public function clearContent() : void
      {
         this.content$field = null;
      }
      
      public function get hasContent() : Boolean
      {
         return this.content$field != null;
      }
      
      public function set content(param1:String) : void
      {
         this.content$field = param1;
      }
      
      public function get content() : String
      {
         return this.content$field;
      }
      
      public function clearLastChangedBy() : void
      {
         this.last_changed_by$field = null;
      }
      
      public function get hasLastChangedBy() : Boolean
      {
         return this.last_changed_by$field != null;
      }
      
      public function set lastChangedBy(param1:String) : void
      {
         this.last_changed_by$field = param1;
      }
      
      public function get lastChangedBy() : String
      {
         return this.last_changed_by$field;
      }
      
      public function clearWriteRights() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.write_rights$field = new Boolean();
      }
      
      public function get hasWriteRights() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set writeRights(param1:Boolean) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.write_rights$field = param1;
      }
      
      public function get writeRights() : Boolean
      {
         return this.write_rights$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         if(this.hasContent)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_STRING(param1,this.content$field);
         }
         if(this.hasLastChangedBy)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_STRING(param1,this.last_changed_by$field);
         }
         if(this.hasWriteRights)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_BOOL(param1,this.write_rights$field);
         }
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.content cannot be set twice.");
                  }
                  _loc4_++;
                  this.content = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.lastChangedBy cannot be set twice.");
                  }
                  _loc5_++;
                  this.lastChangedBy = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.writeRights cannot be set twice.");
                  }
                  _loc6_++;
                  this.writeRights = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc7_);
                  continue;
            }
         }
      }
   }
}
