package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicReconnectCommand extends SimpleCommand
   {
       
      
      public function BasicReconnectCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         BasicDialogHandler.getInstance().destroy();
         BasicController.getInstance().paymentHash = null;
      }
   }
}
