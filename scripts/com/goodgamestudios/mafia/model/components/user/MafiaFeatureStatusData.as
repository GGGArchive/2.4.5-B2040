package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.enums.FeatureType;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.featurestatus.getfeaturestatus.response.PBFeaturestatusGetFeatureStatusFeatureStatus;
   import com.goodgamestudios.mafia.event.model.MafiaFeatureEvent;
   import com.goodgamestudios.mafia.vo.FeatureStatusVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   
   public class MafiaFeatureStatusData
   {
      
      public static const TIMER_EXPIRED:String = "shopTimerExpired";
       
      
      public var activeFeatures:Boolean;
      
      public var featureStatus:Vector.<FeatureStatusVO>;
      
      public function MafiaFeatureStatusData()
      {
         super();
         this.activeFeatures = false;
      }
      
      public function parseFeatureStatus(param1:Array) : void
      {
         var _loc4_:FeatureStatusVO = null;
         if(param1.length == 0)
         {
            this.activeFeatures = false;
         }
         else
         {
            this.activeFeatures = true;
         }
         this.featureStatus = new Vector.<FeatureStatusVO>();
         var _loc2_:Array = param1;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = new FeatureStatusVO();
            _loc4_.feature = ProtobufEnumTranslator.translateProtoFeatureType((_loc2_[_loc3_] as PBFeaturestatusGetFeatureStatusFeatureStatus).feature);
            _loc4_.remaining_until_start = (_loc2_[_loc3_] as PBFeaturestatusGetFeatureStatusFeatureStatus).remainingUntilStart;
            _loc4_.remaining_until_end = (_loc2_[_loc3_] as PBFeaturestatusGetFeatureStatusFeatureStatus).remainingUntilEnd;
            _loc4_.runtime_period = (_loc2_[_loc3_] as PBFeaturestatusGetFeatureStatusFeatureStatus).runtimePeriod;
            this.featureStatus.push(_loc4_);
            _loc3_++;
         }
      }
      
      public function checkFeatureStatusTime(param1:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:FeatureStatusVO = null;
         var _loc6_:Number = NaN;
         var _loc2_:uint = 0;
         while(_loc2_ < this.featureStatus.length)
         {
            _loc4_ = new Array();
            _loc5_ = this.featureStatus[_loc2_];
            _loc6_ = _loc5_.remaining_until_end * 1000 - param1;
            _loc4_.push(TimeStringHelper.getShortTimeString(_loc6_));
            if(_loc5_.remaining_until_start == 0 && _loc5_.remaining_until_end > 0)
            {
               _loc5_.isActive = true;
            }
            else
            {
               _loc5_.isActive = false;
            }
            if(_loc6_ <= 0)
            {
               _loc4_.push(MafiaShopData.TIMER_EXPIRED);
            }
            if(_loc5_.isActive)
            {
               switch(_loc5_.feature)
               {
                  case FeatureType.ExtrasShop:
                     _loc3_ = MafiaFeatureEvent.CHANGE_ITEMS_IN_EXTRAS_SHOP_TIME;
                     BasicController.getInstance().dispatchEvent(new MafiaFeatureEvent(_loc3_,_loc4_));
               }
            }
            _loc2_++;
         }
      }
   }
}
