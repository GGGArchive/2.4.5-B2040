package com.goodgamestudios.mafia.controller.commands.shop
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class IRTCommand extends MafiaCommand
   {
       
      
      public function IRTCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_ITEM_RESPONSE_TIMEOUT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         MafiaModel.userData.unlockAllItems();
         if(param1 == 0)
         {
            return true;
         }
         return false;
      }
   }
}
