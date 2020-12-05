package com.goodgamestudios.mafia.controller.commands.police
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoCashDialog;
   
   public class POBCommand extends MafiaCommand
   {
       
      
      public function POBCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_POST_BAIL;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         switch(param1)
         {
            case 0:
               MafiaModel.userData.policeData.clearActiveEffect();
               return true;
            case 1:
               layoutManager.showDialog(MafiaNoCashDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaNoCashDialog_title"),MafiaModel.languageData.getTextById("MafiaNoCashForBail_copy") + "\n" + MafiaModel.languageData.getTextById("MafiaNoCashForBuyItem_copy_2")));
               break;
            case 2:
         }
         return false;
      }
   }
}
