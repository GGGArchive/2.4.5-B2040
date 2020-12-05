package com.goodgamestudios.mafia
{
   import com.goodgamestudios.basic.BasicFrameOne;
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.constants.CommonGameStates;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicConnectClientCommand;
   import com.goodgamestudios.basic.controller.clientCommands.BasicConnectToInstanceVOCommand;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.firstVisit.ExtraScreenMovieClip;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaChangeCountryCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaCheckMaintenanceCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaInitAvailableCountriesCommand;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaInitServerListCommand;
   import com.goodgamestudios.mafia.controller.commands.account.CreateAvatarCommand;
   import com.goodgamestudios.mafia.model.components.MafiaLanguageData;
   import com.goodgamestudios.mafia.model.components.MafiaSharedObject;
   import com.goodgamestudios.mafia.view.MafiaBackgroundComponent;
   import com.goodgamestudios.mafia.view.screens.firstVisit.MafiaAvatarScreen;
   import com.goodgamestudios.mafia.view.screens.firstVisit.MafiaSocialAvatarScreen;
   
   public class MafiaFrameOne extends BasicFrameOne
   {
       
      
      public function MafiaFrameOne()
      {
         EnvGlobalsHandler.setEnvGlobalsClass(MafiaEnvironmentGlobals);
         super();
      }
      
      override protected function loadXMLs() : void
      {
         super.loadXMLs();
      }
      
      override protected function initPreClientCommands() : void
      {
         CommandController.instance.registerCommand(BasicController.COMMAND_INIT_COUNTRIES,MafiaInitAvailableCountriesCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_INIT_SERVERLIST,MafiaInitServerListCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CHECK_MAINTENANCE,MafiaCheckMaintenanceCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECT_TO_INSTANCEVO,BasicConnectToInstanceVOCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CHANGE_COUNTRY,MafiaChangeCountryCommand);
         CommandController.instance.registerCommand(BasicController.COMMAND_CONNECT_CLIENT,BasicConnectClientCommand);
         ProtobufController.getInstance().commandDict[Constants_SFS.PROTOBUF_CREATE_AVATAR] = new CreateAvatarCommand();
      }
      
      override protected function initLanguage() : void
      {
         BasicModel.languageData = new MafiaLanguageData();
         BasicModel.languageData.addEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,onLanguageXMLComplete);
         BasicModel.languageData.loadLanguage();
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.LANG_XML_START);
         BasicModel.localData = new MafiaSharedObject();
      }
      
      override protected function showFirstScreen() : void
      {
         if(this.env.loginIsKeyBased)
         {
            initFirstVisitScreen(new MafiaSocialAvatarScreen(new MafiaSocialAvatarCreation(),preloaderView.customCursor));
         }
         else if(this.env.isFirstVisit)
         {
            initFirstVisitScreen(new MafiaAvatarScreen(new MafiaNWAvatarCreation(),preloaderView.customCursor));
         }
      }
      
      override protected function additionalFirstVisitScreenInitalization(param1:ExtraScreenMovieClip) : void
      {
         param1.init();
      }
      
      override protected function get mainGameClassName() : String
      {
         return "com.goodgamestudios.mafia.MafiaGame";
      }
      
      override protected function createView() : void
      {
         preloaderView = new MafiaBackgroundComponent(new MafiaTitle());
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
