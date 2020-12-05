package com.goodgamestudios.mafia.controller.commands.duel
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class VEFCommand extends MafiaCommand
   {
       
      
      public function VEFCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_VIEW_WANTED_FIGHT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            MafiaModel.userData.duelData.wantedData.parseWantedFightData(param2);
            return true;
         }
         return false;
      }
   }
}
