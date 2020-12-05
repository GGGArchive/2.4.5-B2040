package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.shop.SellItemCommand;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.event.model.MafiaShopEvent;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaSellEquipBuyItemDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaSellEquipBuyItemDialogProperties;
   import com.goodgamestudios.mafia.view.screens.shops.MafiaBlackMarketShopComponent;
   import com.goodgamestudios.mafia.view.screens.shops.MafiaBoosterShopComponent;
   import com.goodgamestudios.mafia.view.screens.shops.MafiaConsumables2ShopComponent;
   import com.goodgamestudios.mafia.view.screens.shops.MafiaConsumablesShopComponent;
   import com.goodgamestudios.mafia.view.screens.shops.MafiaExtrasShopComponent;
   import com.goodgamestudios.mafia.view.screens.shops.MafiaKioskShopComponent;
   import com.goodgamestudios.mafia.view.screens.shops.MafiaTournamentShopComponent;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.items.ItemDragVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class MafiaShopScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaShopBlackScreen";
      
      public static const WEAPON:String = "weapon";
      
      public static const CONSUMABLES:String = "consumables";
      
      public static const CONSUMABLES_2:String = "consumables2";
      
      public static const KIOSK:String = "kiosk";
      
      public static const BOOSTER:String = "booster";
      
      public static const TOURNAMENT:String = "tournament";
      
      public static const EXTRAS:String = "extras";
       
      
      protected var sellPlaceGlow:GlowFilter;
      
      protected var blackmarketshop:MafiaBlackMarketShopComponent;
      
      protected var consumablesshop:MafiaConsumablesShopComponent;
      
      protected var consumables2shop:MafiaConsumables2ShopComponent;
      
      protected var kioskshop:MafiaKioskShopComponent;
      
      protected var boostershop:MafiaBoosterShopComponent;
      
      protected var tournamentshop:MafiaTournamentShopComponent;
      
      protected var extrasshop:MafiaExtrasShopComponent;
      
      private var shops:Vector.<MafiaScreen>;
      
      private var _shopState:String = "weapon";
      
      private const SELECTSHOPBUTTONPOSITION:int = 285;
      
      private const UNSELECTSHOPBUTTONPOSITION:int = 293;
      
      public function MafiaShopScreen(param1:DisplayObject)
      {
         this.sellPlaceGlow = new GlowFilter(16777215,1,15,15,2,2);
         super(param1,false);
         this.blackmarketshop = new MafiaBlackMarketShopComponent(this.shopScreen.weapon);
         this.consumablesshop = new MafiaConsumablesShopComponent(this.shopScreen.consumables);
         this.consumables2shop = new MafiaConsumables2ShopComponent(this.shopScreen.consumables_2);
         this.kioskshop = new MafiaKioskShopComponent(this.shopScreen.kiosk);
         this.boostershop = new MafiaBoosterShopComponent(this.shopScreen.booster);
         this.tournamentshop = new MafiaTournamentShopComponent(this.shopScreen.tournament);
         this.extrasshop = new MafiaExtrasShopComponent(this.shopScreen.event);
         this.shops = new Vector.<MafiaScreen>();
         this.shops.push(this.blackmarketshop);
         this.shops.push(this.consumablesshop);
         this.shops.push(this.consumables2shop);
         this.shops.push(this.kioskshop);
         this.shops.push(this.boostershop);
         this.shops.push(this.tournamentshop);
         this.shops.push(this.extrasshop);
         controller.addEventListener(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
      }
      
      override public function show() : void
      {
         super.show();
         this.shopScreen.sellPlace.mouseChildren = false;
         this.shopScreen.sellPlace.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(MafiaModel.languageData.getTextById("tt_MafiaShopScreen_sell")),new Point(598,337),"",BasicCustomCursor.CURSOR_ARROW);
         this.shopScreen.btn_weapon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_blackmarket");
         this.shopScreen.btn_kiosk.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_cornershop");
         this.shopScreen.btn_booster.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_booster");
         this.shopScreen.btn_tournament.toolTipText = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_event");
         this.shopScreen.btn_consumables_2.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_consumables_2");
         this.shopScreen.btn_consumables.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_consumables_1");
         controller.addEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onSpecialEventIsOver);
         controller.addEventListener(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
         controller.addEventListener(MafiaShopEvent.CHANGE_SHOP_STATE,this.onChangeShopState);
         this.switchShopState(this.shopState);
         if(MafiaTutorialController.getInstance().isActive)
         {
            if(MafiaTutorialController.getInstance().tutorialState == MafiaTutorialController.TUT_STATE_GO_TO_CONSUMABLES)
            {
               this.shopScreen.btn_consumables.addChild(MafiaTutorialController.getInstance().tutorialArrow);
               MafiaTutorialController.getInstance().flipArrow();
            }
         }
      }
      
      override public function hide() : void
      {
         super.hide();
         this.blackmarketshop.hide();
         this.consumablesshop.hide();
         this.kioskshop.hide();
         this.boostershop.hide();
         this.tournamentshop.hide();
         this.consumables2shop.hide();
         this.extrasshop.hide();
         controller.removeEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onSpecialEventIsOver);
         controller.removeEventListener(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
         controller.removeEventListener(MafiaShopEvent.CHANGE_SHOP_STATE,this.onChangeShopState);
      }
      
      override protected function onTutorialEvent(param1:MafiaTutorialEvent) : void
      {
         if(0)
         {
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:MovieClip = null;
         if(param1.target is TextField)
         {
            return;
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_GO_TO_CONSUMABLES:
                  if(param1.target == this.shopScreen.btn_consumables)
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
         switch(param1.target)
         {
            case this.shopScreen.btn_weapon:
               this.switchShopState(WEAPON);
               super.onClick(param1);
               break;
            case this.shopScreen.btn_consumables:
               this.switchShopState(CONSUMABLES);
               super.onClick(param1);
               break;
            case this.shopScreen.btn_kiosk:
               this.switchShopState(KIOSK);
               super.onClick(param1);
               break;
            case this.shopScreen.btn_booster:
               this.switchShopState(BOOSTER);
               super.onClick(param1);
               break;
            case this.shopScreen.btn_tournament:
               this.switchShopState(EXTRAS);
               super.onClick(param1);
               break;
            case this.shopScreen.btn_consumables_2:
               this.switchShopState(CONSUMABLES_2);
               super.onClick(param1);
         }
      }
      
      public function switchShopState(param1:String) : void
      {
         var _loc2_:Boolean = MafiaModel.specialEvent.tournamentEvent.isEventActive;
         if(param1 == TOURNAMENT && !_loc2_)
         {
            param1 = WEAPON;
         }
         this.shopScreen.layer_weapon.gotoAndStop(2);
         this.shopScreen.btn_weapon.y = this.UNSELECTSHOPBUTTONPOSITION;
         this.shopScreen.layer_consumables.gotoAndStop(2);
         this.shopScreen.btn_consumables.y = this.UNSELECTSHOPBUTTONPOSITION;
         this.shopScreen.layer_kiosk.gotoAndStop(2);
         this.shopScreen.btn_kiosk.y = this.UNSELECTSHOPBUTTONPOSITION;
         this.shopScreen.layer_booster.gotoAndStop(2);
         this.shopScreen.btn_booster.y = this.UNSELECTSHOPBUTTONPOSITION;
         this.shopScreen.layer_consumables_2.gotoAndStop(2);
         this.shopScreen.btn_consumables_2.y = this.UNSELECTSHOPBUTTONPOSITION;
         this.shopScreen.layer_tournament.visible = MafiaModel.userData.extrasShop.isActive;
         this.shopScreen.btn_tournament.visible = MafiaModel.userData.extrasShop.isActive;
         this.shopScreen.layer_tournament.gotoAndStop(2);
         this.shopScreen.btn_tournament.y = this.UNSELECTSHOPBUTTONPOSITION;
         switch(param1)
         {
            case WEAPON:
               this.showShopAndHideAllOthers(this.blackmarketshop);
               this.shopScreen.layer_weapon.gotoAndStop(1);
               this.shopScreen.btn_weapon.y = this.SELECTSHOPBUTTONPOSITION;
               loadBackground(MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_WEAPONS);
               break;
            case CONSUMABLES:
               this.showShopAndHideAllOthers(this.consumablesshop);
               this.shopScreen.layer_consumables.gotoAndStop(1);
               this.shopScreen.btn_consumables.y = this.SELECTSHOPBUTTONPOSITION;
               loadBackground(MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_CONSUMABLES_SHOP);
               break;
            case KIOSK:
               this.showShopAndHideAllOthers(this.kioskshop);
               this.shopScreen.layer_kiosk.gotoAndStop(1);
               this.shopScreen.btn_kiosk.y = this.SELECTSHOPBUTTONPOSITION;
               loadBackground(MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_KIOSK);
               break;
            case BOOSTER:
               this.showShopAndHideAllOthers(this.boostershop);
               this.shopScreen.layer_booster.gotoAndStop(1);
               this.shopScreen.btn_booster.y = this.SELECTSHOPBUTTONPOSITION;
               loadBackground(MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_BOOSTER);
               break;
            case TOURNAMENT:
               this.showShopAndHideAllOthers(this.tournamentshop);
               this.shopScreen.layer_tournament.gotoAndStop(1);
               this.shopScreen.btn_tournament.y = this.SELECTSHOPBUTTONPOSITION;
               loadBackground(MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_WEAPONS);
               break;
            case CONSUMABLES_2:
               this.showShopAndHideAllOthers(this.consumables2shop);
               this.shopScreen.layer_consumables_2.gotoAndStop(1);
               this.shopScreen.btn_consumables_2.y = this.SELECTSHOPBUTTONPOSITION;
               loadBackground(MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_CONSUMABLES_SHOP);
               break;
            case EXTRAS:
               this.showShopAndHideAllOthers(this.extrasshop);
               this.shopScreen.layer_tournament.gotoAndStop(1);
               this.shopScreen.btn_tournament.y = this.SELECTSHOPBUTTONPOSITION;
               loadBackground(MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_WEAPONS);
         }
         this._shopState = param1;
      }
      
      private function onChangeShopState(param1:MafiaShopEvent) : void
      {
         var _loc2_:String = param1.params[0];
         var _loc3_:Boolean = param1.params[1];
         switch(_loc2_)
         {
            case EXTRAS:
               if(_loc3_)
               {
                  this.shopScreen.layer_tournament.visible = true;
                  this.shopScreen.btn_tournament.visible = true;
               }
               else
               {
                  this.shopScreen.layer_tournament.visible = false;
                  this.shopScreen.btn_tournament.visible = false;
                  this.switchShopState(WEAPON);
               }
         }
      }
      
      private function onSpecialEventIsOver(param1:MafiaSpecialEventsEvent) : void
      {
         var _loc2_:int = param1.params[0];
         switch(_loc2_)
         {
            case Constants_SpecialEvents.ID_SICILIAN:
               break;
            case Constants_SpecialEvents.ID_CAPO_VITO:
               break;
            case Constants_SpecialEvents.ID_NIGHT_OF_HORROR:
               break;
            case Constants_SpecialEvents.ID_CALENDAR:
               break;
            case Constants_SpecialEvents.ID_TOURNAMENT:
               this.switchShopState(WEAPON);
         }
      }
      
      private function showShopAndHideAllOthers(param1:MafiaScreen) : void
      {
         var _loc2_:MafiaScreen = null;
         for each(_loc2_ in this.shops)
         {
            if(_loc2_ == param1)
            {
               _loc2_.show();
            }
            else
            {
               _loc2_.hide();
            }
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
         super.onMouseOver(param1);
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:ItemVO = null;
         var _loc5_:Array = null;
         if(MafiaModel.userData.allItemsLocked)
         {
            return;
         }
         switch(param1.target)
         {
            case this.shopScreen.sellPlace:
               if(!layoutManager.dragManager.dragVO)
               {
                  return;
               }
               if(layoutManager.dragManager.dragVO && layoutManager.dragManager.dragVO is ItemDragVO)
               {
                  _loc4_ = layoutManager.dragManager.dragVO.dragSourceMC.properties as ItemVO;
                  layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
                  if(MafiaItemData.isShopLocation(_loc4_.location))
                  {
                     return;
                  }
                  if(_loc4_.location != ItemLocation.Inventory)
                  {
                     layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaSellFromInventoryDialog_title"),MafiaModel.languageData.getTextById("MafiaSellFromInventoryDialog_copy_1")));
                     return;
                  }
                  if(MafiaItemData.shouldUserBeAskedForAmountToSell(_loc4_))
                  {
                     layoutManager.showDialog(MafiaSellEquipBuyItemDialog.NAME,new MafiaSellEquipBuyItemDialogProperties(_loc4_,MafiaSellEquipBuyItemDialogProperties.MODE_SELL,this.sellItem));
                  }
                  else
                  {
                     this.sellItem(_loc4_);
                  }
               }
               break;
         }
      }
      
      private function sellItem(param1:ItemVO) : void
      {
         MafiaModel.userData.lockAllItems();
         var _loc2_:int = param1.slotId;
         var _loc3_:uint = param1.amount;
         SellItemCommand.sendCommand(_loc2_,_loc3_);
      }
      
      public function get shopScreen() : MafiaShop
      {
         return disp as MafiaShop;
      }
      
      public function get shopState() : String
      {
         return this._shopState;
      }
   }
}
