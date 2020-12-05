package com.goodgamestudios.basic.model.components
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import flash.external.ExternalInterface;
   
   public class BasicSocialData
   {
      
      public static const INVITE:String = "invite";
      
      public static const RELOAD:String = "reload";
      
      public static const EXTERNAL_SET_DATA:String = "setData";
      
      public static const EXTERNAL_TRIGGER_ERROR:String = "triggerError";
       
      
      public function BasicSocialData()
      {
         super();
      }
      
      public function inviteFriends() : void
      {
         if(this.env.hasNetworkBuddies)
         {
            this.externalInterface(INVITE);
         }
      }
      
      public function reloadIFrame() : void
      {
         this.externalInterface(RELOAD);
      }
      
      public function setSocialData(param1:int, param2:String) : void
      {
         this.externalInterface(BasicSocialData.EXTERNAL_SET_DATA,[param1,param2,GGSCountryController.instance.currentCountry.ggsLanguageCode,BasicModel.instanceProxy.selectedInstanceVO.instanceId,this.env.pln,this.env.gameId,this.env.networkId,this.env.buildNumberGame,this.env.buildNumberServer]);
      }
      
      protected function externalInterface(param1:String, param2:Array = null) : void
      {
         var type:String = param1;
         var params:Array = param2;
         if(!ExternalInterface.available)
         {
            return;
         }
         try
         {
            switch(type)
            {
               case INVITE:
               case RELOAD:
                  ExternalInterface.call(type);
                  break;
               case EXTERNAL_SET_DATA:
                  ExternalInterface.call(type,params);
                  break;
               case EXTERNAL_TRIGGER_ERROR:
                  ExternalInterface.call(type,params[0],params[1]);
            }
            return;
         }
         catch(error:Error)
         {
            return;
         }
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
