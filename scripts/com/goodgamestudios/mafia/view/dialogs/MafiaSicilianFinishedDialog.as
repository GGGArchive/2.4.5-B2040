package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaSicilianFinishedDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaSicilianFinishedDialog";
       
      
      public function MafiaSicilianFinishedDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.dialog.btn_close.toolTipText = MafiaModel.languageData.getTextById("generic_btn_close");
      }
      
      override protected function applyProperties() : void
      {
         super.applyProperties();
         TextFieldHelper.changeTextFromatSizeByTextWidth(13,this.dialog.txt_header,"++ " + MafiaModel.languageData.getTextById("event_sicilianbeast_copy_21",[" ++ "]) + " ++");
         TextFieldHelper.changeTextFromatSizeByTextWidth(36,this.dialog.txt_title,MafiaModel.languageData.getTextById("event_sicilianbeast_copy_20"),2);
         this.dialog.txt_copy.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_17");
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.dialog.btn_close:
               layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               MafiaDialogHandler.getInstance().registerDialogs(MafiaSicilianThankYouDialog.NAME,null,true,BasicDialogHandler.PRIORITY_MIDDLE);
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_ACTIVE_EVENTS,[Constants_SpecialEvents.ID_SICILIAN]);
               hide();
         }
      }
      
      protected function get dialog() : EventDialog_5
      {
         return disp as EventDialog_5;
      }
   }
}
