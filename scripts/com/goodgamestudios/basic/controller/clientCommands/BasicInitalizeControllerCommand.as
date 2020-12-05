package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.event.BasicUserEvent;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicInitalizeControllerCommand extends SimpleCommand
   {
       
      
      public function BasicInitalizeControllerCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_INIT_SERVERCOMMANDS);
         BasicController.getInstance().addEventListener(BasicUserEvent.REGISTERED,BasicController.getInstance().onRegistered);
      }
   }
}
