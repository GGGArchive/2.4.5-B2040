package com.goodgamestudios.mafia.controller.commands.slotmachine
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSlotEvent;
   
   public class SSMCommand extends MafiaCommand
   {
       
      
      public function SSMCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_START_SLOTMACHINE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         switch(param1)
         {
            case 0:
               param2.shift();
               controller.dispatchEvent(new MafiaSlotEvent(MafiaSlotEvent.START_STLOTMACHINE,param2));
               return true;
            case 1:
               break;
            case 2:
               break;
            case 3:
         }
         return false;
      }
   }
}
