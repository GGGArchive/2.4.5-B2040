package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   
   public class BasicLoginJsonCommand extends SimpleCommand
   {
       
      
      public function BasicLoginJsonCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         if(EnvGlobalsHandler.globals.pln != "" && EnvGlobalsHandler.globals.sig != "")
         {
            param1.PLN = EnvGlobalsHandler.globals.pln;
            param1.KEY = EnvGlobalsHandler.globals.sig;
            param1.connectTime = BasicModel.smartfoxClient.connectionTime;
            param1.ping = BasicModel.smartfoxClient.roundTripTime;
            param1.referrer = EnvGlobalsHandler.globals.referrer;
            param1.networkID = EnvGlobalsHandler.globals.networkId;
            BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_LOGIN_SOCIAL,[com.adobe.serialization.json.JSON.encode(param1)]);
         }
         else
         {
            param1.name = BasicModel.userData.loginName;
            param1.pw = BasicModel.userData.loginPwd;
            param1.lang = GGSCountryController.instance.currentCountry.ggsLanguageCode;
            param1.did = EnvGlobalsHandler.globals.distributorId;
            param1.connectTime = BasicModel.smartfoxClient.connectionTime;
            param1.ping = BasicModel.smartfoxClient.roundTripTime;
            param1.accountId = EnvGlobalsHandler.globals.accountId;
            BasicController.getInstance().sendServerMessageAndWait(BasicSmartfoxConstants.C2S_LOGIN,[com.adobe.serialization.json.JSON.encode(param1)],BasicSmartfoxConstants.C2S_LOGIN);
         }
      }
   }
}
