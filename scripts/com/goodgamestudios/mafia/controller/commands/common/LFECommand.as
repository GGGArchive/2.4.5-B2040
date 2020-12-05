package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class LFECommand extends MafiaCommand
   {
       
      
      public function LFECommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_LOGIN_FEATURES;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            MafiaModel.userData.featureData.parseFeatureData(param2);
            return true;
         }
         return false;
      }
   }
}
