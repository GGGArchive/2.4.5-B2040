package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaSellEquipBuyItemDialogProperties;
   import com.goodgamestudios.mafia.vo.items.components.StackableComponent;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   
   public class MafiaSellEquipBuyItemDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaSellEquipBuyItemDialog";
       
      
      private var _amount:int;
      
      public function MafiaSellEquipBuyItemDialog(param1:Sprite)
      {
         super(param1);
         this.standardDialog.bg.gotoAndStop(2);
      }
      
      override public function show() : void
      {
         super.show();
         this._amount = this.standardDialogProperties.item.amount;
         switch(this.standardDialogProperties.mode)
         {
            case MafiaSellEquipBuyItemDialogProperties.MODE_BUY:
               break;
            case MafiaSellEquipBuyItemDialogProperties.MODE_SELL:
               this.standardDialog.btn_yes.label = MafiaModel.languageData.getTextById("MafiaStackableDialog_sell_title");
               this.standardDialog.txt_title.text = MafiaModel.languageData.getTextById("MafiaStackableDialog_sell_title");
               this.standardDialog.txt_copy.text = MafiaModel.languageData.getTextById("MafiaStackableDialog_sell_copy_1",[this._amount]);
               this.standardDialog.sellLayer.visible = true;
               break;
            case MafiaSellEquipBuyItemDialogProperties.MODE_EQUIP:
               this.standardDialog.btn_yes.label = MafiaModel.languageData.getTextById("MafiaStackableDialog_equip_title");
               this.standardDialog.txt_title.text = MafiaModel.languageData.getTextById("MafiaStackableDialog_equip_title");
               this.standardDialog.txt_copy.text = MafiaModel.languageData.getTextById("MafiaStackableDialog_equip_copy_1",[this._amount]);
               this.standardDialog.sellLayer.visible = false;
               if(MafiaTutorialController.getInstance().isActive)
               {
                  trace(MafiaTutorialController.getInstance().tutorialState);
                  switch(MafiaTutorialController.getInstance().tutorialState)
                  {
                     case MafiaTutorialController.TUT_STATE_INVENTORY_DRAG_DYNAMITE:
                        MafiaTutorialController.getInstance().setStep(MafiaTutorialController.TUT_STATE_SELECT_AMOUNT);
                        this.standardDialog.btn_yes.addChild(MafiaTutorialController.getInstance().tutorialArrow);
                        MafiaTutorialController.getInstance().mirrorArrow();
                  }
               }
         }
         this.standardDialog.btn_no.label = MafiaModel.languageData.getTextById("generic_btn_cancel");
         this.standardDialog.btn_close.toolTipText = MafiaModel.languageData.getTextById("generic_btn_close");
         this.standardDialog.btn_max.toolTipText = MafiaModel.languageData.getTextById("MafiaStackableDialog_btn_max");
         this.showAmount(this._amount);
      }
      
      private function showAmount(param1:int) : void
      {
         this.standardDialog.txt_amount.text = param1.toString();
         this.standardDialog.sellLayer.txt_c1.text = param1 * (this.standardDialogProperties.item.saleCash / this.standardDialogProperties.item.amount);
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.target == this.standardDialog.txt_amount)
         {
            if(isNaN(Number(this.standardDialog.txt_amount.text)))
            {
               this.standardDialog.txt_amount.text = this._amount.toString();
               return;
            }
            if(this.standardDialog.txt_amount.text.toString().indexOf(".") != -1)
            {
               this.standardDialog.txt_amount.text = this._amount.toString();
               return;
            }
            if(int(this.standardDialog.txt_amount.text) > this.standardDialogProperties.item.amount)
            {
               this.standardDialog.txt_amount.text = this.standardDialogProperties.item.amount.toString();
               return;
            }
            if(int(this.standardDialog.txt_amount.text) < 1)
            {
               this.standardDialog.txt_amount.text = String(1);
               return;
            }
            this._amount = int(this.standardDialog.txt_amount.text);
            this.showAmount(this._amount);
         }
         if(param1.keyCode == Keyboard.ENTER)
         {
            if(this.standardDialog.txt_amount.text.length > 0)
            {
               (this.standardDialogProperties.item.getComponent(StackableComponent) as StackableComponent).amount = this._amount;
               if(this.standardDialogProperties.functionYes != null)
               {
                  this.standardDialogProperties.functionYes(this.standardDialogProperties.item);
               }
               hide();
            }
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_yes:
               (this.standardDialogProperties.item.getComponent(StackableComponent) as StackableComponent).amount = this._amount;
               if(this.standardDialogProperties.functionYes != null)
               {
                  this.standardDialogProperties.functionYes(this.standardDialogProperties.item);
               }
               hide();
               break;
            case this.standardDialog.btn_close:
            case this.standardDialog.btn_no:
               if(MafiaTutorialController.getInstance().isActive)
               {
                  switch(MafiaTutorialController.getInstance().tutorialState)
                  {
                     case MafiaTutorialController.TUT_STATE_SELECT_AMOUNT:
                        return;
                  }
               }
               hide();
               if(this.standardDialogProperties.functionNo != null)
               {
                  this.standardDialogProperties.functionNo(null);
               }
               break;
            case this.standardDialog.btn_max:
               this._amount = this.standardDialogProperties.item.amount;
               this.showAmount(this._amount);
               break;
            case this.standardDialog.btn_decrease:
               if(this._amount > 1)
               {
                  this._amount--;
               }
               this.showAmount(this._amount);
               break;
            case this.standardDialog.btn_increase:
               if(this._amount < this.standardDialogProperties.item.amount)
               {
                  this._amount++;
               }
               this.showAmount(this._amount);
         }
      }
      
      protected function get standardDialogProperties() : MafiaSellEquipBuyItemDialogProperties
      {
         return properties as MafiaSellEquipBuyItemDialogProperties;
      }
      
      protected function get standardDialog() : MafiaSellEquipBuyItem
      {
         return disp as MafiaSellEquipBuyItem;
      }
   }
}
