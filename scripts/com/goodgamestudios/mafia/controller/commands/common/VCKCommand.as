package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.externalLogging.ExternalLog;
   import com.goodgamestudios.externalLogging.genericLO.VersionErrorLO;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.utils.BrowserUtil;
   
   public class VCKCommand extends MafiaCommand
   {
       
      
      public function VCKCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return BasicSmartfoxConstants.S2C_VERSION_CHECK;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            env.buildNumberServer = param2.shift();
            if(layoutManager.actState == BasicLayoutManager.STATE_REGISTRATION || layoutManager.actState == BasicLayoutManager.STATE_LOGIN)
            {
               layoutManager.backgroundComponent.showVersion();
               return false;
            }
            if(env.accessKey != "" || env.pln != "" && env.sig != "")
            {
               CommandController.instance.executeCommand(BasicController.COMMAND_LOGIN);
            }
            else
            {
               layoutManager.onEndProgressbar();
               if(!MafiaModel.smartfoxClient.userForcedDisconnect && MafiaModel.localData.readLoginDataUsername() != null && MafiaModel.localData.readLoginDataUsername() != "" && MafiaModel.localData.readLoginDataPass() != null && MafiaModel.localData.readLoginDataPass() != "")
               {
                  MafiaModel.smartfoxClient.userForcedDisconnect = false;
                  MafiaModel.userData.loginName = MafiaModel.localData.readLoginDataUsername();
                  MafiaModel.userData.loginPwd = MafiaModel.localData.readLoginDataPass();
                  CommandController.instance.executeCommand(BasicController.COMMAND_LOGIN);
               }
               else
               {
                  layoutManager.state = BasicLayoutManager.STATE_LOGIN;
               }
            }
            return true;
         }
         ExternalLog.logger.log(new VersionErrorLO(param1,env.versionText),"VCKCommand.as");
         layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_versioncheck_error"),MafiaModel.languageData.getTextById("generic_versioncheck_errorcode_" + param1),BrowserUtil.reloadPage));
         return false;
      }
   }
}
