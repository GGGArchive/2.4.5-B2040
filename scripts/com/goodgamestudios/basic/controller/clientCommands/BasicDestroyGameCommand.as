package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.textfield.manager.GoodgameTextFieldManager;
   
   public class BasicDestroyGameCommand extends SimpleCommand
   {
       
      
      public function BasicDestroyGameCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         if(BasicController.getInstance().soundController)
         {
            BasicController.getInstance().soundController.stopMusic();
            BasicController.getInstance().soundController.stopAllLoopedSoundEffects();
         }
         this.layoutManager.clearAllLayoutContent();
         if(!EnvGlobalsHandler.globals.useLegacyFontManagement)
         {
            GoodgameTextFieldManager.getInstance().unregisterAllTextFields();
         }
      }
      
      protected function get layoutManager() : BasicLayoutManager
      {
         return BasicLayoutManager.getInstance();
      }
   }
}
