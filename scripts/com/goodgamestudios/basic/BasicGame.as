package com.goodgamestudios.basic
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicAddExtraCurrencyCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicChangeCountryCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicCheckMaintenanceCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicConnectClientCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicConnectToInstanceVOCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicConnectionFailedCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicConnectionLostCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicConnectionTimeoutCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicDestroyGameCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicExtensionResponseCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInitServerCommands;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInitalizeControllerCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInviteFriendCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInviteFriendJsonCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicJoinedRoomCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicLoginCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicLoginJsonCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicLogoutCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicOnClickMoreCurrencyCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicOpenForumCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicPrepareReconnectCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicReconnectCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicRegisterJsonCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicRegisterUserCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicShowComaTeaserCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicShowRegisterDialogCommand;
   import com.goodgamestudios.basic.controller.externalInterface.ExternalInterfaceController;
   import com.goodgamestudios.basic.controller.externalInterface.JavascriptFunctionName;
   import com.goodgamestudios.basic.fb.connectlogin.BasicFacebookConnectCommand;
   import com.goodgamestudios.basic.view.BasicBackgroundComponent;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.utils.BrowserUtil;
   import com.google.analytics.AnalyticsTracker;
   import com.google.analytics.GATracker;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class BasicGame extends Sprite
   {
       
      
      protected var preloaderView:BasicBackgroundComponent;
      
      protected var isInitializing:Boolean = false;
      
      protected var sessionStart:Number;
      
      protected var currentState:String = "not_set";
      
      protected var firstSessionCloseMessage:String = "";
      
      public function BasicGame(param1:BasicBackgroundComponent)
      {
         super();
         this.preloaderView = param1;
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.callAnalyticsTracking();
         ExternalInterfaceController.instance.executeJavaScriptFunction(JavascriptFunctionName.ON_LOAD_COMPLETE);
         if(!this.isInitializing)
         {
            this.isInitializing = true;
            stage.stageFocusRect = false;
            this.sessionStart = getTimer();
            BrowserUtil.addLanguageCallback(this.getLanguageCallback);
            this.registerCommands();
            this.initializeGame();
            BasicLanguageFontManager.getInstance().initFontSwf();
         }
      }
      
      protected function registerCommands() : void
      {
         BasicController.init(BasicEnvironmentGlobals);
         CommandController.instance.registerCommand(BasicController.COMMAND_EXTENSION_RESPONSE,BasicExtensionResponseCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INIT_SERVERCOMMANDS,BasicInitServerCommands);
         CommandController.instance.registerCommand(BasicController.COMMAND_LOGIN,BasicLoginCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_LOGOUT,BasicLogoutCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECTION_LOST,BasicConnectionLostCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INITALIZE_CONTROLLER,BasicInitalizeControllerCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_REGISTER_USER,BasicRegisterUserCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_RECONNECT,BasicReconnectCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_OPEN_FORUM,BasicOpenForumCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_DESTROY_GAME,BasicDestroyGameCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_SHOW_REGISTER_DIALOG,BasicShowRegisterDialogCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_SHOW_COMA_TEASER,BasicShowComaTeaserCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_JOINED_ROOM,BasicJoinedRoomCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECTION_FAILED,BasicConnectionFailedCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECTION_TIMEOUT,BasicConnectionTimeoutCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_PREPARE_RECONNECT,BasicPrepareReconnectCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_ADD_EXTRA_CURRENCY,BasicAddExtraCurrencyCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_ON_CLICK_MORE_CURRENY,BasicOnClickMoreCurrencyCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_LOGIN_JSON,BasicLoginJsonCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_REGISTER_USER_JSON,BasicRegisterJsonCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INVITE_FRIEND,BasicInviteFriendCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INVITE_FRIEND_JSON,BasicInviteFriendJsonCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CHANGE_COUNTRY,BasicChangeCountryCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CHECK_MAINTENANCE,BasicCheckMaintenanceCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECT_TO_INSTANCEVO,BasicConnectToInstanceVOCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECT_CLIENT,BasicConnectClientCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_FACEBOOK_CONNECT_LOGIN,BasicFacebookConnectCommand);
      }
      
      private function callAnalyticsTracking() : void
      {
         var tracker:AnalyticsTracker = null;
         try
         {
            tracker = new GATracker(this,"UA-9219771-1","AS3",false);
            tracker.trackPageview(this.env.analyticsTrackingPath);
            return;
         }
         catch(e:Error)
         {
            trace("Error while calling analytics tracking!");
            return;
         }
      }
      
      private function getLanguageCallback() : String
      {
         return GGSCountryController.instance.currentCountry.ggsLanguageCode;
      }
      
      protected function initializeGame() : void
      {
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
