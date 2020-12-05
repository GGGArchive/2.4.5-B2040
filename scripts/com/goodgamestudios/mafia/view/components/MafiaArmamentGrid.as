package com.goodgamestudios.mafia.view.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.basic.view.panels.BasicPanel;
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.equipment.UnlockArmamentCommand;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.MafiaArmamentData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.NewBasicStandartButton;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaUnlockArmamentDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaUnlockArmamentDialogProperties;
   import com.goodgamestudios.mafia.view.screens.MafiaPreCombatScreen;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.vo.items.ItemDragVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemComponent;
   import com.goodgamestudios.mafia.vo.items.components.StackableComponent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   
   public class MafiaArmamentGrid extends BasicPanel
   {
      
      public static const ITEM_BORDER_GOOD:int = 1;
      
      public static const ITEM_BORDER_BAD:int = 2;
      
      public static const ITEM_BORDER_NONE:int = 3;
      
      public static const DROP_ICON_NONE:int = 1;
      
      public static const DROP_ICON_DROP:int = 2;
      
      public static const DROP_ICON_SWAP:int = 3;
      
      public static const DROP_ICON_CANT_DROP:int = 4;
      
      public static const CELL_WIDTH:int = 27;
      
      private static const CELL_STATE_LOCKED:uint = 1;
      
      private static const CELL_STATE_UNLOCKABLE:uint = 2;
      
      private static const CELL_STATE_DROP_POSSIBLE:uint = 3;
      
      private static const CELL_STATE_UNLOCKED:uint = 4;
      
      private static const REGEXP_CELL_COORDINATES:RegExp = /cell_(\d+)_(\d+)/;
      
      private static var itemBorderFilter:DropShadowFilter = new DropShadowFilter(3,45,0,0.6,6,6,1,2);
       
      
      private var data:MafiaArmamentData;
      
      public function MafiaArmamentGrid(param1:ArmamentGrid)
      {
         super(param1);
         this.grid.btn_unlock.visible = false;
         this.grid.waitingForServerAnim.visible = false;
         this.grid.waitingForServerAnim.scaleX = this.grid.waitingForServerAnim.scaleY = 3;
         this.grid.waitingForServerOverlay.visible = false;
         this.controller.addEventListener(MafiaUserEvent.ITEMS_LOCKED,this.onItemsLocked);
         this.controller.addEventListener(MafiaUserEvent.ITEMS_UNLOCKED,this.onItemsUnlocked);
         this.grid.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      public static function createArmamentBackgroundGrid(param1:ItemVO, param2:Boolean = false) : MovieClip
      {
         var _loc4_:MovieClip = null;
         var _loc3_:ArmamentItemComponent = param1.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         if((_loc3_.isActive || param1.location != ItemLocation.Armament) && !param2)
         {
            switch(param1.type)
            {
               case ItemType.Accessory:
                  _loc4_ = new ItemGridBackgroundAccessory();
                  break;
               case ItemType.Consumable:
                  _loc4_ = new ItemGridBackgroundConsumable();
                  break;
               case ItemType.Skill:
                  _loc4_ = new ItemGridBackgroundSkill();
                  break;
               case ItemType.Weapon:
                  _loc4_ = new ItemGridBackgroundWeapon();
            }
         }
         else
         {
            _loc4_ = new ItemGridBackgroundDisabled();
         }
         _loc4_.width = MafiaArmamentGrid.CELL_WIDTH * _loc3_.widthInGrid;
         _loc4_.height = MafiaArmamentGrid.CELL_WIDTH * _loc3_.heightInGrid;
         return _loc4_;
      }
      
      public static function createArmamentBackgroundBorder(param1:ItemVO) : MovieClip
      {
         var _loc2_:ArmamentItemComponent = param1.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         var _loc3_:MovieClip = new ItemGridIconCorners();
         _loc3_.width = MafiaArmamentGrid.CELL_WIDTH * _loc2_.widthInGrid + 6;
         _loc3_.height = MafiaArmamentGrid.CELL_WIDTH * _loc2_.heightInGrid + 6;
         _loc3_.gotoAndStop(ITEM_BORDER_NONE);
         _loc3_.filters = [itemBorderFilter];
         return _loc3_;
      }
      
      public static function createArmamentDropIcon(param1:ItemVO) : MovieClip
      {
         var _loc2_:ArmamentItemComponent = param1.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         var _loc3_:MovieClip = new ItemGridIconDropIcon();
         _loc3_.gotoAndStop(DROP_ICON_DROP);
         _loc3_.x = -MafiaArmamentGrid.CELL_WIDTH * _loc2_.widthInGrid * 0.5 + _loc3_.width * 0.5 + 3;
         _loc3_.y = -MafiaArmamentGrid.CELL_WIDTH * _loc2_.heightInGrid * 0.5 + _loc3_.height * 0.5 + 3;
         _loc3_.gotoAndStop(DROP_ICON_NONE);
         return _loc3_;
      }
      
      override public function destroy() : void
      {
         this.grid.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.controller.removeEventListener(MafiaUserEvent.ITEMS_LOCKED,this.onItemsLocked);
         this.controller.removeEventListener(MafiaUserEvent.ITEMS_UNLOCKED,this.onItemsUnlocked);
         super.destroy();
      }
      
      public function fill(param1:MafiaArmamentData) : void
      {
         this.data = param1;
         this.updateGrid();
         this.updateUnlockButton();
         this.fillItems();
         if(this.isOwnArmament)
         {
            this.controller.removeEventListener(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
            this.controller.addEventListener(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
         }
      }
      
      public function clear() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         MovieClipHelper.clearMovieClip(this.grid.itemHolder);
         var _loc1_:uint = 0;
         while(_loc1_ < MafiaArmamentData.MAX_WIDTH)
         {
            _loc2_ = 0;
            while(_loc2_ < MafiaArmamentData.MAX_HEIGHT)
            {
               _loc3_ = this.grid["cell_" + _loc1_ + "_" + _loc2_];
               _loc3_.mouseChildren = false;
               _loc3_.gotoAndStop(CELL_STATE_LOCKED);
               _loc2_++;
            }
            _loc1_++;
         }
         this.grid.btn_unlock.visible = false;
      }
      
      protected function updateGrid() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc1_:uint = 0;
         while(_loc1_ < MafiaArmamentData.MAX_WIDTH)
         {
            _loc2_ = 0;
            while(_loc2_ < MafiaArmamentData.MAX_HEIGHT)
            {
               _loc3_ = this.grid["cell_" + _loc1_ + "_" + _loc2_];
               _loc3_.mouseChildren = false;
               if(this.data.isCellUnlocked(_loc1_,_loc2_))
               {
                  _loc3_.gotoAndStop(CELL_STATE_UNLOCKED);
               }
               else if(this.isOwnArmament && this.data.isCellUnlockable(_loc1_,_loc2_))
               {
                  _loc3_.gotoAndStop(CELL_STATE_UNLOCKABLE);
               }
               else
               {
                  _loc3_.gotoAndStop(CELL_STATE_LOCKED);
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function fillItems() : void
      {
         var _loc1_:ItemVO = null;
         MovieClipHelper.clearMovieClip(this.grid.itemHolder);
         for each(_loc1_ in this.data.getItems())
         {
            this.generateArmamentItem(_loc1_);
         }
      }
      
      protected function onItemsLocked(param1:Event) : void
      {
         this.grid.waitingForServerAnim.visible = true;
         this.grid.waitingForServerAnim.gotoAndPlay(0);
         this.grid.waitingForServerOverlay.visible = true;
         this.grid.waitingForServerOverlay.gotoAndPlay(0);
      }
      
      protected function onItemsUnlocked(param1:Event) : void
      {
         this.grid.waitingForServerAnim.visible = false;
         this.grid.waitingForServerAnim.gotoAndStop(0);
         this.grid.waitingForServerOverlay.visible = false;
         this.grid.waitingForServerOverlay.gotoAndStop(0);
      }
      
      private function scaleItemIconToFitGrid(param1:MovieClip, param2:uint, param3:uint) : void
      {
         var _loc4_:Number = 10;
         var _loc5_:Number = param2 * CELL_WIDTH - _loc4_;
         var _loc6_:Number = param3 * CELL_WIDTH - _loc4_;
         MovieClipHelper.scaleToFit(param1,_loc5_,_loc6_);
      }
      
      private function generateArmamentItem(param1:ItemVO) : void
      {
         var _loc7_:ColorMatrix = null;
         var _loc8_:MovieClip = null;
         var _loc9_:Array = null;
         var _loc10_:MovieClip = null;
         var _loc11_:StackableItemAmount = null;
         var _loc2_:ArmamentItemComponent = param1.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         var _loc3_:MovieClip = MafiaItemData.getInstance().generateItemIcon(param1);
         var _loc4_:Boolean = param1.type == ItemType.Consumable && MafiaLayoutManager.getInstance().currentState == Constants_LayoutStates.STATE_DUEL_PREPARE && !MafiaPreCombatScreen.useConsumables;
         if(!_loc2_.isActive || _loc4_)
         {
            _loc7_ = new ColorMatrix();
            _loc7_.desaturate();
            _loc8_ = _loc3_.getChildByName("itemPic") as MovieClip;
            _loc9_ = _loc8_.filters;
            _loc9_.push(_loc7_.filter);
            _loc8_.filters = _loc9_;
         }
         this.scaleItemIconToFitGrid(_loc3_,_loc2_.widthInGrid,_loc2_.heightInGrid);
         var _loc5_:MovieClip = createArmamentBackgroundGrid(param1,_loc4_);
         if(this.isOwnArmament)
         {
            _loc10_ = createArmamentBackgroundBorder(param1);
            _loc10_.gotoAndStop(ITEM_BORDER_NONE);
            _loc10_.name = "border";
            if(param1.hasComponent(StackableComponent))
            {
               _loc11_ = new StackableItemAmount();
               _loc11_.txt_amount.text = param1.amount.toString();
               _loc11_.x = _loc2_.widthInGrid * CELL_WIDTH * 0.5 - 2;
               _loc11_.y = _loc2_.heightInGrid * CELL_WIDTH * 0.5 - 2;
            }
         }
         var _loc6_:MovieClip = new MovieClip();
         _loc6_.addChild(_loc5_);
         _loc6_.addChild(_loc3_);
         if(_loc11_ != null)
         {
            _loc6_.addChild(_loc11_);
         }
         if(_loc10_ != null)
         {
            _loc6_.addChild(_loc10_);
         }
         _loc6_.mouseChildren = false;
         _loc6_.properties = param1;
         _loc6_.x = _loc2_.xInGrid * CELL_WIDTH + _loc2_.widthInGrid * CELL_WIDTH * 0.5;
         _loc6_.y = _loc2_.yInGrid * CELL_WIDTH + _loc2_.heightInGrid * CELL_WIDTH * 0.5;
         this.grid.itemHolder.addChild(_loc6_);
         _loc6_.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(param1,TooltipDispPosition.Over,null,!!this.isOwnArmament?int(BasicCustomCursor.CURSOR_HAND):int(BasicCustomCursor.CURSOR_ARROW));
      }
      
      protected function resetUnlockedArea() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.data.width)
         {
            _loc2_ = 0;
            while(_loc2_ < this.data.height)
            {
               _loc3_ = this.grid["cell_" + _loc1_ + "_" + _loc2_];
               _loc3_.gotoAndStop(CELL_STATE_UNLOCKED);
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function highlightDropSlot(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:MovieClip = null;
         var _loc5_:uint = param1;
         while(_loc5_ < param1 + param3)
         {
            _loc6_ = param2;
            while(_loc6_ < param2 + param4)
            {
               _loc7_ = this.grid["cell_" + _loc5_ + "_" + _loc6_];
               _loc7_.gotoAndStop(CELL_STATE_DROP_POSSIBLE);
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      protected function highlightTutorialDropSlot(param1:String) : void
      {
         switch(param1)
         {
            case MafiaTutorialController.TUT_STATE_DRAG_WEAPON:
               this.highlightDropSlot(0,0,3,2);
               break;
            case MafiaTutorialController.TUT_STATE_INVENTORY_DRAG_DYNAMITE:
               this.highlightDropSlot(0,2,2,2);
         }
      }
      
      protected function canDropInTutorial(param1:String, param2:Point) : Boolean
      {
         switch(param1)
         {
            case MafiaTutorialController.TUT_STATE_DRAG_WEAPON:
               return param2.x == 0 && param2.y == 0;
            case MafiaTutorialController.TUT_STATE_INVENTORY_DRAG_DYNAMITE:
               return param2.x == 0 && param2.y == 2;
            default:
               return false;
         }
      }
      
      protected function updateUnlockButton() : void
      {
         var _loc2_:Point = null;
         var _loc3_:String = null;
         var _loc1_:NewBasicStandartButton = this.grid.btn_unlock;
         if(this.isOwnArmament && !this.data.isFullyUnlocked())
         {
            _loc1_.visible = true;
            _loc2_ = this.getCenterOfUnlockableCells();
            _loc1_.x = _loc2_.x;
            _loc1_.y = _loc2_.y;
            if(this.data.isUnlockable())
            {
               _loc3_ = this.data.getUnlockCost().toString();
               _loc1_.goldInfoResizing = true;
               _loc1_.goldInfoVisible = true;
               _loc1_.goldInfoTimeText = _loc3_;
               _loc1_.enableButton = true;
               _loc1_.toolTipText = null;
            }
            else
            {
               _loc1_.goldInfoVisible = false;
               _loc1_.enableButton = false;
               _loc1_.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_btn_NextExpandArmament",[this.data.nextPaidUnlockLevel]);
            }
         }
         else
         {
            _loc1_.visible = false;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         if(!this.isOwnArmament)
         {
            return;
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         if(this.data.isUnlockable())
         {
            if(param1.target == this.grid.btn_unlock)
            {
               this.showUnlockDialog();
            }
            else if(this.isCell(param1.target as MovieClip))
            {
               _loc2_ = this.getCellCoordinates(param1.target as MovieClip);
               if(this.data.isCellUnlockable(_loc2_[0],_loc2_[1]))
               {
                  this.tryToUnlock();
               }
            }
         }
      }
      
      protected function calculateDropPosition(param1:Number, param2:Number, param3:ItemVO) : Point
      {
         var _loc7_:Point = null;
         var _loc4_:Point = this.grid.globalToLocal(new Point(param1,param2));
         _loc4_.x = _loc4_.x + CELL_WIDTH * MafiaArmamentData.MAX_WIDTH * 0.5;
         _loc4_.y = _loc4_.y + CELL_WIDTH * MafiaArmamentData.MAX_HEIGHT * 0.5;
         var _loc5_:ArmamentItemComponent = param3.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         var _loc6_:Point = new Point(_loc4_.x - _loc5_.widthInGrid * CELL_WIDTH * 0.5,_loc4_.y - _loc5_.heightInGrid * CELL_WIDTH * 0.5);
         if(_loc4_.x < this.data.width * CELL_WIDTH && _loc4_.y < this.data.height * CELL_WIDTH)
         {
            _loc7_ = new Point(Math.round(_loc6_.x / CELL_WIDTH),Math.round(_loc6_.y / CELL_WIDTH));
            _loc7_.x = Math.max(_loc7_.x,0);
            _loc7_.y = Math.max(_loc7_.y,0);
            _loc7_.x = Math.min(_loc7_.x,this.data.width - _loc5_.widthInGrid);
            _loc7_.y = Math.min(_loc7_.y,this.data.height - _loc5_.heightInGrid);
            return _loc7_;
         }
         return new Point(-1,-1);
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         if(!this.isOwnArmament)
         {
            return;
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         if(MafiaModel.userData.allItemsLocked)
         {
            return;
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         if(!MafiaLayoutManager.getInstance().dragManager.isDragging)
         {
            this.startDrag(param1);
         }
         super.onMouseDown(param1);
      }
      
      private function startDrag(param1:MouseEvent) : void
      {
         var _loc4_:ItemDragVO = null;
         var _loc5_:ArmamentItemComponent = null;
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:ItemVO = param1.target.properties as ItemVO;
         if(_loc3_ != null)
         {
            _loc4_ = new ItemDragVO();
            _loc4_.dragSourceMC = _loc2_;
            _loc4_.itemVO = _loc3_;
            _loc4_.sourceItemPic = _loc2_.getChildByName("itemIcon") as MovieClip;
            MafiaLayoutManager.getInstance().dragManager.startDragging(_loc4_);
            MafiaLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_DRAG);
            _loc5_ = _loc3_.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
            this.scaleItemIconToFitGrid(_loc4_.item,_loc5_.widthInGrid,_loc5_.heightInGrid);
         }
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         if(!this.isOwnArmament)
         {
            return;
         }
         if(MafiaLayoutManager.getInstance().dragManager.isDragging)
         {
            this.endDrag(param1);
         }
      }
      
      protected function endDrag(param1:MouseEvent) : void
      {
         var _loc2_:ItemDragVO = MafiaLayoutManager.getInstance().dragManager.dragVO as ItemDragVO;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ArmamentItemComponent = _loc2_.itemVO.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         if(_loc3_ == null)
         {
            return;
         }
         this.resetUnlockedArea();
         this.resetItemBorders();
         var _loc4_:Point = this.calculateDropPosition(param1.stageX,param1.stageY,_loc2_.itemVO);
         var _loc5_:ItemVO = this.data.getItemWithAnchorAt(_loc4_.x,_loc4_.y);
         if(_loc5_ == _loc2_.itemVO)
         {
            return;
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            if(this.canDropInTutorial(MafiaTutorialController.getInstance().tutorialState,_loc4_))
            {
               this.data.dropItemAt(_loc4_.x,_loc4_.y,_loc2_.itemVO);
            }
            return;
         }
         if(this.data.canItemBeDroppedAt(_loc4_.x,_loc4_.y,_loc2_.itemVO))
         {
            this.data.dropItemAt(_loc4_.x,_loc4_.y,_loc2_.itemVO,_loc2_.dragAmount);
         }
         else if(this.data.canItemBeMerged(_loc2_.itemVO))
         {
            this.data.mergeItem(_loc2_.itemVO);
         }
         else if(this.data.canItemBeSwappedAt(_loc4_.x,_loc4_.y,_loc2_.itemVO))
         {
            this.data.swapItemAt(_loc4_.x,_loc4_.y,_loc2_.itemVO,_loc2_.dragAmount);
         }
      }
      
      protected function onMouseMove(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         if(!this.isOwnArmament)
         {
            return;
         }
         var _loc2_:ItemDragVO = MafiaLayoutManager.getInstance().dragManager.dragVO as ItemDragVO;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ArmamentItemComponent = _loc2_.itemVO.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc2_.backgroundGrid != null)
         {
            _loc2_.backgroundGrid.visible = true;
         }
         this.scaleItemIconToFitGrid(_loc2_.item,_loc3_.widthInGrid,_loc3_.heightInGrid);
         this.resetUnlockedArea();
         this.resetItemBorders();
         var _loc4_:Point = this.calculateDropPosition(param1.stageX,param1.stageY,_loc2_.itemVO);
         if(MafiaTutorialController.getInstance().isActive)
         {
            _loc5_ = MafiaTutorialController.getInstance().tutorialState;
            switch(_loc5_)
            {
               case MafiaTutorialController.TUT_STATE_DRAG_WEAPON:
               case MafiaTutorialController.TUT_STATE_INVENTORY_DRAG_DYNAMITE:
                  if(this.canDropInTutorial(_loc5_,_loc4_))
                  {
                     this.showDragCanDrop(_loc2_,_loc4_);
                  }
                  else
                  {
                     this.showDragCannotDrop(_loc2_,_loc4_);
                  }
                  this.highlightTutorialDropSlot(_loc5_);
            }
            return;
         }
         if(_loc4_.x == -1 || _loc4_.y == -1)
         {
            this.showDragCannotDrop(_loc2_,_loc4_);
            return;
         }
         if(this.data.canItemBeMerged(_loc2_.itemVO))
         {
            this.showDragCanMerge(_loc2_,_loc4_);
         }
         else if(this.data.canItemBeDroppedAt(_loc4_.x,_loc4_.y,_loc2_.itemVO))
         {
            this.showDragCanDrop(_loc2_,_loc4_);
         }
         else if(this.data.canItemBeSwappedAt(_loc4_.x,_loc4_.y,_loc2_.itemVO))
         {
            this.showDragCanSwap(_loc2_,_loc4_);
         }
         else
         {
            this.showDragCannotDrop(_loc2_,_loc4_);
         }
      }
      
      protected function showDragCanDrop(param1:ItemDragVO, param2:Point) : void
      {
         var _loc3_:ArmamentItemComponent = param1.itemVO.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         this.highlightDropSlot(param2.x,param2.y,_loc3_.widthInGrid,_loc3_.heightInGrid);
         param1.backgroundBorder.gotoAndStop(ITEM_BORDER_GOOD);
         param1.dropIcon.gotoAndStop(DROP_ICON_DROP);
      }
      
      protected function showDragCanMerge(param1:ItemDragVO, param2:Point) : void
      {
         var _loc3_:ItemVO = this.data.getItemToMergeWith(param1.itemVO);
         var _loc4_:MovieClip = this.getItemMovieClip(_loc3_);
         var _loc5_:MovieClip = _loc4_.getChildByName("border") as MovieClip;
         _loc5_.gotoAndStop(ITEM_BORDER_GOOD);
         param1.backgroundBorder.gotoAndStop(ITEM_BORDER_GOOD);
         param1.dropIcon.gotoAndStop(DROP_ICON_DROP);
      }
      
      protected function showDragCanSwap(param1:ItemDragVO, param2:Point) : void
      {
         var _loc3_:ArmamentItemComponent = param1.itemVO.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
         var _loc4_:Vector.<ItemVO> = this.data.getOccupyingItems(param2.x,param2.y,param1.itemVO);
         var _loc5_:MovieClip = this.getItemMovieClip(_loc4_[0]);
         var _loc6_:MovieClip = _loc5_.getChildByName("border") as MovieClip;
         _loc6_.gotoAndStop(ITEM_BORDER_GOOD);
         this.highlightDropSlot(param2.x,param2.y,_loc3_.widthInGrid,_loc3_.heightInGrid);
         param1.backgroundBorder.gotoAndStop(ITEM_BORDER_GOOD);
         param1.dropIcon.gotoAndStop(DROP_ICON_SWAP);
      }
      
      protected function showDragCannotDrop(param1:ItemDragVO, param2:Point) : void
      {
         var _loc4_:ItemVO = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc3_:Vector.<ItemVO> = this.data.getOccupyingItems(param2.x,param2.y,param1.itemVO);
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = this.getItemMovieClip(_loc4_);
            if(_loc5_ != null)
            {
               _loc6_ = _loc5_.getChildByName("border") as MovieClip;
               _loc6_.gotoAndStop(ITEM_BORDER_BAD);
            }
         }
         param1.backgroundBorder.gotoAndStop(ITEM_BORDER_BAD);
         param1.dropIcon.gotoAndStop(DROP_ICON_CANT_DROP);
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         if(!this.isOwnArmament)
         {
            return;
         }
         var _loc2_:ItemDragVO = MafiaLayoutManager.getInstance().dragManager.dragVO as ItemDragVO;
         if(_loc2_ != null)
         {
            if(_loc2_.item != null)
            {
               _loc2_.item.scaleX = _loc2_.item.scaleY = 1;
            }
            if(_loc2_.backgroundBorder != null)
            {
               _loc2_.backgroundBorder.gotoAndStop(ITEM_BORDER_NONE);
            }
            if(_loc2_.backgroundGrid != null)
            {
               _loc2_.backgroundGrid.visible = false;
            }
            if(_loc2_.dropIcon != null)
            {
               _loc2_.dropIcon.gotoAndStop(DROP_ICON_NONE);
            }
         }
         this.resetItemBorders();
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         this.resetUnlockedArea();
      }
      
      private function onTutorialEvent(param1:MafiaTutorialEvent) : void
      {
         var _loc2_:String = MafiaTutorialController.getInstance().tutorialState;
         switch(_loc2_)
         {
            case MafiaTutorialController.TUT_STATE_DRAG_WEAPON:
               this.grid.tutpoint_13.addChild(MafiaTutorialController.getInstance().tutorialArrow);
               MafiaTutorialController.getInstance().flipArrow();
               this.highlightTutorialDropSlot(_loc2_);
               break;
            case MafiaTutorialController.TUT_STATE_INVENTORY_DRAG_DYNAMITE:
               this.grid.tutpoint_21.addChild(MafiaTutorialController.getInstance().tutorialArrow);
               this.highlightTutorialDropSlot(_loc2_);
               break;
            default:
               this.resetUnlockedArea();
         }
      }
      
      protected function showUnlockDialog() : void
      {
         var _loc1_:uint = this.data.getUnlockCost();
         var _loc2_:uint = this.data.getUnlockableCells().length;
         var _loc3_:uint = this.data.nextFreeUnlockLevel;
         MafiaLayoutManager.getInstance().showDialog(MafiaUnlockArmamentDialog.NAME,new MafiaUnlockArmamentDialogProperties(MafiaModel.languageData.getTextById("MafiaExpandArmamentDialog_title"),MafiaModel.languageData.getTextById("MafiaExpandArmamentDialog_copy_1",[_loc2_,_loc3_]),this.tryToUnlock,null,MafiaModel.languageData.getTextById("MafiaGangScreen_copy_5"),_loc1_));
      }
      
      protected function tryToUnlock() : void
      {
         if(MafiaModel.userData.gold >= this.data.getUnlockCost())
         {
            UnlockArmamentCommand.sendCommand();
         }
         else
         {
            MafiaLayoutManager.getInstance().showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForExpandArmament_copy"),basicController.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
         }
      }
      
      protected function get grid() : ArmamentGrid
      {
         return disp as ArmamentGrid;
      }
      
      protected function getItemMovieClip(param1:ItemVO) : MovieClip
      {
         var _loc3_:MovieClip = null;
         var _loc4_:ItemVO = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.grid.itemHolder.numChildren)
         {
            _loc3_ = this.grid.itemHolder.getChildAt(_loc2_) as MovieClip;
            if(_loc3_ != null && _loc3_.hasOwnProperty("properties"))
            {
               _loc4_ = _loc3_.properties as ItemVO;
               if(_loc4_ != null && _loc4_ == param1)
               {
                  return _loc3_;
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function resetItemBorders() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:ItemVO = null;
         var _loc4_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.grid.itemHolder.numChildren)
         {
            _loc2_ = this.grid.itemHolder.getChildAt(_loc1_) as MovieClip;
            if(_loc2_ != null && _loc2_.hasOwnProperty("properties"))
            {
               _loc3_ = _loc2_.properties as ItemVO;
               if(_loc3_ != null)
               {
                  _loc4_ = _loc2_.getChildByName("border") as MovieClip;
                  _loc4_.gotoAndStop(ITEM_BORDER_NONE);
               }
            }
            _loc1_++;
         }
      }
      
      protected function isCell(param1:MovieClip) : Boolean
      {
         return REGEXP_CELL_COORDINATES.test(param1.name);
      }
      
      protected function getCellCoordinates(param1:MovieClip) : Array
      {
         var _loc2_:* = REGEXP_CELL_COORDINATES.exec(param1.name);
         if(_loc2_ != null)
         {
            return [_loc2_[1],_loc2_[2]];
         }
         return [0,0];
      }
      
      protected function getCenterOfUnlockableCells() : Point
      {
         var _loc3_:Array = null;
         var _loc4_:MovieClip = null;
         var _loc1_:Array = this.data.getUnlockableCells();
         if(_loc1_ == null)
         {
            return null;
         }
         var _loc2_:Point = new Point();
         for each(_loc3_ in _loc1_)
         {
            _loc4_ = disp["cell_" + _loc3_[0] + "_" + _loc3_[1]];
            _loc2_ = _loc2_.add(new Point(_loc4_.x,_loc4_.y));
         }
         _loc2_ = new Point(_loc2_.x / _loc1_.length,_loc2_.y / _loc1_.length);
         return _loc2_;
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      protected function get isOwnArmament() : Boolean
      {
         return this.data == MafiaModel.userData.armament;
      }
   }
}
