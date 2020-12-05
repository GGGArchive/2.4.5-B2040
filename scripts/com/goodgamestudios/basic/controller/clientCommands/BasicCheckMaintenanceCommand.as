package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.BasicEnvironmentGlobals;
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.event.SmartfoxEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.commanding.SimpleCommand;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class BasicCheckMaintenanceCommand extends SimpleCommand
   {
      
      public static const VIA_NETWORK_XML:String = "VIA_NETWORK_XML";
      
      public static const VIA_PHP_CALL:String = "VIA_PHP_CALL";
       
      
      private var method:String;
      
      public function BasicCheckMaintenanceCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLLoader = null;
         CommandController.instance.executeCommand(BasicController.COMMAND_CONNECT_CLIENT);
      }
      
      private function onComplete(param1:Event) : void
      {
         var _loc2_:* = int((param1.target as URLLoader).data) == 1;
         this.setMaintenance(_loc2_);
      }
      
      private function setMaintenance(param1:Boolean) : void
      {
         if(param1 && this.env.maintenanceMode)
         {
            if(EnvGlobalsHandler.globals.loginIsKeyBased)
            {
               this.doSocialMaintenanceStuff();
            }
            else
            {
               this.doMaintenanceStuff();
            }
         }
         else
         {
            this.doConnect();
         }
      }
      
      protected function doMaintenanceStuff() : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_CONNECTION_FAILED);
      }
      
      protected function doSocialMaintenanceStuff() : void
      {
         BasicModel.smartfoxClient.dispatchEvent(new SmartfoxEvent(SmartfoxEvent.CONNECT_FAILED));
      }
      
      protected function doConnect() : void
      {
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         this.doConnect();
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         this.doConnect();
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return new BasicEnvironmentGlobals();
      }
   }
}
