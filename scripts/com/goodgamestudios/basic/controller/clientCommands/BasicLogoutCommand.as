package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.externalInterface.ExternalInterfaceController;
   import com.goodgamestudios.basic.controller.externalInterface.JavascriptFunctionName;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicLogoutCommand extends SimpleCommand
   {
       
      
      public function BasicLogoutCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         EnvGlobalsHandler.globals.isFirstVisitOfGGS = false;
         EnvGlobalsHandler.globals.accountCookie.campaignData = null;
         BasicController.getInstance().onLogOut();
         BasicModel.sessionData.resetLoggedinTimer();
         BasicModel.smartfoxClient.logout();
         BasicLayoutManager.getInstance().revertFullscreen();
         ExternalInterfaceController.instance.executeJavaScriptFunction(JavascriptFunctionName.ON_LOGOUT);
      }
   }
}
