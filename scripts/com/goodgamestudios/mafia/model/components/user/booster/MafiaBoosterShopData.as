package com.goodgamestudios.mafia.model.components.user.booster
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.controller.protobuf.mission.booster.showmissionbooster.response.PBMissionBoosterShowMissionBoosterBooster;
   import com.goodgamestudios.mafia.event.model.MafiaBoosterEvent;
   import com.goodgamestudios.mafia.vo.BoosterShopItemVO;
   import flash.geom.Point;
   
   public class MafiaBoosterShopData
   {
       
      
      public var booster:Vector.<BoosterShopItemVO>;
      
      public function MafiaBoosterShopData()
      {
         super();
      }
      
      public function parseBoosterShopData(param1:Array) : void
      {
         var _loc4_:PBMissionBoosterShowMissionBoosterBooster = null;
         var _loc5_:BoosterShopItemVO = null;
         this.booster = new Vector.<BoosterShopItemVO>();
         var _loc2_:Array = [new Point(345,330),new Point(300,120),new Point(560,100)];
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = PBMissionBoosterShowMissionBoosterBooster(param1[_loc3_]);
            _loc5_ = new BoosterShopItemVO();
            _loc5_.boosterID = _loc4_.boosterID;
            _loc5_.power = _loc4_.boosterPower;
            _loc5_.duration = _loc4_.duration;
            _loc5_.cash = _loc4_.costCurrency1;
            _loc5_.gold = _loc4_.costCurrency2;
            _loc5_.earnCash = _loc4_.earnCurrency1;
            _loc5_.staticPosition = _loc2_[_loc3_];
            this.booster.push(_loc5_);
            _loc3_++;
         }
         BasicController.getInstance().dispatchEvent(new MafiaBoosterEvent(MafiaBoosterEvent.CHANGE_BOOSTERSHOPDATA));
      }
   }
}
