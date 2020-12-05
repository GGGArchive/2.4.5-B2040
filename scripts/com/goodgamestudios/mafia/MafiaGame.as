package com.goodgamestudios.mafia
{
   import com.goodgamestudios.basic.BasicGame;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicAddExtraCurrencyCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicInviteFriendCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicOnClickMoreCurrencyCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicPrepareReconnectCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicShowComaTeaserCommand;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.components.BasicSessionData;
   import com.goodgamestudios.basic.view.BasicBackgroundComponent;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.mafia.constants.Constants_CliendCommands;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaConnectionFailedCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaConnectionLostCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaConnectionTimeoutCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaDestroyGameCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaExecuteCheatCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaExecuteLayoutStateCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaExtensionResponseCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaInitLayoutStatesCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaInitServerCommandsCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaInitalizeControllerCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaJoinedRoomCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaLoginCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaLogoutCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaReconnectCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaRegisterUserCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaSendFriendLinkCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaBuddyList;
   import com.goodgamestudios.mafia.model.components.MafiaGoldConstantsData;
   import com.goodgamestudios.mafia.model.components.MafiaOtherUserData;
   import com.goodgamestudios.mafia.model.components.MafiaOwnUserData;
   import com.goodgamestudios.mafia.model.components.MafiaSmartfoxClient;
   import com.goodgamestudios.mafia.model.components.MafiaSocialData;
   import com.goodgamestudios.mafia.model.components.MafiaSpecialEventData;
   import com.goodgamestudios.mafia.model.components.MafiaTipData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class MafiaGame extends BasicGame
   {
       
      
      public function MafiaGame(param1:BasicBackgroundComponent)
      {
         super(param1);
      }
      
      override protected function registerCommands() : void
      {
         BasicController.init(MafiaEnvironmentGlobals);
         CommandController.instance.registerCommand(BasicController.COMMAND_JOINED_ROOM,MafiaJoinedRoomCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECTION_LOST,MafiaConnectionLostCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECTION_FAILED,MafiaConnectionFailedCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECTION_TIMEOUT,MafiaConnectionTimeoutCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_EXTENSION_RESPONSE,MafiaExtensionResponseCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INIT_SERVERCOMMANDS,MafiaInitServerCommandsCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INITALIZE_CONTROLLER,MafiaInitalizeControllerCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_DESTROY_GAME,MafiaDestroyGameCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_LOGIN,MafiaLoginCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_LOGOUT,MafiaLogoutCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_REGISTER_USER,MafiaRegisterUserCommand);
         CommandController.instance.registerCommand(Constants_CliendCommands.COMMAND_SENDFRIENDLINK,MafiaSendFriendLinkCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_PREPARE_RECONNECT,BasicPrepareReconnectCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_RECONNECT,MafiaReconnectCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INVITE_FRIEND,BasicInviteFriendCommand);
         CommandController.instance.registerCommand(Constants_CliendCommands.COMMAND_EXECUTE_CHEATS,MafiaExecuteCheatCommand);
         CommandController.instance.registerCommand(Constants_CliendCommands.COMMAND_INIT_LAYOUT_STATES,MafiaInitLayoutStatesCommand);
         CommandController.instance.registerCommand(Constants_CliendCommands.COMMAND_EXECUTE_LAYOUT_STATES,MafiaExecuteLayoutStateCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_SHOW_COMA_TEASER,BasicShowComaTeaserCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_ADD_EXTRA_CURRENCY,BasicAddExtraCurrencyCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_ON_CLICK_MORE_CURRENY,BasicOnClickMoreCurrencyCommand);
      }
      
      override protected function initializeGame() : void
      {
         if(!MafiaModel.smartfoxClient)
         {
            MafiaModel.smartfoxClient = new MafiaSmartfoxClient();
         }
         BasicModel.sessionData = new BasicSessionData();
         MafiaModel.userData = new MafiaOwnUserData();
         MafiaModel.otherUserData = new MafiaOtherUserData();
         MafiaModel.buddyList = new MafiaBuddyList(stage.loaderInfo.parameters.buddylist);
         MafiaModel.socialData = new MafiaSocialData(BasicController.getInstance());
         MafiaModel.tipData = new MafiaTipData();
         MafiaModel.specialEvent = new MafiaSpecialEventData();
         MafiaModel.goldConstants = new MafiaGoldConstantsData();
         this.initView();
         CommandController.instance.executeCommand(BasicController.COMMAND_INITALIZE_CONTROLLER);
      }
      
      private function initView() : void
      {
         var _loc1_:MafiaLayoutManager = MafiaLayoutManager.getInstance();
         _loc1_.initialize(preloaderView);
         addChild(_loc1_);
         _loc1_.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         BasicLanguageFontManager.getInstance().initFontSwf();
         MafiaModel.languageData.addEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.onLanguageXMLLoadComplete);
      }
      
      private function onLanguageXMLLoadComplete(param1:LanguageDataEvent) : void
      {
         BasicLanguageFontManager.getInstance().initFontSwf();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:Number = getTimer();
         MafiaModel.userData.update(_loc2_);
         MafiaModel.specialEvent.update(_loc2_);
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
