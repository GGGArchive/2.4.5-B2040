package com.goodgamestudios.mafia.view.screens.shops
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.event.model.MafiaShopEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.MafiaShopData;
   import com.goodgamestudios.mafia.view.screens.MafiaScreen;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.vo.items.ArmamentItemVO;
   import com.goodgamestudios.mafia.vo.items.ItemDragVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemComponent;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class MafiaConsumables2ShopComponent extends MafiaScreen
   {
       
      
      private const ITEM_SIZE_GRID_OFFSET_X:Number = -45;
      
      private const ITEM_SIZE_GRID_OFFSET_Y:Number = -24;
      
      public function MafiaConsumables2ShopComponent(param1:DisplayObject, param2:Boolean = false)
      {
         super(param1,param2);
      }
      
      override public function updatePosition() : void
      {
      }
      
      override public function show() : void
      {
         super.show();
         this.shop.txt_title.text = MafiaModel.languageData.getTextById("MafiaShopScreen_copy_1");
         this.shop.txt_copy.text = MafiaModel.languageData.getTextById("MafiaShopScreen_copy_2");
         this.fillItemsInShop(Vector.<ItemVO>(MafiaModel.userData.consumablesShop.items),ItemLocation.ShopConsumables);
         controller.addEventListener(MafiaShopEvent.CHANGE_CONSUMABLE_SHOP_DATA,this.onChangeConsumableShopData);
         controller.addEventListener(MafiaShopEvent.CHANGE_NEW_ITEMS_IN_CONSUMABLES_SHOP_TIME,this.onShopTimer);
      }
      
      private function onChangeConsumableShopData(param1:MafiaShopEvent) : void
      {
         layoutManager.dragManager.stopDragging();
         this.fillItemsInShop(MafiaModel.userData.consumablesShop.items,ItemLocation.ShopConsumables);
      }
      
      protected function onShopTimer(param1:MafiaShopEvent) : void
      {
         this.shop.txt_time.text = param1.params[0];
         if(param1.params.length > 1 && param1.params[1] == MafiaShopData.TIMER_EXPIRED)
         {
         }
      }
      
      public function fillItemsInShop(param1:Vector.<ItemVO>, param2:ItemLocation) : void
      {
         var _loc3_:uint = 0;
         if(param1.length == 1)
         {
            this.showOneItemSlot();
            this.fillOneItemInShop(param1,_loc3_,param2);
         }
         else if(param1.length > 1)
         {
            this.showItemSlots();
            _loc3_ = 8;
            while(_loc3_ < 12)
            {
               this.fillOneItemInShop(param1,_loc3_,param2);
               _loc3_++;
            }
         }
      }
      
      public function showOneItemSlot() : void
      {
         this.shop.item_bg.visible = false;
         this.shop.extrashop0.visible = true;
         this.shop.btn_info.visible = true;
         this.shop.shop0.visible = false;
         this.shop.shop1.visible = false;
         this.shop.shop2.visible = false;
         this.shop.shop3.visible = false;
      }
      
      public function showItemSlots() : void
      {
         this.shop.item_bg.visible = true;
         this.shop.item_bg.mouseEnabled = false;
         this.shop.extrashop0.visible = false;
         this.shop.btn_info.visible = false;
         this.shop.shop0.visible = true;
         this.shop.shop1.visible = true;
         this.shop.shop2.visible = true;
         this.shop.shop3.visible = true;
      }
      
      public function get shop() : EventShop
      {
         return disp as EventShop;
      }
      
      protected function configMouseChildren(param1:MovieClip) : void
      {
         param1.mouseChildren = false;
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         controller.removeEventListener(MafiaShopEvent.CHANGE_NEW_ITEMS_IN_CONSUMABLES_SHOP_TIME,this.onShopTimer);
         controller.removeEventListener(MafiaShopEvent.CHANGE_CONSUMABLE_SHOP_DATA,this.onChangeConsumableShopData);
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
            case 8:
            case 9:
            case 10:
            case 11:
               _loc4_ = 350;
         }
         var _loc5_:Point = new Point(param1.x + _loc4_,param1.y + _loc3_);
         _loc5_ = param1.parent.localToGlobal(_loc5_);
         _loc5_ = param1.parent.globalToLocal(_loc5_);
         return _loc5_;
      }
      
      protected function fillOneItemInShop(param1:Vector.<ItemVO>, param2:uint, param3:ItemLocation) : void
      {
         var _loc4_:ItemVO = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc8_:MovieClip = null;
         if(param1.length > 1)
         {
            _loc6_ = this.shop["shop" + (param2 - 8)] as MovieClip;
         }
         else if(param1.length == 1)
         {
            _loc6_ = this.shop["extrashop" + (param2 - 8)] as MovieClip;
         }
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
         if(param1.length > 1)
         {
            _loc7_.scaleX = _loc7_.scaleY = Constants_ViewScales.SCALE_SHOP_ITEMS;
         }
         else if(param1.length == 1)
         {
            _loc7_.scaleX = _loc7_.scaleY = Constants_ViewScales.SCALE_EXTRA_SHOP_ITEM;
         }
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
         if(param1.target is ShopItem || param1.target is ShopExtraItem)
         {
            _loc2_ = param1.target as MovieClip;
            if(_loc2_.holder.numChildren == 0)
            {
               return;
            }
            _loc3_ = _loc2_.holder.getChildAt(0) as MovieClip;
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_HAND);
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
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:ItemDragVO = null;
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
            case this.shop.extrashop0:
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
                        return;
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
               if(!layoutManager.dragManager.dragVO)
               {
                  return;
               }
               _loc5_ = (layoutManager.dragManager.dragVO.dragSourceMC.properties as ItemVO).location;
               if(!MafiaItemData.isShopLocation(_loc5_))
               {
                  return;
               }
               break;
         }
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      override public function hide() : void
      {
         super.hide();
      }
   }
}
