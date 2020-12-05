package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.vo.OfferVO;
   
   public class SOECommand extends MafiaCommand
   {
       
      
      public function SOECommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return BasicSmartfoxConstants.S2C_SPECIAL_OFFER_EVENT;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         var _loc3_:OfferVO = null;
         if(param1 == 0)
         {
            _loc3_ = MafiaModel.userData.offerData.parseData(param2);
            MafiaModel.userData.offerData.handleSpecialOffer(_loc3_);
            return true;
         }
         return false;
      }
   }
}
