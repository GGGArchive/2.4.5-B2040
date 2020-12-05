package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaPolicePostBailDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaPolicePostBailDialog";
       
      
      public function MafiaPolicePostBailDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.dialog.txt_title.text = MafiaModel.languageData.getTextById("MafiaPolice_BailDialog_title");
         this.dialog.txt_info.text = MafiaModel.languageData.getTextById("MafiaPolice_BailDialog_copy_1");
         this.dialog.txt_penalty.text = MafiaModel.userData.policeData.getEffectDescription();
         this.dialog.btn_pay.label = MafiaModel.languageData.getTextById("MafiaPolice_BailDialog_btn_bail");
         this.dialog.btn_pay.goldInfoTimeText = String(MafiaModel.userData.policeData.activeEffectBailCost);
         this.dialog.btn_pay.goldInfoResizing = true;
         this.dialog.btn_pay.goldInfoVisible = true;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.dialog.btn_pay:
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_POST_BAIL,[]);
               hide();
               break;
            case this.dialog.btn_close:
               hide();
         }
      }
      
      protected function get dialog() : MafiaPolicePostBail
      {
         return disp as MafiaPolicePostBail;
      }
   }
}
