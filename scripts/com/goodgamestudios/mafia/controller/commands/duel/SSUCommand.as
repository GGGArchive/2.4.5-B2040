package com.goodgamestudios.mafia.controller.commands.duel
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class SSUCommand extends MafiaCommand
   {
       
      
      public function SSUCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_SHOW_SURVIVAL_COOLDOWN;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            MafiaModel.userData.duelData.survivalData.parseSurvivalCoolDown(param2);
            return true;
         }
         return false;
      }
   }
}
