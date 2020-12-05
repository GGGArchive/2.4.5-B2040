package com.goodgamestudios.basic.controller.commands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   
   public class BasicCommand
   {
       
      
      public function BasicCommand()
      {
         super();
      }
      
      public function executeCommand(param1:int, param2:Array) : Boolean
      {
         return true;
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
      
      protected function get nomoneyId() : String
      {
         return "error_nomoney_copy";
      }
      
      protected function get cmdId() : String
      {
         return "";
      }
   }
}
