package com.goodgamestudios.mafia.controller.protobuf.mission.view
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBMission;
   import com.goodgamestudios.mafia.controller.protobuf.mission.view.response.PBMissionViewResult;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBMissionViewResponse extends Message
   {
      
      public static const RESULT:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.mission.view.Response.result","result",1 << 3 | WireType.VARINT,PBMissionViewResult);
      
      public static const ENERGY_REFILLER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.view.Response.energy_refiller","energyRefiller",2 << 3 | WireType.VARINT);
      
      public static const FREE_MISSION_ENERGY_DRINKS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.view.Response.free_mission_energy_drinks","freeMissionEnergyDrinks",3 << 3 | WireType.VARINT);
      
      public static const MAX_ENERGY_REFILL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.view.Response.max_energy_refill","maxEnergyRefill",4 << 3 | WireType.VARINT);
      
      public static const MISSION_ENERGY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.view.Response.mission_energy","missionEnergy",5 << 3 | WireType.VARINT);
      
      public static const CITY_EVENT_MISSION:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.mission.view.Response.city_event_mission","cityEventMission",6 << 3 | WireType.LENGTH_DELIMITED,PBMission);
      
      public static const CITY_EVENT_MISSION_PROGRESS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.view.Response.city_event_mission_progress","cityEventMissionProgress",7 << 3 | WireType.VARINT);
      
      public static const CITY_EVENT_TOTAL_MISSIONS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.view.Response.city_event_total_missions","cityEventTotalMissions",8 << 3 | WireType.VARINT);
      
      public static const CITY_EVENT_MISSIONS_TIME_LEFT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.mission.view.Response.city_event_missions_time_left","cityEventMissionsTimeLeft",9 << 3 | WireType.VARINT);
      
      public static const MISSIONS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.mission.view.Response.missions","missions",10 << 3 | WireType.LENGTH_DELIMITED,PBMission);
       
      
      public var result:int;
      
      public var energyRefiller:uint;
      
      public var freeMissionEnergyDrinks:uint;
      
      public var maxEnergyRefill:uint;
      
      public var missionEnergy:uint;
      
      private var city_event_mission$field:PBMission;
      
      private var city_event_mission_progress$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var city_event_total_missions$field:uint;
      
      private var city_event_missions_time_left$field:uint;
      
      public var missions:Array;
      
      public function PBMissionViewResponse()
      {
         this.missions = [];
         super();
      }
      
      public function clearCityEventMission() : void
      {
         this.city_event_mission$field = null;
      }
      
      public function get hasCityEventMission() : Boolean
      {
         return this.city_event_mission$field != null;
      }
      
      public function set cityEventMission(param1:PBMission) : void
      {
         this.city_event_mission$field = param1;
      }
      
      public function get cityEventMission() : PBMission
      {
         return this.city_event_mission$field;
      }
      
      public function clearCityEventMissionProgress() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.city_event_mission_progress$field = new uint();
      }
      
      public function get hasCityEventMissionProgress() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set cityEventMissionProgress(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.city_event_mission_progress$field = param1;
      }
      
      public function get cityEventMissionProgress() : uint
      {
         return this.city_event_mission_progress$field;
      }
      
      public function clearCityEventTotalMissions() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.city_event_total_missions$field = new uint();
      }
      
      public function get hasCityEventTotalMissions() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set cityEventTotalMissions(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.city_event_total_missions$field = param1;
      }
      
      public function get cityEventTotalMissions() : uint
      {
         return this.city_event_total_missions$field;
      }
      
      public function clearCityEventMissionsTimeLeft() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.city_event_missions_time_left$field = new uint();
      }
      
      public function get hasCityEventMissionsTimeLeft() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set cityEventMissionsTimeLeft(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.city_event_missions_time_left$field = param1;
      }
      
      public function get cityEventMissionsTimeLeft() : uint
      {
         return this.city_event_missions_time_left$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_ENUM(param1,this.result);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_UINT32(param1,this.energyRefiller);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_UINT32(param1,this.freeMissionEnergyDrinks);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_UINT32(param1,this.maxEnergyRefill);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_UINT32(param1,this.missionEnergy);
         if(this.hasCityEventMission)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,6);
            WriteUtils.write$TYPE_MESSAGE(param1,this.city_event_mission$field);
         }
         if(this.hasCityEventMissionProgress)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,this.city_event_mission_progress$field);
         }
         if(this.hasCityEventTotalMissions)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,8);
            WriteUtils.write$TYPE_UINT32(param1,this.city_event_total_missions$field);
         }
         if(this.hasCityEventMissionsTimeLeft)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,9);
            WriteUtils.write$TYPE_UINT32(param1,this.city_event_missions_time_left$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.missions.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,10);
            WriteUtils.write$TYPE_MESSAGE(param1,this.missions[_loc2_]);
            _loc2_++;
         }
         for(_loc3_ in this)
         {
            super.writeUnknown(param1,_loc3_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc12_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc12_ >> 3)
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
                     throw new IOError("Bad data format: Response.energyRefiller cannot be set twice.");
                  }
                  _loc4_++;
                  this.energyRefiller = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Response.freeMissionEnergyDrinks cannot be set twice.");
                  }
                  _loc5_++;
                  this.freeMissionEnergyDrinks = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Response.maxEnergyRefill cannot be set twice.");
                  }
                  _loc6_++;
                  this.maxEnergyRefill = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Response.missionEnergy cannot be set twice.");
                  }
                  _loc7_++;
                  this.missionEnergy = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Response.cityEventMission cannot be set twice.");
                  }
                  _loc8_++;
                  this.cityEventMission = new PBMission();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.cityEventMission);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: Response.cityEventMissionProgress cannot be set twice.");
                  }
                  _loc9_++;
                  this.cityEventMissionProgress = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: Response.cityEventTotalMissions cannot be set twice.");
                  }
                  _loc10_++;
                  this.cityEventTotalMissions = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: Response.cityEventMissionsTimeLeft cannot be set twice.");
                  }
                  _loc11_++;
                  this.cityEventMissionsTimeLeft = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 10:
                  this.missions.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBMission()));
                  continue;
               default:
                  super.readUnknown(param1,_loc12_);
                  continue;
            }
         }
      }
   }
}
