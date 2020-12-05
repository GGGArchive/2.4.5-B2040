package com.goodgamestudios.mafia.controller.commands.events
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class SAECommand extends MafiaCommand
   {
       
      
      public function SAECommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_SHOW_ACTIVE_EVENTS;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         switch(param1)
         {
            case Constants_SFS.ERROR_OK:
               param2.shift();
               MafiaModel.specialEvent.parseSAE(param2);
               return true;
            default:
               return false;
         }
      }
   }
}
