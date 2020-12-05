package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.graphics.utils.ColorUtils;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_UnlockLevel;
   import com.goodgamestudios.mafia.constants.enums.GearType;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.equipment.EquipFoodCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.EquipGearCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.GetArmamentPresetStatusCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.UnequipFoodCommand;
   import com.goodgamestudios.mafia.controller.commands.shop.BuyItemCommand;
   import com.goodgamestudios.mafia.event.model.MafiaBoosterEvent;
   import com.goodgamestudios.mafia.event.model.MafiaGangEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.booster.MafiaBoosterData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.components.MafiaArmamentPresetSelection;
   import com.goodgamestudios.mafia.view.dialogs.MafiaDeactivateFoodDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardYesNoDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaDeactivateFoodDialogProperties;
   import com.goodgamestudios.mafia.view.tooltips.MafiaGangMemberAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaGangMemberAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.AchievementVO;
   import com.goodgamestudios.mafia.vo.GangVO;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.items.FoodVO;
   import com.goodgamestudios.mafia.vo.items.GearVO;
   import com.goodgamestudios.mafia.vo.items.ItemDragVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.mafia.vo.items.components.StackableComponent;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class MafiaUserSubProfileScreen extends MafiaSubProfileScreen
   {
      
      public static const NAME:String = "MafiaUserSubProfileScreen";
       
      
      private var foodReplaceHolder:Array;
      
      private var helpSlot:MovieClip;
      
      private var armamentPresetSelection:MafiaArmamentPresetSelection;
      
      public function MafiaUserSubProfileScreen(param1:DisplayObject)
      {
         super(param1);
         this.armamentPresetSelection = new MafiaArmamentPresetSelection(tabEquipment.combatPreset);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA,this.onChangeUserAvatarData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_ACHIEVEMENT_DATA,this.onChangeUserAchievementsData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_BOOSTER_DATA,this.onChangeUserBoosterData);
         controller.addEventListener(MafiaGangEvent.CHANGE_OWN_USER_GANG_DATA,this.onChangeUserGangData);
         if(MafiaModel.userData.achievementsData.achievements.length > 0)
         {
            this.fillAchievements(MafiaModel.userData.achievementsData.achievements);
         }
         if(MafiaModel.userData.gearData.items.length > 0)
         {
            fillGear(MafiaModel.userData.gearData.items);
         }
         if(MafiaModel.userData.foodData.food.length > 0)
         {
            fillFood(MafiaModel.userData.foodData.food);
         }
         if(MafiaModel.userData.armament != null)
         {
            fillArmament(MafiaModel.userData.armament);
         }
      }
      
      override public function show() : void
      {
         super.show();
         this.fillAll();
         controller.addEventListener(MafiaBoosterEvent.CHANGE_BOOSTER_TIMER,this.onChangeBoosterTimer);
         controller.addEventListener(MafiaGangEvent.CHANGE_OWN_USER_GANG_TIME,this.onChangeGangTimer);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_GEAR_DATA,this.onChangeUserGearData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_FOOD_DATA,this.onChangeUserFoodData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_ARMAMENT_DATA,this.onChangeUserArmamentData);
         controller.addEventListener(MafiaUserEvent.CHANGE_EQUIP_HELP,this.onChangeEquipHelp);
         controller.addEventListener(MafiaUserEvent.ITEMS_LOCKED,this.onItemsLocked);
         controller.addEventListener(MafiaUserEvent.ITEMS_UNLOCKED,this.onItemsUnlocked);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_ARMAMENT_PRESET_DATA,this.onPresetData);
         GetArmamentPresetStatusCommand.sendCommand();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA,this.onChangeUserAvatarData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_ACHIEVEMENT_DATA,this.onChangeUserAchievementsData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_BOOSTER_DATA,this.onChangeUserBoosterData);
         controller.removeEventListener(MafiaGangEvent.CHANGE_OWN_USER_GANG_DATA,this.onChangeUserGangData);
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaBoosterEvent.CHANGE_BOOSTER_TIMER,this.onChangeBoosterTimer);
         controller.removeEventListener(MafiaGangEvent.CHANGE_OWN_USER_GANG_TIME,this.onChangeGangTimer);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_GEAR_DATA,this.onChangeUserGearData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_FOOD_DATA,this.onChangeUserFoodData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_ARMAMENT_DATA,this.onChangeUserArmamentData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_EQUIP_HELP,this.onChangeEquipHelp);
         controller.removeEventListener(MafiaUserEvent.ITEMS_LOCKED,this.onItemsLocked);
         controller.removeEventListener(MafiaUserEvent.ITEMS_UNLOCKED,this.onItemsUnlocked);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_ARMAMENT_PRESET_DATA,this.onPresetData);
         super.removeEvents();
      }
      
      private function onChangeEquipHelp(param1:MafiaUserEvent) : void
      {
         var _loc3_:GearType = null;
         var _loc4_:int = 0;
         this.resetHelpSlot();
         var _loc2_:ItemType = param1.params[0] as ItemType;
         switch(_loc2_)
         {
            case ItemType.Gear:
               _loc3_ = param1.params[1] as GearType;
               this.helpSlot = tabEquipment["itemsInUse" + _loc3_.index] as ItemsInUse;
               this.helpSlot.gotoAndStop(2);
               this.helpSlot.helpBG.gotoAndStop(_loc3_.index);
               if(MafiaModel.userData.gearData.items[_loc3_.index - 1] == null)
               {
                  ColorUtils.setColor(this.helpSlot.item,15356484);
               }
               break;
            case ItemType.Food:
               _loc4_ = MafiaModel.userData.foodData.getSlotOfFoodWithSameItemId(param1.params[2]);
               if(_loc4_ == -1)
               {
                  _loc4_ = MafiaModel.userData.foodData.getFirstFreeSlot();
               }
               if(_loc4_ >= 0)
               {
                  this.helpSlot = tabEquipment["food" + _loc4_];
                  this.helpSlot.gotoAndStop(2);
                  this.helpSlot.helpBG.gotoAndStop(_loc4_ + 1);
                  if(MafiaModel.userData.foodData.food[_loc4_] == null)
                  {
                     ColorUtils.setColor(this.helpSlot.item,15356484);
                  }
               }
               break;
            case ItemType.Accessory:
            case ItemType.Consumable:
            case ItemType.Skill:
            case ItemType.Weapon:
               this.helpSlot = tabEquipment.grid;
               this.helpSlot.gotoAndStop(2);
         }
      }
      
      private function fillAll() : void
      {
         fillArmament(MafiaModel.userData.armament);
         fillAvatarStats(MafiaModel.userData.profileData);
         this.fillBooster(MafiaModel.userData.boosterData);
         fillGear(MafiaModel.userData.gearData.items);
         fillFood(MafiaModel.userData.foodData.food);
         this.fillAchievements(MafiaModel.userData.achievementsData.achievements);
         fillGang(MafiaModel.userData.gangData);
      }
      
      protected function onItemsLocked(param1:Event) : void
      {
         this.showItemLockAnimation();
      }
      
      protected function onItemsUnlocked(param1:Event) : void
      {
         this.hideItemLockAnimation();
      }
      
      public function showItemLockAnimation() : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:MovieClip = null;
         var _loc1_:uint = 1;
         while(_loc1_ < 9)
         {
            _loc2_ = tabEquipment["itemsInUse" + _loc1_];
            _loc3_ = new ServerWaitingAnim();
            _loc3_.name = "lockAnim";
            _loc2_.addChild(_loc3_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = tabEquipment["food" + _loc1_];
            _loc3_ = new ServerWaitingAnim();
            _loc3_.scaleX = _loc3_.scaleY = 0.6;
            _loc3_.name = "lockAnim";
            _loc2_.addChild(_loc3_);
            _loc1_++;
         }
      }
      
      public function hideItemLockAnimation() : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:ServerWaitingAnim = null;
         var _loc1_:uint = 1;
         while(_loc1_ < 9)
         {
            _loc2_ = tabEquipment["itemsInUse" + _loc1_];
            _loc3_ = _loc2_.getChildByName("lockAnim") as ServerWaitingAnim;
            if(_loc3_)
            {
               _loc2_.removeChild(_loc3_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = tabEquipment["food" + _loc1_];
            _loc3_ = _loc2_.getChildByName("lockAnim") as ServerWaitingAnim;
            if(_loc3_)
            {
               _loc2_.removeChild(_loc3_);
            }
            _loc1_++;
         }
      }
      
      private function onChangeUserAvatarData(param1:MafiaUserEvent) : void
      {
         fillAvatarStats(MafiaModel.userData.profileData);
      }
      
      private function onChangeBoosterTimer(param1:MafiaBoosterEvent) : void
      {
         mafiaSubProfile.tab_additional.boosterPicField.txt_boostduration.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_boosterduration") + "\n" + String(param1.params[0]);
         mafiaSubProfile.tab_additional.boosterPicField.txt_traveltime.appendText("\n" + String("-" + MafiaModel.userData.boosterData.boosterPower + "%"));
      }
      
      private function onChangeUserAchievementsData(param1:MafiaUserEvent) : void
      {
         this.fillAchievements(MafiaModel.userData.achievementsData.achievements);
      }
      
      override public function fillAchievements(param1:Vector.<AchievementVO>) : void
      {
         super.fillAchievements(param1);
      }
      
      private function onChangeUserBoosterData(param1:MafiaUserEvent) : void
      {
         super.fillBooster(MafiaModel.userData.boosterData);
      }
      
      override public function fillBooster(param1:MafiaBoosterData) : void
      {
         super.fillBooster(param1);
         if(param1.boosterID == 0)
         {
            tabAdditional.boosterPicField.visible = false;
            tabAdditional.noBooster.visible = true;
            if(MafiaModel.userData.profileData.isBoosterUnlocked)
            {
               tabAdditional.noBooster.btn_toBoosterShop.toolTipText = MafiaModel.languageData.getTextById("MafiaBoosterShopScreen_btn_rent");
               tabAdditional.noBooster.btn_toBoosterShop.enableButton = true;
               tabAdditional.noBooster.txt_noBooster.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_nobooster");
            }
            else
            {
               tabAdditional.noBooster.btn_toBoosterShop.enableButton = false;
               tabAdditional.noBooster.txt_noBooster.text = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_boosterunlock",[Constants_UnlockLevel.UNLOCK_BOOSTER]);
            }
         }
         else
         {
            tabAdditional.boosterPicField.visible = true;
            tabAdditional.noBooster.visible = false;
            tabAdditional.boosterPicField.txt_traveltime.appendText("\n" + String("-" + param1.boosterPower + "%"));
            tabAdditional.boosterPicField.txt_boostduration.appendText("\n" + TimeStringHelper.getTimeToString(param1.boosterEndTime / 1000,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById));
         }
      }
      
      private function onChangeUserGangData(param1:MafiaGangEvent) : void
      {
         fillGang(MafiaModel.userData.gangData);
      }
      
      private function onChangeGangTimer(param1:MafiaGangEvent) : void
      {
         var _loc2_:GangVO = param1.params[0] as GangVO;
         var _loc3_:GangMemberContainer = mafiaSubProfile.tab_additional.gang.getChildByName("member" + _loc2_.index) as GangMemberContainer;
         _loc3_.toolTipVO = new TooltipVO(MafiaGangMemberAdvancedTooltip.NAME,new MafiaGangMemberAdvancedTooltipProperties(_loc2_,false),null,"",BasicCustomCursor.CURSOR_CLICK);
      }
      
      private function onChangeUserArmamentData(param1:MafiaUserEvent) : void
      {
         fillArmament(MafiaModel.userData.armament);
      }
      
      private function onChangeUserGearData(param1:MafiaUserEvent) : void
      {
         fillGear(MafiaModel.userData.gearData.items);
         this.updateGearMouseover();
      }
      
      private function onChangeUserFoodData(param1:MafiaUserEvent) : void
      {
         fillFood(MafiaModel.userData.foodData.food);
      }
      
      private function updateGearMouseover() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:ItemsInUse = null;
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         var _loc6_:Shape = null;
         if(disp.stage)
         {
            _loc1_ = disp.stage.getObjectsUnderPoint(new Point(disp.stage.mouseX,disp.stage.mouseY));
            _loc2_ = new Array();
            for each(_loc4_ in _loc1_)
            {
               _loc6_ = _loc4_ as Shape;
               if(_loc6_ != null)
               {
                  _loc3_ = _loc6_.parent.parent as ItemsInUse;
                  if(_loc3_ != null)
                  {
                     _loc2_.push(_loc3_);
                  }
               }
            }
            _loc5_ = 0;
            while(_loc5_ < MafiaModel.userData.gearData.items.length)
            {
               _loc3_ = tabEquipment["itemsInUse" + (_loc5_ + 1)] as ItemsInUse;
               if(_loc3_ != null && _loc2_.indexOf(_loc3_) != -1)
               {
                  _loc3_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
               }
               _loc5_++;
            }
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         if(!param1.target.enabled)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case tabAdditional.noBooster:
            case tabAdditional.boosterPicField:
            case tabAdditional.noBooster.btn_toBoosterShop:
               layoutManager.state = Constants_LayoutStates.STATE_SHOP;
               (layoutManager.getScreen(MafiaShopScreen.NAME) as MafiaShopScreen).switchShopState(MafiaShopScreen.BOOSTER);
               break;
            case tabAdditional.gang.member0:
            case tabAdditional.gang.member1:
            case tabAdditional.gang.member2:
            case tabAdditional.gang.member3:
            case tabAdditional.gang.member4:
               layoutManager.state = Constants_LayoutStates.STATE_GANG;
               break;
            default:
               super.onMouseDown(param1);
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         if(layoutManager.dragManager.dragVO)
         {
            return;
         }
         if(param1.target is BoosterContainer || param1.target is NoBoosterContainer && MafiaModel.userData.boosterData.boosterID > 0)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
         super.onMouseOver(param1);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         super.onMouseOut(param1);
         if(layoutManager.dragManager.dragVO)
         {
            super.onMouseOut(param1);
            return;
         }
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:ItemDragVO = null;
         var _loc5_:int = 0;
         if(param1.target == mafiaSubProfile.bg)
         {
            return;
         }
         if(param1.target is MovieClip)
         {
            _loc2_ = param1.target as MovieClip;
            if(_loc2_.numChildren <= 1)
            {
               return;
            }
         }
         if(param1.target is Inventory)
         {
            if(MafiaTutorialController.getInstance().isActive)
            {
               if(0)
               {
               }
               return;
            }
            _loc2_ = param1.target as Inventory;
            if(MafiaModel.userData.allItemsLocked)
            {
               return;
            }
            if(_loc2_.item.numChildren > 0)
            {
               _loc3_ = _loc2_.item.getChildAt(0) as MovieClip;
            }
            if(_loc3_ && _loc3_.properties is ItemVO)
            {
               _loc4_ = new ItemDragVO();
               _loc4_.dragSourceMC = _loc3_;
               _loc4_.itemVO = _loc3_.properties;
               layoutManager.dragManager.startDragging(_loc4_);
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_DRAG);
            }
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            return;
         }
         if(param1.target is ItemsInUse || param1.target is DynamitePlace)
         {
            if(MafiaModel.userData.allItemsLocked)
            {
               return;
            }
            _loc2_ = param1.target as MovieClip;
            if(_loc2_.item.numChildren > 0)
            {
               _loc3_ = _loc2_.item.getChildAt(0) as MovieClip;
            }
            if(_loc3_ && _loc3_.properties is ItemVO)
            {
               _loc4_ = new ItemDragVO();
               _loc4_.dragSourceMC = _loc3_;
               _loc4_.itemVO = _loc3_.properties;
               _loc4_.sourceItemPic = _loc3_.getChildByName("itemPic") as MovieClip;
               MafiaLayoutManager.getInstance().dragManager.stopDragging();
               layoutManager.dragManager.startDragging(_loc4_);
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_DRAG);
            }
         }
         else if(param1.target is Food)
         {
            if(MafiaModel.userData.allItemsLocked)
            {
               return;
            }
            _loc2_ = param1.target as Food;
            if(_loc2_.item.numChildren > 0)
            {
               _loc3_ = _loc2_.item.getChildAt(0) as MovieClip;
            }
            if(_loc3_ && _loc3_.properties is ItemVO)
            {
               _loc5_ = int(String(_loc2_.name).substr(-1,1));
               layoutManager.showDialog(MafiaDeactivateFoodDialog.NAME,new MafiaDeactivateFoodDialogProperties(_loc5_,MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_food"),MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_cancelfood"),this.unequipFood,null,MafiaModel.languageData.getTextById("generic_btn_yes"),MafiaModel.languageData.getTextById("generic_btn_no")));
            }
         }
         else
         {
            super.onMouseDown(param1);
         }
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:MovieClip = null;
         var _loc4_:ItemVO = null;
         var _loc5_:ItemVO = null;
         var _loc6_:int = 0;
         var _loc7_:ItemLocation = null;
         var _loc8_:ItemLocation = null;
         if(!layoutManager.dragManager.dragVO)
         {
            return;
         }
         if(layoutManager.dragManager.dragVO is ItemDragVO)
         {
            _loc3_ = param1.target as MovieClip;
            _loc4_ = layoutManager.dragManager.dragVO.dragSourceMC.properties as ItemVO;
            if(MafiaModel.userData.allItemsLocked)
            {
               return;
            }
            if(!_loc3_)
            {
               return;
            }
            _loc7_ = _loc4_.location;
            _loc8_ = this.getTargetLocation(param1.target);
            if(this.isEquipmentLocation(_loc8_))
            {
               if(_loc3_.name.substr(0,10) == "itemsInUse")
               {
                  _loc6_ = int(String(_loc3_.name).substr(-1,1));
                  _loc5_ = MafiaModel.userData.gearData.itemOnIndex(_loc6_);
               }
               else if(_loc3_.name.substr(0,4) == "food")
               {
                  _loc6_ = int(String(_loc3_.name).substr(-1,1));
               }
               if(_loc7_ == ItemLocation.Gear || _loc7_ == ItemLocation.FoodInUse)
               {
                  return;
               }
               if(MafiaItemData.isShopLocation(_loc4_.location))
               {
                  return;
               }
               if(_loc4_.location == ItemLocation.Inventory)
               {
                  if(_loc4_.type == ItemType.Food)
                  {
                     _loc2_ = [_loc4_.slotId,_loc4_.amount];
                     if(!this.checkWithFoodInUse(_loc4_,_loc6_,Constants_SFS.PROTOBUF_EQUIP_FOOD,_loc2_))
                     {
                        return;
                     }
                  }
                  if(_loc4_.hasComponent(StackableComponent) && _loc5_ && _loc5_.hasComponent(StackableComponent) && _loc4_.id != _loc5_.id)
                  {
                     layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaInventoryFullDialog_copy_3")));
                     return;
                  }
                  switch(_loc4_.type)
                  {
                     case ItemType.Gear:
                        this.equipGear(_loc4_ as GearVO);
                        break;
                     case ItemType.Food:
                        this.equipFood(_loc4_ as FoodVO,_loc6_);
                        break;
                     default:
                        trace("illegal item type");
                  }
               }
            }
         }
      }
      
      private function getTargetLocation(param1:Object) : ItemLocation
      {
         switch(param1)
         {
            case tabEquipment.itemsInUse0:
            case tabEquipment.itemsInUse1:
            case tabEquipment.itemsInUse2:
            case tabEquipment.itemsInUse3:
            case tabEquipment.itemsInUse4:
            case tabEquipment.itemsInUse5:
            case tabEquipment.itemsInUse6:
            case tabEquipment.itemsInUse7:
            case tabEquipment.itemsInUse8:
               return ItemLocation.Gear;
            case tabEquipment.food0:
            case tabEquipment.food1:
            case tabEquipment.food2:
               return ItemLocation.FoodInUse;
            default:
               return ItemLocation.None;
         }
      }
      
      private function equipFood(param1:FoodVO, param2:int) : void
      {
         MafiaModel.userData.lockAllItems();
         EquipFoodCommand.sendCommand(param1.slotId,param2);
      }
      
      private function equipGear(param1:GearVO) : void
      {
         MafiaModel.userData.lockAllItems();
         EquipGearCommand.sendCommand(param1.slotId);
      }
      
      private function isEquipmentLocation(param1:ItemLocation) : Boolean
      {
         switch(param1)
         {
            case ItemLocation.Gear:
            case ItemLocation.FoodInUse:
            case ItemLocation.Armament:
               return true;
            default:
               return false;
         }
      }
      
      private function checkWithFoodInUse(param1:ItemVO, param2:int, param3:String, param4:Array) : Boolean
      {
         var _loc5_:Vector.<FoodVO> = MafiaModel.userData.foodData.food;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(_loc5_[_loc6_] && _loc5_[_loc6_].id == param1.id)
            {
               layoutManager.showDialog(MafiaStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaReplaceFoodDialog_replace"),this.onClickYesFoodReplace,this.onClickNoFoodReplace));
               this.foodReplaceHolder = [param1,_loc6_,param3,param4,param2];
               return false;
            }
            _loc6_++;
         }
         if(!MafiaModel.userData.foodData.isAFoodSlotEmpty)
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaReplaceFoodDialog_full")));
            return false;
         }
         return true;
      }
      
      private function onClickYesFoodReplace(param1:Event) : void
      {
         var _loc2_:Array = null;
         var _loc3_:ItemLocation = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         MafiaModel.userData.lockAllItems();
         this.unequipFood(this.foodReplaceHolder[1]);
         switch(this.foodReplaceHolder[2])
         {
            case Constants_SFS.PROTOBUF_BUY_ITEM:
               _loc2_ = this.foodReplaceHolder[3];
               _loc3_ = _loc2_[0];
               _loc4_ = _loc2_[1];
               _loc5_ = _loc2_[2];
               BuyItemCommand.sendCommand(_loc3_,_loc4_,_loc5_);
               break;
            case Constants_SFS.PROTOBUF_EQUIP_FOOD:
               this.equipFood(this.foodReplaceHolder[0],this.foodReplaceHolder[4]);
         }
         this.foodReplaceHolder = null;
      }
      
      private function onClickNoFoodReplace(param1:Event) : void
      {
         this.foodReplaceHolder = null;
      }
      
      private function unequipFood(param1:int) : void
      {
         UnequipFoodCommand.sendCommand(param1);
      }
      
      private function resetHelpSlot() : void
      {
         if(this.helpSlot)
         {
            if(this.helpSlot.item != null)
            {
               ColorUtils.resetColor(this.helpSlot.item);
            }
            this.helpSlot.gotoAndStop(1);
            this.helpSlot = null;
         }
      }
      
      private function addTutorialArrowAt(param1:DisplayObject, param2:Boolean = false, param3:Boolean = false) : void
      {
         MafiaTutorialController.getInstance().removeArrow();
         if(param2)
         {
            MafiaTutorialController.getInstance().mirrorArrow();
         }
         if(param3)
         {
            MafiaTutorialController.getInstance().flipArrow();
         }
         layoutManager.addTutorialArrow(MafiaTutorialController.getInstance().tutorialArrow);
         MafiaTutorialController.getInstance().tutorialArrow.x = param1.localToGlobal(new Point()).x;
         MafiaTutorialController.getInstance().tutorialArrow.y = param1.localToGlobal(new Point()).y;
      }
      
      private function onPresetData(param1:Event) : void
      {
         this.armamentPresetSelection.setup(MafiaModel.userData.armamentPresetData.unlockedArmaments,MafiaModel.userData.armamentPresetData.activeArmament,true);
      }
   }
}
