package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicConnectionLostCommand;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   
   public class MafiaConnectionLostCommand extends BasicConnectionLostCommand
   {
       
      
      public function MafiaConnectionLostCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         MafiaDialogHandler.getInstance().destroy();
         if(layoutManager.currentState == BasicLayoutManager.STATE_PRELOAD_CONNECTED || layoutManager.currentState == BasicLayoutManager.STATE_LOGIN || layoutManager.currentState == BasicLayoutManager.STATE_REGISTRATION)
         {
            BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_NO_CONNECTION));
            return;
         }
         if(MafiaTutorialController.getInstance().isActive)
         {
            MafiaLayoutManager.getInstance().removeTutorialPanel();
         }
         layoutManager.clearAllLayoutContent();
         super.execute(param1);
      }
   }
}
