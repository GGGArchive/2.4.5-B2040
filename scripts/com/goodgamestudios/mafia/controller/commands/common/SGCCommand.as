package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class SGCCommand extends MafiaCommand
   {
       
      
      public function SGCCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_SET_GOLD_CONSTANTS;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         MafiaModel.goldConstants.parseData(param2);
         return true;
      }
   }
}
