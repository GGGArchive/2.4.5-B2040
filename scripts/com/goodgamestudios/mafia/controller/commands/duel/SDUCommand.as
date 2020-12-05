package com.goodgamestudios.mafia.controller.commands.duel
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class SDUCommand extends MafiaCommand
   {
       
      
      public function SDUCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_SHOW_DUEL;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            MafiaModel.userData.duelData.pvpData.parseData(param2);
            return true;
         }
         return false;
      }
   }
}
