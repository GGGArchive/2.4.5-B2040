package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.constants.BasicConstants;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import flash.net.URLLoaderDataFormat;
   
   public class BasicReloadNetworkCommand extends SimpleCommand
   {
       
      
      public function BasicReloadNetworkCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         this.reloadNetworkXML();
         this.reloadInstances();
      }
      
      public function reloadNetworkXML() : void
      {
         BasicModel.basicLoaderData.appLoader.addXMLLoader(BasicConstants.NETWORK_INFO_LOADER,this.env.networkInfoUrl,URLLoaderDataFormat.BINARY,this.onReloadNetworkXML,true);
      }
      
      private function onReloadNetworkXML() : void
      {
         var _loc1_:XML = XML(BasicModel.basicLoaderData.appLoader.getLoaderData(BasicConstants.NETWORK_INFO_LOADER));
         this.env.defaultInstanceId = parseInt(_loc1_.general.defaultinstance.text());
         this.env.allowedfullscreen = _loc1_.general.allowedfullscreen == "true"?true:false;
         this.env.networknameString = _loc1_.general.networkname.text();
         this.env.loginIsKeyBased = _loc1_.general.usekeybaselogin == "true"?true:false;
         this.env.hasNetworkBuddies = _loc1_.general.networkbuddies == "true"?true:false;
         this.env.enableFeedMessages = _loc1_.general.enablefeedmessages == "true"?true:false;
         this.env.enableLonelyCow = _loc1_.general.enablelonelycow == "true"?true:false;
         this.env.requestPayByJS = _loc1_.general.requestpaybyjs == "true"?true:false;
         this.env.networkNewsByJS = _loc1_.general.networknewsbyjs == "true"?true:false;
         this.env.earnCredits = parseInt(_loc1_.general.earncredits);
         this.env.useexternallinks = _loc1_.general.useexternallinks == "true"?true:false;
         this.env.invitefriends = _loc1_.general.invitefriends == "true"?true:false;
         this.env.maxUsernameLength = parseInt(_loc1_.general.maxusernamelength.text());
         this.env.usePayment = _loc1_.general.usepayment == "true"?true:false;
         this.env.showVersion = _loc1_.general.showversion == "true"?true:false;
         delete _loc1_.instance[0];
         CommandController.instance.executeCommand(BasicController.COMMAND_UPDATE_NETWORK,BasicNetworkUpdateCommand);
      }
      
      public function reloadInstances() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<InstanceVO> = null;
         var _loc5_:InstanceVO = null;
         var _loc1_:InstanceVO = BasicModel.instanceProxy.getInstanceVOByID(this.env.defaultInstanceId);
         var _loc2_:String = "default";
         if(_loc1_)
         {
            _loc2_ = _loc1_.defaultcountry;
         }
         if(_loc2_ != "default" && _loc2_ != "")
         {
            GGSCountryController.instance.selectedCountry = _loc2_;
         }
         if(this.env.presetInstanceId == 0)
         {
            _loc4_ = BasicModel.instanceProxy.getInstancesForActualCountry();
            _loc4_.length = 0;
            if(_loc4_.length > 0)
            {
               _loc5_ = _loc4_[0];
               if(!_loc5_.isInternationalInstance)
               {
                  _loc3_ = _loc5_.instanceId;
               }
               else
               {
                  _loc3_ = this.env.defaultInstanceId;
               }
            }
         }
         else
         {
            this.env.forceInstanceConnect = true;
            _loc3_ = this.env.presetInstanceId;
         }
         BasicModel.instanceProxy.selectedInstanceVO = BasicModel.instanceProxy.getInstanceVOByID(_loc3_);
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
