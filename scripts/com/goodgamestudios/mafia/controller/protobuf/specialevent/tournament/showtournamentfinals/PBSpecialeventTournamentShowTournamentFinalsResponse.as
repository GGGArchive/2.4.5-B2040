package com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals
{
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.response.PBSpecialeventTournamentShowTournamentFinalsDuelInfo;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.response.PBSpecialeventTournamentShowTournamentFinalsResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBSpecialeventTournamentShowTournamentFinalsResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.Response.result","result",1 << 3 | WireType.VARINT,PBSpecialeventTournamentShowTournamentFinalsResult);
      
      public static const DUELS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.specialevent.tournament.showtournamentfinals.Response.duels","duels",2 << 3 | WireType.LENGTH_DELIMITED,PBSpecialeventTournamentShowTournamentFinalsDuelInfo);
       
      
      public var result:int;
      
      public var duels:Array;
      
      public function PBSpecialeventTournamentShowTournamentFinalsResponse()
      {
         this.duels = [];
         super();
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         var _loc2_:uint = 0;
         while(_loc2_ < this.duels.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,this.duels[_loc2_]);
            _loc2_++;
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
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
                     throw new IOError("Bad data format: Response.result cannot be set twice.");
                  }
                  _loc3_++;
                  this.result = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 2:
                  this.duels.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBSpecialeventTournamentShowTournamentFinalsDuelInfo()));
                  continue;
               default:
                  super.readUnknown(param1,_loc4_);
                  continue;
            }
         }
      }
   }
}
