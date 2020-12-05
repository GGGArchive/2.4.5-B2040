package com.goodgamestudios.mafia.controller.commands.ranking
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   
   public class SRTCommand extends MafiaCommand
   {
       
      
      public function SRTCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_SHOW_TOP_RANKING;
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
