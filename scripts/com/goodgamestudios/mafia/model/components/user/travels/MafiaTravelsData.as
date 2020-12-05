package com.goodgamestudios.mafia.model.components.user.travels
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.PBTravelShowTravelPossibilitiesResponse;
   import com.goodgamestudios.mafia.controller.protobuf.travel.showtravelpossibilities.response.PBTravelShowTravelPossibilitiesTarget;
   import com.goodgamestudios.mafia.event.model.MafiaTravelEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.vo.travel.TravelVO;
   
   public class MafiaTravelsData
   {
       
      
      public var travels:Vector.<TravelVO>;
      
      public function MafiaTravelsData()
      {
         super();
         this.travels = new Vector.<TravelVO>();
      }
      
      public function parseTravelPossibilitiesData(param1:PBTravelShowTravelPossibilitiesResponse) : void
      {
         var _loc3_:PBTravelShowTravelPossibilitiesTarget = null;
         var _loc4_:TravelVO = null;
         var _loc5_:TravelVO = null;
         var _loc6_:PBTravelShowTravelPossibilitiesTarget = null;
         var _loc7_:TravelVO = null;
         this.travels = new Vector.<TravelVO>();
         var _loc2_:uint = 0;
         while(_loc2_ < param1.cities.length)
         {
            _loc3_ = param1.cities[_loc2_];
            _loc4_ = this.createTravelVOFromProto(_loc3_);
            this.travels.push(_loc4_);
            _loc2_++;
         }
         if(!MafiaModel.specialEvent.sicilianEvent.isSicilyAndFightOnMap)
         {
            _loc5_ = new TravelVO();
            _loc5_.targetId = MafiaModel.userData.profileData.city.index;
            _loc5_.nextOpponentLevel = MafiaModel.userData.gangwarData.bestDungeonOpponent;
            _loc5_.energyUsage = 0;
            _loc5_.flightTimeInSeconds = 0;
            _loc5_.isUnlocked = true;
            this.travels.unshift(_loc5_);
         }
         if(param1.hasCityEvent)
         {
            _loc6_ = param1.cityEvent;
            _loc7_ = this.createTravelVOFromProto(_loc6_);
            _loc7_.targetId = City.Sicily.index;
            this.travels.unshift(_loc7_);
         }
         BasicController.getInstance().dispatchEvent(new MafiaTravelEvent(MafiaTravelEvent.CHANGE_TRAVELDATA));
      }
      
      private function createTravelVOFromProto(param1:PBTravelShowTravelPossibilitiesTarget) : TravelVO
      {
         var _loc2_:TravelVO = new TravelVO();
         _loc2_.targetId = ProtobufEnumTranslator.translateProtoCity(param1.city).index;
         _loc2_.nextOpponentLevel = param1.nextOpponentLevel;
         _loc2_.energyUsage = param1.energyUsage / 10;
         _loc2_.flightTimeInSeconds = param1.flightTime;
         _loc2_.isUnlocked = param1.unlocked;
         return _loc2_;
      }
   }
}
