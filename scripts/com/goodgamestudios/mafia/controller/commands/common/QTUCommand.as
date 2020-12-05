package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   
   public class QTUCommand extends MafiaCommand
   {
       
      
      public function QTUCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_QUIT_TUTORIAL;
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
