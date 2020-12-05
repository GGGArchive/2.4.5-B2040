package com.goodgamestudios.mafia.controller.commands.gang
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   
   public class DGACommand extends MafiaCommand
   {
       
      
      public function DGACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_FIRE_GANGMEMBER;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         return false;
      }
   }
}
