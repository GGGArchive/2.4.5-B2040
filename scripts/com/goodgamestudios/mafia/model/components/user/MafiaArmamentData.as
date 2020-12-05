package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemSubtype;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.WeaponType;
   import com.goodgamestudios.mafia.controller.commands.equipment.ChangeArmamentCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.EquipArmamentCommand;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItemSlot;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.viewarmament.PBEquipmentViewArmamentResponse;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSellEquipBuyItemDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaSellEquipBuyItemDialogProperties;
   import com.goodgamestudios.mafia.vo.ArmamentGridVO;
   import com.goodgamestudios.mafia.vo.items.ArmamentItemVO;
   import com.goodgamestudios.mafia.vo.items.ItemEffectVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.mafia.vo.items.WeaponVO;
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemComponent;
   import com.goodgamestudios.mafia.vo.items.components.StackableComponent;
   import flash.utils.Dictionary;
   
   public class MafiaArmamentData
   {
      
      public static const MAX_WIDTH:uint = 12;
      
      public static const MAX_HEIGHT:uint = 8;
      
      private static const GRID_EXPANSIONS:Array = [[4,4],[5,4],[6,4],[6,5],[7,5],[8,5],[8,6],[9,6],[10,6],[10,7],[11,7],[12,7],[12,8]];
       
      
      private var grid:ArmamentGridVO;
      
      private var tempEquipParams:Array;
      
      public var lastSwappedWithSlotId:int = -1;
      
      public var lastSwappedAmount:uint = 0;
      
      public function MafiaArmamentData()
      {
         super();
         this.setupVO();
      }
      
      public function parseData(param1:PBEquipmentViewArmamentResponse) : void
      {
         var _loc2_:PBItemSlot = null;
         var _loc3_:uint = 0;
         var _loc4_:ItemVO = null;
         this.setSize(param1.width,param1.height);
         this.clear();
         this.grid.isUnlockable = param1.isUnlockable;
         this.grid.unlockCost = !!param1.hasUnlockCost?int(param1.unlockCost):0;
         this.grid.nextPaidUnlockLevel = !!param1.hasNextPaidUnlockLevel?uint(param1.nextPaidUnlockLevel):uint(0);
         this.grid.nextFreeUnlockLevel = !!param1.hasNextFreeUnlockLevel?uint(param1.nextFreeUnlockLevel):uint(0);
         for each(_loc2_ in param1.itemSlots)
         {
            _loc3_ = _loc2_.slotY * MAX_WIDTH + _loc2_.slotX;
            _loc4_ = MafiaItemData.parseItem(_loc2_.item,ItemLocation.Armament,_loc3_);
            (_loc4_.getComponent(ArmamentItemComponent) as ArmamentItemComponent).isActive = _loc2_.active;
            this.addItemAt(_loc2_.slotX,_loc2_.slotY,_loc4_);
         }
      }
      
      public function startDragAfterSwap(param1:uint, param2:uint = 0) : void
      {
         this.lastSwappedWithSlotId = param1;
         this.lastSwappedAmount = param2;
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.ITEM_SWAPPED));
      }
      
      private function setupVO() : void
      {
         this.grid = new ArmamentGridVO();
         this.grid.gridMap = new Vector.<Vector.<ItemVO>>();
      }
      
      private function setSize(param1:uint, param2:uint) : void
      {
         this.grid.width = param1;
         this.grid.height = param2;
      }
      
      private function clear() : void
      {
         this.grid.gridMap = new Vector.<Vector.<ItemVO>>(this.width);
         var _loc1_:uint = 0;
         while(_loc1_ < this.width)
         {
            this.grid.gridMap[_loc1_] = new Vector.<ItemVO>(this.height);
            _loc1_++;
         }
      }
      
      public function containsItem(param1:ItemVO) : Boolean
      {
         return this.getItems().indexOf(param1) != -1;
      }
      
      public function canItemBeDroppedAt(param1:int, param2:int, param3:ItemVO) : Boolean
      {
         var _loc6_:int = 0;
         var _loc4_:ArmamentItemComponent = param3.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         if(!this.isItemWithinBounds(param1,param2,_loc4_.widthInGrid,_loc4_.heightInGrid))
         {
            return false;
         }
         var _loc5_:int = param1;
         while(_loc5_ < param1 + _loc4_.widthInGrid)
         {
            _loc6_ = param2;
            while(_loc6_ < param2 + _loc4_.heightInGrid)
            {
               if(this.isItemAt(_loc5_,_loc6_) && this.getItemAt(_loc5_,_loc6_) != param3)
               {
                  return false;
               }
               _loc6_++;
            }
            _loc5_++;
         }
         return true;
      }
      
      public function canItemBeSwappedAt(param1:int, param2:int, param3:ItemVO) : Boolean
      {
         var _loc7_:int = 0;
         var _loc4_:ArmamentItemComponent = param3.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         if(MafiaModel.userData.inventory.isInventoryFull)
         {
            return false;
         }
         if(!this.isItemWithinBounds(param1,param2,_loc4_.widthInGrid,_loc4_.heightInGrid))
         {
            return false;
         }
         var _loc5_:ItemVO = null;
         var _loc6_:int = param1;
         while(_loc6_ < param1 + _loc4_.widthInGrid)
         {
            _loc7_ = param2;
            while(_loc7_ < param2 + _loc4_.heightInGrid)
            {
               if(this.isItemAt(_loc6_,_loc7_) && this.getItemAt(_loc6_,_loc7_) != param3)
               {
                  if(_loc5_ == null)
                  {
                     _loc5_ = this.getItemAt(_loc6_,_loc7_);
                  }
                  else if(_loc5_ != this.getItemAt(_loc6_,_loc7_))
                  {
                     return false;
                  }
               }
               _loc7_++;
            }
            _loc6_++;
         }
         return true;
      }
      
      public function canItemBeMerged(param1:ItemVO) : Boolean
      {
         return this.getItemToMergeWith(param1) != null;
      }
      
      public function getItemToMergeWith(param1:ItemVO) : ItemVO
      {
         var _loc3_:ItemVO = null;
         var _loc2_:Vector.<ItemVO> = this.getItems();
         for each(_loc3_ in _loc2_)
         {
            if(this.canItemsBeMerged(param1,_loc3_))
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function canItemsBeMerged(param1:ItemVO, param2:ItemVO) : Boolean
      {
         if(param1 == null || param2 == null || param1 == param2)
         {
            return false;
         }
         if(!param1.hasComponent(StackableComponent) || !param2.hasComponent(StackableComponent))
         {
            return false;
         }
         return param1.type == param2.type && param1.subtype == param2.subtype && param1.id == param2.id && param1.quality == param2.quality;
      }
      
      public function dropItemAt(param1:int, param2:int, param3:ItemVO, param4:uint = 0) : void
      {
         var _loc5_:ArmamentItemComponent = param3.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         if(this.isItemWithinBounds(param1,param2,_loc5_.widthInGrid,_loc5_.heightInGrid))
         {
            switch(param3.location)
            {
               case ItemLocation.Inventory:
                  if(MafiaItemData.shouldUserBeAskedForAmount(param3))
                  {
                     if(param4 == 0)
                     {
                        this.tempEquipParams = [param1,param2];
                        MafiaLayoutManager.getInstance().showDialog(MafiaSellEquipBuyItemDialog.NAME,new MafiaSellEquipBuyItemDialogProperties(param3,MafiaSellEquipBuyItemDialogProperties.MODE_EQUIP,this.equipAfterAmountDialog));
                     }
                     else
                     {
                        MafiaModel.userData.lockAllItems();
                        EquipArmamentCommand.sendCommand(param3.slotId,param4,param1,param2);
                     }
                  }
                  else
                  {
                     MafiaModel.userData.lockAllItems();
                     EquipArmamentCommand.sendCommand(param3.slotId,1,param1,param2);
                  }
                  break;
               case ItemLocation.Armament:
                  MafiaModel.userData.lockAllItems();
                  ChangeArmamentCommand.sendCommand(_loc5_.xInGrid,_loc5_.yInGrid,param1,param2);
                  break;
               default:
                  trace("cant drop item into armament except from inventory or armament!");
            }
         }
      }
      
      public function equipAfterAmountDialog(param1:ItemVO) : void
      {
         if(this.tempEquipParams != null)
         {
            MafiaModel.userData.lockAllItems();
            EquipArmamentCommand.sendCommand(param1.slotId,param1.amount,this.tempEquipParams[0],this.tempEquipParams[1]);
            this.tempEquipParams = null;
         }
      }
      
      public function mergeItem(param1:ItemVO) : void
      {
         var _loc2_:ArmamentItemComponent = param1.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         var _loc3_:ItemVO = this.getItemToMergeWith(param1);
         var _loc4_:ArmamentItemComponent = _loc3_.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         switch(param1.location)
         {
            case ItemLocation.Inventory:
               if(MafiaItemData.shouldUserBeAskedForAmount(param1))
               {
                  this.tempEquipParams = [_loc4_.xInGrid,_loc4_.yInGrid];
                  MafiaLayoutManager.getInstance().showDialog(MafiaSellEquipBuyItemDialog.NAME,new MafiaSellEquipBuyItemDialogProperties(param1,MafiaSellEquipBuyItemDialogProperties.MODE_EQUIP,this.equipAfterAmountDialog));
               }
               else
               {
                  MafiaModel.userData.lockAllItems();
                  EquipArmamentCommand.sendCommand(param1.slotId,1,_loc4_.xInGrid,_loc4_.yInGrid);
               }
               break;
            default:
               trace("cant merge item into armament except from inventory!");
         }
      }
      
      public function swapItemAt(param1:int, param2:int, param3:ItemVO, param4:uint = 0) : void
      {
         var _loc6_:ItemVO = null;
         var _loc7_:ArmamentItemComponent = null;
         var _loc5_:ArmamentItemComponent = param3.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         if(!MafiaModel.userData.inventory.isInventoryFull && this.isItemWithinBounds(param1,param2,_loc5_.widthInGrid,_loc5_.heightInGrid))
         {
            _loc6_ = this.getOccupyingItems(param1,param2,param3)[0];
            _loc7_ = _loc6_.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
            switch(param3.location)
            {
               case ItemLocation.Inventory:
                  if(MafiaItemData.shouldUserBeAskedForAmount(param3))
                  {
                     if(param4 == 0)
                     {
                        this.tempEquipParams = [param1,param2];
                        MafiaLayoutManager.getInstance().showDialog(MafiaSellEquipBuyItemDialog.NAME,new MafiaSellEquipBuyItemDialogProperties(param3,MafiaSellEquipBuyItemDialogProperties.MODE_EQUIP,this.equipAfterAmountDialog));
                     }
                     else
                     {
                        MafiaModel.userData.lockAllItems();
                        EquipArmamentCommand.sendCommand(param3.slotId,param4,param1,param2);
                     }
                  }
                  else
                  {
                     MafiaModel.userData.lockAllItems();
                     EquipArmamentCommand.sendCommand(param3.slotId,1,param1,param2);
                  }
                  break;
               case ItemLocation.Armament:
                  ChangeArmamentCommand.sendCommand(_loc5_.xInGrid,_loc5_.yInGrid,param1,param2);
                  break;
               default:
                  trace("cant drop item into armament except frop inventory or armament!");
            }
         }
      }
      
      public function getItems() : Vector.<ItemVO>
      {
         var _loc3_:int = 0;
         var _loc4_:ItemVO = null;
         var _loc1_:Vector.<ItemVO> = new Vector.<ItemVO>();
         var _loc2_:int = 0;
         while(_loc2_ < this.width)
         {
            _loc3_ = 0;
            while(_loc3_ < this.height)
            {
               _loc4_ = this.getItemAt(_loc2_,_loc3_);
               if(_loc4_ != null && _loc1_.indexOf(_loc4_) == -1)
               {
                  _loc1_.push(_loc4_);
               }
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getItemsByType(param1:ItemType) : Vector.<ArmamentItemVO>
      {
         var _loc3_:ArmamentItemVO = null;
         var _loc2_:Vector.<ArmamentItemVO> = new Vector.<ArmamentItemVO>();
         for each(_loc3_ in this.getItems())
         {
            if(_loc3_.type == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getActiveItemsByType(param1:ItemType) : Vector.<ArmamentItemVO>
      {
         var _loc3_:ArmamentItemVO = null;
         var _loc2_:Vector.<ArmamentItemVO> = new Vector.<ArmamentItemVO>();
         for each(_loc3_ in this.getItemsByType(param1))
         {
            if(_loc3_.armamentComponent.isActive)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function isWeaponTypeActive(param1:ItemType, param2:WeaponType) : Boolean
      {
         var _loc3_:WeaponVO = null;
         for each(_loc3_ in this.getActiveItemsByType(param1))
         {
            if(_loc3_.subtype == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getActiveItemsByTypeAndSubtype(param1:ItemType, param2:ItemSubtype) : Vector.<ArmamentItemVO>
      {
         var _loc4_:ArmamentItemVO = null;
         var _loc3_:Vector.<ArmamentItemVO> = new Vector.<ArmamentItemVO>();
         for each(_loc4_ in this.getActiveItemsByType(param1))
         {
            if(_loc4_.subtype == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function isAtLeastOneWeaponActive() : Boolean
      {
         var _loc1_:ArmamentItemVO = null;
         for each(_loc1_ in this.getAllActiveItems())
         {
            if(_loc1_.type == ItemType.Weapon)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getAllActiveItems() : Vector.<ArmamentItemVO>
      {
         var _loc2_:ArmamentItemVO = null;
         var _loc1_:Vector.<ArmamentItemVO> = new Vector.<ArmamentItemVO>();
         for each(_loc2_ in this.getItems())
         {
            if(_loc2_.armamentComponent.isActive)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getAllActiveEffects() : Dictionary
      {
         var _loc2_:ArmamentItemVO = null;
         var _loc3_:ItemEffectVO = null;
         var _loc1_:Dictionary = new Dictionary();
         for each(_loc2_ in this.getAllActiveItems())
         {
            for each(_loc3_ in _loc2_.effectComponent.effects)
            {
               _loc1_[_loc3_.id] = [_loc3_.firstValue,_loc3_.secondValue];
            }
         }
         return _loc1_;
      }
      
      public function getItemEffectsToCompare(param1:ItemVO) : Dictionary
      {
         var _loc3_:ArmamentItemVO = null;
         var _loc4_:ItemEffectVO = null;
         var _loc2_:Dictionary = new Dictionary();
         for each(_loc3_ in this.getActiveItemsByType(param1.type))
         {
            if(_loc3_.id == param1.id)
            {
               for each(_loc4_ in _loc3_.effectComponent.effects)
               {
                  _loc2_[_loc4_.id] = [_loc4_.firstValue,_loc4_.secondValue];
               }
            }
         }
         return _loc2_;
      }
      
      public function getAllActiveEffectsByTypeAndSubtype(param1:ItemType, param2:ItemSubtype) : Dictionary
      {
         var _loc4_:ArmamentItemVO = null;
         var _loc5_:ItemEffectVO = null;
         var _loc3_:Dictionary = new Dictionary();
         for each(_loc4_ in this.getActiveItemsByTypeAndSubtype(param1,param2))
         {
            for each(_loc5_ in _loc4_.effectComponent.effects)
            {
               _loc3_[_loc5_.id] = [_loc5_.firstValue,_loc5_.secondValue];
            }
         }
         return _loc3_;
      }
      
      private function addItemAt(param1:uint, param2:uint, param3:ItemVO) : void
      {
         var _loc6_:uint = 0;
         if(!this.canItemBeDroppedAt(param1,param2,param3))
         {
            trace("item can\'t be added to armament at " + param1 + ":" + param2);
            return;
         }
         var _loc4_:ArmamentItemComponent = param3.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         trace("adding item to armament at " + param1 + ":" + param2);
         _loc4_.xInGrid = param1;
         _loc4_.yInGrid = param2;
         var _loc5_:uint = param1;
         while(_loc5_ < param1 + _loc4_.widthInGrid)
         {
            _loc6_ = param2;
            while(_loc6_ < param2 + _loc4_.heightInGrid)
            {
               this.grid.gridMap[_loc5_][_loc6_] = param3;
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      public function getItemAt(param1:uint, param2:uint) : ItemVO
      {
         var _loc3_:ItemVO = null;
         if(param1 < this.grid.gridMap.length && param2 < this.grid.gridMap[param1].length)
         {
            _loc3_ = this.grid.gridMap[param1][param2];
         }
         return _loc3_;
      }
      
      public function getItemWithAnchorAt(param1:uint, param2:uint) : ItemVO
      {
         var _loc4_:ArmamentItemComponent = null;
         var _loc3_:ItemVO = this.getItemAt(param1,param2);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
            if(_loc4_.xInGrid == param1 && _loc4_.yInGrid == param2)
            {
               return _loc3_;
            }
            return null;
         }
         return null;
      }
      
      public function isItemWithinBounds(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         return param1 >= 0 && param2 >= 0 && param1 + param3 <= this.width && param2 + param4 <= this.height;
      }
      
      public function isItemAt(param1:uint, param2:uint) : Boolean
      {
         return this.getItemAt(param1,param2) != null;
      }
      
      public function isUnlockable() : Boolean
      {
         return this.grid.isUnlockable;
      }
      
      public function getUnlockCost() : int
      {
         return this.grid.unlockCost;
      }
      
      public function isCellUnlocked(param1:uint, param2:uint) : Boolean
      {
         return param1 < this.width && param2 < this.height;
      }
      
      public function isCellUnlockable(param1:uint, param2:uint) : Boolean
      {
         var _loc3_:uint = this.getUnlockStep() + 1;
         if(_loc3_ >= GRID_EXPANSIONS.length)
         {
            return false;
         }
         var _loc4_:Array = GRID_EXPANSIONS[_loc3_];
         return !this.isCellUnlocked(param1,param2) && param1 < _loc4_[0] && param2 < _loc4_[1];
      }
      
      public function getUnlockStep() : uint
      {
         var _loc2_:Array = null;
         var _loc1_:int = 0;
         while(_loc1_ < GRID_EXPANSIONS.length)
         {
            _loc2_ = GRID_EXPANSIONS[_loc1_];
            if(this.grid.width == _loc2_[0] && this.grid.height == _loc2_[1])
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 0;
      }
      
      public function isFullyUnlocked() : Boolean
      {
         return this.getUnlockStep() == GRID_EXPANSIONS.length - 1;
      }
      
      public function get nextPaidUnlockLevel() : uint
      {
         return this.grid.nextPaidUnlockLevel;
      }
      
      public function get nextFreeUnlockLevel() : uint
      {
         return this.grid.nextFreeUnlockLevel;
      }
      
      public function getUnlockableCells() : Array
      {
         var _loc5_:uint = 0;
         var _loc1_:Array = [];
         var _loc2_:uint = this.getUnlockStep() + 1;
         if(_loc2_ >= GRID_EXPANSIONS.length)
         {
            return null;
         }
         var _loc3_:Array = GRID_EXPANSIONS[_loc2_];
         var _loc4_:uint = 0;
         while(_loc4_ < MAX_WIDTH)
         {
            _loc5_ = 0;
            while(_loc5_ < MAX_HEIGHT)
            {
               if(_loc4_ < _loc3_[0] && _loc5_ < _loc3_[1] && (_loc4_ >= this.width || _loc5_ >= this.height))
               {
                  _loc1_.push([_loc4_,_loc5_]);
               }
               _loc5_++;
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function containsWeaponType(param1:WeaponType) : Boolean
      {
         return false;
      }
      
      public function get width() : uint
      {
         return this.grid.width;
      }
      
      public function get height() : uint
      {
         return this.grid.height;
      }
      
      public function getOccupyingItems(param1:int, param2:int, param3:ItemVO) : Vector.<ItemVO>
      {
         var _loc7_:int = 0;
         var _loc4_:Vector.<ItemVO> = new Vector.<ItemVO>();
         var _loc5_:ArmamentItemComponent = param3.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         if(!this.isItemWithinBounds(param1,param2,_loc5_.widthInGrid,_loc5_.heightInGrid))
         {
            return _loc4_;
         }
         var _loc6_:int = param1;
         while(_loc6_ < param1 + _loc5_.widthInGrid)
         {
            _loc7_ = param2;
            while(_loc7_ < param2 + _loc5_.heightInGrid)
            {
               if(this.isItemAt(_loc6_,_loc7_) && this.getItemAt(_loc6_,_loc7_) != param3 && _loc4_.indexOf(this.getItemAt(_loc6_,_loc7_)) == -1)
               {
                  _loc4_.push(this.getItemAt(_loc6_,_loc7_));
               }
               _loc7_++;
            }
            _loc6_++;
         }
         return _loc4_;
      }
   }
}
