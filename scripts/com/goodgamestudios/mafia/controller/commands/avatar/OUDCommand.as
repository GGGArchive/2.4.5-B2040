package com.goodgamestudios.mafia.controller.commands.avatar
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class OUDCommand extends MafiaCommand
   {
       
      
      public function OUDCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:Array) : void
      {
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_AVATAR_USERDATA,param1);
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_AVATAR_USERDATA;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0 && param2[1] == MafiaModel.userData.playerID)
         {
            MafiaModel.userData.parseUserData(param2);
            CommandController.instance.executeCommand(BasicController.COMMAND_TRACK_LOGIN,env);
            return true;
         }
         if(param1 == 0 && param2[1] != MafiaModel.userData.playerID)
         {
            MafiaModel.otherUserData.playerID = param2[1];
            MafiaModel.otherUserData.parseUserData(param2);
            return true;
         }
         return false;
      }
   }
}
