package com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCity;
   import com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.response.PBGangwarShowGangWarsGangWar;
   import com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.response.PBGangwarShowGangWarsResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBGangwarShowGangWarsResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.result","result",1 << 3 | WireType.VARINT,PBGangwarShowGangWarsResult);
      
      public static const CITY:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.city","city",2 << 3 | WireType.VARINT,PBCity);
      
      public static const RECRUITEDFRIENDS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.recruitedFriends","recruitedFriends",3 << 3 | WireType.VARINT);
      
      public static const GANG_WARS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.gangwar.showgangwars.Response.gang_wars","gangWars",4 << 3 | WireType.LENGTH_DELIMITED,PBGangwarShowGangWarsGangWar);
       
      
      public var result:int;
      
      public var city:int;
      
      public var recruitedFriends:uint;
      
      public var gangWars:Array;
      
      public function PBGangwarShowGangWarsResponse()
      {
         this.gangWars = [];
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_ENUM(param1,this.city);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.recruitedFriends);
         var _loc2_:uint = 0;
         while(_loc2_ < this.gangWars.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,this.gangWars[_loc2_]);
            _loc2_++;
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Response.city cannot be set twice.");
                  }
                  _loc4_++;
                  this.city = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.recruitedFriends cannot be set twice.");
                  }
                  _loc5_++;
                  this.recruitedFriends = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  this.gangWars.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBGangwarShowGangWarsGangWar()));
                  continue;
               default:
                  super.readUnknown(param1,_loc6_);
                  continue;
            }
         }
      }
   }
}
