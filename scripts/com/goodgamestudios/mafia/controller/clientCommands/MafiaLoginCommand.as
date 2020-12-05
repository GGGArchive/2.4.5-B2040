package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.controller.clientCommands.BasicLoginCommand;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   
   public class MafiaLoginCommand extends BasicLoginCommand
   {
       
      
      public function MafiaLoginCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         if(this.env.pln != "" && this.env.sig != "")
         {
            BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_LOGIN_SOCIAL,[this.env.pln,this.env.sig,BasicModel.smartfoxClient.connectionTime,BasicModel.smartfoxClient.roundTripTime,this.env.referrer,this.env.networkId,this.env.accountId]);
         }
         else
         {
            BasicModel.localData.saveInstanceId(BasicModel.instanceProxy.selectedInstanceVO.instanceId);
            BasicController.getInstance().sendServerMessageAndWait(BasicSmartfoxConstants.C2S_LOGIN,[BasicModel.userData.loginName,BasicModel.userData.loginPwd,GGSCountryController.instance.currentCountry.ggsLanguageCode,BasicModel.smartfoxClient.connectionTime,BasicModel.smartfoxClient.roundTripTime,this.env.accountId],BasicSmartfoxConstants.S2C_LOGIN);
         }
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
