package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.event.model.MafiaOfferEvent;
   
   public class PPCCommand extends MafiaCommand
   {
       
      
      public function PPCCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return BasicSmartfoxConstants.S2C_PAYMENTSHOP_PRICE_CHANGE;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         controller.dispatchEvent(new MafiaOfferEvent(MafiaOfferEvent.CHANGE_OFFER,[0,3,0]));
         return true;
      }
   }
}
