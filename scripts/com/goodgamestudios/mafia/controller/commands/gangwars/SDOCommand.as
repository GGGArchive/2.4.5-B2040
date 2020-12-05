package com.goodgamestudios.mafia.controller.commands.gangwars
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class SDOCommand extends MafiaCommand
   {
       
      
      public function SDOCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_GANGWAR_OPPONENTS,[param1]);
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_SHOW_GANGWAR_OPPONENTS;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            MafiaModel.userData.gangwarData.parseGangwarData(param2);
            return true;
         }
         return false;
      }
   }
}
