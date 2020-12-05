package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.commands.shop.BuyItemCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.NewBasicStandartButton;
   import com.goodgamestudios.mafia.view.dialogs.breakingTheLaw.MafiaBreakingTheLawOverviewComponent;
   import com.goodgamestudios.mafia.view.screens.shops.MafiaBreakingTheLawShopComponent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MafiaBreakingTheLawDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaBreakingTheLawDialog";
       
      
      protected var componentOverview:MafiaBreakingTheLawOverviewComponent;
      
      protected var componentShop:MafiaBreakingTheLawShopComponent;
      
      public function MafiaBreakingTheLawDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.componentOverview = new MafiaBreakingTheLawOverviewComponent(this.dialog.component_overview);
         this.componentShop = new MafiaBreakingTheLawShopComponent(this.dialog.component_shop);
         this.dialog.component_overview.txt_tabShop.mouseEnabled = false;
         this.dialog.component_shop.txt_tabOverview.mouseEnabled = false;
         this.dialog.btn_close.toolTipText = MafiaModel.languageData.getTextById("generic_btn_close");
         this.dialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_okay");
         this.componentOverview.fill(MafiaModel.specialEvent.breakingTheLawEvent);
         this.componentOverview.registerEvents();
         this.componentShop.fill(MafiaModel.specialEvent.breakingTheLawEvent);
         controller.addEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onSpecialEventIsOver);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_CURRENCY,this.onChangeCurrency);
      }
      
      override public function hide() : void
      {
         super.hide();
         this.componentShop.destroy();
         this.componentOverview.destroy();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.componentShop.destroy();
         this.componentOverview.destroy();
      }
      
      protected function onSpecialEventIsOver(param1:Event) : void
      {
         this.hide();
      }
      
      override public function updatePosition() : void
      {
         super.updatePosition();
         disp.y = disp.y - 150 * layoutManager.scaleFactor;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:NewBasicStandartButton = param1.target as NewBasicStandartButton;
         if(_loc2_ != null && !_loc2_.enabled)
         {
            return;
         }
         switch(param1.target)
         {
            case this.dialog.component_overview.btn_tabShop:
               this.dialog.component_overview.visible = false;
               this.dialog.component_shop.visible = true;
               this.componentShop.fill(MafiaModel.specialEvent.breakingTheLawEvent);
               break;
            case this.dialog.component_shop.btn_tabOverview:
               this.dialog.component_overview.visible = true;
               this.dialog.component_shop.visible = false;
               this.componentOverview.fill(MafiaModel.specialEvent.breakingTheLawEvent);
               break;
            case this.dialog.component_shop.shop0.btn_buy:
               BuyItemCommand.sendCommand(ItemLocation.ShopBreakingTheLaw,0,0);
               break;
            case this.dialog.component_shop.shop1.btn_buy:
               BuyItemCommand.sendCommand(ItemLocation.ShopBreakingTheLaw,1,0);
               break;
            case this.dialog.component_shop.shop2.btn_buy:
               BuyItemCommand.sendCommand(ItemLocation.ShopBreakingTheLaw,2,0);
               break;
            case this.dialog.btn_close:
            case this.dialog.btn_ok:
               this.hide();
         }
         super.onClick(param1);
         updateAllTextFields();
      }
      
      protected function onChangeCurrency(param1:Event) : void
      {
         this.componentShop.updateCurrency();
         this.componentOverview.updateCurrency();
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onSpecialEventIsOver);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_CURRENCY,this.onChangeCurrency);
      }
      
      protected function get dialog() : EventDialog_8
      {
         return disp as EventDialog_8;
      }
   }
}
