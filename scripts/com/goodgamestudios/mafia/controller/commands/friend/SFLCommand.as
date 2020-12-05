package com.goodgamestudios.mafia.controller.commands.friend
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   
   public class SFLCommand extends MafiaCommand
   {
       
      
      public function SFLCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_SEND_FRIEND_LINK;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            layoutManager.hideAllDialogs();
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_inviteFriends"),MafiaModel.languageData.getTextById("MafiaInviteFriendDialog_copy_8")));
            return true;
         }
         if(param1 == 1)
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_inviteFriends"),MafiaModel.languageData.getTextById("generic_register_emailwrong_copy")));
            return false;
         }
         if(param1 == 2)
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_inviteFriends"),MafiaModel.languageData.getTextById("generic_register_error_accountalreadyexists")));
            return false;
         }
         if(param1 == 3)
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_inviteFriends"),MafiaModel.languageData.getTextById("generic_register_namenotvalid")));
            return false;
         }
         return false;
      }
   }
}
