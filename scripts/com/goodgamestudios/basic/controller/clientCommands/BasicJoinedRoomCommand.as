package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.constants.CommonGameStates;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.event.SmartfoxEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.components.BasicSmartfoxClient;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.commanding.SimpleCommand;
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class BasicJoinedRoomCommand extends SimpleCommand
   {
      
      private static const LOGGER:ILogger = Log.getLogger("BasicJoinedRoomCommand.as");
       
      
      public function BasicJoinedRoomCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:SmartfoxEvent = param1 as SmartfoxEvent;
         if(_loc2_.params[0] == BasicSmartfoxClient.LOBBY_ROOM_NAME)
         {
            EnvGlobalsHandler.globals.clientInstanceHash = BasicModel.localData.readComputerInstanceCookie();
            CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.VERSION_CHECK_SEND);
            if(EnvGlobalsHandler.globals.clientInstanceHash >= 0)
            {
               BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_VERSION_CHECK,[EnvGlobalsHandler.globals.buildNumberGame,EnvGlobalsHandler.globals.clientInstanceHash]);
            }
            else
            {
               BasicModel.smartfoxClient.sendMessage(BasicSmartfoxConstants.C2S_VERSION_CHECK,[EnvGlobalsHandler.globals.buildNumberGame]);
            }
         }
         else
         {
            LOGGER.fatal("Joined room name != " + BasicSmartfoxClient.LOBBY_ROOM_NAME + " : " + _loc2_.params[0]);
         }
      }
   }
}
