package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   
   public class BasicRegisterJsonCommand extends SimpleCommand
   {
       
      
      public function BasicRegisterJsonCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:Array = param1 as Array;
         var _loc3_:String = _loc2_.shift();
         var _loc4_:String = _loc2_.shift();
         var _loc5_:Object = _loc2_.shift() as Object;
         _loc5_.mail = _loc3_;
         _loc5_.pw = _loc4_;
         _loc5_.referrer = EnvGlobalsHandler.globals.referrer;
         _loc5_.lang = GGSCountryController.instance.currentCountry.ggsLanguageCode;
         _loc5_.did = EnvGlobalsHandler.globals.distributorId;
         _loc5_.connectTime = BasicModel.smartfoxClient.connectionTime;
         _loc5_.ping = BasicModel.smartfoxClient.roundTripTime;
         _loc5_.accountId = EnvGlobalsHandler.globals.accountId;
         _loc5_.campainPId = EnvGlobalsHandler.globals.campainVars.partnerId;
         _loc5_.campainCr = EnvGlobalsHandler.globals.campainVars.creative;
         _loc5_.campainPl = EnvGlobalsHandler.globals.campainVars.placement;
         _loc5_.campainKey = EnvGlobalsHandler.globals.campainVars.keyword;
         _loc5_.campainNW = EnvGlobalsHandler.globals.campainVars.network;
         _loc5_.campainLP = EnvGlobalsHandler.globals.campainVars.lp;
         _loc5_.campainCId = EnvGlobalsHandler.globals.campainVars.channelId;
         _loc5_.campainTS = EnvGlobalsHandler.globals.campainVars.trafficSource;
         _loc5_.adid = EnvGlobalsHandler.globals.campainVars.aid;
         _loc5_.camp = EnvGlobalsHandler.globals.campainVars.camp;
         _loc5_.adgr = EnvGlobalsHandler.globals.campainVars.adgr;
         _loc5_.matchtype = EnvGlobalsHandler.globals.campainVars.matchtype;
         BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_REGISTER,[com.adobe.serialization.json.JSON.encode(_loc5_)]);
         BasicModel.userData.loginPwd = _loc4_;
      }
   }
}
