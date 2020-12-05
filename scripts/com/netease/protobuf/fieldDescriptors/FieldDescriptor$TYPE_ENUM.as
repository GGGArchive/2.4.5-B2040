package com.netease.protobuf.fieldDescriptors
{
   import com.netease.protobuf.FieldDescriptor;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.utils.IDataInput;
   
   public final class FieldDescriptor$TYPE_ENUM extends FieldDescriptor
   {
       
      
      public var enumType:Class;
      
      public function FieldDescriptor$TYPE_ENUM(param1:String, param2:String, param3:uint, param4:Class)
      {
         super();
         this.fullName = param1;
         this._name = param2;
         this.tag = param3;
         this.enumType = param4;
      }
      
      override public function get type() : Class
      {
         return int;
      }
      
      override public function readSingleField(param1:IDataInput) : *
      {
         return ReadUtils.read$TYPE_ENUM(param1);
      }
      
      override public function writeSingleField(param1:WritingBuffer, param2:*) : void
      {
         WriteUtils.write$TYPE_ENUM(param1,param2);
      }
   }
}
