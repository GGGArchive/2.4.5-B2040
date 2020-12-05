package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.externalInterface.ExternalInterfaceController;
   import com.goodgamestudios.basic.controller.externalInterface.vo.JavascriptCallOnLoginCompleteFactory;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.tracking.ClientLoginTrackingEvent;
   import com.goodgamestudios.tracking.TrackingCache;
   
   public final class BasicSendClientLoginTrackingCommand extends SimpleCommand
   {
       
      
      public function BasicSendClientLoginTrackingCommand()
      {
         super(true);
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc3_:ClientLoginTrackingEvent = null;
         var _loc2_:IEnvironmentGlobals = param1 as IEnvironmentGlobals;
         if(!_loc2_.isLocal)
         {
            _loc3_ = TrackingCache.getInstance().getEvent(ClientLoginTrackingEvent.EVENT_ID) as ClientLoginTrackingEvent;
            _loc3_.lang = GGSCountryController.instance.currentCountry.ggsLanguageCode;
            _loc3_.gameId = _loc2_.gameId;
            _loc3_.instanceID = BasicModel.instanceProxy.selectedInstanceVO.instanceId;
            _loc3_.networkId = _loc2_.networkId;
            _loc3_.playerID = BasicModel.userData.playerID;
            TrackingCache.getInstance().sendEvent(ClientLoginTrackingEvent.EVENT_ID);
            ExternalInterfaceController.instance.executeJavaScriptFunction(new JavascriptCallOnLoginCompleteFactory());
         }
      }
   }
}
