package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.event.model.MafiaOfferEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.MafiaSpecialOfferData;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaBonusDialogProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaBonusDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaBonusDialog";
       
      
      private var offerid:int;
      
      private const GOLDEXAMPLE:int = 15000;
      
      public function MafiaBonusDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.bonusDialog.btn_buy.label = MafiaModel.languageData.getTextById("generic_btn_topayment");
         controller.addEventListener(MafiaOfferEvent.CHANGE_OFFERENDTIME,this.onOfferTime);
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaOfferEvent.CHANGE_OFFERENDTIME,this.onOfferTime);
         super.removeEvents();
      }
      
      override protected function applyProperties() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         this.offerid = this.bonusDialogProperties.bonus.offerID;
         switch(this.offerid)
         {
            case MafiaSpecialOfferData.ID_PRIMETIME:
               TextFieldHelper.changeTextFromatSizeByTextWidth(24,this.bonusDialog.txt_title,MafiaModel.languageData.getTextById("primetime_title"));
               this.bonusDialog.txt_time.text = MafiaModel.languageData.getTextById("promotion_discount_time",[this.bonusDialogProperties.bonus.offerEndTime]);
               _loc1_ = MafiaModel.languageData.getTextById("primetime_copy1");
               _loc2_ = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_currency2");
               _loc1_ = _loc1_ + ("\n" + MafiaModel.languageData.getTextById("primetime_copy2",[this.bonusDialogProperties.bonus.offerEndTime,this.bonusDialogProperties.bonus.percentGold,_loc2_]));
               _loc1_ = _loc1_ + ("\n" + MafiaModel.languageData.getTextById("primetime_copy3",[this.GOLDEXAMPLE,_loc2_,this.GOLDEXAMPLE + this.GOLDEXAMPLE / 100 * Number(this.bonusDialogProperties.bonus.percentGold)]));
               TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.bonusDialog.txt_copy,_loc1_,7);
               this.bonusDialog.txt_bonus.text = MafiaModel.languageData.getTextById("promotion_bonus",[this.bonusDialogProperties.bonus.percentGold]);
               break;
            case MafiaSpecialOfferData.ID_REGBONUS:
               TextFieldHelper.changeTextFromatSizeByTextWidth(24,this.bonusDialog.txt_title,MafiaModel.languageData.getTextById("generic_payment_discount_title"));
               this.bonusDialog.txt_time.text = MafiaModel.languageData.getTextById("generic_payment_discount_time",[this.bonusDialogProperties.bonus.offerEndTime]);
               this.bonusDialog.txt_bonus.text = MafiaModel.languageData.getTextById("promotion_bonus",[this.bonusDialogProperties.bonus.percentGold]);
               TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.bonusDialog.txt_copy,MafiaModel.languageData.getTextById("generic_payment_discount_copy",[this.bonusDialogProperties.bonus.percentGold]),7);
               break;
            case MafiaSpecialOfferData.ID_PRICECHANGE:
               this.bonusDialog.txt_bonus.text = "";
               TextFieldHelper.changeTextFromatSizeByTextWidth(24,this.bonusDialog.txt_title,MafiaModel.languageData.getTextById("generic_payment_discount_title"));
               this.bonusDialog.txt_copy.text = MafiaModel.languageData.getTextById("generic_payment_newPrices");
         }
         if(this.bonusDialogProperties.bonus.isUnderPrimeTimeTime == true)
         {
            this.bonusDialog.redLines.gotoAndPlay(2);
         }
      }
      
      private function onOfferTime(param1:MafiaOfferEvent) : void
      {
         switch(this.offerid)
         {
            case MafiaSpecialOfferData.ID_PRICECHANGE:
               this.bonusDialog.txt_time.text = "";
               break;
            default:
               this.bonusDialog.txt_time.text = MafiaModel.languageData.getTextById("generic_payment_discount_time",[param1.params[0]]);
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.bonusDialog.btn_close:
               controller.removeEventListener(MafiaOfferEvent.CHANGE_OFFERENDTIME,this.onOfferTime);
               hide();
               break;
            case this.bonusDialog.btn_buy:
               if(!env.isBeta)
               {
                  controller.onClickMoreMoney(null);
               }
         }
      }
      
      protected function get bonusDialogProperties() : MafiaBonusDialogProperties
      {
         return properties as MafiaBonusDialogProperties;
      }
      
      private function get bonusDialog() : BonusDialog
      {
         return disp as BonusDialog;
      }
   }
}
