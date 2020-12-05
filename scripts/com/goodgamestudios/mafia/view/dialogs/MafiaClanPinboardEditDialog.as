package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.controller.commands.clan.FamilyChangeBulletinBoardCommand;
   import com.goodgamestudios.mafia.event.model.MafiaClanEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class MafiaClanPinboardEditDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaClanPinboardEditDialog";
       
      
      private const MAXLINES:int = 8;
      
      private var defaultText:String;
      
      public function MafiaClanPinboardEditDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.standardDialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_register_btn_save");
         this.standardDialog.btn_cancle.label = MafiaModel.languageData.getTextById("generic_btn_cancel");
         this.defaultText = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_20");
         this.standardDialog.txt_input.addEventListener(KeyboardEvent.KEY_DOWN,this.displayKey);
         this.standardDialog.txt_input.maxChars = 600;
         this.validateSaveBtn();
      }
      
      override public function hide() : void
      {
         super.hide();
         this.standardDialog.txt_input.removeEventListener(KeyboardEvent.KEY_DOWN,this.displayKey);
      }
      
      private function validateSaveBtn() : void
      {
         if(this.standardDialog.txt_input.text == this.defaultText)
         {
            this.standardDialog.btn_ok.enableButton = false;
         }
         else
         {
            this.standardDialog.btn_ok.enableButton = true;
         }
         updateAllTextFields();
         this.standardDialog.btn_ok.update();
      }
      
      private function displayKey(param1:KeyboardEvent) : void
      {
         var _loc2_:int = 0;
         if(this.standardDialog.txt_input.numLines > this.MAXLINES)
         {
            _loc2_ = this.standardDialog.txt_input.getLineOffset(this.MAXLINES) - 1;
            this.standardDialog.txt_input.setSelection(_loc2_,_loc2_);
            this.standardDialog.txt_input.text = this.standardDialog.txt_input.text.substring(0,_loc2_);
         }
      }
      
      override protected function applyProperties() : void
      {
         if(MafiaModel.userData.userClan.pinboard_content)
         {
            this.standardDialog.txt_input.text = MafiaModel.userData.userClan.pinboard_content;
         }
         else
         {
            this.standardDialog.txt_input.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_20");
         }
         this.standardDialog.txt_title.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_22");
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.target == this.standardDialog.txt_input)
         {
            this.validateSaveBtn();
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.txt_input:
               if(this.standardDialog.txt_input.text == this.defaultText)
               {
                  this.standardDialog.txt_input.text = "";
                  this.validateSaveBtn();
               }
               break;
            case this.standardDialog.btn_close:
            case this.standardDialog.btn_cancle:
               this.hide();
               break;
            case this.standardDialog.btn_ok:
               if(param1.target.enabled)
               {
                  FamilyChangeBulletinBoardCommand.sendCommand(this.standardDialog.txt_input.text);
                  MafiaModel.userData.userClan.pinboard_content = this.standardDialog.txt_input.text;
                  MafiaModel.userData.userClan.pinboard_lastChangedBy = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_21",[MafiaModel.userData.userName]);
                  BasicController.getInstance().dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_PINBOARDDATA));
                  this.hide();
               }
         }
      }
      
      protected function get standardDialog() : ClanPinboardEdit
      {
         return disp as ClanPinboardEdit;
      }
   }
}
