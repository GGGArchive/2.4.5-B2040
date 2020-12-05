package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   
   public class FDBCommand extends MafiaCommand
   {
       
      
      public function FDBCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_FEEDBACK;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaShoutboxDialog_title"),MafiaModel.languageData.getTextById("MafiaMailScreen_copy_8")));
            return true;
         }
         return false;
      }
   }
}
