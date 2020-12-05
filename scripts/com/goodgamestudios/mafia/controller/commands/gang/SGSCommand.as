package com.goodgamestudios.mafia.controller.commands.gang
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   
   public class SGSCommand extends MafiaCommand
   {
       
      
      public function SGSCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_SHOW_GANG_SHOP;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            MafiaModel.userData.gangData.parseGangShop(param2);
            return true;
         }
         return false;
      }
   }
}
