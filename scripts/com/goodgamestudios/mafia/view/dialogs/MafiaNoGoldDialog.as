package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MafiaNoGoldDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaNoGoldDialog";
       
      
      public function MafiaNoGoldDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaUserEvent.CHANGE_PAYUSER_INFO,this.onUpdatePayuserInfo);
         this.standardDialog.btn_ok.label = this.standardDialogProperties.buttonLabel_yes;
         this.standardDialog.btn_ok.enableButton = !env.isBeta;
      }
      
      override protected function applyProperties() : void
      {
         this.standardDialog.btn_close.toolTipText = this.standardDialogProperties.buttonLabel_no;
         this.standardDialog.txt_title.text = this.standardDialogProperties.title;
         this.standardDialog.txt_copy.text = this.standardDialogProperties.copy;
         if(MafiaModel.userData.hasPaymentDoppler && !MafiaModel.userData.offerData.offer)
         {
            this.standardDialog.icon_doppler.visible = true;
         }
         else
         {
            this.standardDialog.icon_doppler.visible = false;
         }
         this.alignOkButton();
      }
      
      override public function hide() : void
      {
         super.hide();
         controller.addEventListener(MafiaUserEvent.CHANGE_PAYUSER_INFO,this.onUpdatePayuserInfo);
      }
      
      private function alignOkButton() : void
      {
         var _loc1_:int = this.standardDialog.txt_copy.x + this.standardDialog.txt_copy.width - 8;
         var _loc2_:int = !!this.standardDialog.icon_doppler.visible?30:0;
         this.standardDialog.btn_ok.x = _loc1_ - _loc2_;
      }
      
      private function onUpdatePayuserInfo(param1:Event = null) : void
      {
         if(MafiaModel.userData.hasPaymentDoppler)
         {
            this.standardDialog.icon_doppler.visible = true;
            this.alignOkButton();
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_ok:
               if(!env.isBeta)
               {
                  this.hide();
                  if(this.standardDialogProperties.functionYes != null)
                  {
                     this.standardDialogProperties.functionYes(null);
                  }
               }
               break;
            case this.standardDialog.btn_close:
               this.hide();
               if(this.standardDialogProperties.functionNo != null)
               {
                  this.standardDialogProperties.functionNo(null);
               }
         }
      }
      
      protected function get standardDialogProperties() : BasicStandardYesNoDialogProperties
      {
         return properties as BasicStandardYesNoDialogProperties;
      }
      
      protected function get standardDialog() : MafiaNoGold
      {
         return disp as MafiaNoGold;
      }
   }
}
