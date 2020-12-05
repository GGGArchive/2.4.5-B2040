package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.clientCommands.BasicCheckMaintenanceCommand;
   import com.goodgamestudios.basic.event.SmartfoxEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   
   public class MafiaCheckMaintenanceCommand extends BasicCheckMaintenanceCommand
   {
       
      
      public function MafiaCheckMaintenanceCommand()
      {
         super();
      }
      
      override protected function doSocialMaintenanceStuff() : void
      {
         BasicModel.smartfoxClient.dispatchEvent(new SmartfoxEvent(SmartfoxEvent.CONNECT_FAILED));
         trace("isMaintenance on Socialnetwork");
      }
   }
}
