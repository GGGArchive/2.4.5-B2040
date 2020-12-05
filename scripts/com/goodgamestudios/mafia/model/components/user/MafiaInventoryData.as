package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItem;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewinventory.PBEquipmentViewInventoryResponse;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.mafia.vo.items.components.StackableComponent;
   
   public class MafiaInventoryData
   {
      
      public static const NUMBER_OF_ITEMS_PER_ROW:uint = 5;
      
      public static const MAX_NUMBER_OF_ROWS:uint = 10;
      
      public static const MAX_NUMBER_OF_ITEMS:uint = MAX_NUMBER_OF_ROWS * NUMBER_OF_ITEMS_PER_ROW;
       
      
      public var items:Vector.<ItemVO>;
      
      public var isInventoryFull:Boolean;
      
      public var highestUnlockedRow:int;
      
      public var itemCount:int;
      
      private var _currentTopRow:int;
      
      private var _inventoryUnlockCost:Number;
      
      public function MafiaInventoryData()
      {
         super();
         this.items = new Vector.<ItemVO>();
      }
      
      public function parseInventoryDataPB(param1:PBEquipmentViewInventoryResponse) : void
      {
         var _loc5_:ItemVO = null;
         this._inventoryUnlockCost = param1.unlockCost;
         this.items = new Vector.<ItemVO>();
         var _loc2_:Array = param1.items;
         var _loc3_:int = _loc2_.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = MafiaItemData.parseItem(_loc2_[_loc4_] as PBItem,ItemLocation.Inventory,_loc4_);
            this.items.push(_loc5_);
            _loc4_++;
         }
         this.calculateInventorySpace();
         this.highestUnlockedRow = Math.ceil(this.items.length / NUMBER_OF_ITEMS_PER_ROW) - 1;
         this.currentTopRow = this.readCurrentTopRow();
      }
      
      public function getItemsInRow(param1:uint) : Vector.<ItemVO>
      {
         var _loc4_:uint = 0;
         var _loc2_:Vector.<ItemVO> = null;
         var _loc3_:uint = NUMBER_OF_ITEMS_PER_ROW * param1;
         if(this.items.length > _loc3_)
         {
            _loc2_ = new Vector.<ItemVO>(NUMBER_OF_ITEMS_PER_ROW);
            _loc4_ = 0;
            while(_loc4_ < NUMBER_OF_ITEMS_PER_ROW)
            {
               _loc2_[_loc4_] = this.items[_loc4_ + _loc3_];
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      private function readCurrentTopRow() : int
      {
         return MafiaModel.localData.readCurrentTopInventoryRow();
      }
      
      private function saveCurrentTopRow(param1:int) : void
      {
         MafiaModel.localData.saveCurrentTopInventoryRow(param1);
      }
      
      public function calculateInventorySpace() : void
      {
         var _loc3_:ItemVO = null;
         this.itemCount = 0;
         var _loc1_:int = this.items.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.items[_loc2_];
            if(_loc3_ != null)
            {
               this.itemCount++;
            }
            _loc2_++;
         }
         this.isInventoryFull = this.itemCount == _loc1_;
      }
      
      public function getFreeSlot() : int
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         if(!this.isInventoryFull)
         {
            _loc1_ = this.items.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(this.items[_loc2_] == null)
               {
                  return _loc2_;
               }
               _loc2_++;
            }
            return -1;
         }
         return -1;
      }
      
      public function itemOnIndex(param1:int) : ItemVO
      {
         return this.items[param1];
      }
      
      public function replaceItemOnIndex(param1:int, param2:ItemVO) : void
      {
         if(param2)
         {
            param2.slotId = param1;
         }
         this.items[param1] = param2;
      }
      
      public function get currentTopRow() : int
      {
         return this._currentTopRow;
      }
      
      public function set currentTopRow(param1:int) : void
      {
         var _loc2_:int = this._currentTopRow;
         this._currentTopRow = param1;
         if(_loc2_ != this._currentTopRow)
         {
            this.saveCurrentTopRow(this._currentTopRow);
            BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_INVENTORY_DATA));
         }
      }
      
      public function get inventoryUnlockCost() : Number
      {
         return this._inventoryUnlockCost;
      }
      
      public function get currentSize() : int
      {
         return (this.highestUnlockedRow + 1) * NUMBER_OF_ITEMS_PER_ROW;
      }
      
      public function isSameStackableItemInInventory(param1:ItemVO) : Boolean
      {
         var _loc2_:ItemVO = null;
         for each(_loc2_ in this.items)
         {
            if(param1.location != ItemLocation.Inventory && _loc2_ && _loc2_.id == param1.id && _loc2_.type == param1.type && _loc2_.hasComponent(StackableComponent) && param1.hasComponent(StackableComponent))
            {
               return true;
            }
         }
         return false;
      }
      
      public function getSameItemInInventory(param1:ItemVO) : ItemVO
      {
         var _loc2_:ItemVO = null;
         for each(_loc2_ in this.items)
         {
            if(_loc2_ && _loc2_.id == param1.id && _loc2_.type == param1.type)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function containsItem(param1:ItemVO) : Boolean
      {
         return this.items.indexOf(param1) != -1;
      }
   }
}
