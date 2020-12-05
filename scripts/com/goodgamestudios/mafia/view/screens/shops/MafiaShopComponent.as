package com.goodgamestudios.mafia.view.screens.shops
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.shop.ClearSafeCommand;
   import com.goodgamestudios.mafia.controller.commands.shop.OrderItemsCommand;
   import com.goodgamestudios.mafia.controller.commands.shop.SaveItemCommand;
   import com.goodgamestudios.mafia.controller.commands.shop.SellItemCommand;
   import com.goodgamestudios.mafia.event.model.MafiaShopEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.MafiaShopData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaDeactivateTresorItemDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaDeactivateTresorItemDialogProperties;
   import com.goodgamestudios.mafia.view.screens.MafiaScreen;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.items.ArmamentItemVO;
   import com.goodgamestudios.mafia.vo.items.ItemDragVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemComponent;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class MafiaShopComponent extends MafiaScreen
   {
       
      
      private const SAFE_SLOT_ID:int = 9;
      
      private const ITEM_SIZE_GRID_OFFSET_X:Number = -45;
      
      private const ITEM_SIZE_GRID_OFFSET_Y:Number = -24;
      
      private const TUTORIAL_FLASHBANG_SLOT_ID:int = 0;
      
      public function MafiaShopComponent(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,param2);
      }
      
      public function get MAX_SHOPITEMS() : int
      {
         return 8;
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaUserEvent.ITEMS_LOCKED,this.onItemsLocked);
         controller.addEventListener(MafiaUserEvent.ITEMS_UNLOCKED,this.onItemsUnlocked);
         this.fillBasicShopInfo();
      }
      
      override public function hide() : void
      {
         super.hide();
         controller.removeEventListener(MafiaUserEvent.ITEMS_LOCKED,this.onItemsLocked);
         controller.removeEventListener(MafiaUserEvent.ITEMS_UNLOCKED,this.onItemsUnlocked);
      }
      
      override public function updatePosition() : void
      {
      }
      
      protected function fillBasicShopInfo() : void
      {
         if(this.shop.btn_newItems)
         {
            controller.addEventListener(MafiaShopEvent.CHANGE_NEW_SHOP_ITEMS_FAILED,this.onNewShopItemsFailed);
         }
      }
      
      protected function fillNewItemInfo() : void
      {
         if(this.shop.btn_newItems)
         {
            this.shop.btn_newItems.toolTipText = MafiaModel.languageData.getTextById("MafiaBlackMarketScreen_btn_newstock");
            this.shop.btn_newItems.goldInfoVisible = false;
         }
      }
      
      override public function destroy() : void
      {
         var _loc2_:MovieClip = null;
         super.destroy();
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_DATA,this.onChangeUserData);
         disp.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         disp.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         var _loc1_:uint = 0;
         while(_loc1_ < this.MAX_SHOPITEMS)
         {
            _loc2_ = this.shop["shop" + _loc1_] as MovieClip;
            if(_loc2_)
            {
               MovieClipHelper.clearMovieClip(_loc2_.holder);
            }
            _loc1_++;
         }
         if(this.shop.tresor)
         {
            MovieClipHelper.clearMovieClip(this.shop.tresor.holder);
         }
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         if(this.shop.btn_newItems)
         {
            controller.removeEventListener(MafiaShopEvent.CHANGE_NEW_SHOP_ITEMS_FAILED,this.onNewShopItemsFailed);
         }
      }
      
      override protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
         if(this.shop.btn_newItems)
         {
            this.shop.btn_newItems.enableButton = true;
         }
      }
      
      private function onNewShopItemsFailed(param1:MafiaShopEvent) : void
      {
         if(this.shop.btn_newItems)
         {
            this.shop.btn_newItems.enableButton = true;
         }
      }
      
      public function fillItemsInShop(param1:Vector.<ItemVO>, param2:ItemLocation) : void
      {
         if(this.shop.btn_newItems)
         {
            this.shop.btn_newItems.gotoAndStop(1);
            this.shop.btn_newItems.label = MafiaModel.languageData.getTextById("MafiaBlackMarketScreen_btn_newstock");
            this.shop.btn_newItems.enableButton = true;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this.MAX_SHOPITEMS)
         {
            this.fillOneItemInShop(param1,_loc3_,param2);
            _loc3_++;
         }
         if(this.shop.tresor)
         {
            this.fillSafeInShop(param1);
         }
      }
      
      private function fillSafeInShop(param1:Vector.<ItemVO>) : void
      {
         var _loc2_:MovieClip = null;
         MovieClipHelper.clearMovieClip(this.shop.tresor.holder);
         if(param1.length == 9 && param1[8] != null)
         {
            _loc2_ = MafiaItemData.getInstance().generateItemIcon(param1[8]);
            this.shop.tresor.holder.addChild(_loc2_);
            _loc2_.scaleX = _loc2_.scaleY = Constants_ViewScales.SCALE_TRESOR_ITEMS;
            this.setItemTooltip(this.shop.tresor,_loc2_.properties,this.SAFE_SLOT_ID,BasicCustomCursor.CURSOR_HAND);
         }
         else
         {
            _loc2_ = MafiaItemData.getInstance().generatePlaceholder(ItemLocation.ShopSafe);
            _loc2_.properties = -1;
            _loc2_.mouseEnabled = false;
            this.shop.tresor.holder.addChild(_loc2_);
            this.shop.tresor.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaShopScreen_safeslot")),new Point(505,337),"",BasicCustomCursor.CURSOR_ARROW);
         }
         this.shop.tresor.mouseChildren = false;
      }
      
      protected function fillOneItemInShop(param1:Vector.<ItemVO>, param2:uint, param3:ItemLocation) : void
      {
         var _loc4_:ItemVO = null;
         var _loc5_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc6_:MovieClip = this.shop["shop" + param2] as MovieClip;
         _loc6_.toolTipVO = null;
         _loc6_.useHandCursor = false;
         _loc6_.buttonMode = false;
         MovieClipHelper.clearMovieClip(_loc6_.holder);
         _loc6_.txt_cost.text = "";
         _loc6_.price.visible = false;
         if(param1 == null || param2 >= param1.length || param1[param2] == null)
         {
            if(_loc6_.lock)
            {
               _loc6_.lock.visible = false;
            }
            if(_loc6_.soldOut)
            {
               _loc6_.soldOut.visible = true;
            }
            _loc5_ = MafiaItemData.getInstance().generatePlaceholder(param3);
            if(_loc6_.amount)
            {
               _loc6_.amount.visible = false;
            }
            _loc6_.holder.addChild(_loc5_);
            return;
         }
         _loc4_ = param1[param2];
         _loc5_ = MafiaItemData.getInstance().generateItemIcon(_loc4_);
         var _loc7_:MovieClip = _loc5_.getChildByName("itemPic") as MovieClip;
         _loc7_.scaleX = _loc7_.scaleY = Constants_ViewScales.SCALE_SHOP_ITEMS;
         MovieClipHelper.scaleDownToFit(_loc7_,_loc6_.itemSize.width,_loc6_.itemSize.height);
         if(_loc4_.hasComponent(ArmamentItemComponent))
         {
            _loc8_ = MafiaItemData.getInstance().generateItemGridSizeIcon(_loc4_);
            _loc8_.x = this.ITEM_SIZE_GRID_OFFSET_X;
            _loc8_.y = this.ITEM_SIZE_GRID_OFFSET_Y;
            _loc5_.addChild(_loc8_);
         }
         _loc6_.holder.addChild(_loc5_);
         this.configMouseChildren(_loc6_);
         if(_loc6_.soldOut)
         {
            _loc6_.soldOut.visible = false;
         }
         this.setItemTooltip(_loc6_,_loc4_,param2,BasicCustomCursor.CURSOR_HAND);
         _loc6_.txt_cost.text = _loc4_.gold > 0?NumberStringHelper.groupString(_loc4_.gold,MafiaModel.languageData.getTextById):NumberStringHelper.groupString(_loc4_.cash,MafiaModel.languageData.getTextById);
         _loc6_.price.visible = true;
         _loc6_.price.gotoAndStop(_loc4_.gold > 0?2:1);
         if(_loc6_.lock)
         {
            if(_loc4_.minUnlockLevel > MafiaModel.userData.userLevel)
            {
               _loc6_.lock.visible = true;
               _loc6_.lock.txt_label.text = MafiaModel.languageData.getTextById("tt_MafiaFeatureUnlock",[_loc4_.minUnlockLevel]);
            }
            else
            {
               _loc6_.lock.visible = false;
            }
         }
         if(_loc6_.amount)
         {
            switch(_loc4_.type)
            {
               case ItemType.Consumable:
                  _loc6_.amount.visible = true;
                  _loc6_.amount.txt_amount.text = (_loc4_ as ArmamentItemVO).amount.toString();
                  break;
               default:
                  _loc6_.amount.visible = false;
            }
         }
      }
      
      protected function configMouseChildren(param1:MovieClip) : void
      {
         param1.mouseChildren = false;
      }
      
      protected function setItemTooltip(param1:MovieClip, param2:ItemVO, param3:uint, param4:int) : void
      {
         param1.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(param2,TooltipDispPosition.Over,this.getItemTooltipPosition(param1,param3),param4);
      }
      
      protected function getItemTooltipPosition(param1:MovieClip, param2:int) : Point
      {
         var _loc3_:int = 375;
         var _loc4_:int = 400;
         switch(param2)
         {
            case 0:
            case 1:
            case 4:
            case 5:
               _loc4_ = 400;
               break;
            case 2:
            case 3:
            case 6:
            case 7:
               _loc4_ = 350;
               break;
            case this.SAFE_SLOT_ID:
               _loc4_ = 300;
         }
         var _loc5_:Point = new Point(param1.x + _loc4_,param1.y + _loc3_);
         _loc5_ = param1.parent.localToGlobal(_loc5_);
         _loc5_ = param1.parent.globalToLocal(_loc5_);
         return _loc5_;
      }
      
      protected function onShopTimer(param1:MafiaShopEvent) : void
      {
         if(this.shop.btn_newItems)
         {
            this.shop.btn_newItems.goldInfoVisible = true;
            this.shop.btn_newItems.goldInfoTimeText = MafiaModel.languageData.getTextById("tt_MafiaButton_forfree") + " " + param1.params[0];
            this.shop.btn_newItems.goldInfoGoldText = MafiaModel.goldConstants.newShopItemsPrice.toString();
            if(param1.params.length > 1 && param1.params[1] == MafiaShopData.TIMER_EXPIRED)
            {
               this.shop.btn_newItems.goldInfoVisible = false;
            }
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.shop.btn_newItems:
               if(!this.shop.btn_newItems.enabled)
               {
                  return;
               }
               this.shop.btn_newItems.enableButton = false;
               this.shop.btn_newItems.goldInfoVisible = false;
               MafiaModel.userData.lockAllItems();
               OrderItemsCommand.sendCommand(this.shop.btn_newItems.properties);
               return;
            default:
               return;
         }
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:ItemDragVO = null;
         trace(param1.target);
         if(param1.target is TextField)
         {
            return;
         }
         if(MafiaModel.userData.allItemsLocked)
         {
            return;
         }
         switch(param1.target)
         {
            case this.shop.shop0:
            case this.shop.shop1:
            case this.shop.shop2:
            case this.shop.shop3:
            case this.shop.shop4:
            case this.shop.shop5:
            case this.shop.shop6:
            case this.shop.shop7:
            case this.shop.tresor:
               _loc3_ = param1.target as MovieClip;
               if(_loc3_.holder.numChildren > 0)
               {
                  _loc4_ = _loc3_.holder.getChildAt(0) as MovieClip;
                  if(_loc4_.properties is ItemVO)
                  {
                     if(_loc4_.properties.minUnlockLevel > MafiaModel.userData.userLevel)
                     {
                        return;
                     }
                     _loc5_ = new ItemDragVO();
                     _loc5_.dragSourceMC = _loc4_;
                     _loc5_.itemVO = _loc4_.properties;
                     _loc5_.sourceItemPic = _loc4_.getChildByName("itemPic") as MovieClip;
                     if(MafiaTutorialController.getInstance().isActive)
                     {
                        switch(MafiaTutorialController.getInstance().tutorialState)
                        {
                           case MafiaTutorialController.TUT_STATE_SELECT_DYNAMITE:
                              if(_loc5_.itemVO.slotId == this.TUTORIAL_FLASHBANG_SLOT_ID)
                              {
                                 MafiaTutorialController.getInstance().nextStep();
                              }
                              else
                              {
                                 return;
                              }
                           default:
                              return;
                        }
                     }
                     layoutManager.dragManager.startDragging(_loc5_);
                     layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_DRAG);
                  }
                  break;
               }
               return;
         }
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:ItemVO = null;
         var _loc5_:ItemLocation = null;
         if(MafiaModel.userData.allItemsLocked)
         {
            return;
         }
         switch(param1.target)
         {
            case this.shop.tresor:
               _loc2_ = param1.target as TresorItem;
               if(_loc2_.holder.numChildren == 0)
               {
                  return;
               }
               _loc3_ = _loc2_.holder.getChildAt(0) as MovieClip;
               if(_loc3_.properties is ItemVO)
               {
                  layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
                  if(layoutManager.dragManager.dragVO && _loc3_.properties.id != layoutManager.dragManager.dragVO.dragSourceMC.properties.id)
                  {
                     return;
                  }
                  layoutManager.showDialog(MafiaDeactivateTresorItemDialog.NAME,new MafiaDeactivateTresorItemDialogProperties(MafiaItemData.getShopLocationByName(this.shop.name),MafiaModel.languageData.getTextById("MafiaRemoveSavedItemDialog_title"),MafiaModel.languageData.getTextById("MafiaRemoveSavedItemDialog_copy_1"),this.onDeactivateSaveItem,null,null,MafiaModel.languageData.getTextById("generic_btn_yes"),MafiaModel.languageData.getTextById("generic_btn_no")));
                  return;
               }
               if(!layoutManager.dragManager.dragVO)
               {
                  return;
               }
               _loc5_ = (layoutManager.dragManager.dragVO.dragSourceMC.properties as ItemVO).location;
               if(!MafiaItemData.isShopLocation(_loc5_))
               {
                  return;
               }
               this.onItemToSafe(layoutManager.dragManager.dragVO.dragSourceMC.properties);
               break;
            default:
               if(!layoutManager.dragManager.dragVO)
               {
                  return;
               }
               _loc4_ = layoutManager.dragManager.dragVO.dragSourceMC.properties as ItemVO;
               _loc5_ = _loc4_.location;
               if((_loc5_ == ItemLocation.ShopBlackMarket || _loc5_ == ItemLocation.ShopKiosk) && _loc4_.slotId == this.SAFE_SLOT_ID)
               {
                  layoutManager.showDialog(MafiaDeactivateTresorItemDialog.NAME,new MafiaDeactivateTresorItemDialogProperties(MafiaItemData.getShopLocationByName(this.shop.name),MafiaModel.languageData.getTextById("MafiaRemoveSavedItemDialog_title"),MafiaModel.languageData.getTextById("MafiaRemoveSavedItemDialog_copy_1"),this.onDeactivateSaveItem,null,null,MafiaModel.languageData.getTextById("generic_btn_yes"),MafiaModel.languageData.getTextById("generic_btn_no")));
               }
               break;
         }
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      private function onItemsLocked(param1:Event) : void
      {
         var _loc3_:Sprite = null;
         var _loc4_:MovieClip = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.MAX_SHOPITEMS)
         {
            trace(this.shop["shop" + _loc2_] as Sprite);
            _loc3_ = this.shop["shop" + _loc2_] as Sprite;
            _loc4_ = new ServerWaitingAnim();
            _loc4_.name = "lockAnim";
            _loc3_.addChild(_loc4_);
            _loc2_++;
         }
         _loc3_ = this.shop.tresor as Sprite;
         if(_loc3_)
         {
            _loc4_ = new ServerWaitingAnim();
            _loc4_.name = "lockAnim";
            _loc3_.addChild(_loc4_);
         }
      }
      
      private function onItemsUnlocked(param1:Event) : void
      {
         var _loc3_:Sprite = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.MAX_SHOPITEMS)
         {
            _loc3_ = this.shop["shop" + _loc2_] as Sprite;
            if(_loc3_)
            {
               _loc3_.removeChild(_loc3_.getChildByName("lockAnim"));
            }
            _loc2_++;
         }
         _loc3_ = this.shop.tresor as Sprite;
         if(_loc3_)
         {
            _loc3_.removeChild(_loc3_.getChildByName("lockAnim"));
         }
      }
      
      private function sellItem(param1:ItemVO) : void
      {
         MafiaModel.userData.lockAllItems();
         SellItemCommand.sendCommand(param1.slotId,param1.amount);
      }
      
      private function onDeactivateSaveItem(param1:ItemLocation) : void
      {
         MafiaModel.userData.lockAllItems();
         ClearSafeCommand.sendCommand(param1);
      }
      
      private function onItemToSafe(param1:ItemVO) : void
      {
         MafiaModel.userData.lockAllItems();
         SaveItemCommand.sendCommand(param1.slotId,param1.location);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         if(param1.target is TextField)
         {
            return;
         }
         if(layoutManager.dragManager.dragVO)
         {
            return;
         }
         super.onMouseOver(param1);
         if(param1.target is ShopItem || param1.target is TresorItem || param1.target is TournamentShopItem)
         {
            _loc2_ = param1.target as MovieClip;
            if(_loc2_.holder.numChildren == 0)
            {
               return;
            }
            _loc3_ = _loc2_.holder.getChildAt(0) as MovieClip;
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(layoutManager.dragManager.dragVO)
         {
            return;
         }
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         super.onMouseOut(param1);
      }
      
      protected function get shop() : MovieClip
      {
         return disp as MovieClip;
      }
   }
}
