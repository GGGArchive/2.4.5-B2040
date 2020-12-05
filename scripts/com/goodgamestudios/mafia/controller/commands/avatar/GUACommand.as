package com.goodgamestudios.mafia.controller.commands.avatar
{
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class GUACommand extends MafiaCommand
   {
       
      
      public function GUACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_GET_UNLOCKED_ASSETS;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            param2.shift();
            MafiaModel.userData.unlockedAssetsData.parseUnlockedAssets(param2.shift());
            layoutManager.state = Constants_LayoutStates.STATE_CUSTOMIZE_AVATAR;
            return true;
         }
         return false;
      }
   }
}
