package com.goodgamestudios.mafia.controller.commands.friend
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   
   public class GALCommand extends MafiaCommand
   {
       
      
      public function GALCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_ADDFRIEND_LINK;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            return true;
         }
         return false;
      }
   }
}
