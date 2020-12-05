package com.goodgamestudios.mafia.controller.commands.gang
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoCashDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   
   public class HGACommand extends MafiaCommand
   {
       
      
      public function HGACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_HIRE_GANGMEMBER;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         switch(param1)
         {
            case 0:
               return true;
            case 1:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForBuyItem_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               return false;
            case 7:
               layoutManager.showDialog(MafiaNoCashDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaNoCashDialog_title"),MafiaModel.languageData.getTextById("MafiaNoCashForBuyItem_copy") + "\n" + MafiaModel.languageData.getTextById("MafiaNoCashForBuyItem_copy_2")));
         }
         return false;
      }
   }
}
