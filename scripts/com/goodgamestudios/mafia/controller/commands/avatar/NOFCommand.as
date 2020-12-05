package com.goodgamestudios.mafia.controller.commands.avatar
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class NOFCommand extends MafiaCommand
   {
       
      
      public function NOFCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_NOTIFICATION;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            MafiaModel.userData.notificationsData.parseNotification(param2);
            return true;
         }
         return false;
      }
   }
}
