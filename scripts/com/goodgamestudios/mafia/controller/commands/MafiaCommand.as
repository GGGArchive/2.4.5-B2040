package com.goodgamestudios.mafia.controller.commands
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.commands.BasicCommand;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   
   public class MafiaCommand extends BasicCommand
   {
       
      
      public function MafiaCommand()
      {
         super();
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(0)
         {
         }
         return true;
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      protected function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
   }
}
