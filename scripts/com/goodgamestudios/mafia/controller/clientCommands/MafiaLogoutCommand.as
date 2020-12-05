package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicLogoutCommand;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   
   public class MafiaLogoutCommand extends BasicLogoutCommand
   {
       
      
      public function MafiaLogoutCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         BasicController.getInstance().soundController.stopMusic();
         BasicController.getInstance().soundController.stopAllLoopedSoundEffects();
         MafiaDialogHandler.getInstance().destroy();
         BasicModel.smartfoxClient.logout();
      }
   }
}
