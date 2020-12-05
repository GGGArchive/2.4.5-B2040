package com.goodgamestudios.mafia.controller.commands.avatar
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.MafiaTutorialData;
   
   public class OIOCommand extends MafiaCommand
   {
       
      
      public function OIOCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_PLAYER_INFO;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            MafiaModel.userData.email = param2.shift();
            MafiaModel.userData.emailVerified = parseInt(param2.shift()) != 0;
            MafiaTutorialData.getInstance().tutorialShown = param2.shift() == 1;
            return true;
         }
         return false;
      }
   }
}
