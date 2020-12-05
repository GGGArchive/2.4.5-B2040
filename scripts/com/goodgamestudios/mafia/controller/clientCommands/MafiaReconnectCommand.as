package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicReconnectCommand;
   import com.goodgamestudios.commanding.CommandController;
   
   public class MafiaReconnectCommand extends BasicReconnectCommand
   {
       
      
      public function MafiaReconnectCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         super.execute(param1);
         CommandController.instance.executeCommand(BasicController.COMMAND_INITALIZE_CONTROLLER);
      }
   }
}
