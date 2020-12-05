package com.goodgamestudios.mafia.controller
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.netease.protobuf.Message;
   
   public class BasicProtobufCommand
   {
       
      
      public function BasicProtobufCommand()
      {
         super();
      }
      
      public function executeCommand(param1:Message) : Boolean
      {
         return true;
      }
      
      public function getRequestClass() : Class
      {
         trace("BasicProtobufCommand getRequestClass must be overriden! Override missing in " + Object(this).constructor + ".");
         return null;
      }
      
      public function getResponseClass() : Class
      {
         trace("BasicProtobufCommand getResponseClass must be overriden! Override missing in " + Object(this).constructor + ".");
         return null;
      }
      
      protected function get cmdId() : String
      {
         return "";
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      protected function get layoutManager() : BasicLayoutManager
      {
         return BasicLayoutManager.getInstance();
      }
      
      protected function get env() : MafiaEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
