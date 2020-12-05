package com.goodgamestudios.mafia.controller.commands.avatar
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   
   public class UATCommand extends MafiaCommand
   {
       
      
      private const ERROR_NONE:int = 0;
      
      private const ERROR_NOTENOUGHCASH:int = 1;
      
      private const ERROR_WRONGPARAMETERCOUNT:int = 91;
      
      public function UATCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_UPGRADE_ATTRIBUTE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         switch(param1)
         {
            case this.ERROR_NONE:
               return true;
            case this.ERROR_NOTENOUGHCASH:
            case this.ERROR_WRONGPARAMETERCOUNT:
         }
         return false;
      }
   }
}
