package com.goodgamestudios.mafia.view.screens.inventory
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.FlashUIComponent;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_ItemContainer;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.ExtraType;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemQuality;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.equipment.ChangeInventoryCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.OpenContainerCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.UnequipArmamentCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.UnequipGearCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.ViewInventoryCommand;
   import com.goodgamestudios.mafia.controller.commands.item.UnlockInventoryCommand;
   import com.goodgamestudios.mafia.controller.commands.shop.BuyItemCommand;
   import com.goodgamestudios.mafia.event.model.MafiaOpenItemContainerEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.MafiaInventoryData;
   import com.goodgamestudios.mafia.model.components.user.MafiaShopData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaBreakingTheLawDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoCashDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.dialogs.luckyDevil.MafiaLuckyDevilDialog;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.vo.items.ArmamentItemVO;
   import com.goodgamestudios.mafia.vo.items.FoodVO;
   import com.goodgamestudios.mafia.vo.items.ItemDragVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemComponent;
   import com.gskinner.motion.GTween;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   
   public class MafiaInventoryComponent extends FlashUIComponent
   {
       
      
      private const INVENTORY_POS_Y:int = 462;
      
      private const INVENTORY_TWEEN_STEPS:Array = [this.INVENTORY_POS_Y,423,370,316,262,208,140];
      
      private const TUTORIAL_FLASHBANG_SLOT_ID:int = 0;
      
      private var inventoryRows:Vector.<MafiaInventoryRow>;
      
      private var rowHolderStartY:Number;
      
      private const rowOffsetY:Number = 53.25;
      
      private var numVisibleRows:uint;
      
      private var _currentTopRow:uint;
      
      private var saveCurrentRow:Boolean;
      
      public function MafiaInventoryComponent(param1:DisplayObject, param2:uint, param3:Boolean = false)
      {
         super(param1);
         this.numVisibleRows = param2;
         this.inventory.txt_title.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_inventory");
         updateAllTextFields();
         this.inventory.txt_amount.x = this.inventory.txt_title.x + this.inventory.txt_title.textWidth + 5;
         this.rowHolderStartY = this.inventory.rowHolder.y;
         var _loc4_:Number = this.rowOffsetY * param2 + (this.rowHolderStartY - this.inventory.rowMask.y) / 2;
         this.inventory.rowMask.height = _loc4_;
         this.inventory.btn_down.y = this.inventory.rowMask.y + this.rowOffsetY * param2 - this.inventory.btn_down.height / 2;
      }
      
      override public function show() : void
      {
         var _loc2_:MafiaInventoryRow = null;
         super.show();
         this.clearRows();
         this.createRows();
         this.inventory.rowHolder.y = this.getRowHolderTargetScrollPos(this.currentTopRow);
         var _loc1_:int = 0;
         while(_loc1_ < this.numVisibleRows)
         {
            _loc2_ = this.inventoryRows[_loc1_];
            _loc2_.gotoAndStop(2);
            _loc2_.btn_unlock.visible = false;
            _loc1_++;
         }
         if(this.data.items.length > 0)
         {
            this.fillItemsInInventory(this.data);
         }
         this.controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_INVENTORY_DATA,this.onChangeUserInventoryData);
         this.controller.addEventListener(MafiaUserEvent.ITEMS_LOCKED,this.onItemsLocked);
         this.controller.addEventListener(MafiaUserEvent.ITEMS_UNLOCKED,this.onItemsUnlocked);
         this.controller.addEventListener(MafiaUserEvent.ITEM_SWAPPED,this.onItemSwapped);
         this.controller.addEventListener(MafiaOpenItemContainerEvent.CONTAINER_OPENED,this.onContainerOpened);
      }
      
      override public function hide() : void
      {
         super.hide();
         this.clearRows();
         this.controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_INVENTORY_DATA,this.onChangeUserInventoryData);
         this.controller.removeEventListener(MafiaUserEvent.ITEMS_LOCKED,this.onItemsLocked);
         this.controller.removeEventListener(MafiaUserEvent.ITEMS_UNLOCKED,this.onItemsUnlocked);
         this.controller.removeEventListener(MafiaUserEvent.ITEM_SWAPPED,this.onItemSwapped);
         this.controller.removeEventListener(MafiaOpenItemContainerEvent.CONTAINER_OPENED,this.onContainerOpened);
      }
      
      private function createRows() : void
      {
         var _loc3_:MafiaInventoryRow = null;
         this.inventoryRows = new Vector.<MafiaInventoryRow>();
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < MafiaInventoryData.MAX_NUMBER_OF_ROWS)
         {
            _loc3_ = new MafiaInventoryRow();
            _loc3_.name = "row" + _loc2_;
            _loc3_.y = _loc1_;
            this.inventoryRows.push(_loc3_);
            this.inventory.rowHolder.addChild(_loc3_);
            _loc1_ = _loc1_ + this.rowOffsetY;
            _loc2_++;
         }
      }
      
      private function clearRows() : void
      {
         MovieClipHelper.clearMovieClip(this.inventory.rowHolder);
      }
      
      private function set currentTopRow(param1:int) : void
      {
         var _loc2_:int = this._currentTopRow;
         this._currentTopRow = Math.max(0,Math.min(param1,this.highestPossibleTopRow));
         if(this.saveCurrentRow)
         {
            MafiaModel.userData.inventory.currentTopRow = this._currentTopRow;
         }
         this.updateButtons();
      }
      
      private function get currentTopRow() : int
      {
         if(this.saveCurrentRow)
         {
            this._currentTopRow = MafiaModel.userData.inventory.currentTopRow;
         }
         return this._currentTopRow;
      }
      
      public function get canCurrentTopRowIncrease() : Boolean
      {
         return this._currentTopRow < this.highestPossibleTopRow;
      }
      
      public function get highestPossibleTopRow() : int
      {
         var _loc1_:int = Math.max(0,MafiaModel.userData.inventory.highestUnlockedRow - this.numVisibleRows + 1);
         if(MafiaModel.userData.inventory.highestUnlockedRow >= this.numVisibleRows - 1 && MafiaModel.userData.inventory.highestUnlockedRow < MafiaInventoryData.MAX_NUMBER_OF_ROWS - 1)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      private function fillAll() : void
      {
         this.fillItemsInInventory(this.data);
      }
      
      override public function destroy() : void
      {
         this.clearInventory();
         super.destroy();
      }
      
      private function clearInventory() : void
      {
         var _loc2_:MafiaInventoryRow = null;
         var _loc3_:uint = 0;
         var _loc4_:Inventory = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.numVisibleRows)
         {
            _loc2_ = this.inventoryRows[_loc1_] as MafiaInventoryRow;
            if(_loc2_.currentFrame == 1)
            {
               _loc3_ = 0;
               while(_loc3_ < MafiaInventoryData.NUMBER_OF_ITEMS_PER_ROW)
               {
                  _loc4_ = _loc2_["slot" + _loc3_] as Inventory;
                  MovieClipHelper.clearMovieClip(_loc4_.item);
                  _loc4_.toolTipVO = null;
                  _loc3_++;
               }
            }
            _loc1_++;
         }
      }
      
      public function showItemLockAnimation() : void
      {
         var _loc2_:MafiaInventoryRow = null;
         var _loc3_:uint = 0;
         var _loc4_:Inventory = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Btn_OpenContainer = null;
         var _loc1_:uint = 0;
         while(_loc1_ < MafiaInventoryData.MAX_NUMBER_OF_ROWS)
         {
            _loc2_ = this.inventoryRows[_loc1_] as MafiaInventoryRow;
            if(_loc2_.currentFrame == 1)
            {
               _loc3_ = 0;
               while(_loc3_ < MafiaInventoryData.NUMBER_OF_ITEMS_PER_ROW)
               {
                  _loc4_ = _loc2_["slot" + _loc3_] as Inventory;
                  _loc5_ = new ServerWaitingAnim();
                  _loc5_.scaleX = _loc5_.scaleY = 0.9;
                  _loc5_.name = "lockAnim";
                  _loc4_.addChild(_loc5_);
                  _loc6_ = _loc2_["btn_open" + _loc3_] as Btn_OpenContainer;
                  _loc6_.enableButton = false;
                  _loc3_++;
               }
            }
            _loc1_++;
         }
      }
      
      public function hideItemLockAnimation() : void
      {
         var _loc2_:MafiaInventoryRow = null;
         var _loc3_:uint = 0;
         var _loc4_:Inventory = null;
         var _loc5_:ServerWaitingAnim = null;
         var _loc6_:Btn_OpenContainer = null;
         var _loc1_:uint = 0;
         while(_loc1_ < MafiaInventoryData.MAX_NUMBER_OF_ROWS)
         {
            _loc2_ = this.inventoryRows[_loc1_] as MafiaInventoryRow;
            if(_loc2_.currentFrame == 1)
            {
               _loc3_ = 0;
               while(_loc3_ < MafiaInventoryData.NUMBER_OF_ITEMS_PER_ROW)
               {
                  _loc4_ = _loc2_["slot" + _loc3_] as Inventory;
                  _loc5_ = _loc4_.getChildByName("lockAnim") as ServerWaitingAnim;
                  if(_loc5_)
                  {
                     _loc4_.removeChild(_loc5_);
                  }
                  _loc6_ = _loc2_["btn_open" + _loc3_] as Btn_OpenContainer;
                  _loc6_.enableButton = true;
                  _loc3_++;
               }
            }
            _loc1_++;
         }
      }
      
      private function onChangeUserInventoryData(param1:MafiaUserEvent) : void
      {
         this.fillItemsInInventory(this.data);
         this.updateInventoryMouseover();
      }
      
      private function updateInventoryMouseover() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:Shape = null;
         var _loc6_:MafiaInventoryRow = null;
         var _loc7_:uint = 0;
         var _loc8_:Inventory = null;
         if(disp.stage)
         {
            if(this.layoutManager.isDialogVisible(MafiaStandardOkDialog) || this.layoutManager.isDialogVisible(MafiaLuckyDevilDialog) || this.layoutManager.isDialogVisible(MafiaBreakingTheLawDialog))
            {
               return;
            }
            _loc1_ = disp.stage.getObjectsUnderPoint(new Point(disp.stage.mouseX,disp.stage.mouseY));
            _loc2_ = new Array();
            for each(_loc3_ in _loc1_)
            {
               _loc5_ = _loc3_ as Shape;
               if(_loc5_ != null)
               {
                  _loc2_.push(_loc5_.parent);
               }
            }
            _loc4_ = 0;
            while(_loc4_ < MafiaInventoryData.MAX_NUMBER_OF_ROWS)
            {
               _loc6_ = this.inventoryRows[_loc4_];
               _loc7_ = 0;
               while(_loc7_ < MafiaInventoryData.NUMBER_OF_ITEMS_PER_ROW)
               {
                  _loc8_ = _loc6_["slot" + _loc7_] as Inventory;
                  if(_loc8_ != null && _loc8_.hitbox != null && _loc2_.indexOf(_loc8_.hitbox) != -1)
                  {
                     _loc8_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
                  }
                  _loc7_++;
               }
               _loc4_++;
            }
         }
      }
      
      private function fillItemsInInventory(param1:MafiaInventoryData) : void
      {
         var _loc4_:Vector.<ItemVO> = null;
         var _loc5_:MafiaInventoryRow = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Inventory = null;
         var _loc9_:Btn_OpenContainer = null;
         var _loc2_:Vector.<ItemVO> = param1.items;
         this.inventory.txt_amount.text = param1.itemCount + "/" + param1.currentSize;
         var _loc3_:uint = 0;
         while(_loc3_ < MafiaInventoryData.MAX_NUMBER_OF_ROWS)
         {
            _loc4_ = param1.getItemsInRow(_loc3_);
            _loc5_ = this.inventoryRows[_loc3_];
            if(_loc3_ <= param1.highestUnlockedRow)
            {
               _loc5_.gotoAndStop(1);
               _loc6_ = 0;
               while(_loc6_ < MafiaInventoryData.NUMBER_OF_ITEMS_PER_ROW)
               {
                  _loc7_ = _loc6_ + _loc3_ * MafiaInventoryData.NUMBER_OF_ITEMS_PER_ROW;
                  _loc8_ = _loc5_["slot" + _loc6_] as Inventory;
                  _loc8_.slotId = _loc7_;
                  MovieClipHelper.clearMovieClip(_loc8_.item);
                  _loc8_.toolTipVO = null;
                  _loc8_.amount.visible = false;
                  if(_loc4_ != null)
                  {
                     this.insertItemGraphic(_loc8_,_loc4_[_loc6_]);
                  }
                  _loc9_ = _loc5_["btn_open" + _loc6_] as Btn_OpenContainer;
                  _loc9_.visible = _loc4_ != null && _loc4_[_loc6_] != null && _loc4_[_loc6_].type == ItemType.Extra && _loc4_[_loc6_].subtype == ExtraType.Container;
                  _loc9_.toolTipText = MafiaModel.languageData.getTextById("MafiaShopScreen_copy_3");
                  _loc6_++;
               }
            }
            else
            {
               _loc5_.gotoAndStop(2);
               _loc5_.btn_unlock.visible = _loc3_ == param1.highestUnlockedRow + 1;
               _loc5_.btn_unlock.goldInfoVisible = true;
               _loc5_.btn_unlock.goldInfoTimeText = param1.inventoryUnlockCost.toString();
               _loc5_.btn_unlock.update();
            }
            _loc3_++;
         }
         this.updateButtons();
      }
      
      public function updateButtons() : void
      {
         this.inventory.btn_up.enableButton = this.currentTopRow > 0;
         this.inventory.btn_down.enableButton = this.canCurrentTopRowIncrease;
      }
      
      public function getItemByIndex(param1:uint) : MovieClip
      {
         var _loc6_:MovieClip = null;
         var _loc2_:int = Math.floor(param1 / MafiaInventoryData.NUMBER_OF_ITEMS_PER_ROW);
         var _loc3_:int = param1 % MafiaInventoryData.NUMBER_OF_ITEMS_PER_ROW;
         var _loc4_:MafiaInventoryRow = this.inventoryRows[_loc2_];
         var _loc5_:Inventory = _loc4_["slot" + _loc3_] as Inventory;
         if(_loc5_.item != null && _loc5_.slotId == param1)
         {
            if(_loc5_.item.numChildren > 0)
            {
               _loc6_ = _loc5_.item.getChildAt(0) as MovieClip;
               return _loc6_;
            }
         }
         return null;
      }
      
      public function getInventorySlotBySlotId(param1:uint) : Inventory
      {
         var _loc2_:int = Math.floor(param1 / MafiaInventoryData.NUMBER_OF_ITEMS_PER_ROW);
         var _loc3_:int = param1 % MafiaInventoryData.NUMBER_OF_ITEMS_PER_ROW;
         var _loc4_:MafiaInventoryRow = this.inventoryRows[_loc2_];
         var _loc5_:Inventory = _loc4_["slot" + _loc3_] as Inventory;
         return _loc5_;
      }
      
      private function insertItemGraphic(param1:Inventory, param2:ItemVO) : void
      {
         if(param2 != null)
         {
            this.generateInventoryItemGraphic(param1,param2);
         }
         else
         {
            this.generateInventoryPlaceholderGraphic(param1);
         }
      }
      
      private function generateInventoryPlaceholderGraphic(param1:Inventory) : void
      {
         var _loc2_:String = MafiaItemData.getInstance().generateItemPicClassname(ItemType.None,0,0,ItemQuality.None.index);
         var _loc3_:Class = getDefinitionByName(_loc2_) as Class;
         var _loc4_:Sprite = new _loc3_();
         _loc4_.mouseEnabled = false;
         _loc4_.mouseChildren = false;
         param1.item.addChildAt(_loc4_,0);
         param1.mouseChildren = false;
         param1.useHandCursor = false;
         param1.buttonMode = false;
      }
      
      private function generateInventoryItemGraphic(param1:Inventory, param2:ItemVO) : void
      {
         var _loc7_:MovieClip = null;
         var _loc3_:MovieClip = MafiaItemData.getInstance().generateItemIcon(param2);
         var _loc4_:int = -29;
         var _loc5_:int = -20;
         if(param2.hasComponent(ArmamentItemComponent))
         {
            _loc7_ = MafiaItemData.getInstance().generateItemGridSizeIcon(param2);
            _loc7_.x = _loc4_;
            _loc7_.y = _loc5_;
            _loc3_.addChild(_loc7_);
         }
         var _loc6_:MovieClip = _loc3_.getChildByName("itemPic") as MovieClip;
         _loc6_.scaleX = _loc6_.scaleY = Constants_ViewScales.SCALE_INVENTORY_ITEMS;
         MovieClipHelper.scaleDownToFit(_loc6_,param1.hitbox.width,param1.hitbox.height);
         param1.item.addChildAt(_loc3_,0);
         param1.mouseChildren = false;
         switch(param2.type)
         {
            case ItemType.Consumable:
               param1.amount.visible = true;
               param1.amount.txt_amount.text = (param2 as ArmamentItemVO).amount.toString();
               break;
            case ItemType.Food:
               param1.amount.visible = true;
               param1.amount.txt_amount.text = (param2 as FoodVO).amount.toString();
         }
         param1.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(_loc3_.properties,TooltipDispPosition.Over,null,BasicCustomCursor.CURSOR_HAND);
      }
      
      public function scrollToItem(param1:uint) : void
      {
         var _loc2_:uint = Math.floor(param1 / MafiaInventoryData.NUMBER_OF_ITEMS_PER_ROW);
         this.scrollToRow(_loc2_);
      }
      
      public function scrollToRow(param1:uint) : void
      {
         if(param1 < this.currentTopRow)
         {
            this.currentTopRow = param1;
            this.scrollInventory(this.currentTopRow);
         }
         else if(param1 >= this.currentTopRow + this.numVisibleRows)
         {
            this.currentTopRow = param1 - this.numVisibleRows + 1;
            this.scrollInventory(this.currentTopRow);
         }
      }
      
      private function scrollInventory(param1:uint) : void
      {
         var _loc2_:Number = this.getRowHolderTargetScrollPos(param1);
         var _loc3_:GTween = new GTween(this.inventory.rowHolder,0.3,{"y":_loc2_});
      }
      
      private function getRowHolderTargetScrollPos(param1:uint) : Number
      {
         return this.rowHolderStartY - param1 * this.rowOffsetY;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Btn_OpenContainer = null;
         var _loc3_:uint = 0;
         var _loc4_:Inventory = null;
         var _loc5_:uint = 0;
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         switch(param1.target)
         {
            case this.inventory.btn_up:
               if(this.inventory.btn_up.enabled)
               {
                  this.inventory.rowHolder.y = this.getRowHolderTargetScrollPos(this.currentTopRow);
                  this.currentTopRow--;
                  this.scrollInventory(this.currentTopRow);
               }
               break;
            case this.inventory.btn_down:
               if(this.inventory.btn_down.enabled)
               {
                  this.inventory.rowHolder.y = this.getRowHolderTargetScrollPos(this.currentTopRow);
                  this.currentTopRow++;
                  this.scrollInventory(this.currentTopRow);
               }
         }
         if(param1.target is Btn_UnlockArmament)
         {
            UnlockInventoryCommand.sendCommand();
         }
         if(param1.target is Btn_OpenContainer && param1.target.enabled)
         {
            _loc2_ = param1.target as Btn_OpenContainer;
            _loc3_ = uint(_loc2_.name.charAt(_loc2_.name.length - 1));
            _loc4_ = _loc2_.parent.getChildByName("slot" + _loc3_) as Inventory;
            _loc5_ = _loc4_.slotId;
            MafiaModel.userData.lockAllItems();
            OpenContainerCommand.sendCommand(_loc5_);
         }
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         if(this.layoutManager.dragManager.isDragging)
         {
            this.endDrag(param1.target);
         }
         else
         {
            if(param1.target is MovieClip)
            {
               _loc3_ = param1.target as MovieClip;
               _loc4_ = null;
               if(_loc3_.numChildren > 1)
               {
                  _loc4_ = _loc3_.getChildAt(1) as MovieClip;
               }
               if(_loc4_ == null)
               {
                  return;
               }
            }
            if(param1.target is Inventory)
            {
               if(MafiaTutorialController.getInstance().isActive)
               {
                  switch(MafiaTutorialController.getInstance().tutorialState)
                  {
                     case MafiaTutorialController.TUT_STATE_SELECT_WEAPON:
                     case MafiaTutorialController.TUT_STATE_INVENTORY_SELECT_DYNAMITE:
                        MafiaTutorialController.getInstance().nextStep();
                     default:
                        return;
                  }
               }
               _loc3_ = param1.target as Inventory;
               if(MafiaModel.userData.allItemsLocked)
               {
                  return;
               }
               if(_loc3_.item.numChildren > 0)
               {
                  _loc2_ = _loc3_.item.getChildAt(0) as MovieClip;
               }
               this.startDrag(_loc2_);
            }
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         super.onMouseDown(param1);
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         if(this.layoutManager.dragManager.isDragging)
         {
            this.endDrag(param1.target);
         }
      }
      
      private function startDrag(param1:MovieClip, param2:uint = 0) : void
      {
         var _loc3_:ItemDragVO = null;
         if(!this.layoutManager.dragManager.isDragging)
         {
            if(param1 && param1.properties is ItemVO)
            {
               _loc3_ = new ItemDragVO();
               _loc3_.dragSourceMC = param1;
               _loc3_.itemVO = param1.properties;
               _loc3_.sourceItemPic = param1.getChildByName("itemPic") as MovieClip;
               _loc3_.dragAmount = param2;
               this.layoutManager.dragManager.startDragging(_loc3_);
               this.layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_DRAG);
            }
         }
      }
      
      private function endDrag(param1:Object) : void
      {
         var _loc2_:Array = null;
         var _loc3_:MovieClip = null;
         var _loc4_:ItemVO = null;
         var _loc5_:ItemVO = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:ArmamentItemComponent = null;
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_DRAG_WEAPON:
               case MafiaTutorialController.TUT_STATE_INVENTORY_DRAG_DYNAMITE:
                  return;
            }
         }
         if(this.layoutManager.dragManager.dragVO is ItemDragVO)
         {
            _loc3_ = param1 as MovieClip;
            _loc4_ = this.layoutManager.dragManager.dragVO.dragSourceMC.properties as ItemVO;
            if(MafiaModel.userData.allItemsLocked)
            {
               return;
            }
            if(!_loc3_)
            {
               return;
            }
            if(_loc3_ is Inventory)
            {
               _loc6_ = _loc3_.slotId;
               if(_loc4_.location == ItemLocation.Inventory && _loc6_ == _loc4_.slotId)
               {
                  return;
               }
               if(MafiaItemData.isShopLocation(_loc4_.location))
               {
                  if(MafiaTutorialController.getInstance().isActive)
                  {
                     switch(MafiaTutorialController.getInstance().tutorialState)
                     {
                        case MafiaTutorialController.TUT_STATE_DRAG_DYNAMITE:
                           if(_loc6_ != this.TUTORIAL_FLASHBANG_SLOT_ID)
                           {
                              return;
                           }
                           break;
                     }
                  }
                  _loc8_ = this.tryToBuyItem(_loc4_,_loc6_);
                  if(!_loc8_)
                  {
                     return;
                  }
               }
               else if(_loc4_.location == ItemLocation.Gear)
               {
                  MafiaModel.userData.lockAllItems();
                  UnequipGearCommand.sendCommand(_loc4_.slotId,_loc6_);
               }
               else if(_loc4_.location == ItemLocation.Armament)
               {
                  _loc9_ = _loc4_.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
                  MafiaModel.userData.lockAllItems();
                  UnequipArmamentCommand.sendCommand(_loc6_,_loc9_.xInGrid,_loc9_.yInGrid);
               }
               else if(_loc4_.location == ItemLocation.Inventory)
               {
                  MafiaModel.userData.lockAllItems();
                  ChangeInventoryCommand.sendCommand(_loc4_.slotId,_loc6_);
               }
            }
         }
      }
      
      protected function onItemSwapped(param1:Event) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:int = MafiaModel.userData.armament.lastSwappedWithSlotId;
         MafiaModel.userData.armament.lastSwappedWithSlotId = -1;
         if(_loc2_ >= 0)
         {
            _loc3_ = this.getItemByIndex(_loc2_);
            if(_loc3_ != null)
            {
               this.startDrag(_loc3_,MafiaModel.userData.armament.lastSwappedAmount);
               this.scrollToItem(_loc2_);
            }
         }
         MafiaModel.userData.armament.lastSwappedAmount = 0;
      }
      
      protected function onItemsLocked(param1:Event) : void
      {
         this.showItemLockAnimation();
      }
      
      protected function onItemsUnlocked(param1:Event) : void
      {
         this.hideItemLockAnimation();
      }
      
      private function tryToBuyItem(param1:ItemVO, param2:int) : Boolean
      {
         if(param1.cash > MafiaModel.userData.cash)
         {
            this.layoutManager.showDialog(MafiaNoCashDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaNoCashDialog_title"),MafiaModel.languageData.getTextById("MafiaNoCashForBuyItem_copy") + "\n" + MafiaModel.languageData.getTextById("MafiaNoCashForBuyItem_copy_2")));
            return false;
         }
         if(param1.gold > MafiaModel.userData.gold)
         {
            this.layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForBuyItem_copy"),this.controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
            return false;
         }
         var _loc3_:Array = [param1.location,param1.slotId,param2];
         if(param1.location != ItemLocation.ShopConsumables && param1.slotId == MafiaShopData.SLOT_SAFE)
         {
            _loc3_[1] = -1;
         }
         this.executeBuy(_loc3_);
         return true;
      }
      
      private function executeBuy(param1:Array) : void
      {
         var _loc2_:ItemLocation = param1[0];
         var _loc3_:int = param1[1];
         var _loc4_:int = param1[2];
         MafiaModel.userData.lockAllItems();
         BuyItemCommand.sendCommand(_loc2_,_loc3_,_loc4_);
      }
      
      private function onContainerOpened(param1:MafiaOpenItemContainerEvent) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc2_:Inventory = this.getInventorySlotBySlotId(param1.containerSlotId);
         switch(param1.containerType)
         {
            case Constants_ItemContainer.MYSTERY_BOX:
               _loc4_ = MafiaItemData.getInstance().generateItemIcon(param1.item);
               _loc4_.scaleX = _loc4_.scaleY = Constants_ViewScales.SCALE_INVENTORY_ITEMS;
               _loc3_ = new MysteryBoxAni();
               _loc3_.itemHolder.addChild(_loc4_);
         }
         _loc2_.addChild(_loc3_);
         MovieClipHelper.watchAnimationEnd(_loc3_,this.onContainerAnimFinished);
      }
      
      private function onContainerAnimFinished(param1:MovieClip) : void
      {
         param1.stop();
         param1.visible = false;
         param1.parent.removeChild(param1);
         ViewInventoryCommand.sendCommand();
      }
      
      protected function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      protected function get inventory() : MafiaInventory
      {
         return disp as MafiaInventory;
      }
      
      protected function get data() : MafiaInventoryData
      {
         return MafiaModel.userData.inventory;
      }
   }
}
