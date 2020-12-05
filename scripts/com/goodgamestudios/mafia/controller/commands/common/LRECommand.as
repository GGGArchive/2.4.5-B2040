package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.basic.constants.CommonGameStates;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.event.BasicUserEvent;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import flash.external.ExternalInterface;
   
   public class LRECommand extends MafiaCommand
   {
       
      
      public function LRECommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return BasicSmartfoxConstants.S2C_REGISTER;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         switch(param1)
         {
            case 0:
               layoutManager.hideAllPanels();
               MafiaModel.userData.userID = param2[1];
               MafiaModel.userData.playerID = param2[2];
               MafiaModel.localData.saveLoginData(MafiaModel.userData.loginName,MafiaModel.userData.loginPwd,true);
               MafiaModel.localData.saveCountryData(GGSCountryController.instance.currentCountry.ggsCountryCode);
               controller.dispatchEvent(new BasicUserEvent(BasicUserEvent.REGISTERED));
               CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.REGISTERED);
               if(env.campainVars.isValid() && ExternalInterface.available)
               {
                  ExternalInterface.call("onRegisterComplete");
               }
               MafiaModel.localData.saveCurrentTopInventoryRow(1);
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_GET_ALLPLAYERDATA,[]);
               layoutManager.onEndProgressbar();
               return true;
            case 4:
            case 5:
               param2.shift();
               controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_NAME_OFFER,[param2.shift().split("#"),param1]));
               break;
            case 6:
               controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_WRONG_REGISTER_PARAMS,[MafiaModel.languageData.getTextById("generic_register_error_accountalreadyexists")]));
               break;
            case 7:
               controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_WRONG_REGISTER_PARAMS,[MafiaModel.languageData.getTextById("generic_register_error_invalidemail")]));
               break;
            case 9:
               controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_WRONG_REGISTER_PARAMS,[MafiaModel.languageData.getTextById("generic_register_password_copy")]));
               break;
            case 10:
               controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_WRONG_REGISTER_PARAMS,[MafiaModel.languageData.getTextById("generic_register_passwordshort_copy")]));
         }
         return false;
      }
   }
}
