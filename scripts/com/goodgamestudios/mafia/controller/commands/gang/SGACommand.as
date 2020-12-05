package com.goodgamestudios.mafia.controller.commands.gang
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.event.model.MafiaGangEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class SGACommand extends MafiaCommand
   {
       
      
      public function SGACommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_SHOW_GANG;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0 && param2[1] == MafiaModel.userData.playerID)
         {
            MafiaModel.userData.gangData.parsePlayerGang(param2);
            controller.dispatchEvent(new MafiaGangEvent(MafiaGangEvent.CHANGE_OWN_USER_GANG_DATA));
            controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA));
            return true;
         }
         if(param1 == 0 && param2[1] != MafiaModel.userData.playerID)
         {
            MafiaModel.otherUserData.gangData.parsePlayerGang(param2);
            controller.dispatchEvent(new MafiaGangEvent(MafiaGangEvent.CHANGE_OTHER_USER_GANG_DATA));
            controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA));
            return true;
         }
         return false;
      }
   }
}
