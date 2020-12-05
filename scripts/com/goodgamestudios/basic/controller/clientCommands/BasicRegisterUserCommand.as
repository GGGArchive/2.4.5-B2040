package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.misc.ValueCollection;
   
   public class BasicRegisterUserCommand extends SimpleCommand
   {
       
      
      public function BasicRegisterUserCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:ValueCollection = param1 as ValueCollection;
         var _loc3_:String = _loc2_.currStringValue;
         var _loc4_:String = _loc2_.currStringValue;
         BasicController.getInstance().sendServerMessageAndWait(BasicSmartfoxConstants.C2S_REGISTER,[_loc3_,_loc4_,EnvGlobalsHandler.globals.referrer,EnvGlobalsHandler.globals.distributorId,BasicModel.smartfoxClient.connectionTime,BasicModel.smartfoxClient.roundTripTime,EnvGlobalsHandler.globals.accountId,EnvGlobalsHandler.globals.campainVars.partnerId,EnvGlobalsHandler.globals.campainVars.creative,EnvGlobalsHandler.globals.campainVars.placement,EnvGlobalsHandler.globals.campainVars.keyword,EnvGlobalsHandler.globals.campainVars.network,EnvGlobalsHandler.globals.campainVars.lp,EnvGlobalsHandler.globals.campainVars.channelId,EnvGlobalsHandler.globals.campainVars.trafficSource],BasicSmartfoxConstants.S2C_REGISTER);
         BasicModel.userData.loginPwd = _loc4_;
      }
   }
}
