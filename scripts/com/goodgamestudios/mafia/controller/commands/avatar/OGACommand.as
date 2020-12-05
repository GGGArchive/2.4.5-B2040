package com.goodgamestudios.mafia.controller.commands.avatar
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class OGACommand extends MafiaCommand
   {
       
      
      public function OGACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_AVATAR_ACHIEVMENTS;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0 && param2[1] == MafiaModel.userData.playerID)
         {
            MafiaModel.userData.parseAchievementData(param2);
            return true;
         }
         if(param1 == 0 && param2[1] != MafiaModel.userData.playerID)
         {
            MafiaModel.otherUserData.parseAchievementData(param2);
            return true;
         }
         return false;
      }
   }
}
