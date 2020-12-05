package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.commands.equipment.ViewFoodCommand;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.vo.items.FoodVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   
   public class MafiaFoodData
   {
       
      
      public var food:Vector.<FoodVO>;
      
      private var numActiveFood:int;
      
      public function MafiaFoodData()
      {
         super();
         this.food = new Vector.<FoodVO>();
      }
      
      public function parseDataPB(param1:Array, param2:MafiaProfileData) : void
      {
         var _loc5_:FoodVO = null;
         this.food = new Vector.<FoodVO>();
         var _loc3_:Array = param1;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = MafiaItemData.parseItem(_loc3_[_loc4_] as PBItem,ItemLocation.FoodInUse,_loc4_) as FoodVO;
            this.food.push(_loc5_);
            _loc4_++;
         }
         this.countActiveFood(this.food,param2);
      }
      
      private function countActiveFood(param1:Vector.<FoodVO>, param2:MafiaProfileData) : void
      {
         var _loc4_:FoodVO = null;
         this.numActiveFood = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_)
            {
               this.numActiveFood++;
            }
            _loc3_++;
         }
      }
      
      public function checkFoodTime(param1:Number) : void
      {
         var _loc2_:uint = 0;
         if(this.food.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.food.length)
            {
               if(this.food[_loc2_] != null)
               {
                  if(param1 > this.food[_loc2_].expiringComponent.endTime)
                  {
                     this.food[_loc2_] = new FoodVO();
                     BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_FOOD_DATA));
                     BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA));
                     ViewFoodCommand.sendCommand(MafiaModel.userData.playerID);
                  }
                  this.food[_loc2_].expiringComponent.remainingTime = TimeStringHelper.getTimeToString((this.food[_loc2_].expiringComponent.endTime - param1) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
               }
               _loc2_++;
            }
         }
      }
      
      public function get isAFoodSlotEmpty() : Boolean
      {
         return this.numActiveFood < 3;
      }
      
      public function getSlotOfFoodWithSameItemId(param1:int) : int
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.food.length)
         {
            if(this.food[_loc2_] && this.food[_loc2_].id == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function getFirstFreeSlot() : int
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.food.length)
         {
            if(this.food[_loc1_] == null)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
   }
}
