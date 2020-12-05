package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicClientCommand extends SimpleCommand
   {
       
      
      public function BasicClientCommand(param1:Boolean = false)
      {
         super(param1);
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
