package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewgear.PBEquipmentViewGearResponse;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.vo.items.GearVO;
   
   public class MafiaGearData
   {
       
      
      public var items:Vector.<GearVO>;
      
      public function MafiaGearData()
      {
         super();
         this.items = new Vector.<GearVO>();
      }
      
      public function parseDataPB(param1:PBEquipmentViewGearResponse, param2:MafiaProfileData) : void
      {
         var _loc5_:PBItem = null;
         var _loc6_:GearVO = null;
         this.items = new Vector.<GearVO>();
         var _loc3_:Array = param1.items;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_];
            _loc6_ = MafiaItemData.parseItem(_loc3_[_loc4_] as PBItem,ItemLocation.Gear,_loc4_ + 1) as GearVO;
            this.items.push(_loc6_);
            _loc4_++;
         }
      }
      
      public function getItemById(param1:int) : GearVO
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.items.length)
         {
            if(this.items[_loc2_].id == param1)
            {
               return this.items[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function itemOnIndex(param1:int) : GearVO
      {
         if(param1 >= 0)
         {
            return this.items[param1 - 1];
         }
         return null;
      }
      
      public function replaceItemOnIndex(param1:int, param2:GearVO) : void
      {
         if(param2)
         {
            param2.slotId = param1;
         }
         this.items[param1 - 1] = param2;
      }
   }
}
