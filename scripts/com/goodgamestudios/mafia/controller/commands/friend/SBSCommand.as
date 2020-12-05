package com.goodgamestudios.mafia.controller.commands.friend
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class SBSCommand extends MafiaCommand
   {
       
      
      public function SBSCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_SOCIAL_BUDDIES;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            MafiaModel.buddyList.addSocialBuddies(param2);
            return true;
         }
         return false;
      }
   }
}
