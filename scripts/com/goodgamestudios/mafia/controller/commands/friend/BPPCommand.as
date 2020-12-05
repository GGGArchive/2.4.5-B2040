package com.goodgamestudios.mafia.controller.commands.friend
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class BPPCommand extends MafiaCommand
   {
       
      
      public function BPPCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_GET_BUDDY_PLAYER_PROFILE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            MafiaModel.buddyList.addSocialBuddyAvatarInfo(param2);
            return true;
         }
         return false;
      }
   }
}
